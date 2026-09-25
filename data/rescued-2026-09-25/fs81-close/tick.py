import re
from pathlib import Path
P = Path("/home/kooshi/source/lean-dir/plans/FS81-close-inventory.md")
L = P.read_text().split("\n")
D, R, RC, S, B, PR, CM, H = "f3f5e3a5", "08606f17", "7b2834c4", "e55de81f", "4362efd9", "c159d042", "9ac6a758", "ff3cd5c3"
st = {
1: f"**done** at {RC} (§R-close.3) and {CM} (G72's second count, both ways); the split itself stays Kooshi's (item 7)",
2: f"**done** — at the opening (above); widened again at {CM} (item 10: χ = L for real quadratic fields with L ≤ 4)",
3: f"**done** — at the opening (above); the exposed-predictions paragraph updated at {CM}",
4: f"**done** — at the opening (above); FS-59's §00 added at {S}",
5: "**done** — at the opening (above)",
6: f"**done** — at the opening (above); filed as FS81-T25 at {D}; scored in §R-close.5",
7: f"**open (Kooshi)** — recorded both ways in G72 ({CM}) and §R-close.3 ({RC})",
8: f"**done** at {S} — one rank per row, 1–50, with a solver column",
9: f"**done** at {S} — §5 rewritten as where the programme stands; the order of work points at `plans/FRONTIER-STUBS.md`",
10: f"**open (Kooshi obtaining, item 33)** — every claim bounded: rows 82–83's *Not claimed* ({R}), G61 and item 14 ({CM}), both BIBLIOGRAPHY rows ({B})",
11: f"**done** — `[DeVosEtAl2007]` entered and read at the plan's gate (§PA); the glossary row (a `Θ_k` point = a circular colouring given by a character) at {B}",
12: f"**done** — routed to FS-64's stub and to FS-83 (the layer method at four and five colours) at {S}; derivation §5 R7 ({D})",
13: "settled",
14: "settled — the close planner does not push; the owner pushes",
15: f"**done** at {CM} — G54's *Do* names the refusing sign",
16: "**done** (the owner) — `data/fs81/briefs/` holds the seven briefs; the advisor's record is `plans/POROS-2026-09-24-fs81-plan.md` (checked present at the close)",
17: f"**done** — scored in §R-close.5 (P-G61b won); G61's reading with its killing test ({CM}); derivation §5 R1",
18: f"**done** — the plan's §IQ item 5; FS-83 ({S})",
19: f"**done** — registered as P0-T41-finite; scored in §R-close.5 (won as far as scorable); the d ≡ 23 (mod 48) lead to FS-75 ({S})",
20: "**done** — answered in the plan (§X card 5, §R-review item 2); the calibration is row 84",
21: f"**done** — §R-close.8 ({RC})",
22: f"**done** — verified blind by stage C; `LEDGER.md` row 82 ({R})",
23: f"**done, in pointer form** — `CLOSED-QUESTIONS.md` §1.7 gets a pointer and is not rewritten while the Johnson papers are unread ({B}); G61's demotion record ({CM})",
24: "**done** — stage C ran as ruled; T8 answers the finite-witness question",
25: f"**done** — row 82's consequences ({R}); item 14 ({CM})",
26: f"**done** — the verifier's §3.2; FS81-T6 ({D})",
27: f"**done** — re-read at the plan's gate (§PA.3) and by the verifier (§3.2); read status at {B}",
28: f"**done** at {S} — FS-48 re-aimed to multiquadratic fields without √3, ℚ(√2,√7) first",
29: f"**done** — FS81-T6 ({D}); row 82",
30: f"**done** — G61 demoted and G74 minted ({CM}); rows 82–83 ({R}); §1.7 pointer only ({B}); FS-75 re-aimed and FS-83 minted, FS-59's §00 ({S}); G72's count ({CM})",
31: f"**done** — §R-close.7 item 8 and §R-close.8 ({RC})",
32: f"**done** — the corrections bound stages B–D; recorded in §R-close.1 and .7 ({RC})",
33: f"**open (Kooshi obtaining)** — honoured at every claim: rows 82–83 ({R}), G61, item 14 and the prior-art position ({CM}), BIBLIOGRAPHY ({B}), §1.7 not closed ({B})",
34: f"**done** — its errors in §R-close.8 ({RC}); the protocol's fourth run ({PR})",
35: "**noted** — the held items stay outside `plans/`; nothing to file",
36: f"**done** — fixed at `634d75d3`; §R-close.8 ({RC})",
37: "**done** — P0.2 ran the two smallest (a, c), both signs (phase-0 record §5)",
38: f"**done** at {S} — a note in `plans/FS73-rigidity-dichotomy.md` §R-close.9; FS81-T19 ({D})",
39: f"**done** — FS81-T13 ({D}); P0.1-cells scored lost (§R-close.5)",
40: "**done** (bookkeeping)",
41: f"**done** — FS81-T15 ({D}); row 83 ({R})",
42: f"**done** — G21's instance ({CM}); FS81-T17 ({D})",
43: f"**done** — scored in §R-close.5 ({RC})",
44: f"**done** — FS81-T2, T3 ({D})",
45: f"**done** — the plan's §B; the X_A/X_B correction in §R-close.1 and .7 ({RC})",
46: f"**done** — P-F1–P-F3 are FS81-T1, T2, T5 ({D})",
47: f"**done** — FS81-T18 ({D})",
48: f"**done** — FS81-T3, T4 ({D})",
49: f"**done** — FS81-T5, T6 ({D}); C0 scored in §R-close.5",
50: f"**done** — §R-close.1 items 2–5, .6 and .8 ({RC})",
51: f"**done** — §R-close.8, the owner's errors ({RC})",
52: f"**done** at {CM} — § Toolchain's item 2 reworded (over the unpinned colours only, or the pinned clique first); FS81-T20 ({D})",
53: f"**done** — K2 built as specified (`677d59e9`); row 84 ({R})",
54: "**declined** — the ≈ 8.9 threshold is quoted nowhere at the close; it stays [external, unchecked] in plan §B.1.2",
55: "**done** — the verifier ran C4 on A (FS81-T8(b)); the implementer's verdict-line proposals recorded in §B.3",
56: "**done** (bookkeeping)",
57: f"**done** — row 82's grade [hand, two independent derivations] ({R})",
58: f"**done** — FS81-T1, T2, T5 ({D})",
59: f"**done** — FS81-T8(b) ({D}); G61's reading with its killing test ({CM}); derivation §5 R1",
60: f"**done** — FS81-T20–T22 ({D}); row 84 ({R})",
61: f"**done** — row 84 ({R})",
62: f"**done** — T1–T8 completed with proof verdicts, T7 re-read by the close planner ({D})",
63: f"**done** — FS81-T5, T7 ({D}); ℚ(√2,√7) in row 82 and FS-48's re-aim; the residual case is FS-82 ({S})",
64: f"**done** — FS81-T8 ({D}); row 83 ({R})",
65: f"**done** — scored in §R-close.5 ({RC})",
66: f"**done** — (1) FS-82 minted, (2) FS-75 re-aimed ({S}); (3) §R-close.7 item 5; (4) G61's reading ({CM})",
67: f"**done** — §R-close.8 ({RC})",
68: f"**done** — row 84; the solver-free bound in FS81-T23 ({D})",
69: f"**done** — the quiet numbers are row 84's ({R})",
70: f"**done** — row 84 ({R}); PD-1–PD-8 scored in §R-close.5",
71: "**done** by the owner at `912f9a67`; not restated at the close",
72: f"**done** — FS81-T9, T12 ({D}); row 83 ({R})",
73: f"**done** — row 83 ({R})",
74: f"**done** — row 83's tree prices ({R})",
75: f"**done** — row 84 ({R})",
76: f"**done** — row 84 ({R}); G65's instance ({CM})",
77: f"**done** — §R-close.8 ({RC})",
78: f"**done** — the re-asks ran to 4-hour walls; row 84 ({R})",
79: f"**done** — row 83 ({R}); the d ≡ 23 (mod 48) lead to FS-75 ({S})",
80: f"**done** — §R-close.5 ({RC})",
81: f"**done** — §R-close.8 ({RC}); G21's instance ({CM})",
82: f"**done** — § Toolchain and the Frontier ({CM}), `plans/FRONTIER-STUBS.md` ({S}), the session handoff ({H})",
83: f"**done** — FS81-T23 ({D}); row 84 ({R})",
84: f"**done** — row 84 ({R}); §R-close.5 and .8 ({RC})",
85: f"**done** — FS81-T24 ({D}); row 84 ({R})",
86: f"**done** — row 84 ({R}); FS-84 minted with D1's deep pass ({S})",
}
seen = set()
for i, l in enumerate(L):
    m = re.match(r"^\| (\d+) \|", l)
    if not m: continue
    n = int(m.group(1))
    if n not in st: continue
    body = l.rstrip()
    assert body.endswith("|")
    k = body.rstrip("|").rstrip().rfind(" | ")
    L[i] = body[:k] + " | " + st[n] + " |"
    seen.add(n)
