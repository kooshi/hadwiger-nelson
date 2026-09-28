#!/usr/bin/env python3
"""X1 stage 2: file the closes' LEDGER.md drafts (manifest items 1-2), verbatim, with F1, ruling 3 and Amendment 1's Q2, Q5.

Every text is taken from its source by exact anchors; every replacement is asserted to occur exactly once.
Run from anywhere:  python3 data/workflow3/x1/file_ledger.py [--dry]
"""
import re, sys
from common import read, write, once, poros_pairs, r111

C114 = read("plans/FS114-C-close.md")
C111 = read("plans/FS111-C-close.md")
F = poros_pairs()


def between(s, a, b, start=0):
    i = s.index(a, start) + len(a)
    j = s.index(b, i)
    return s[i:j]


def draft_block(s, head, nxt):
    a = s.index(head); b = s.index(nxt, a)
    return s[a:b]


def main(dry):
    led = read("LEDGER.md")
    lines = led.split("\n")

    # ---------------- item 1a: FS-114's rows 137-138, F1 on row 137
    blk114 = draft_block(C114, "### `LEDGER.md` — § A, rows 137–138", "### `LEDGER.md` — § B")
    r137 = [l for l in blk114.split("\n") if l.startswith("| 137 | ")]
    r138 = [l for l in blk114.split("\n") if l.startswith("| 138 | ")]
    assert len(r137) == 1 and len(r138) == 1
    r137 = r137[0]
    f1 = F["F1"]
    assert f1[1][0].startswith("With unit arcs, the six-map question is local:")
    r137 = once(r137, f1[1][0], f1[1][1], "F1 row 137 opening")
    assert f1[2][0].startswith("So S–V's Question 2 with unit arcs is one local statement")
    r137 = once(r137, f1[2][0], f1[2][1], "F1 row 137 sentence")
    new_a = [r137, r138[0]]

    # ---------------- item 1b: FS-111's three rows, numbered 139-141
    d1 = draft_block(C111, "### D1. `LEDGER.md`", "### D2. `CLAUDE.md`")
    rows111 = [l for l in d1.split("\n") if re.match(r"\| ‹R111-[abc]› \| \*\*", l)]
    assert [l[:10] for l in rows111] == ["| ‹R111-a›", "| ‹R111-b›", "| ‹R111-c›"], [l[:10] for l in rows111]
    new_a += [r111(l) for l in rows111]
    assert [l.split(" | ")[0] for l in new_a] == ["| 137", "| 138", "| 139", "| 140", "| 141"]

    i136 = next(k for k, l in enumerate(lines) if l.startswith("| 136 | "))
    assert lines[i136 + 1] == "", "row 136 is not the table's last row"
    lines[i136 + 1:i136 + 1] = new_a

    # ---------------- item 1c: FS-114's corrections to rows 134, 135
    cor = draft_block(C114, "### `LEDGER.md` — corrections owed to existing rows and lines", "### `CLAUDE.md` — the shared units")
    b134 = next(l for l in cor.split("\n") if l.startswith("- **Row 134's grade bracket**"))
    ins134 = between(b134, 'insert before its closing "]**": "', '". The Proof Atlas')
    b135 = next(l for l in cor.split("\n") if l.startswith("- **Row 135:**"))
    pairs135 = re.findall(r'"([^"]*)" → "([^"]*)"', b135)
    assert len(pairs135) == 4, len(pairs135)
    del135 = between(b135, 'delete "', '" (walked')

    def row(n):
        return next(k for k, l in enumerate(lines) if l.startswith(f"| {n} | "))

    k = row(134)
    assert lines[k].count("]**") == 1
    lines[k] = lines[k].replace("]**", ins134 + "]**")
    k = row(135)
    for o, n in pairs135:
        lines[k] = once(lines[k], o, n, "row 135")
    lines[k] = once(lines[k], "; " + del135, "", "row 135 Not claimed deletion")

    # ---------------- item 1d: FS-111's corrections to rows 130, 131, 133, 136
    cr = d1[d1.index("**Corrections to existing rows:**"):d1.index("**§ B, one line per entry")]
    bl = {m.group(1): l for l in cr.split("\n") for m in [re.match(r"- \*\*Row (\d+)\*\*", l)] if m}
    assert sorted(bl) == ["130", "131", "133", "136"]
    for n in ("130", "131"):
        o, nw = re.findall(r'\*"([^"]*)"\* → \*"([^"]*)"\*', bl[n])[0]
        k = row(n)
        lines[k] = once(lines[k], o, nw, f"row {n}")
    # row 133: the old sentence with its FS-110 parenthesis; the parenthesis kept after "(FS-110's question, then FS-114's)" (Amendment 1, Q2 (a))
    o133, n133 = re.findall(r'\*"([^"]*)"\* → \*"([^"]*)"\*', bl["133"])[0]
    assert o133.startswith("So stability at six is two questions:") and "(FS-110; …)" in o133
    pre, post = o133.split("(FS-110; …)")
    k = row(133)
    i = lines[k].index(pre) + len(pre)
    assert lines[k].count(pre) == 1 and lines[k][i:].startswith("(FS-110; ")
    j = lines[k].index(post, i)
    paren = lines[k][i:j]
    assert paren.endswith(")") and paren.count("(") == paren.count(")"), paren
    n133 = r111(n133)
    anchor = "route M, the map NO (FS-110's question, then FS-114's)"
    n133 = once(n133, anchor, anchor + " " + paren, "row 133 new sentence anchor")
    lines[k] = lines[k][:i - len(pre)] + n133 + lines[k][j + len(post):]
    # row 136: one clause for its Not claimed, at the end of that list
    clause = between(bl["136"], 'one clause for its **Not claimed**: *"', '"*')
    k = row(136)
    a = lines[k].index("**Not claimed:**")
    b = lines[k].index(". **Prior art:**", a)
    assert lines[k].count("**Not claimed:**") == 1
    lines[k] = lines[k][:b] + "; " + clause + lines[k][b:]

    # ---------------- item 2c: FS-114's corrections to FS-112's § B lines (before appending new lines)
    def bline(i):
        return next(k for k, l in enumerate(lines) if l.startswith(f"| {i} | "))

    def cells(k):
        return lines[k].split(" | ")

    def setcell(k, idx, val):
        c = cells(k); c[idx] = val; lines[k] = " | ".join(c)

    cl = {m.group(1): l for l in cor.split("\n") for m in [re.match(r"- \*\*§ B, (?:l\. \d+, )?([A-Z0-9-]+):\*\*", l)] if m}
    # FS112-L60: statement and grade
    bL = next(l for l in cor.split("\n") if "FS112-L60:**" in l)
    oL = between(bL, 'FS112-L60:** "', '" → "')
    nL = between(bL, '" → "', '"; grade → "')
    gL = between(bL, '"; grade → "', '".')
    k = bline("FS112-L60"); c = cells(k)
    assert c[2] == oL, c[2]
    setcell(k, 2, nL); setcell(k, 3, gL)
    # FS112-N3-BASE: grade "…; X" → "…; Y"
    bN = cl["FS112-N3-BASE"]
    oN = between(bN, 'grade "…; ', '" → "')
    nN = between(bN, '" → "…; ', '".')
    k = bline("FS112-N3-BASE"); c = cells(k)
    setcell(k, 3, once(c[3], "; " + oN, "; " + nN, "N3-BASE grade"))
    # FS112-C-ENDS: "… A" → "… B"; grade
    bE = cl["FS112-C-ENDS"]
    oE = between(bE, 'C-ENDS:** "… ', '" → "')
    nE = between(bE, '" → "… ', '"; grade → "')
    gE = between(bE, '"; grade → "', '".')
    k = bline("FS112-C-ENDS"); c = cells(k)
    assert c[2].endswith(oE), c[2]
    setcell(k, 2, c[2][:-len(oE)] + nE); setcell(k, 3, gE)
    # FS112-C-PARTNERS and FS112-C-DOUBLE: grades
    bP = cl["FS112-C-PARTNERS"]
    gP = between(bP, 'C-PARTNERS:** grade → "', '".')
    gD = between(bP, 'C-DOUBLE:** grade → "', '".')
    setcell(bline("FS112-C-PARTNERS"), 3, gP)
    setcell(bline("FS112-C-DOUBLE"), 3, gD)
    # kernel column "stub (FS-114)" → "stub (FS-116)" on FS-112 lines
    nk = 0
    for k, l in enumerate(lines):
        if l.endswith("| stub (FS-114) |"):
            assert l.startswith("| FS112-"), l[:40]
            lines[k] = l[:-len("stub (FS-114) |")] + "stub (FS-116) |"; nk += 1
    assert nk == 29, nk

    # ---------------- items 2a, 2b: FS-114's 46 and FS-111's 85 § B lines, after FS-112's
    b114 = [l for l in read("data/fs114/fs114-c/ledger-b-draft.md").split("\n") if l.strip()]
    assert len(b114) == 46 and all(l.startswith("| FS114-") for l in b114)
    b111 = [l for l in d1.split("\n") if l.startswith("| FS111-")]
    assert len(b111) == 85
    fixed = []
    for l in b111:
        c = l.split(" | ")
        assert c[1] in ("‹R111-a›", "‹R111-b›", "‹R111-c›"), c[1]
        c[1] = "row " + r111(c[1])          # Amendment 1, Q5: "row 139" etc.
        fixed.append(r111(" | ".join(c)))
    last = max(k for k, l in enumerate(lines) if l.startswith("| FS112-"))
    assert all(not l.startswith("| ") for l in lines[last + 1:]), "FS-112's lines are not the table's end"
    lines[last + 1:last + 1] = b114 + fixed

    out = "\n".join(lines)
    assert "‹R111" not in out
    print(f"§ A rows added: 5; § B lines added: {len(b114)} + {len(fixed)}; kernel cells moved to FS-116: {nk}")
    print(f"LEDGER.md: {len(led.encode())} -> {len(out.encode())} bytes")
    if not dry:
        write("LEDGER.md", out)


if __name__ == "__main__":
    main("--dry" in sys.argv)
