# Session handoff — 2026-10-14, evening: the port and the density equality on `main`; the density bound proved and landing; the chain one join from its headline

*Rewritten 2026-10-14 19:42 UTC by Keryx, at Kooshi's word ("Please write your handoff now. Compaction imminent"). Current state
only. A successor reads this file first, then `plans/FS131-close-inventory.md` items 837–914 (everything since the morning
handoff, each with its receipt and its ruling in four parts; items 750–836 are older, and their written times in 750–810 are wrong
by up to six and a half hours, item 812). `plans/SESSION-HANDOFF-2026-10-13.md` is older still: read it only for the parked frontier
(its § 8) and the older corrections (its § 7). **On resuming, tell Kooshi in one line that the handoff is current and four jobs are
running.***

## 1. Kooshi's words in force

Verbatim in `data/fs131/REQUEST-2026-10-13.md`: **W1–W3** (wind down and publish the repository; every finding of ours formalized;
reports only at a gate, a decision that is his, or his check-in); **W4** (the port approved; Lean/Mathlib stay at v4.32.0 for good);
**W5**: **four agents at once** (a Sonnet agent counts half; `.claude/output-styles/keryx.md` § Staffing on disk says four — the
system prompt sometimes injects a stale three-slot copy; the file governs) and **time estimates = Lean lines ÷ the measured rate**
(about 850–950 net lines per active hour; implementers write 0.3–0.85 of their planners' lines); **W6**: Rudin's book (held); "Yes,
prove the density bound." (done on its line, landing now); and the **conditional instruction**: *when the five-colour chain lands*
(row 121's `χ(ℚ(√47)²) = 5` through the gate on `main`, no hypothesis of ours left) — sanitization, history rewrites, READMEs, a
public readable roadmap, a push to GitHub; "Not a full writeup"; **each irreversible step confirmed with him at the time**; nothing
published before the chain lands. **Nothing is waiting on him.** He has had a report at each landing and at each notable result.

**Machine.** Laptop, 12 cores, 31 GB; disk 83 %, 316 GB free. Memory tool: `env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3
scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name <tag> -- <cmd>`; jobs may ask up to 12 GiB without telling me. A cap kill
under `timeout` shows as 143 — read `journalctl` for "oom-kill". **The remote is down**: commit locally, then **`git push -q
backup --all`** after each commit. Agent ids: scratch `agents.txt`, copies `~/source/lean-dir-tmp-rescue-2026-10-13/agents.txt` and
`agents-scratch-copy.txt`.

## 2. Held on `main`

- **The port** (FS131-LP1, merged `398523e99`): `Outside.OAI158.proper_to_borel_weak` is `[OAIMath2026]`'s theorem ported with its
  proof; the library declares two outside axioms (Weil's bound; the release's five-colouring theorem).
- **The density equality — FS-133 Closed** (FS133-LD1, merged `5e4a6ac65`; FS-133's own inventory ticked).
- **Filings:** FC4 (`684d5fe5e`) and FC5 (`8eece67b0`; the "Last filed" chain's older entries moved to `plans/FILINGS.md` under the
  size budget, `CLAUDE.md` 77,141 of 80,000 bytes). **The next filing's fact-audit base: `8eece67b0`.**
- **Counts on `main`:** audit 9,101 records (9,038 clean, 32 axiom-free, 26 imported, 5 purchases); `axioms=2 rests=27`; vacuity
  `declarations=17902 refutations-skipped=234`. **Reference compiled tree for `main`: `fs133-wk1`.**
- **Today's search** (SEARCH-2026-10-14, item 908): smaller class-ratio certificates at p = 19 and p = 11, each accepted by FS-66's
  frozen checker, in `data/search/2026-10-14/certs/` (read there; not copied to `data/fs66/`). Search queue row 24: done.

## 3. Running now (two jobs; two slots left free on purpose)

1. **FS131-LCH1 — the chain's landing, part 1** (tree `fs131-wq1`, branch `fs131-wlc` from `fs131-wm15`, item 931, amended in items 933, 934, 938): merging `main`, **`fs131-wcm4`** (M13 with its dyadic certificates, item 938) and **`fs131-wc17`** (the bound at p = 19, item 937); the eight ruled integrations; the joined tree's gate steps; drafts for part 2.
2. **FS131-IKL1 — the certificate link** (tree `fs132-wi1`, branch `fs131-wkl` from `fs131-wcm3` with `fs131-wc16` merged, item 929): K3–K5 in a module `ClassRatio` imports; Hensel's count and the per-character bound as hypotheses discharged at part 2 by `ClassRatio`'s `card_res_fibreT` and `norm_charSum_le_of_resT` with `exists_conj_sub_notMem` (items 932, 938); `q = 19` over `FibreShareBound 19 U`, discharged by `FibreCertSound.sum_le_nineteen`.

**Why two slots are free:** nothing else is on the chain's critical path, the memory tool's 22 GiB is the bottleneck for the two Lean jobs, and the second filing waits for the chain's records to reach `main` (item 938's turn). **Handed back since the last rewrite:** FS131-IKC4 (item 937: the bound at p = 19 on the standard three, the checker unchanged, F2 not built; 49 MB of generated p = 19 text in git — to Kooshi with the publication pass; search queue row 25 would shrink it below 1 MB), FS131-ICM4 (item 938: M13 rests on `ratioAtMost_cert` alone).

**Landed today since the last rewrite:** **the density bound** (FS131-LDB1, merged `2d71a0872`, item 927; `main` equal to the gated `7a2acfef8` outside `plans/` and `data/`; announced). **Handed back:** the join (FS131-IJN1, item 918), M13's leaves (FS131-ICM3, item 922), the instances (FS131-KM15, item 926: `χ(ℚ(√47)²) = 5` over `hOA`, through the headline's leaves and one link, `fs131-wm15` in `fs131-wq1`, whose build is current). **Reference compiled tree for `main`: `fs131-w10g`** (the gated build). **Counts on `main`:** audit 9,824 records (9,438 clean, 355 axiom-free, 26 imported, 5 purchases); `axioms=2 rests=27` unchanged; vacuity `declarations=20563`.

## 4. Where each line stands

**The five-colour chain** (headline `min_localBound_five_le_chromaticNumber_of_closed`; the join states it closed) — proved on its
branches today: lane T and M8b (the adelic model; the zero-entropy side), M10, M2a, M3, M2b, M11, the entropy split with lane A
(Einsiedler–Lindenstrauss Thm 1.2 from their Thm 1.3), M5-E and M5-P, the count (all eight modules), M13's public theorems over
Weil's bound with four private leaves left (three in ICM3, the certificate link at the join), the certificate checker proved sound
(it was found unsound and strengthened, items 853, 869), the bound at p = 11. **The chain will rest on two declared outside
theorems**: Weil's bound (M13's tail) and `positive_entropy_rigidity` (EL Thm 1.3). **Lines to join at the chain's landing:**
`fs131-wj` (IJN1), `fs131-wcm3` (ICM3), `fs131-wc17` (IKC4; from `main`), and `main` (which will hold the density bound). **Still
unassigned: M15** — the instances, `ℚ(√47)` first (`fs131-wch:plans/FS131-KR1-chain-map.md` § 2.7); `χ(ℚ(√47)²) = 5` through the gate
on `main` is W6's trigger.

