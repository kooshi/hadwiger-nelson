#!/usr/bin/env python3
"""Build the Unit Distance Atlas page: inline core.js into page.tmpl.html at the /*CORE*/ marker -> atlas.html.

Usage: python3 visualizations/unit-distance-atlas/build.py
The published artifact is https://claude.ai/artifact/3nuVwboAbketNuWw7yRdw2 (republish atlas.html to that URL after a build).
"""
from pathlib import Path

HERE = Path(__file__).resolve().parent
template = (HERE / "page.tmpl.html").read_text()
core = (HERE / "core.js").read_text()
assert template.count("/*CORE*/") == 1, "the template must carry exactly one /*CORE*/ marker"
(HERE / "atlas.html").write_text(template.replace("/*CORE*/", core))
print(f"wrote {HERE / 'atlas.html'}")
