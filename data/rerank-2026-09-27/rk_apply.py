#!/usr/bin/env python3
"""RK's ranking pass: apply data/rerank-2026-09-27/rk_moves.py to plans/FRONTIER-STUBS.md (stage 2) and mirror ranks 1-29 into CLAUDE.md
§ Paths forward (stage 3). Writes plans/RERANK-2026-09-27.md's generated sections at stage 2. Idempotence is NOT a goal: each stage runs once
on the file state it asserts, and refuses (AssertionError) on any other.

    python3 data/rerank-2026-09-27/rk_apply.py stubs     # stage 2: FRONTIER-STUBS.md + the record's tables
    python3 data/rerank-2026-09-27/rk_apply.py mirror    # stage 3: CLAUDE.md's table
"""
import importlib.util
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location("rk_moves", ROOT / "data/rerank-2026-09-27/rk_moves.py")
M = importlib.util.module_from_spec(spec)
spec.loader.exec_module(M)

FS = ROOT / "plans/FRONTIER-STUBS.md"
REC = ROOT / "plans/RERANK-2026-09-27.md"
CL = ROOT / "CLAUDE.md"


def split_cells(line):
    """Cells of a markdown table row, splitting on pipes outside backticks (FS-41's question holds a bare |S|, so the bearing is
    located from the END: rank, stub, question..., bearing, cost, status, solver)."""
    cells, cur, tick = [], "", False
    for ch in line[1:]:
        if ch == "`":
            tick = not tick
        if ch == "|" and not tick:
            cells.append(cur.strip())
            cur = ""
        else:
            cur += ch
    return cells


def pipes(line):
    """Positions of the pipes outside backticks."""
    out, tick = [], False
    for k, ch in enumerate(line):
        if ch == "`":
            tick = not tick
        elif ch == "|" and not tick:
            out.append(k)
    return out


def set_cell_from_end(line, j, text):
    """Replace the j-th cell counted from the end (1 = the last cell) with text."""
    p = pipes(line)
    a, b = p[-j - 1], p[-j]
    return line[:a + 1] + " " + text + " " + line[b:]


def ranked_rows(lines):
    """(index, rank, fs, cells) for every row of the ranked table."""
    start = lines.index("## Ranked stubs")
    end = next(i for i, l in enumerate(lines) if l.startswith("## Closed, absorbed and demoted"))
    out = []
    for i in range(start, end):
        l = lines[i]
        m = re.match(r"\| (\d+) \| \*\*(FS-\d+)[ *]", l)
        if m:
            out.append((i, int(m.group(1)), m.group(2), split_cells(l)))
    return out


