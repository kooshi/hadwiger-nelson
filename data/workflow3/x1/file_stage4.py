#!/usr/bin/env python3
"""X1 stage 4: manifest items 4-8 — grokking instances, bibliography, claim lists, stubs, the frontier re-rank — verbatim, with F1, F2, F3,
ruling 3 and Amendment 1 (Q3, Q4, Q6, Q7, Q8, Q9).  Run from anywhere:  python3 data/workflow3/x1/file_stage4.py [--dry]
"""
import re, sys
from common import read, write, once, once_ws, poros_pairs, r111

C114 = read("plans/FS114-C-close.md")
C111 = read("plans/FS111-C-close.md")
PR = read("plans/POROS-2026-09-28-close-reread.md")
F = poros_pairs()
OUT = {}


def blk(s, a, b):
    i = s.index(a); return s[i:s.index(b, i)]


def joined(s):
    return re.sub(r"\n  (?=\S)", " ", s)


def bullets(s):
    return [l for l in joined(s).split("\n") if l.startswith("- ")]


def between(s, a, b, start=0):
    i = s.index(a, start) + len(a); return s[i:s.index(b, i)]


def get(p):
    if p not in OUT:
        OUT[p] = read(p)
    return OUT[p]


def put(p, s):
    OUT[p] = s


def section_end(lines, head):
    """index of the line after the section whose heading line equals `head` (the next `## ` heading or EOF)."""
    i = lines.index(head)
    k = i + 1
    while k < len(lines) and not lines[k].startswith("## "):
        k += 1
    return k


def append_instance(p, head, header, body, before=None):
    lines = get(p).split("\n")
    if before is not None:
        k = lines.index(before)
        assert k > lines.index(head)
    else:
        k = section_end(lines, head)
    while lines[k - 1] == "":
        k -= 1
    lines[k:k] = ["", header, "", body]
    put(p, "\n".join(lines))


# ======================================================================= item 4: plans/GROKKING-INSTANCES.md
GI = "plans/GROKKING-INSTANCES.md"
HEAD = {"G21": "## G21 — A negative measures its enumeration", "G30": "## G30 — Measurement generates; derivation kills",
        "G51": "## G51 — A competitor and an advisor beat one mind", "G72": "## G72 — The invariant question",
        "G79": "## G79 — A wall arrives as a counterexample's invariant", "G67": "## G67 — A grokking is grokked by its form",
        "GATE": "## `CLAUDE.md` § Make the gate fail, and watch it fail"}


def item4():
    # the new G67 section, between G65 and G72 (Amendment 1, Q7)
    lines = get(GI).split("\n")
    assert HEAD["G67"] not in lines
    k = lines.index(HEAD["G72"])
    lines[k:k] = [HEAD["G67"], ""]
    put(GI, "\n".join(lines))
    n = 0
    # FS-114's four: the italic header split from the body, the file's form
    for b in bullets(blk(C114, "### `plans/GROKKING-INSTANCES.md` — new instances", "### `BIBLIOGRAPHY.md` — rows")):
        m = re.match(r"- \*\*§(G\d+)\*\*, [^:]*: (\*FS114-C, [^*]*:\*) (.*)$", b)
        assert m, b[:80]
        g, header, body = m.groups()
        append_instance(GI, HEAD[g], header, body, before="### The tally, re-sorted 2026-09-26 (job G2)" if g == "G30" else None)
        n += 1
    assert n == 4
    # FS-111's eight: the header of Amendment 1 Q7, each italic paragraph as it stands; G72's opens "Twenty-first, FS-111:"
    d4 = C111[C111.index("**Instances for `plans/GROKKING-INSTANCES.md`**"):C111.index("### D5.")]
    hdr = "*FS111-C, FS-111's close (`plans/FS111-C-close.md` §D4):*"
    for b in bullets(d4):
        m = re.match(r"- \*\*§ ?(G\d+|Make the gate fail)[^*]*:\*\* (\*.*\*)$", b)
        assert m, b[:80]
        g, body = m.groups()
        g = "GATE" if g == "Make the gate fail" else g
        if g == "G72":
            body = once(body, "*FS-111: through", "*Twenty-first, FS-111: through", "G72 opening")
        append_instance(GI, HEAD[g], hdr, body, before="### The tally, re-sorted 2026-09-26 (job G2)" if g == "G30" else None)
        n += 1
    assert n == 12, n