**Rulings to carry at the chain's landing:** M3's private copies of `main`'s `Plane/OneClass/InvariantLaw` helpers made one shared
copy (item 876); the `UnitCircle` and `ClassRatio` docstrings (items 897, 893) if the join has not done them; the generated
`congr_simp` names allowed (items 850, 881); every ruled statement change the jobs listed (binder drops under item 726's word;
`rowsEdgeNull_levelRows` gains `TCA F`, item 878; `finite_quot` gains `[NumberField F]` and `countable_splitPlace` its binder, item 847). **The density bound's `mOne` (item 916):** at the density bound's landing this line's definition is deleted for `main`'s, with a bridge theorem stating the old definition as an equality; at the chain's landing `Plane/WindowDensity`, `CountDescent` and `PlaneZhang` (which read the old definition by its shape) are rewritten through that bridge, and the chain's copy of `Plane/OneAvoidingDensity` gives way to `main`'s.

**Rank 4, the p-adic result (row 75):** unplanned; after the chain.

## 5. The queue (launch into each slot as it frees)

1. **The chain's lander, part 1 — running (FS131-LCH1, above).** **Part 2** at FS131-IKL1's hand-back (FS131-ICM4's and FS131-IKC4's lines join in part 1): merge `fs131-wkl`; `ratioAtMost_cert` one line; `q = 19`'s hypothesis
   discharged; the full gate on one commit (item 808's rule); drafts; the filing. **Then the W6 publication pass**, each
   irreversible step confirmed with Kooshi. The ~110 MB of p = 19 text, if F2 is built in full, goes to him then (item 902).
2. F2's remaining parts if FS131-IKC4 needs them.

Generators: `data/fs131/briefs/scripts/mk-*.py` on `mkbrief.py` (`fresh(JOB)` refuses a used id or a folder name used under any
`data/fs13*/`). Gate every brief (`python3 .claude/skills/keryx/scripts/brief_gate.py all <brief>`) and **commit only inside `if
<gate>; then … fi`**; write paths in full under the job's tree; reword "independent" in a role line (the gate's false positive); the
statements section must hold the quotations. Templates by kind: an implementer on the chain's line `mk-fs131-ij3.py` or
`mk-fs131-icm3.py`; a landing `mk-fs131-ldb1.py`; a filing `mk-fs131-fc5.py`; the Searcher `mk-search-1014.py`.

