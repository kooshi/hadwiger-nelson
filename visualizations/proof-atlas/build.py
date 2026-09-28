#!/usr/bin/env python3
"""Inline data/viz/proof-atlas/facts.json into page.tmpl.html at the /*FACTS*/ marker → index.html, the page the owner publishes.

Run tools/viz_proof_atlas_facts.py first. This runs tools/viz_proof_atlas_check.py and refuses to build when it does not exit 0: a page
never shows a fact the checker could not re-read from its source. It also refuses when the two dark token blocks disagree or declare a
token the light palette lacks, and when tools/viz_proof_atlas_contrast.py (the palette review, both themes) fails."""
import json, pathlib, re, subprocess, sys

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


def tokens(block_head):
    """The custom properties declared in the first CSS block that opens with block_head."""
    i = tmpl.index(block_head) + len(block_head)
    body = tmpl[i:tmpl.index("}", i)]
    return dict(re.findall(r"--([\w-]+):\s*([^;]+);", body))


# The theme contract: the light palette complete on bare :root, and the two dark blocks (the system preference, and the page's or the
# viewer's explicit choice) carrying the same tokens, each already declared in the light palette. A token that drifts between the two
# dark blocks shows one dark look to the "System" viewer and another to the "Dark" one.
light = tokens(":root {")
dark_system = tokens(':root:not([data-theme="light"]) {')
dark_chosen = tokens(':root[data-theme="dark"] {')
assert dark_system == dark_chosen, f"the two dark blocks differ: {sorted(set(dark_system.items()) ^ set(dark_chosen.items()))}"
assert set(dark_chosen) <= set(light), f"dark tokens with no light definition: {sorted(set(dark_chosen) - set(light))}"
print(f"theme tokens: {len(light)} light, {len(dark_chosen)} redefined for dark, both dark blocks identical")
pal = subprocess.run([sys.executable, str(ROOT / "tools/viz_proof_atlas_contrast.py")], capture_output=True, text=True)
print(pal.stdout.strip().splitlines()[-1] if pal.stdout.strip() else pal.stderr.strip())
if pal.returncode != 0:
    sys.exit("refusing to build: the palette review failed (python3 tools/viz_proof_atlas_contrast.py names every failing token)")
assert tmpl.count("/*FACTS*/null") == 1, "the template must carry exactly one /*FACTS*/null marker"
page = tmpl.replace("/*FACTS*/null", json.dumps(facts, ensure_ascii=False, separators=(",", ":")).replace("</", "<\\/"))
for bad in ("<!doctype", "<html", "<head>", "<body"):
    assert bad not in page.lower(), f"the page contract forbids {bad!r}: the viewer wraps the page itself"
(HERE / "index.html").write_text(page, encoding="utf-8")
print(f"wrote {(HERE / 'index.html').relative_to(ROOT)}, {len(page.encode()):,} bytes")