# ======================================================================= item 5: BIBLIOGRAPHY.md
BIB = "BIBLIOGRAPHY.md"


def cells(row):
    assert row.startswith("| ") and row.endswith(" |")
    return row[2:-2].split(" | ")


def mkrow(c):
    return "| " + " | ".join(c) + " |"


def set_row(key_prefix, fn):
    lines = get(BIB).split("\n")
    ks = [k for k, l in enumerate(lines) if l.startswith(key_prefix)]
    assert len(ks) == 1, (key_prefix, len(ks))
    lines[ks[0]] = fn(lines[ks[0]])
    put(BIB, "\n".join(lines))


def join_cell(cell, add):
    return cell + (" " if cell.rstrip().endswith(".") else ". ") + add


def item5():
    d114 = blk(C114, "### `BIBLIOGRAPHY.md` — rows", "### `data/fs114/claims.md`")
    rows114 = [l for l in d114.split("\n") if l.startswith("| **[")]
    assert len(rows114) == 7
    rows114 = [r for r in rows114 if not r.startswith("| **[AxenovichLiuSagdeev2025]**")]   # Amendment 1, Q6 (a)
    assert len(rows114) == 6
    d5 = blk(C111, "### D5. `BIBLIOGRAPHY.md`", "### D6.")
    d5j = joined(d5)
    ci = d5j.index("§ C (titles seen")
    rowsA111 = [l[3:-1] for l in d5j[:ci].split("\n") if l.startswith("- `| **[")]
    rowsC111 = [l[3:-1] for l in d5j[ci:].split("\n") if l.startswith("- `| **[")]
    assert len(rowsA111) == 3 and len(rowsC111) == 7, (len(rowsA111), len(rowsC111))
    for r in rowsA111 + rowsC111:
        assert r.startswith("| **[") and r.endswith(" |"), r[:60]

    lines = get(BIB).split("\n")
    # § A: append FS-114's six, then FS-111's three, at the end of the § A table
    ia = lines.index("### A′. Retired and alternate keys")
    k = ia
    while not lines[k - 1].startswith("| "):
        k -= 1
    lines[k:k] = rows114 + rowsA111
    # § A′: the alias in the table's backtick form (Q6 (e))
    alias = between(d114, "**§ A′ (alternate keys):** `", "`.\n")
    assert alias == "| [AHNR2018] | **[AngelHutchcroftNachmiasRay2018]** | the short key FS114-N6 and FS114-NB6 used |", alias
    alias = "| `[AHNR2018]` | **`[AngelHutchcroftNachmiasRay2018]`** | the short key FS114-N6 and FS114-NB6 used |"
    ib = lines.index("## B. The library — every held file, with its key and read status")
    k = ib
    while not lines[k - 1].startswith("| "):
        k -= 1
    lines[k:k] = [alias]
    # § C: FS-111's seven at the end of the § C table
    ig = next(i for i, l in enumerate(lines) if l.startswith("## G. The Geombinatorics archive walk"))
    k = ig
    while not lines[k - 1].startswith("| "):
        k -= 1
    lines[k:k] = rowsC111
    put(BIB, "\n".join(lines))

    # FS-114's edits to existing rows
    e0 = d114.index("**Edits to existing rows:**")
    ed = d114[e0:d114.index("\n\n", e0)].replace("\n", " ")     # one wrapped paragraph
    assert "[Oostema2020]` — last page **389**" in ed
    oo = [l for l in get(BIB).split("\n") if l.startswith("| **[Oostema2020]**")]
    assert len(oo) == 1 and "373–389" in oo[0]          # Q6 (b): a no-op
    sir = "read: pp. 1–11 and 13 (FS114-Y); its stitch is a seven-colour device"   # Amendment 1, Q6 (d)
    assert ("`[Sirgedas2021]` — " + sir + ".") in ed

    def f_sir(r):
        c = cells(r); assert c[4] == "not read (debt 5)", c[4]; c[4] = sir; return mkrow(c)
    set_row("| **[Sirgedas2021]**", f_sir)
    tho = between(ed, "`[Thomassen1999]` — ", ".")
    assert tho == "page images not held, OCR only (FS114-CVB)", tho

    def f_tho(r):
        c = cells(r); c[4] = c[4] + "; " + tho; return mkrow(c)
    set_row("| **[Thomassen1999]**", f_tho)
    p114 = between(ed, "`[Polymath16threads]` — add: ", " **The Google group row**")
    assert p114.endswith("(FS114-NB §1.2 item 1).")
    p114 = p114[:-1]
    grp = between(ed, "**The Google group row** (`~/source/library/hadwiger-nelson-problem-group/`): ", " With these rows")
    assert grp.startswith("archived 2026-09-27 with no browser profile") and grp.endswith("the inventory calls it unheld.")

    def f_grp(r):
        c = cells(r); assert len(c) == 2 and c[1].startswith("**Held, unread**")
        c[1] = once(c[1], "**Held, unread**", "**Held, partly read**", "group verdict")
        c[1] = join_cell(c[1], "**FS-114:** " + grp)
        return mkrow(c)
    set_row("| T. Sirgedas and others, the Google group `hadwiger-nelson-problem`", f_grp)

    # FS-111's D5 amendments
    bk = [l for l in d5j.split("\n") if l.startswith("- **Amend `[Bukh2008]`**")][0]
    b_work = between(bk, 'add "', '" to the work')
    b_role = between(bk, 'role add "', '"; copy ')
    b_copy = between(bk, "; copy `", "`; read ")
    b_read = between(bk, '; read "', '".')

    def f_bukh(r):
        c = cells(r); assert len(c) == 5 and c[3] == "not held" and c[4] == "**not read — named only**"
        c[1] = c[1] + "; " + b_work
        c[2] = join_cell(c[2], b_role)
        c[3] = "`" + b_copy + "`"
        c[4] = b_read
        return mkrow(c)
    set_row("| **[Bukh2008]**", f_bukh)
    pm = [l for l in d5j.split("\n") if l.startswith("- **Amend `[Polymath16threads]`**")][0]
    p111 = between(pm, 'role add "', '".')

    def f_pm(r):
        c = cells(r); assert len(c) == 5
        c[2] = join_cell(join_cell(c[2], "**FS-114:** " + p114), p111)
        return mkrow(c)
    set_row("| **[Polymath16threads]**", f_pm)


