#!/usr/bin/env python3
"""Inline data/viz/proof-atlas/facts.json into page.tmpl.html at the /*FACTS*/ marker → index.html, the page the owner publishes.

Run tools/viz_proof_atlas_facts.py first. This runs tools/viz_proof_atlas_check.py and refuses to build when it does not exit 0: a page
never shows a fact the checker could not re-read from its source."""
import json, pathlib, subprocess, sys

HERE = pathlib.Path(__file__).resolve().parent
ROOT = HERE.parents[1]
chk = subprocess.run([sys.executable, str(ROOT / "tools/viz_proof_atlas_check.py")], capture_output=True, text=True)
out = chk.stdout.strip().splitlines()
print(out[-1] if out else chk.stderr.strip())
if chk.returncode != 0:
    print("\n".join(out[:-1][:20]))
    sys.exit("refusing to build: the facts check failed (python3 tools/viz_proof_atlas_check.py names every failing fact)")
facts = json.loads((ROOT / "data/viz/proof-atlas/facts.json").read_text(encoding="utf-8"))
tmpl = (HERE / "page.tmpl.html").read_text(encoding="utf-8")
assert tmpl.count("/*FACTS*/null") == 1, "the template must carry exactly one /*FACTS*/null marker"
page = tmpl.replace("/*FACTS*/null", json.dumps(facts, ensure_ascii=False, separators=(",", ":")).replace("</", "<\\/"))
for bad in ("<!doctype", "<html", "<head>", "<body"):
    assert bad not in page.lower(), f"the page contract forbids {bad!r}: the viewer wraps the page itself"
(HERE / "index.html").write_text(page, encoding="utf-8")
print(f"wrote {(HERE / 'index.html').relative_to(ROOT)}, {len(page.encode()):,} bytes")
