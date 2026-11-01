#!/usr/bin/env python3
"""Kullanim:
  ingest.py good <gorsel> [--cat KATEGORI]   guzel: kucult, AVIF+thumb uret, meta yaz
  ingest.py bad  <gorsel> [--why SEBEP]      cirkin: sil, sadece hash'i kaydet
"""
import sys, json, hashlib, argparse, os, datetime
from pathlib import Path
from PIL import Image
ROOT = Path(__file__).resolve().parent.parent
DS = ROOT / "dataset"

def dhash(im, n=8):
    g = im.convert("L").resize((n + 1, n), Image.LANCZOS)
    p = list(g.tobytes()); bits = 0
    for r in range(n):
        for c in range(n):
            bits = (bits << 1) | (p[r*(n+1)+c] > p[r*(n+1)+c+1])
    return f"{bits:016x}"

def near(h, others, thr=6):
    return any(bin(int(h,16) ^ int(o,16)).count("1") <= thr for o in others)

def known(kind):
    f = DS / kind
    return [l.split()[0] for l in f.read_text().splitlines() if l.strip()] if f.exists() else []

def palette(im, k=6):
    q = im.convert("RGB").resize((120, 260)).quantize(k, method=Image.MEDIANCUT)
    pal = q.getpalette()[:k*3]; cnt = sorted(q.getcolors(), reverse=True)
    return ["#%02x%02x%02x" % tuple(pal[i*3:i*3+3]) for _, i in cnt]

def main():
    a = argparse.ArgumentParser(); a.add_argument("mode", choices=["good","bad"])
    a.add_argument("path"); a.add_argument("--cat", default="uncategorized"); a.add_argument("--why", default="")
    a = a.parse_args(); src = Path(a.path)
    im = Image.open(src).convert("RGB"); h = dhash(im)
    if a.mode == "bad":
        with open(DS/"rejected.txt","a") as f: f.write(f"{h} {a.why}\n")
        src.unlink(missing_ok=True); print("silindi", h); return
    if near(h, known("rejected.txt")): print("daha once reddedilmis, atlandi"); return
    if near(h, known("accepted.txt")): print("tekrar, atlandi"); return
    sid = h
    w = 585; main_im = im.resize((w, round(im.height*w/im.width)), Image.LANCZOS)
    main_im.save(DS/"screens"/f"{sid}.avif", quality=50, speed=6)
    t = im.resize((90, max(1, round(im.height*90/im.width))), Image.LANCZOS)
    t.save(DS/"thumbs"/f"{sid}.webp", quality=60, method=6)
    meta = {"id": sid, "added": datetime.date.today().isoformat(), "category": a.cat,
            "orig_size": [im.width, im.height], "palette": palette(im),
            "theme": "dark" if im.convert("L").resize((1,1)).getpixel((0,0)) < 110 else "light",
            "tags": [], "components": [], "description": "(vision ile doldurulacak)"}
    (DS/"meta"/f"{sid}.json").write_text(json.dumps(meta, ensure_ascii=False, indent=1))
    with open(DS/"accepted.txt","a") as f: f.write(f"{h}\n")
    src.unlink(missing_ok=True); print("eklendi", sid)
if __name__ == "__main__": main()