# ======================================================================= item 6: the claim lists
def item6():
    d = blk(C114, "### `data/fs114/claims.md` — corrections at the close", "### `CLOSED-QUESTIONS.md` — declined")
    body = "\n".join(l for l in d.split("\n")[1:]).strip("\n")
    old9 = F["F1"][9][0]
    assert old9 == "C114-LOCAL-FR: not needed (C114-LOCAL-F alone is the NO)"
    body = once(body, "(C114-LOCAL-F alone is the NO)", F["F1"][9][1], "F1 claim-list line")
    s = get("data/fs114/claims.md").rstrip("\n")
    assert "## 9." not in s
    put("data/fs114/claims.md", s + "\n\n## 9. Corrections at the close (FS114-C, 2026-09-28; `plans/FS114-C-close.md`)\n\n" + body + "\n")
    d3 = blk(C111, "### D3. `data/fs111/claims.md`", "### D4.")
    body = "\n".join(d3.split("\n")[1:]).strip("\n")
    s = get("data/fs111/claims.md").rstrip("\n")
    assert "## 6." not in s
    put("data/fs111/claims.md", s + "\n\n## 6. Corrections at the close (FS111-C, 2026-09-28; `plans/FS111-C-close.md` §D3)\n\n" + r111(body) + "\n")


