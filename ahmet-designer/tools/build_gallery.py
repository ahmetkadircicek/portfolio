#!/usr/bin/env python3
"""dataset/ icinden tek dosyalik gallery.html uretir (thumb'lar base64 gomulu)."""
import json, base64, html
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent; DS = ROOT/"dataset"
items = []
for m in sorted((DS/"meta").glob("*.json")):
    d = json.loads(m.read_text()); t = DS/"thumbs"/f"{d['id']}.webp"
    d["thumb"] = "data:image/webp;base64," + base64.b64encode(t.read_bytes()).decode() if t.exists() else ""
    d["full"] = f"dataset/screens/{d['id']}.avif"; items.append(d)
page = """<!doctype html><meta charset=utf-8><meta name=viewport content="width=device-width,initial-scale=1">
<title>Moodboard</title><style>body{font-family:system-ui;margin:16px;background:#111;color:#eee}
input,select{padding:8px;margin:0 8px 12px 0;background:#222;color:#eee;border:1px solid #444;border-radius:8px}
#g{display:grid;grid-template-columns:repeat(auto-fill,minmax(110px,1fr));gap:10px}
.c{background:#1b1b1b;border-radius:10px;padding:6px;cursor:pointer}.c img{width:100%;border-radius:6px}
.p{display:flex;height:6px;margin-top:4px;border-radius:3px;overflow:hidden}.p i{flex:1}
#o{position:fixed;inset:0;background:#000d;display:none;align-items:center;justify-content:center}
#o img{max-height:92vh;max-width:92vw}</style>
<input id=q placeholder="ara: kategori, etiket, bilesen"><select id=t><option value="">tema</option><option>dark</option><option>light</option></select>
<span id=n></span><div id=g></div><div id=o onclick="this.style.display='none'"><img id=oi></div>
<script>const D=__DATA__;const g=document.getElementById('g');
function r(){const q=document.getElementById('q').value.toLowerCase(),t=document.getElementById('t').value;
const L=D.filter(d=>(!t||d.theme==t)&&(!q||JSON.stringify([d.category,d.tags,d.components,d.description]).toLowerCase().includes(q)));
document.getElementById('n').textContent=L.length+' ekran';
g.innerHTML=L.map(d=>`<div class=c onclick="document.getElementById('oi').src='${d.full}';document.getElementById('o').style.display='flex'"><img src="${d.thumb}"><div class=p>${d.palette.map(c=>`<i style=background:${c}></i>`).join('')}</div></div>`).join('')}
q.oninput=t.onchange=r;r()</script>"""
(ROOT/"gallery.html").write_text(page.replace("__DATA__", json.dumps(items, ensure_ascii=False)))
print(len(items), "ekran, gallery.html hazir")