## 6. Owed, not done

- **The second filing** (base `8eece67b0`): the older handoff's § 7 list; the `LEAN.md` lines drafted in today's records (KN7, KN8,
  KN9, KT1, K8B1, KPD1, KR1, K12A, KDB1, KC13, KM11, ITK1, IJ1, IJ2, IJ3, IM11, ILA1, ICL1, ICL2, ICM1, ICM2, IKC1–IKC3, IDB1–IDB3,
  IN1L, IDG1, IG1, IPA1, IPB1, IPD1, IP23, ITT1, the port's classes); bibliography lines (`[EinsiedlerLindenstrauss2022]`,
  `[OAIMath2026]`, `[Rudin1962]`, `[AmbrusEtAl2023]` with p. 18's sign of `J₀′`, `[KMOR2016]`, Schur 1912 (key `Schur1912`, "recalled, not read"), and
  those KR1, K12A, KC13 drafted); corrections: `plans/EXT-OAI1-audit.md` 16,600 → 12,005 lines; `scripts/Vacuity.lean` l. 561; the
  density bound's price (items 818, 823); M13's prices (items 848, 893, 905); K2's price (item 886); F2's price (item 902); J26/J49's
  grade note (item 845); KDB1's prototype truncation (item 911); the IDB1 record's mis-headed last section (item 895); J45's erratum
  (item 873); FS-133's deriver's predictions to score; the `--dupes` +1 run.
- **One sweep of older docstrings and proof hygiene** (the unread `have hne` in `residual_fourier_model`; docstrings flagged in items
  876, 890).
- **The tooling list:** `slot.py` reads a cap kill only at 137; `code_only_diff.py` plants at the first `:=`; `#eval` dumpers buffer;
  the assumptions step cannot see a discharged written-out hypothesis nor a projection's model; the brief gate's "independent" false
  positive; the port generator's textual guard; `fresh()`'s cross-milestone folder match; **a skeleton `instance`/`def` with a
  `sorry` body drops the section's instance variables** (item 847); statement comparators that skip internal names (item 905);
  `lake lint` is run by no planner and by neither the build nor `lake env lean` (item 863); `tools/fs131_ikc1_gen.py` writes its
  summary inside `Proofs/` (item 902); a per-module batch option for `build.sh` (item 902).
- **Cleanup** (in W6's pass, each irreversible step with his word): finished trees' builds and untracked logs; the 335 MB of p = 19
  probe data in `fs131-wnf:data/fs131/ikc3/` once F2's form is settled.

## 7. Rules from today

Times from `date -u`. Hand-backs quoted "from its hand-back message". Review by artifact: print the key theorem's axioms myself from
the agent's compiled tree before logging (`lake env lean` on a scratch file under the memory tool); read a probe's "does not exist"
with its namespace. A fact is proved once: move a statement upstream rather than copy it; make a private lemma public rather than reach
it by `open private`. An unread binder of a theorem of ours is dropped with a dump; on a definition whose binder would move other
stored types, `@[nolint unusedArguments]` with its reason. **A landing is announced only when the gate is green on one commit, merged
into `main`, and `main` checked equal to it outside `plans/` and `data/`** — the merge is mine, after the hand-back. **The size budget
is met by a move to a file read by address, its lost tokens given that home in the fact audit's `EXTERNAL_HOMES`.** When a search can
make a kernel job much smaller, run the Searcher before the job. A memory or disk reading near its limit is reported at once.
