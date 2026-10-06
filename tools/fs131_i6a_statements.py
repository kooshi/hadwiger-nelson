#!/usr/bin/env python3
"""FS131-I6A: the statement check against the commit the statements were fixed at (3928644b).

For Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean, tree against base:
  * every declaration of the base is present, with a byte-identical STATEMENT (the text from its keyword to the first
    ':=' of the declaration; a def/structure/abbrev is compared whole, body included);
  * every declaration the base PROVED (no 'sorry' in its body) keeps a byte-identical body;
  * every base docstring is byte-identical, except for the declarations in ALLOW_DOC (the brief's Done-means 3: a model
    line for `half_upperDensity` and `pinch`), where the base docstring must still be a prefix-preserved subsequence of
    lines (lines may be added, none removed or altered);
  * the module docstring is byte-identical;
  * declarations new in the tree are listed (helpers), never a failure, unless one is an `axiom` or uses `native_decide`.
Proofs/HadwigerNelson/Plane/Saturated/Basic.lean must be byte-identical to the base.

Prints one line per base declaration, the helpers, the count of `sorry` leaves; exit 1 on any failure; exit 2 if the base
yields no declaration (a check that found nothing to check has not passed).

Usage: python3 tools/fs131_i6a_statements.py [--plant KIND]
  --plant hyp     drops the hypothesis `(hx : x ∈ N)` from `pinch` in an in-memory copy of the tree's file
  --plant doc     alters a docstring line of `c11_split` (a declaration outside ALLOW_DOC)
  --plant basic   alters one character of an in-memory copy of Basic.lean
  --plant axiom   appends an `axiom` to the in-memory copy
  --plant proof   alters the body of a base-proved theorem (`half_dichotomy`)
  --plant example alters the statement of a base `example` (the spec of `erosion_diam`)
Each must report at least one failure and exit 1."""
import hashlib, re, subprocess, sys, pathlib

BASE = "3928644b"
ROOT = pathlib.Path(__file__).resolve().parent.parent
PINCH = "Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean"
BASIC = "Proofs/HadwigerNelson/Plane/Saturated/Basic.lean"
ALLOW_DOC = {"half_upperDensity", "pinch"}
KW = re.compile(r"^(?:@\[[^\]]*\]\s*)?(?:private |protected |noncomputable )*(theorem|lemma|def|abbrev|structure|instance|example|axiom|inductive|class)\b\s*([^\s:({\[]*)")


def base_text(path):
    return subprocess.run(["git", "-C", str(ROOT), "show", f"{BASE}:{path}"], check=True, capture_output=True, text=True).stdout


def parse(text):
    """Return (module_doc, [(kind, name, doc, statement, body)]) in file order. A declaration runs from its keyword line to
    the line before the next top-level item (a docstring opener, a keyword, a section comment, `end`, `namespace`, ...)."""
    lines = text.split("\n")
    mdoc = ""
    m = re.search(r"/-!.*?-/", text, re.S)
    if m:
        mdoc = m.group(0)
    decls, i, n = [], 0, len(lines)
    pending_doc = ""
    anon = 0
    while i < n:
        ln = lines[i]
        if ln.startswith("/--"):
            j = i
            while "-/" not in lines[j]:
                j += 1
            pending_doc = "\n".join(lines[i:j + 1])
            i = j + 1
            continue
        if ln.startswith("/-!") or ln.startswith("/-"):
            j = i
            while "-/" not in lines[j]:
                j += 1
            i = j + 1
            pending_doc = ""
            continue
        mk = KW.match(ln)
        if mk:
            j = i + 1
            while j < n and not (lines[j].startswith("/--") or lines[j].startswith("/-!") or KW.match(lines[j])
                                 or re.match(r"^(end|namespace|open|variable|section|set_option|attribute|#)", lines[j])):
                j += 1
            block = "\n".join(lines[i:j]).rstrip()
            kind, name = mk.group(1), mk.group(2)
            if kind in ("theorem", "lemma", "example", "instance"):
                k = block.find(":=")
                stmt, body = (block, "") if k < 0 else (block[:k], block[k:])
            else:
                stmt, body = block, ""
            if kind == "example" or not name:
                # an anonymous declaration is keyed by its statement, never by its position: helpers added above it
                # must not shift it (a defect of this tool's first version, found at stage 3)
                anon += 1
                name = f"<{kind} {hashlib.sha1(stmt.encode()).hexdigest()[:10]}>"
            decls.append((kind, name, pending_doc, stmt, body))
            pending_doc = ""
            i = j
            continue
        if ln.strip() and not ln.startswith(" "):
            pending_doc = ""
        i += 1
    return mdoc, decls


