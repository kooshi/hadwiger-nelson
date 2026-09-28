#!/usr/bin/env python3
"""X1 stage 3: file the closes' CLAUDE.md drafts (manifest item 3) verbatim, with F1, F9, the ruled merges and Amendment 1's Q1.

Sources: FS-114's units (plans/FS114-C-close.md § `CLAUDE.md`, checked against data/fs114/fs114-c/claude_md_units.py), FS-111's
clauses (§D2 items 1-4) and grokkings (§D4), Poros's open unit and Paths-forward rows (data/workflow3/r1/, re-assembled and compared
with the record at this stage), the coordinator's G72 line (Amendment 1 to the brief, on main).
Run from anywhere:  python3 data/workflow3/x1/file_claude.py [--dry]
"""
import os, re, subprocess, sys
from common import ROOT, read, write, once, once_ws, poros_pairs, r111

C114 = read("plans/FS114-C-close.md")
C111 = read("plans/FS111-C-close.md")
F = poros_pairs()


def units_114():
    """{name: (old, new)} from the close record's `#### <name>: replace` blocks."""
    a = C114.index("### `CLAUDE.md` — the shared units"); b = C114.index("### `plans/GROKKING-INSTANCES.md` — new instances")
    blk = C114[a:b]
    out = {}
    for m in re.finditer(r"#### (\w+): replace \(verbatim, the whole unit\)\n\n```text\n(.*?)\n```\n\nwith\n\n```text\n(.*?)\n```", blk, re.S):
        out[m.group(1)] = (m.group(2), m.group(3))
    assert sorted(out) == sorted(["last", "open", "prog", "i31", "g83", "g72", "rows"]), sorted(out)
    # the checker script holds the same texts
    cwd = os.getcwd(); os.chdir(ROOT); sys.path.insert(0, str(ROOT / "data/fs114/fs114-c"))
    import claude_md_units as U
    os.chdir(cwd)
    for k, (o, n) in out.items():
        assert U.old[k] == o and U.new[k] == n, f"record and checker disagree on unit {k}"
    return out


def fs111_clauses():
    a = C111.index("### D2. `CLAUDE.md`"); b = C111.index("**Corrections owed elsewhere in `CLAUDE.md`")
    lines = [l for l in C111[a:b].split("\n") if re.match(r"\d\. \*", l)]
    assert len(lines) == 4
    c1 = lines[0].split(":* ", 1)[1]
    c2 = lines[1].split(":* ", 1)[1]
    c3 = lines[2].split("the same at unbounded complexity\": ", 1)[1]
    c4 = lines[3].split("\"Past it, whether junctions keep a cone scale.\": ", 1)[1]
    return c1, c2, c3, c4


def grok_111():
    a = C111.index("### D4."); b = C111.index("**Instances for `plans/GROKKING-INSTANCES.md`**")
    g = [l for l in C111[a:b].split("\n") if l.startswith("* **G8")]
    assert [l[:9] for l in g] == ["* **G84 —", "* **G85 —"]
    return [r111(l) for l in g]


def g72_line():
    t = subprocess.run(["git", "-C", str(ROOT), "show", "main:data/workflow3/briefs/X1-front-page.md"],
                       capture_output=True, text=True, check=True).stdout
    a = t.index("## Amendment 1")
    blk = re.sub(r"\n  (?=\S)", " ", t[a:])
    s = blk.index('file exactly: "') + len('file exactly: "')
    e = blk.index('" Alternative weighed', s)
    line = blk[s:e]
    assert line.startswith("**The count so far — eighteen of twenty-one**") and line.endswith("both through).")
    return line


def main(dry):
    s = read("CLAUDE.md")
    n0 = len(s.encode())
    U = units_114()
    f1 = F["F1"]; f9 = F["F9"]
    c1, c2, c3, c4 = fs111_clauses()

    # --- last: F1 pair 3; FS-111's clause 1, ending with a full stop (ruling 1)
    o, n = U["last"]
    assert f1[3][0] == "so the NO is one exclusion at an explicit radius about such a vertex"
    n = once(n, f1[3][0], f1[3][1], "F1 last")
    n = once(n, "‹FS-111› ", r111(c1) + ". ", "last marker")
    s = once(s, o, n, "unit last")

    # --- open: Poros's whole unit (replaces FS-114's drafted one; merges FS-111's clause)
    o, _ = U["open"]
    pu = read("data/workflow3/r1/open-unit.md").strip()
    s = once(s, o, r111(pu), "unit open")

    # --- prog: F1 pair 4; FS-111's clause 3, ending with a semicolon (ruling 2)
    o, n = U["prog"]
    assert f1[4][0] == "the NO is one local exclusion about a four-colour vertex"
    n = once(n, f1[4][0], f1[4][1], "F1 prog")
    n = once(n, "‹FS-111› ", r111(c3) + "; ", "prog marker")
    s = once(s, o, n, "unit prog")

    # --- i31: F1 pairs 5 (across the line break) and 6; the heading parenthesis (ruling); FS-111's clause 4 with F9
    o, n = U["i31"]
    n = once_ws(n, f1[5][0], f1[5][1], "F1 i31 (a)")
    n = once(n, f1[6][0], f1[6][1], "F1 i31 (b)")
    n = once(n, "(§ The aim; rows 131–138;\n   FS-116, FS-117, ‹FS-111›)", "(§ The aim; rows 131–141;\n   FS-116, FS-117, FS-120–FS-122)", "i31 heading")
    c4f = once(c4, f9[0][0], f9[0][1], "F9 i31 clause")
    n = once(n, "‹FS-111›", r111(c4f), "i31 marker")
    s = once(s, o, n, "unit i31")

    # --- g83: F1 pair 7 on G83; G84 and G85 between G83 and G86
    o, n = U["g83"]
    n = once(n, f1[7][0], f1[7][1], "F1 G83")
    g84, g85 = grok_111()
    n = once(n, "\n* **G86 —", "\n" + g84 + "\n" + g85 + "\n* **G86 —", "G84-G85 placement")
    s = once(s, o, n, "unit g83")

    # --- g72: the coordinator's line (Amendment 1, Q1), in place of FS-114's drafted count (F6)
    o, _ = U["g72"]
    s = once(s, o, g72_line(), "unit g72")

    # --- rows: ‹last› = 141
    o, n = U["rows"]
    s = once(s, o, n.replace("‹last›", "141"), "unit rows")

    # --- § Paths forward: Poros's rows 1-29 and the group row
    lines = s.split("\n")
    h = lines.index("| rank | stub | the question | bearing on the answer |")
    assert lines[h + 1] == "|---|---|---|---|"
    k = h + 2
    while lines[k].startswith("| "):
        k += 1
    old_rows = lines[h + 2:k]
    assert len(old_rows) == 30 and old_rows[-1].startswith("| 30–66 | ")
    new_rows = [r111(l) for l in read("data/workflow3/r1/claude-paths-forward.md").rstrip("\n").split("\n")]
    assert len(new_rows) == 30 and new_rows[0].startswith("| 1 | **FS-116") and new_rows[-1].startswith("| 30–69 | ")
    lines[h + 2:k] = new_rows
    s = "\n".join(lines)

    assert "‹FS-111›" not in s and "‹R111" not in s and "‹last›" not in s
    print(f"CLAUDE.md: {n0} -> {len(s.encode())} bytes (net {len(s.encode()) - n0:+d})")
    if not dry:
        write("CLAUDE.md", s)


if __name__ == "__main__":
    main("--dry" in sys.argv)
