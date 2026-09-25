*Brief for crunch job **J23c**: milestone M3's close-math. Opus 5.5, 2026-09-25. Written by the product owner. **Its template is
J23a's brief** (`data/crunch-2026-09-25/briefs/J23a-M1-close-math.md`, M1's close): read that in full and follow it, with the changes
below, which override it where they differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **M3's close planner**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md`, `WORKFLOW.md` (step 9) and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this
brief.** I'm the product owner.

**If your outputs already exist, you are resuming:** the ticks in `plans/M3-close-inventory.md` and the `Stage n — SAVED` headings in
the plan's §R-close are your map; check them against `git log`, and continue at the first stage not SAVED.

## The milestone (replaces J23a's milestone block)

**M3 = "colourings no periodic colouring or character gives"** — plan `plans/M3-exotic-colourings.md`; its two questions:
- **Q1 (FS-76 in rank one):** is every countable four-colouring shift of a distance graph on ℤ finite (R2, A-T1)? Jobs: J18 (derivation,
  `plans/M3-S1A-rank-one.md`), J19 (second mind, `plans/M3-S1B-rank-one.md`), J20 (blind check, `plans/M3-S1V-rank-one.md`). All DONE;
  A-T1 is open at a named step, reached three times.
- **Q2 (FS-64 at five colours over ℚ(√167)):** can measurable windows over finitely many places five-colour the plane? Jobs: J21
  (derivation, `plans/M3-S1D-windows-five.md`), J22 and J22b (blind check, `plans/M3-S1V-windows-five.md`). All DONE; the verdicts agree,
  with gaps at D1-43 and D2(a)/(b).

**Your sources:** `plans/M3-close-inventory.md` (every item ticked or declined, numbers read from sources); the five records above; the
reports in `data/crunch-2026-09-25/reports/`; the index `plans/CRUNCH-2026-09-25-INDEX.md` §3 (M3).

**Two items only you can close:**
- **The FS-66 checker re-run at 23** (a frozen checker on `data/fs66/b1/cert-p23.json --m 5`): J22's first run was killed by its own 8 GiB
  slot cap (exit 137 at step 6/7, peak 8.38 GB — explained, not a crash; `data/m3/j22/fs66-cert-p23-m5.out`). The owner re-launched it
  under a 16 GiB slot; its log is `data/m3/j22/fs66-cert-p23-m5-rerun.out` (last line `exit=<code>` when done). Read its verdict when it
  has finished, commit the log, and file it; D1-fac's clause at 23 rests on row 75's recorded certified verdict either way.
- **The ban measurement:** list every "at the ban's edge" note in M3 (J19's enumeration of 94 rigid points of `X₄({2,6,11,13,14})`; J20's
  declined residue step mod 20, which the owner ruled waits for 2026-10-01; any others) and every would-have-searched line.

**Prior art:** M3 had no separate close-time gate job. Run WORKFLOW 3.2's items yourself on M3's results that could be new — J21-MX (a
spectral form of Burr–Erdős–Lovász; Hedetniemi for special factors; Kechris–Marks Problem 4.23), J21-TH/RED, J22-T10, J18-DC and J19-KT
(one-dimensional SFT colourings, Kempe moves) — with the zbMATH API, ≈ 60k tokens at most; record negatives as findings; never "new".
`[EggletonErdosSkilton1990]` is unheld (Kooshi asked); `[Zhu2021]`-type items the records list.

## Outputs

As J23a's: `plans/M3-derivation.md` (every theorem filed, with grade, verification status, address, what rests on it, kernel decision);
the plan's §R-close (re-reads, G72's count, predictions scored once, the verdict ruled in four parts, the honesty tally, the ban
measurement); **drafts** in §R-close only (LEDGER rows after the last one M1's close drafts — coordinate the number by reading
`plans/FS91-character-local-global.md` §R-close stage 4 if it exists, else leave the number as "next"; `CLAUDE.md` lines ≤ 4,000 bytes
net; stub re-aims for FS-76, FS-64, FS-59, FS-49, and new stubs as files).

## Rules (J23a's, with these paths)

Touch only `plans/M3-exotic-colourings.md` (§R-close), `plans/M3-derivation.md`, `plans/M3-close-inventory.md`, new stub files, the rerun
log above, and `data/m3/j23c/`. Subjects "J23c: stage n". Budget about 350k harness, hand back by 420k; a successor is expected if needed.
No subagents (delegation is one level deep; staffing is Kooshi's budget decision and the owner can only review work it knows about).
Report to `data/crunch-2026-09-25/reports/J23c.md` and by SendMessage `to: "main"`; final text "J23c idle; report sent to the owner by
SendMessage".