# ======================================================================= item 7: the stubs
def banner_under_title(p, banner_lines):
    lines = get(p).split("\n")
    assert lines[0].startswith("# ") and lines[1] == ""
    lines[2:2] = banner_lines + [""]
    put(p, "\n".join(lines))


def add_close_line(p, where, text):
    """Amendment 1, Q4: '*At FS-111's close:* <text>' at the end of a `## ` section (a new paragraph) or of a bold-labelled paragraph."""
    lines = get(p).split("\n")
    add = "*At FS-111's close:* " + text
    if where.startswith("## "):
        k = section_end(lines, where)
        while lines[k - 1] == "":
            k -= 1
        lines[k:k] = ["", add]
    else:
        i = next(i for i, l in enumerate(lines) if l.startswith(where))
        k = i
        while k + 1 < len(lines) and lines[k + 1] != "":
            k += 1
        lines[k] = lines[k] + " " + add
    put(p, "\n".join(lines))


def item7():
    # 7a: FS-114's closed banner (F1 pair 8), under the title
    d = blk(C114, "### `plans/STUB-global-step.md` — the closed banner", "### `tools/viz_proof_atlas_facts.py`")
    ban = [l for l in d.split("\n") if l.startswith("> ")]
    assert len(ban) == 3
    txt = once("\n".join(ban), F["F1"][8][0], F["F1"][8][1], "F1 banner")
    banner_under_title("plans/STUB-global-step.md", txt.split("\n"))
    # 7b: FS-111's closed banner (D7)
    d = blk(C111, "### D7.", "### D8.")
    ban = [r111(l) for l in d.split("\n") if l.startswith("> ")]
    assert len(ban) == 4
    banner_under_title("plans/STUB-reg-scale.md", ban)
    # 7c: D8
    d8 = bullets(blk(C111, "### D8.", "### D9."))
    g = d8[0]
    assert g.startswith("- **`plans/STUB-global-step.md` (FS-114), § Bearing:**")
    old = between(g, 'replace "', '" by: *"')
    new = between(g, '" by: *"', '"*')
    A, B = new.split("; the NO alone", 1)
    B = "the NO alone" + B
    tail = ", and `χ(ℝ²) = 7` given MR (rows 128, 131)."
    s = get("plans/STUB-global-step.md")
    s = once_ws(s, old + tail, A + tail[:-1] + "; " + B, "D8 global-step bearing (Q3)")
    s = once(s, "(C114-LOCAL-F) is the whole NO", "(C114-LOCAL-F) suffices for the whole NO", "Q9 stub paragraph")
    put("plans/STUB-global-step.md", s)
    where = {"plans/STUB-stuck-ray.md": "**Provisional bearings**", "plans/STUB-cp-plane-six.md": "## Bearing on χ ≥ 6",
             "plans/STUB-regular-half-residuals.md": "## Bearing on the answer", "plans/STUB-hole-dial.md": "## Provisional bearings",
             "plans/STUB-mr-in-lean.md": "## Provisional bearings", "plans/STUB-main-clause-five-kernel.md": "**Provisional bearings** (WORKFLOW 3.1 item 5)"}
    done = []
    for b in d8[1:6]:
        p = re.match(r"- \*\*`(plans/STUB-[a-z0-9-]+\.md)`", b).group(1)
        add_close_line(p, where[p], between(b, 'add *"', '"*')); done.append(p)
    b = d8[5]
    assert b.startswith("- **`plans/STUB-mr-in-lean.md` (FS-113) and `plans/STUB-main-clause-five-kernel.md` (FS-101):**")
    add_close_line("plans/STUB-main-clause-five-kernel.md", where["plans/STUB-main-clause-five-kernel.md"], between(b, 'add *"', '"*'))
    done.append("plans/STUB-main-clause-five-kernel.md")
    assert sorted(done) == sorted(where), done
    assert d8[6].startswith("- **Any stub a new grokking bears on:**")   # says both are in the lines above: nothing to file
    # 7d: F3 and F2
    s = get("plans/STUB-local-exclusion.md")
    for o, n in F["F3"]:
        s = once(s, o, n, "F3")
    put("plans/STUB-local-exclusion.md", s)
    f2 = joined(PR[PR.index("- **F2, FS-121's bearing**"):PR.index("- **F6, G72's count:**")])
    anchor = between(f2, 'after "', '" add "')
    add = between(f2, '" add "', '"\n')
    assert anchor == "Rank it by the NO it would add, not by the equivalence." and add.startswith("The same equivalence holds of")
    s = get("plans/STUB-map-step.md")
    put("plans/STUB-map-step.md", once(s, anchor, anchor + " " + add, "F2"))


