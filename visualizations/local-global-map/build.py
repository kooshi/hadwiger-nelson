#!/usr/bin/env python3
"""Inline data/viz/local-global-map/facts.json into page.tmpl.html at the /*FACTS*/ marker → index.html (the published file).
Run tools/viz_local_global_map_build.py and tools/viz_local_global_map_check.py first; this refuses to build if the check fails."""
import json, pathlib, subprocess, sys
HERE = pathlib.Path(__file__).resolve().parent; ROOT = HERE.parents[1]
chk = subprocess.run([sys.executable, str(ROOT / "tools/viz_local_global_map_check.py")], capture_output=True, text=True)
print(chk.stdout.strip().splitlines()[-1] if chk.stdout.strip() else chk.stderr)
if chk.returncode != 0: sys.exit("refusing to build: the facts check failed (run the checker for the failing facts)")
facts = json.loads((ROOT / "data/viz/local-global-map/facts.json").read_text(encoding="utf-8"))
tmpl = (HERE / "page.tmpl.html").read_text(encoding="utf-8")
assert tmpl.count("/*FACTS*/null") == 1, "the template must carry exactly one /*FACTS*/null marker"
out = tmpl.replace("/*FACTS*/null", json.dumps(facts, ensure_ascii=False, separators=(",", ":")).replace("</", "<\\/"))
(HERE / "index.html").write_text(out, encoding="utf-8")
print(f"wrote {HERE.relative_to(ROOT)}/index.html, {len(out.encode()):,} bytes")
