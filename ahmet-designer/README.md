# ahmet-designer

Ahmet'in tasarım zevkini taşıyan ajan hafızası: skill, zevk profili ve moodboard veri seti.

- `skills/ahmet-designer/SKILL.md`: tasarım işi gelince ajanın okuyacağı skill
- `taste/profile.md`: beğenilen/beğenilmeyen ekranlardan çıkan zevk kuralları
- `dataset/`: beğenilen ekranlar (AVIF 585px), küçük önizleme (WebP), meta JSON
- `tools/`: otomatik hat (işle, reddet, galeri üret)
- `defter/`: ajanın öğrendikleri, `durum/`: ajanlar arası durum dosyaları

Galeriyi görmek için: `python3 tools/build_gallery.py` sonra `gallery.html` dosyasını tarayıcıda aç.