# ======================================================================= item 8: plans/FRONTIER-STUBS.md
def item8():
    FSx = "plans/FRONTIER-STUBS.md"
    d = PR[PR.index("## Draft re-rank"):PR.index("## Draft for CLAUDE.md § Paths forward")]
    para = between(d, "**1. The re-rank paragraph** (to insert as the first paragraph under `## Ranked stubs`):\n\n", "\n\n**2.")
    assert para.startswith("*At FS-114's and FS-111's closes") and para.endswith("*")
    para = para.replace("\n", " ")          # one line, as every paragraph of the section is
    thead = between(d, "**2. The ranked table** (to replace the table under `## Ranked stubs`, header unchanged):\n\n", "\n")
    rows = [l for l in d.split("\n") if re.match(r"\| \d+ \| ", l)]
    tab = read("data/workflow3/r1/ranked-table.md").rstrip("\n").split("\n")
    assert rows == tab and len(tab) == 69
    openp = joined(d[d.index("**3. The open-milestones paragraph**"):d.index("**4. The closed list**")])
    newopen = between(openp, 'by: "', '"\n').replace("\n", " ")   # the paragraph is one line in the file
    closed = d[d.index("**4. The closed list**"):d.index("**5. Banner lines.**")]
    cl = joined(closed)
    cl_lines = [l for l in cl.split("\n") if l.startswith("* **FS-11")]
    assert len(cl_lines) == 2
    ban = joined(d[d.index("**5. Banner lines.**"):d.index("**6. Corrections owed")])
    b115 = between(ban, '- `plans/STUB-stuck-ray.md`: "', '"\n')
    assert b115.startswith("> **Re-aimed 2026-09-28 (R1), rank 4 → 6.**")

    s = get(FSx)
    lines = s.split("\n")
    # block 1: first paragraph under ## Ranked stubs
    i = lines.index("## Ranked stubs")
    assert lines[i + 1] == "" and lines[i + 2].startswith("*At FS-112's close")
    lines[i + 2:i + 2] = [para, ""]
    # block 2: the table (header unchanged)
    h = next(k for k, l in enumerate(lines) if l.startswith("| rank | stub | the question | bearing on the answer | cost |"))
    assert lines[h] == thead, "the table's header differs from Poros's"
    k = h + 2
    while lines[k].startswith("| "):
        k += 1
    assert k - (h + 2) == 66
    lines[h + 2:k] = tab
    # block 4: the closed list's head
    c = lines.index("## Closed, absorbed and demoted")
    assert lines[c + 1].startswith("* **FS-112 the unit-arc half**")
    lines[c + 1:c + 1] = [r111(l) for l in cl_lines]   # one line per entry, the list's own form
    s = "\n".join(lines)
    # block 3: the open-milestones sentences
    a = s.index("**None is open.** FS-112, the unit-arc half")
    e = s.index("(§ Toolchain).", a) + len("(§ Toolchain).")
    assert s[a:e].count("(§ Toolchain).") == 1
    s = s[:a] + r111(newopen) + s[e:]
    put(FSx, s)
    # block 5: FS-115's banner under its title
    banner_under_title("plans/STUB-stuck-ray.md", [b115])


def main(dry):
    item4(); item5(); item6(); item7(); item8()
    for p, s in OUT.items():
        assert "‹R111" not in s and "‹FS-111›" not in s, p
        print(f"{p}: {len(read(p).encode())} -> {len(s.encode())} bytes")
        if not dry:
            write(p, s)


if __name__ == "__main__":
    main("--dry" in sys.argv)
