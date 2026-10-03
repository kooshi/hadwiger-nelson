#!/usr/bin/env python3
"""FS116-Z2 — draft the four CLAUDE.md units FS-116 and FS-121 share, in full, with FS-121's ‹FS-121› clauses (plans/FS121-Z1-close.md D2) placed
verbatim, plus FS-116's two small corrections (the theory paragraph, § The aim's link 5). Reads CLAUDE.md as it stands, applies named
substitutions (each must find its old text exactly once, or exit 1), writes the drafted units to data/fs116/fs116-z2/claude-md-units.md and a
whole-file draft to data/fs116/fs116-z2/CLAUDE.md.draft, and prints the byte counts. Nothing is written to CLAUDE.md (Keryx's file).

    python3 tools/fs116_z2_units.py           # draft; prints sizes
    python3 tools/fs116_z2_units.py --plant   # one old text altered: must exit 1
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "data/fs116/fs116-z2"


def fs121_clause(label: str) -> str:
    text = (ROOT / "plans/FS121-Z1-close.md").read_text()
    sec = text.split("### D2.", 1)[1].split("### D3.", 1)[0]
    m = re.findall(r"- \*" + re.escape(label) + r",?\*[^\"]*?\"(.*?)\"", sec, re.S)
    if len(m) != 1:
        raise SystemExit(f"FAIL: FS-121's clause {label!r} found {len(m)} times")
    return " ".join(m[0].split())


def main() -> int:
    claude = (ROOT / "CLAUDE.md").read_text()
    f121_last = fs121_clause('"Last updated" line')
    f121_open = fs121_clause("Open-milestones line")
    f121_aim = fs121_clause("§ The aim's programme line")
    f121_31 = fs121_clause('"Where the problem stands" item 31')

    # ---- unit 1: the "Last updated" line, whole
    m = re.search(r"\*Last updated: 2026-09-28 — .*?Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git\.\*\n", claude, re.S)
    old1 = m.group(0)
    new1 = ("*Last updated: 2026-10-03 — **FS-116, the local exclusion, closed undecided** (rows ‹R116-a›–‹R116-d›; `plans/FS116-Z1-close.md`,\n"
            "`plans/FS116-Z2-close.md`): the YES needs no map, and in non-Siamese simple fragments a four-colour vertex whose ring carries no boundary arc\n"
            "dies at `1 + ε`; the (Q)-free, (Q) and saturated cases left are FS-123–FS-125. " + f121_last + " Before them, **FS-114**\n"
            "(rows 137–138), **FS-111** (rows 139–141), **FS-112** (rows 135–136), **FS-110** (row 134), **FS-107** (row 133) and **the reframe** (Kooshi,\n"
            "2026-09-26): the aim is the answer, formalized in Lean (§ The aim). Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*\n")

    # ---- unit 2: the open-milestones paragraph, whole
    m = re.search(r"\*\*Open milestones, in order\.\*\* \*\*None is open\.\*\*.*?Every earlier close: `plans/FRONTIER-STUBS.md`'s closed list\.\n", claude, re.S)
    old2 = m.group(0)
    new2 = ("**Open milestones, in order.** **None is open.** FS-116, the local exclusion (`plans/STUB-local-exclusion.md`), is **closed undecided** (rows\n"
            "‹R116-a›–‹R116-d›); its successors are FS-123, the (Q)-free ring (`plans/STUB-qfree-ring.md`, opening with whether a fragment's bends keep the\n"
            "class FS116-Y4-EMPTY reads), FS-124, the (Q) ring (`plans/STUB-q-ring.md`), and FS-125, the saturated class (`plans/STUB-saturated-local.md`).\n"
            + f121_open + " **Next:** Poros's re-rank (`plans/FRONTIER-STUBS.md`); BASE-V stands beside them (row 134's base re-derived but for\n"
            "Lemma 4 at cusps). **M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it. Every earlier close:\n"
            "`plans/FRONTIER-STUBS.md`'s closed list.\n")

    # ---- unit 3: § The aim's programme line (FS-116's and FS-121's clauses)
    old3a = "**FS-116, the local exclusion**;"
    new3a = ("**FS-116, the local exclusion — closed** (rows ‹R116-a›–‹R116-d›: the Γ-free four-colour vertex dies at `1 + ε`); its successors **FS-123,\n"
             "the (Q)-free ring**, **FS-124, the (Q) ring**, **FS-125, the saturated class**;")
    old3b = "**FS-121, the map step**"
    new3b = f121_aim
    m = re.search(r"\*\*The program\*\* \(`plans/STUB-regularity-wall.md`\):.*?\n\n", claude, re.S)
    old3 = m.group(0)
    if old3.count(old3a) != 1 or old3.count(old3b) != 1:
        print("FAIL: § The aim's programme line: a clause marker not found exactly once")
        return 1
    new3 = old3.replace(old3a, new3a).replace(old3b, new3b)

    # ---- unit 4: "Where the problem stands" item 31, whole
    m = re.search(r"31\. \*\*The regularity wall, verified;.*?Bearing on the answer: none moved; half of door \(A\) closed, the other half reduced to one local statement\.\n", claude, re.S)
    old4 = m.group(0)
    new4 = ("31. **The regularity wall, verified; the question is stability; at bounded complexity, one four-colour vertex** (§ The aim; rows 131–141,\n"
            "   ‹R116-a›–‹R116-d›, ‹R121-a›–‹R121-c›; FS-117, FS-120, FS-122–FS-128). Regular classes need seven almost everywhere — slack, polygons, convex\n"
            "   tilings, nice maps — and maps six; closed classes are the tight question itself. With no MR, `χ_m⁰ ≥ 7` ⟺ `lim µ₆(ε) < 1` (row 131). At bounded\n"
            "   complexity that is whether a tight six-map exists (row 133): under Condition 5 none does (row 134); with unit arcs every one has a vertex of at\n"
            "   least four colours (rows 135, 137), so one exclusion at an explicit radius, above `φ²/√2`, about such a vertex suffices for the NO; where the count\n"
            "   gives six room the configurations die at `√3` or `1 + ε` but for named cases, and both printed positives are part of no such map (rows 136, 138).\n"
            "   FS-116 (rows ‹R116-a›–‹R116-d›): valid fragments on discs of every radius give `χ(ℝ²) ≤ 6` with no MR, so that exclusion decides both ways;\n"
            "   a four-colour vertex whose ring carries no boundary arc dies at `1 + ε` (non-Siamese, simple), and the ring's change points off (Q) arcs are\n"
            "   four-colour vertices; open: (Q)-free rings with (R2) arcs, (Q) rings, five- and six-colour vertices, the saturated cross off its class, Siamese\n"
            "   fragments. The doors are two routes, not halves (row 139, two minds): seven is the NO's hole bound made uniform in the complexity bound, so\n"
            "   FS-114's NO reaches it only through the map step — or through route R's forced pair, where the NO is idle — and each is the answer restated;\n"
            "   route M's rungs hold down to the pinch at a junction (rows 140–141; FS-120–FS-122). " + f121_31 + "\n"
            "   Bearing on the answer: none moved; half of door (A) closed, the other half one local statement, now a case list (FS-123–FS-125).\n")

    # ---- corrections: the theory paragraph (FS-116's clause, and FS-121's at its marker), § The aim's link 5
    th_old = "at an explicit radius uniform in the complexity (row 137, G83), and a tile count reaches only its non-Siamese part (G86; all [hand])."
    th_new = ("at an explicit radius uniform in the complexity (row 137, G83), and a tile count reaches only its non-Siamese part (G86; all [hand]); such a\n"
              "vertex whose ring carries no boundary arc dies at `1 + ε` in the non-Siamese simple class (row ‹R116-d›, G91; [hand], two minds).")
    th2_old = "open (rows 140–141, G84, G85; [hand])."
    sec = (ROOT / "plans/FS121-Z1-close.md").read_text().split("### D2.", 1)[1].split("### D3.", 1)[0]
    app = re.findall(r"Correction owed, the theory paragraph\*.*?append \"(.*?)\"", sec, re.S)
    if len(app) != 1:
        print("FAIL: FS-121's theory-paragraph append not found exactly once")
        return 1
    f121_theory = " ".join(app[0].split())
    th2_new = "open (rows 140–141, G84, G85; [hand])" + f121_theory + "."
    l5_old = "A refutation needs no wild set: it is a sequence of periodic grid-square colourings, wild only in the\n   limit, whose normal form FS-103 holds."
    l5_new = ("A refutation needs no wild set: it is a sequence of periodic grid-square colourings, wild only in the\n   limit, whose normal form FS-103 holds,"
              " or valid fragments on discs of every radius (row ‹R116-a›).")
    subs = [("unit 1", old1, new1), ("unit 2", old2, new2), ("unit 3", old3, new3), ("unit 4", old4, new4),
            ("theory clause", th_old, th_new), ("theory FS-121", th2_old, th2_new), ("aim link 5", l5_old, l5_new)]
    if "--plant" in sys.argv:
        subs[4] = ("theory clause", th_old.replace("G83", "G38"), th_new)
    draft = claude
    for name, old, new in subs:
        if draft.count(old) != 1:
            print(f"FAIL: {name}: old text found {draft.count(old)} times")
            return 1
        draft = draft.replace(old, new)
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / "CLAUDE.md.draft").write_text(draft)
    body = ["# The four shared `CLAUDE.md` units in full, and FS-116's two corrections (drafted by FS116-Z2; FS-121's clauses verbatim)\n"]
    for name, old, new in subs:
        body.append(f"\n## {name}\n\n*Replaces ({len(old.encode())} bytes):*\n\n```\n{old.rstrip()}\n```\n\n*With ({len(new.encode())} bytes):*\n\n```\n{new.rstrip()}\n```\n")
    (OUT / "claude-md-units.md").write_text("".join(body))
    f121 = sum(len(x.encode()) for x in (f121_last, f121_open, f121_aim, f121_31, f121_theory)) - len("**FS-121, the map step**".encode())
    total = len(draft.encode()) - len(claude.encode())
    print(f"CLAUDE.md now {len(claude.encode())} bytes; drafted {len(draft.encode())} bytes; net {total:+d}")
    print(f"FS-121's clauses placed: about {f121} bytes of that; FS-116's net ≈ {total - f121:+d}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
