"""FS129-P1 stage 2: fill the inventory readings and hunch statuses in place (each replacement asserted to hit exactly once)."""
import sys
P = "/home/kooshi/source/lean-dir/plans/POROS-2026-10-03-fs129-rerank.md"
s = open(P).read()
inv = {
"`plans/FS129-cross-application-audit.md` § 3": "no; stage 6 (ll. 96–98): P1 re-ranks with the new stubs beside L1, Keryx files both",
"`data/fs129/demand-judged.md`, J10": "yes; J10 (ll. 162–175) says only \"no open stub carries it\" and names the cover route's rungs; OR1 § J10 found it half true: MUA-FIN is FS-120's, REG-J′₅ FS-127's, and only MUA-REG-P and the top colour at five have no carrier (the correction, § 2.6)",
"`plans/FS129-OA1-audit.md` (lane A, pass 1)": "yes; 21 of 24 null as expected, but its J4 (§ 2.1) answers my FS-128 card \"no — coverage at the top colour restates TOP₆; it cannot spend six\", and finds the plane Hoffman-slack at every k (tightness at k = 3.4829…); its RINGWIND is a lane-A composition on a ring step (J2), which kills `arithmetic-bears-through-compulsion`",
"`plans/FS129-OR1-audit.md` (lane R, pass 1)": "yes; J1 closed as expected, but by repairing the restriction (whole tiles, radius ≤ √3), and J15 (§ J15) settles my card 2 on its first branch: routes R and M share their object at FS112-N3-COR3's corners; J10's note 3: at five a Grundy map needs no NO-PAR, and the obstacle is the unbound top colour, TOP₆'s at six",
"`plans/FS129-MA1-audit.md`, `plans/FS129-MA2-audit.md` (lane A, pass 2)": "no; read through their entries in the derivation file (§§ 1–3) and Z2's scored table: the Falconer-fan family and the slack-plane no-go on FS-104 routes (b), (c), as expected; the readers' own records sampled only at MA1 § 5.1 through FS-130's stub",
"`plans/FS129-MR1-audit.md` (lane R, pass 2)": "no; DOUBLETIP carries V6-HUG to every ring whose outer germs lie off (Q) arcs, and its control checks \"the three-step closure\" (derivation file, ll. 760–800)",
"`plans/FS129-SA1-audit.md` (lane A, pass 3)": "no; the merged family (PLACE-HOM, NOAFF-K, FALC-FAN, -DICHO-K, -RES, -RED) as expected; read through the derivation file, the record itself not opened",
"`plans/FS129-SR1-audit.md`, `plans/FS129-SR2-audit.md`, `plans/FS129-SR3-audit.md` (lane R, pass 3)": "yes in one place; SR3 dropped \"simple\" from EMPTY as well as from QFREE (EMPTY-NS), which my expectation did not foresee; read through the derivation file's entries (§§ 4–6), the records not opened",
"`plans/FS129-derivation.md` (44 entries, 12 superseded)": "yes; E1 fails: 10 of the 32 standing entries are lane A, 8 of them bearing on FS-104's routes (b) and (c) (§ 2.1)",
"`plans/FS129-Z1-record.md`": "no; not opened beyond the derivation file's preamble, which states its changes entry by entry; sampled, not read",
"`plans/FS129-Z2-record.md` § Stage 4 (stubs), § Stage 6 (predictions), § Stage 7 (sweeps), § Drafts for the front page": "yes; row 154 is not the cover route's rungs but FS129-OR1-TOP5, the honest route's top colour at five (E3 fails); G92 drafted as a method grokking as expected; § Stage 7 records the §IQ partial counterexample for me",
"`plans/STUB-bicycle-windings.md` (FS-130)": "yes; E2 killed — the bicycle is two unit circles whose centres are 1 < d < 2 apart (C-T-BIKE), its windings FS-110's ring winding (G71's height), its bearing route R's, through branch (i) of Voronov's Lemma 6.1",
"The nine stubs Z2 touched": "no; dated paragraphs and correction notes only (`git show 26f2fe55`), no question rewritten; FS-122's l. 37 corrected to Condition 5",
"`plans/FRONTIER-STUBS.md` (the table as it stands)": "no; ranks 1–12 and 18 read in full (ll. 44–55, 61); FS-130 absent; rank 3's cell still calls the regularity route at five \"a reformulation, not a shortcut\"",
"`plans/FS129-close-inventory.md` items 26, 43, 58, 138, 146": "no; items 26, 43, 58, 138, 146, 147 read; the middle sample (70–90) not read — replaced by the derivation file, which carries those items' results",
"`data/fs129/reports/*.md` (the readers' hand-backs)": "no; Z2's and OR1's heads agree with their records on the numbers (44 entries; rows 149–154; J1 with the whole-tile repair); the others not sampled",
"`data/fs129/z2/` (the where-else column, 97 theorems, 200 sites)": "yes; read through Z2 § Stage 3's table: 93 of 97 theorems with a site are lane R's, and lane A's four land on ledger rows (row 66 with 13 sites), not on ring steps — my expectation was right on the lane and wrong on the unit: the column is per theorem, and the arithmetic era's yield is per row",
"`plans/STUB-top-colour.md` (FS-128), my card": "no; the phrase is there (carried card, ask line); OA1 § 2.1's correction applies",
"The absent": "yes; the carrier is half absent (FS-120 and FS-127 hold two of the five-colour rungs), the tally of new-kind steps is absent, and Z2 wrote nothing in FS-127 or FS-128, as expected",
"The conditions of the last reading": "no; Z2 scored after reading the nine records, by a tool with a planted fault; my FS129-Q1 reading (17:47) preceded every reader, so its cards are re-scored here",
}
lines = s.split("\n")
for k, v in inv.items():
    hits = [i for i, l in enumerate(lines) if l.startswith("- " + k) and l.endswith("surprised: unread")]
    assert len(hits) == 1, (k, hits)
    i = hits[0]
    lines[i] = lines[i][: -len("unread")] + v
