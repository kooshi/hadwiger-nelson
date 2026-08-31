#!/usr/bin/env python3
"""Produce the ARTIFACT copy of tools/descent-viz.html (the internet-accessible viewer Kooshi asked
for, 2026-08-31): same data block and script, the instrument's design tokens and faces, no document
wrapper tags (the artifact host supplies them). Run after `descentviz_refresh.py`, then republish
the output with the Artifact tool to the SAME URL (recorded in plans/M51-descent-engine.md).

  python3 tools/descentviz_artifact.py <out.html>
"""
import re, sys
from pathlib import Path
src = (Path(__file__).resolve().parent / 'descent-viz.html').read_text()
data = re.search(r'<script type="application/json" id="descentdata">(.*?)</script>', src, re.S).group(1)
js = src.split('<script>', 1)[1].rsplit('</script>', 1)[0]
for a, b in (("'#444'", "'#3a3f47'"), ("'#ffa726'", "'#f28c28'"), ("'#ef5350'", "'#e5484d'"), ("'#e040fb'", "'#d946ef'"),
             ("'#42a5f5'", "'#4c9be8'"), ("'#00e676'", "'#22c55e'"), ("'#ff1744'", "'#ff2d55'"), ("ctx.fillStyle='#111'", "ctx.fillStyle='#0f1114'"),
             ("ctx.strokeStyle='#fff'; ctx.lineWidth=2; ctx.beginPath(); ctx.arc(x,y,7,0,7)", "ctx.strokeStyle='#ffd166'; ctx.lineWidth=2; ctx.beginPath(); ctx.arc(x,y,7,0,7)"),
             ("ctx.font='12px sans-serif'", "ctx.font='12px IBM Plex Mono, monospace'"),
             ("document.getElementById('title').textContent = 'descent object · ' + (D.label||'');", "")):
    js = js.replace(a, b)
js = js.replace("$('counts').innerHTML = `${D.n} points (${D.seed_n} seed, ${D.deleted.length} deleted, ${D.n - D.seed_n} halo, max depth ${D.counts.max_depth})<br>${D.counts.unit} unit edges · ${D.counts.cheats} cheats · floor ${D.counts.floor} · put back ${D.counts.putback} · removed ${D.counts.removed}<br>forced pair ${D.forced[0]}–${D.forced[1]} · fp ${D.fingerprint}`",
                "$('counts').innerHTML = `<b>${D.n}</b> points — ${D.seed_n} seed (${D.deleted.length} deleted), ${D.n - D.seed_n} halo to depth ${D.counts.max_depth}<br><b>${D.counts.unit}</b> unit edges · <b>${D.counts.cheats}</b> cheats standing · floor ${D.counts.floor} · put back ${D.counts.putback} · removed ${D.counts.removed}<br>forced pair ${D.forced[0]}–${D.forced[1]} · object ${D.label}<br>fingerprint ${D.fingerprint}`")
TEMPLATE = Path(__file__).resolve().parent / 'descent-viz-artifact.tmpl.html'
html = TEMPLATE.read_text().replace('%%DATA%%', data).replace('%%JS%%', js)
Path(sys.argv[1]).write_text(html); print(f'wrote {sys.argv[1]} ({len(html)//1024} KB)')