def stage_stubs():
    lines = FS.read_text().split("\n")
    rows = ranked_rows(lines)
    assert [r[1] for r in rows] == list(range(1, 65)), "ranks are not 1..64 in order"
    old_rank = {fs: rk for _, rk, fs, _ in rows}
    order = ["FS-110", "FS-111", "FS-104"] + M.NEW_ORDER
    assert [fs for _, rk, fs, _ in rows[:3]] == order[:3]
    assert sorted(order) == sorted(old_rank), "the new order is not a permutation of the table"
    new_rank = {fs: i + 1 for i, fs in enumerate(order)}
    old_bearing, new_line = {}, {}
    for i, rk, fs, cells in rows:
        line = lines[i]
        if rk <= 3:
            new_line[fs] = line
            continue
        ob = cells[len(cells) - 4]
        old_bearing[fs] = ob
        assert split_cells(line)[len(cells) - 4] == ob
        line = set_cell_from_end(line, 4, M.BEARING[fs])
        line = re.sub(r"^\| %d \| " % rk, "| %d | " % new_rank[fs], line)
        if fs in M.MOVES:
            mark = "**Re-ranked 2026-09-27 (RK; %d → %d).**" % (rk, new_rank[fs])
            line, n = re.subn(r"\*\*Re-ranked 2026-09-26 \(R3; [^)]*\)\.\*\*", mark, line, count=1)
            assert n == 1, (fs, "no R3 marker to replace")
            st = split_cells(line)[len(cells) - 2]
            line = set_cell_from_end(line, 2, st + "; re-ranked 2026-09-27 (RK)")
        new_line[fs] = line
    first = rows[0][0]
    for k, fs in enumerate(order):
        lines[first + k] = new_line[fs]
    # the ranked-stubs preamble: the new paragraph first, and FS-107's owed-task sentence now done
    txt = "\n".join(lines)
    owed = "Rows 6–64 keep six-framed bearings (FS-106 inventory items 5 and 82): a ranking task still owed.*"
    assert txt.count(owed) == 1
    txt = txt.replace(owed, "Rows 6–64's six-framed bearings (FS-106 inventory items 5 and 82) were restated at the ranking pass, the paragraph above.*")
    head = "## Ranked stubs\n\n"
    assert txt.count(head) == 1
    moved = ", ".join("%s %d → %d" % (fs, old_rank[fs], new_rank[fs]) for fs in M.MOVES)
    shifted = [fs for fs in M.NEW_ORDER if fs not in M.MOVES and old_rank[fs] != new_rank[fs]]
    para = ("*At the ranking pass (2026-09-27, RK; `plans/RERANK-2026-09-27.md`): every bearing of ranks 4–64 restated against the answer "
            "(`CLAUDE.md` § The aim, links 1–6; § Counter-priors, rule 1), grades and soft-as-to-truth warnings kept, \"none\" where it is the "
            "truth. **Moved:** " + moved + "; by insertion " + ", ".join(shifted) + "; ranks 1–3 and 20–64 unchanged.*\n\n")
    txt = txt.replace(head, head + para)
    FS.write_text(txt)
    # the record's generated tables
    t1 = ["| stub | was | now | reason |", "|---|---|---|---|"]
    for fs in M.MOVES:
        t1.append("| %s | %d | %d | %s |" % (fs, old_rank[fs], new_rank[fs], M.MOVES[fs]))
    for fs in shifted:
        t1.append("| %s | %d | %d | by insertion (no reason of its own; its bearing did not move it past a neighbour) |" % (fs, old_rank[fs], new_rank[fs]))
    t2 = ["| now | was | stub | bearing before RK | bearing after RK |", "|---|---|---|---|---|"]
    for fs in M.NEW_ORDER:
        t2.append("| %d | %d | %s | %s | %s |" % (new_rank[fs], old_rank[fs], fs, old_bearing[fs], M.BEARING[fs]))
    return "\n".join(t1), "\n".join(t2)


def stage_mirror():
    txt = CL.read_text()
    lines = txt.split("\n")
    hdr = lines.index("| rank | stub | the question | bearing on the answer |")
    grp = next(i for i in range(hdr, len(lines)) if lines[i].startswith("| 30–64 |"))
    old_rows = lines[hdr + 2:grp]
    fsl = FS.read_text().split("\n")
    rows = ranked_rows(fsl)
    assert [r[1] for r in rows] == list(range(1, 65))
    top = {fs: None for fs in ("FS-110", "FS-111", "FS-104")}
    for l in old_rows[:3]:
        fs = re.search(r"\*\*(FS-\d+)", l).group(1)
        top[fs] = l
    new = []
    for _, rk, fs, _ in rows[:29]:
        if rk <= 3:
            assert top[fs] is not None and top[fs].startswith("| %d |" % rk)
            new.append(top[fs])
        else:
            s, q, b = M.MIRROR[fs]
            new.append("| %d | %s | %s | %s |" % (rk, s, q, b))
    group = "| 30–64 | " + ", ".join(fs for _, rk, fs, _ in rows[29:]) + \
            " — in rank order; their rows are `plans/FRONTIER-STUBS.md`'s alone | … | … |"
    lines[hdr + 2:grp + 1] = new + [group]
    CL.write_text("\n".join(lines))
    return old_rows


if __name__ == "__main__":
    what = sys.argv[1]
    if what == "stubs":
        t1, t2 = stage_stubs()
        (ROOT / "data/rerank-2026-09-27/rk_tables.md").write_text("## 1. The moves\n\n" + t1 + "\n\n## 2. Every row, its bearing before and after\n\n" + t2 + "\n")
        print("stage 2 applied")
    elif what == "mirror":
        old = stage_mirror()
        (ROOT / "data/rerank-2026-09-27/rk_mirror_before.md").write_text("\n".join(old) + "\n")
        print("stage 3 applied; old rows:", len(old))
    else:
        sys.exit("usage: rk_apply.py stubs|mirror")