s = "\n".join(lines)
stat = {
"bends-keep-the-class": "confirmed, in a repaired form (by: derivation — FS129-SR1-BENDANY over FS129-OR1-WHOLE, one mind, attacked by FS129-SR1 without success: the bends keep the class on the whole-tile restriction of radius at most √3; the round neighbourhood my claim named can cut a tile into a Siamese pair, control fs129-or1-cut)",
"qfree-class-is-empty": "confirmed, stronger than registered (by: derivation — FS129-OR1-QFREE, and FS129-SR3-QFREE-NS without simplicity, one mind each)",
"identity-is-three-step-closure": "confirmed (by: derivation — FS129-SR1-TWOCIRC's identity and control fs129-mr1-doubletip's flank clause, \"the three-step closure\", exact)",
"arithmetic-bears-through-compulsion": "killed (by: FS129-OA1-RINGWIND, lane A's composition on J2, FS-124 case 1, a ring step; superseded by FS129-SR1-RINGBAND; the first half held — row 66's repaint carried lane A's FS-104 yield, FS129-SA1-NOAFF-K and the Falconer-fan family)",
"rank-one-is-the-ring-residue": "confirmed (by: R2's table, FS-123 at rank 1, and this record's § 3, FS-124 at rank 1 — a self-prediction, scored for the ledger's count only)",
"the-room-is-on-q-rings": "open (confirmed in the non-Siamese class, stronger, at `1 + ε`: FS129-SR3-QFREE-NS, one mind; the Siamese class open — FS-123)",
"next-miss-is-a-class-hypothesis-unread": "confirmed, weakly (by: FS129-SR2-TOUCHW, FS116-N1-TOUCH's hypothesis idle; FS129-SR2-SUPK, FS106-SUP's argument reading no class count; FS129-SR3-EMPTY-NS — the brief had named the pattern, so the hunch carried little)",
}
for name, new in stat.items():
    key = "hunch: " + name + "\n"
    i = s.index(key)
    j = s.index("  status: ", i)
    k = s.index("\n", j)
    assert s.count(key) == 1
    s = s[:j] + "  status: " + new + s[k:]
if "--fault" in sys.argv:
    assert s.count("surprised: unread") == 1, "fault: an unread line should remain"
open(P, "w").write(s)
print("filled", len(inv), "inventory lines,", len(stat), "statuses; unread left:", s.count("surprised: unread"))