assert seen == set(st), set(st) - seen
new = [
f"| 87 | prior art (the owner, from the algebra-week advisor's record) | **Soifer's Open Problems 55.1 (2019), \"Construct a triangle-free 5-chromatic unit-distance graph\", and 55.2 (one of the smallest order)**, `[Soifer2024]` ch. 55 p. 699, held and cited nowhere; a certified χ(ℚ(√47)²) = 5 would answer 55.1 (no √3, so no unit triangles, G57), Exoo–Ismailescu's smallest-subfield question and Moorhouse's. | the owner's message at the close; `plans/POROS-2026-09-24-algebra-week.md` §6.7 | **done** — `CLOSED-QUESTIONS.md` §3 and the Soifer read status ({B}); G50's instance ({CM}); FS-84's row names it ({CM}) |",
f"| 88 | correction (the owner) | The triangle-free remark (\"without triangles … must be computationally very hard\") is **Voronov's** (Polymath16, July 2021), not Parts's; fix it wherever the record says otherwise. | the owner's message at the close | **checked, nothing to fix** — every committed file attributing it says Voronov (`plans/FS58-four-colours.md` §PA; the algebra-week record); none says Parts. The `[Polymath16threads]` row now carries it, attributed to Voronov ({B}) |",
f"| 89 | bibliography debts (the owner) | de Grey 2026 (a triangle-free five-chromatic unit-distance graph in ℝ³, 61 vertices, in zbMATH); Haugstrup's pseudo-edge constructions (ℝ⁴, Polymath16, December 2025 – February 2026); Heule's T721 (a four-colour forced pair in ℚ(√2,√3)², not held). | the owner's message at the close | **done** at {B} — `[deGrey2026]` in § R.3 (zbMATH 1581.05080, listing only; the close planner re-found it by the API); Haugstrup and de Grey's December 2025 comment on the `[Polymath16threads]` row (read by the advisor, not by the close); T721 on `[Heule2021]`'s R.3 row (relayed; which paper holds it unchecked) |",
"| 90 | scoring (the owner) | The algebra-week advisor scored this morning's next-direction hunches in its §2; use them if the close scores that record's cards. | the owner's message at the close | **declined, with the reason** — this close scored no cards from the next-direction record (the brief did not route them here); the advisor's §2 stands as their scoring |",
f"| 91 | defect found (close planner) | `plans/FRONTIER-STUBS.md`'s FS-30 row had lost its bearing, cost and status cells at some earlier edit. | the re-rank's row parse | **done** at {S} — restored from `CLAUDE.md`'s mirror, marked as restored |",
f"| 92 | defect found (close planner) | FS-69 was missing from `CLAUDE.md`'s Paths-forward mirror. | the re-rank | **done** at {CM} — added at rank 27 |",
f"| 93 | method (close planner) | The fact audit's allowances: the ranges extended (1–84, G1–G74), the re-rank's group labels, the compressed open-milestones paragraph's four stub paths and `§ B.`, old item 14's '56th'/'57th', FS-9's old intro mention, G61's status tag. | `tools/claude_md_fact_audit.py` | **done** at {CM} — each with its reason; `--base fad1c032` PASS; `--dupes` 13 runs (was 15; the close's own repeats reworded) |",
f"| 94 | gates (close planner) | The close's gates, run under `scripts/slot.py`. | `build/gate/` | **done** — build up to date (1698 modules, 2 s); axioms 1034 clean, 5 declared (unchanged); vacuity counts unchanged (`declarations=6795`, `sites=275`, `unknown=2`); `check_architecture`, `bib_audit`, `fs71_ledger_b_check --strict` PASS (recorded at {H}) |",
]
last = max(i for i, l in enumerate(L) if re.match(r"^\| \d+ \|", l))
L[last+1:last+1] = new
P.write_text("\n".join(L))
print("ok")
