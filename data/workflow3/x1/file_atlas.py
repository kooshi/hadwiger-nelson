#!/usr/bin/env python3
"""X1 stage 5, item 10: fold both closes' atlas drafts into tools/viz_proof_atlas_facts.py, with F1, F9 and Amendment 1's Q9.

Drafted: FS-114's block (plans/FS114-C-close.md § `tools/viz_proof_atlas_facts.py`) and its "Edits to existing nodes"; FS-111's D9.
Mechanical re-addressing (the same words at their new address, or the quotation that "moves with the row"): listed in MECH below.
Run from anywhere:  python3 data/workflow3/x1/file_atlas.py [--dry]
"""
import re, sys
from common import read, write, once, poros_pairs

P = "tools/viz_proof_atlas_facts.py"
C114 = read("plans/FS114-C-close.md")
C111 = read("plans/FS111-C-close.md")
F = poros_pairs()


def fence(s, head, stop):
    a = s.index(head); b = s.index(stop, a)
    blk = s[a:b]
    i = blk.index("```python\n") + len("```python\n"); j = blk.index("```", i)
    return blk[i:j]


def call_span(s, start):
    """span of a top-level N(...)/E(...) call beginning at `start` (column 0), up to the matching close paren."""
    depth = 0; i = start; q = None
    while True:
        ch = s[i]
        if q:
            if ch == "\\": i += 2; continue
            if ch == q: q = None
        elif ch in "\"'": q = ch
        elif ch == "(": depth += 1
        elif ch == ")":
            depth -= 1
            if depth == 0:
                return start, i + 1
        i += 1


def node_span(s, nid):
    k = s.index(f'\nN("{nid}", ') + 1
    return call_span(s, k)


def edge_span(s, a, b):
    ks = [m.start() + 1 for m in re.finditer(rf'\nE\("{a}", "{b}", ', s)]
    assert len(ks) == 1, (a, b, len(ks))
    return call_span(s, ks[0])