def main():
    plant = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
    old_p, new_p = base_text(PINCH), (ROOT / PINCH).read_text()
    old_b, new_b = base_text(BASIC), (ROOT / BASIC).read_text()
    if plant == "hyp":
        assert "(hx : x ∈ N)\n    (hya" in new_p or " {x ya yb : ℂ} (hx : x ∈ N)" in new_p
        new_p = new_p.replace("(h : TwoColourOn A B N) {x ya yb : ℂ} (hx : x ∈ N)", "(h : TwoColourOn A B N) {x ya yb : ℂ}", 1)
    elif plant == "doc":
        assert "of the unit circle about `y`. -/" in new_p
        new_p = new_p.replace("of the unit circle about `y`. -/", "of a unit circle about `y`. -/", 1)
    elif plant == "basic":
        new_b = new_b.replace("dist x y = 1 ∧", "dist x y = 2 ∧", 1)
    elif plant == "axiom":
        new_p += "\naxiom planted : False\n"
    elif plant == "proof":
        assert "obtain ⟨hout, hin⟩ := hcon" in new_p
        new_p = new_p.replace("obtain ⟨hout, hin⟩ := hcon", "obtain ⟨hout, hin'⟩ := hcon", 1)
    elif plant == "example":
        assert "example : (1 / 2 : ℝ) ≤ 1 / (2 * Real.sin" in new_p
        new_p = new_p.replace("example : (1 / 2 : ℝ) ≤ 1 / (2 * Real.sin", "example : (1 / 3 : ℝ) ≤ 1 / (2 * Real.sin", 1)
    elif plant is not None:
        print("unknown plant", plant)
        sys.exit(2)

    omd, old = parse(old_p)
    nmd, new = parse(new_p)
    if not old:
        print("NO DECLARATION PARSED from the base")
        sys.exit(2)
    newmap = {}
    for d in new:
        newmap.setdefault(d[1], d)
    bad = 0

    def fail(msg):
        nonlocal bad
        bad += 1
        print("FAIL    | " + msg)

    if old_b != new_b:
        fail("Basic.lean differs from the base")
    else:
        print("same    | Basic.lean byte-identical to the base")
    if omd != nmd:
        fail("Pinch: the module docstring differs")
    else:
        print("same    | Pinch: module docstring")
    for kind, name, doc, stmt, body in old:
        d = newmap.get(name)
        if d is None:
            fail(f"{kind} {name}: missing from the tree" + (" (an anonymous declaration: its STATEMENT differs or it was removed)" if name.startswith("<") else ""))
            continue
        notes = []
        if d[0] != kind:
            fail(f"{name}: kind {kind} -> {d[0]}")
        if d[3] != stmt:
            fail(f"{kind} {name}: STATEMENT differs")
            continue
        if doc != d[2]:
            if name in ALLOW_DOC:
                ol, nl = doc.split("\n"), d[2].split("\n")
                # lines may be added; no base line removed or altered, except that the closing ' -/' may move to the added last line
                norm = lambda L: [re.sub(r"\s*-/\s*$", "", x) for x in L]
                it = iter(norm(nl))
                if all(any(x == y for y in it) for x in norm(ol)):
                    notes.append("docstring: lines added (allowed)")
                else:
                    fail(f"{kind} {name}: docstring altered beyond added lines")
            else:
                fail(f"{kind} {name}: docstring differs (not in ALLOW_DOC)")
        was_sorry = "sorry" in body
        if not was_sorry and kind in ("theorem", "lemma", "example", "instance") and d[4] != body:
            fail(f"{kind} {name}: the body of a base-proved declaration differs")
        state = "leaf: still sorry" if "sorry" in d[4] else ("leaf: PROVED here" if was_sorry else "proved at base")
        if kind not in ("theorem", "lemma", "example", "instance"):
            state = "definition, whole text identical"
        print("same    | " + f"{kind} {name}: statement identical; {state}" + ("; " + "; ".join(notes) if notes else ""))
    oldnames = {d[1] for d in old}
    helpers = [d for d in new if d[1] not in oldnames]
    for kind, name, doc, stmt, body in helpers:
        if kind == "axiom":
            fail(f"new axiom {name}")
        elif "native_decide" in body or "native_decide" in stmt:
            fail(f"{kind} {name}: native_decide")
        else:
            print("helper  | " + f"{kind} {name}" + ("  [uses sorry]" if "sorry" in body else ""))
    if re.search(r"\bnative_decide\b", new_p):
        fail("native_decide occurs in the tree's Pinch.lean")
    sorries = [d[1] for d in new if re.search(r"\bsorry\b", d[4])]
    print(f"base declarations: {len(old)}  helpers: {len(helpers)}  sorry leaves in the tree: {len(sorries)} {sorries}  failures: {bad}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