def main(dry):
    s = read(P)
    n0 = len(s)

    # ---------------- FS-111's D9
    d9 = fence(C111, "### D9.", "### D10.")
    parts = re.split(r"\n(?=# )", d9)
    blocks = {p.split("\n", 1)[0]: p.split("\n", 1)[1] if "\n" in p else "" for p in parts}
    new_fs111 = next(v for k, v in blocks.items() if k.startswith("# replace node FS111")).strip()
    new_meet = next(v for k, v in blocks.items() if k.startswith("# replace node MEET")).strip()
    new_nodes = next(v for k, v in blocks.items() if k.startswith("# new nodes")).strip()
    new_edges = next(v for k, v in blocks.items() if k.startswith("# edges:")).strip()
    new_fs111 = once(new_fs111, F["F9"][0][0], F["F9"][0][1], "F9 atlas FS111")
    a, b = node_span(s, "FS111"); s = s[:a] + new_fs111 + s[b:]
    a, b = node_span(s, "MEET"); s = s[:a] + new_meet + s[b:]
    for x, y in (("MEET", "M7"), ("TSMNO", "MEET"), ("FS111", "MEET"), ("WEQK", "MEET")):
        a, b = edge_span(s, x, y)
        assert s[b] == "\n"
        s = s[:a] + s[b + 1:]
    # the new nodes after MEET (the "toward seven" nodes' block), the new edges after the "toward seven" edges
    a, b = node_span(s, "MEET")
    s = s[:b] + "\n# ---- FS-111's successors (D9): the map step (FS-121), the pinch at a junction (FS-120), the forced pair (FS-122)\n" + new_nodes + s[b:]
    k = s.index('\nE("NG131", "M7", "blocks"') + 1
    s = s[:k] + new_edges + "\n" + s[k:]
    # route wall7: links and about
    old_links = '"WEQK", "MEET", "R132", "R134", "N3BASE", "N3DENSE3", "COMPOSE", "GSTEP",\n                "FS111", "SEVEN", "UB7"]'
    s = once(s, old_links, old_links.replace('"FS111", "SEVEN"', '"FS111", "FS121", "FS120", "FS122", "SEVEN"'), "wall7 links")
    about_new = re.sub(r"\n#\s+", " ", d9[d9.index('"… the global step (FS-114).') + 1:])
    about_new = about_new[:about_new.index('(FS-120)."') + len("(FS-120).")]
    assert about_new.startswith("… the global step (FS-114). Card 1 (FS-111, two minds)")
    tail = about_new[len("… the global step (FS-114)."):]
    i = s.index('dict(id="wall7"'); j = s.index("dict(id=", i + 10)
    w = s[i:j]
    k0 = w.index("the global step (FS-114)") + len("the global step (FS-114)")
    k1 = w.index('which the night advisor\'s first question tests."') + len('which the night advisor\'s first question tests.')
    head = w[:k0] + "."
    # keep the string-literal layout: close the running literal, then the new sentences as one literal
    w2 = head + ' "\n               "' + tail.strip() + w[k1:]
    s = s[:i] + w2 + s[j:]

    # ---------------- FS-114's block, F1 and Q9, placed after FS-112's nodes (before MEET)
    blk = fence(C114, "### `tools/viz_proof_atlas_facts.py` — entries", "### Questions and findings")
    f1 = F["F1"]
    assert f1[10][0] == "With CV-EXISTS this is the whole unit-arc NO"
    blk = once(blk, 'With "\n  "CV-EXISTS this is the whole unit-arc NO', 'With "\n  "CV-EXISTS it gives the whole unit-arc NO', "F1 LOCALF")
    old_q = "its NO is exactly an explicit radius about a vertex of at least four colours within which no such map fragment exists"
    new_q = "its NO follows from an explicit radius, uniform in the complexity, about a vertex of at least four colours within which no such map fragment exists"
    assert new_q in f1[2][1]
    assert blk.count(old_q) == 2
    blk = blk.replace(old_q, new_q)                                  # LOCALF's quote and the CVEXISTS→LOCALF edge (F1; Q9)
    blk = once(blk, '"So S–V\'s Question 2 with unit arcs is one local statement"', '"So one local statement suffices for S–V\'s Question 2 with unit arcs"', "F1 LOCALF→UANO")
    blk = once(blk, 'So the unit-arc NO is "\n  "one local statement about one such vertex, Siamese pairs included',
               'So one local statement "\n  "about one such vertex suffices for the unit-arc NO, Siamese pairs included', "Q9 CVEXISTS")
    k = s.index('\nN("MEET", ') + 1
    s = s[:k] + blk.rstrip("\n") + "\n" + s[k:]

    # ---------------- FS-114's "edits to existing nodes"
    a, b = node_span(s, "GSTEP"); g = s[a:b]
    g = once(g, '(FS-114, rank 1).", {"file"', '(FS-114, rank 1). FS-114 closed undecided: the global step is now the local exclusion (LOCALF).", {"file"', "GSTEP text")
    s = s[:a] + g + s[b:]
    a, b = node_span(s, "N3BASE"); g = s[a:b]
    g = once(g, "is being re-derived blind tonight (BASE-V); row 134's grade stands as printed until it reports",
             "BASE-V re-derived row 134's print steps blind: every step but Lemma 4 at cusps upgraded", "N3BASE note")
    s = s[:a] + g + s[b:]
    a, b = node_span(s, "TSMYES"); g = s[a:b]
    g = once(g, 'vertex within 3 of every point.", GSTUB', 'vertex within 3 of every point and, by row 137, a vertex of at least four colours.", GSTUB', "TSMYES text")
    s = s[:a] + g + s[b:]

    # ---------------- MECH: quotations that moved with their rows, and rank-addressed rows renumbered by the re-rank (same words)
    MECH = [
        # N3BASE: its grade and `also` move with FS112-N3-BASE's line and row 135 (FS-114's drafts: "its quotation moves with the row")
        ("\"hand; two minds: N3; NB3, blind; over row 134's base unre-derived\"", "\"hand; two minds: N3; NB3, blind; over row 134's base, re-derived by BASE-V but for Lemma 4 at cusps\""),
        ("(L(135), \"over row 134's base at its grade, unre-derived here — S–V Lemma 5, Prop. 18, Lemma 6's < 9 branch and CUSP-BASE — where a \"\n         \"common error of both walks would sit\")",
         "(L(135), \"over row 134's base, re-derived by BASE-V at FS-114 but for Lemma 4 at cusps (CUSP-BASE's D5 items 1–4, 6, one mind), where a \"\n         \"common error would now sit\")"),
        ("E(\"R134\", \"N3BASE\", \"rests\", B(\"FS112-N3-BASE\"), \"over row 134's base unre-derived\")",
         "E(\"R134\", \"N3BASE\", \"rests\", B(\"FS112-N3-BASE\"), \"over row 134's base, re-derived by BASE-V but for Lemma 4 at cusps\")"),
        # rank-addressed rows: old ranks 5–66 become 8–69 (the re-rank); the quoted words are unchanged in the renumbered rows
        ("PF(8)", "PF(11)"), ("PF(13)", "PF(16)"), ("PF(7)", "PF(10)"),
    ]
    for o, n in MECH:
        c = s.count(o)
        assert c >= 1, o[:70]
        s = s.replace(o, n)
    print(f"{P}: {n0} -> {len(s)} characters")
    if not dry:
        write(P, s)


if __name__ == "__main__":
    main("--dry" in sys.argv)
