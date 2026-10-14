# Session handoff — 2026-10-14, afternoon: the port and the density equality on `main`; four jobs running on the chain and the density bound

*Rewritten 2026-10-14 14:58 UTC by Keryx, between hand-backs, so a compaction loses nothing. Current state only. A successor reads this
file first, then `plans/FS131-close-inventory.md` items 837–861 (everything since the last rewrite, each with its receipt and its ruling
in four parts; items 750–836 are the morning's, and their written times in 750–810 are wrong by up to six and a half hours, item 812).
`plans/SESSION-HANDOFF-2026-10-13.md` is older: read it only for the parked frontier (its § 8) and the older corrections (its § 7).*

## 1. Kooshi's words in force

Verbatim in `data/fs131/REQUEST-2026-10-13.md`: **W1–W3** (wind down and publish the repository; every finding of ours formalized;
reports only at a gate, a decision that is his, or his check-in); **W4** (the port approved; Lean/Mathlib stay at v4.32.0 for good);
**W5**: **four agents at once** (a Sonnet agent counts half; `.claude/output-styles/keryx.md` § Staffing on disk says four — a stale
injected copy may show three; the file governs), and **time estimates are Lean lines ÷ the measured rate** (about 850–950 net
hand-written lines per active hour, item 825; implementers write 0.5–0.85 of their planners' lines, items 829, 845, 850); **W6**: Rudin's
book (held); **"Yes, prove the density bound."** (`m₁(ℝ²) ≤ 0.2470`, `[AmbrusEtAl2023]` Thm 1 — formalized, not declared); and the
**conditional instruction**: *when the five-colour chain lands* (row 121's `χ(ℚ(√47)²) = 5` through the gate on `main`, no hypothesis of
ours left) — sanitization, history rewrites, READMEs, a public readable roadmap, a push to GitHub; "Not a full writeup"; **each
irreversible step confirmed with him at the time**; nothing published before the chain lands. **Nothing is waiting on him.**

**Machine.** Laptop, 12 cores, 31 GB; disk 83 %, 318 GB free. Memory tool: `env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3
scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name <tag> -- <cmd>`; jobs may ask up to 12 GiB without telling me. A cap kill
under `timeout` shows as 143 — read `journalctl` for "oom-kill" (item 835). **The remote is down**: commit locally, then **`git
push -q backup --all`** after each commit. Agent ids: scratch `agents.txt`, copy `~/source/lean-dir-tmp-rescue-2026-10-13/agents.txt`.

## 2. Held on `main` (since this morning)

- **The port** (FS131-LP1, merged `398523e99`; item 841): the transfer `Outside.OAI158.proper_to_borel_weak` is `[OAIMath2026]`'s
  theorem ported with its proof; the library declares **two** outside axioms (Weil's bound, the release's five-colouring theorem).
  Filed (FS131-FC4, `684d5fe5e`).
- **The density equality — FS-133 Closed** (FS133-LD1, merged `5e4a6ac65`; items 856–857; FS-133's own inventory ticked):
  `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, `χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, `f(n)/n → m₁`, the labelling claim both ways — standard three, no
  import; not new (`[Davies2026]`, dimension ≥ 4). Filed (FS131-FC5, `8eece67b0`; item 859): the "Last filed" chain's older entries
  moved to `plans/FILINGS.md` under the size budget (`CLAUDE.md` 77,141 of 80,000 bytes).
- **Counts on `main`:** audit 9,101 records (9,038 clean, 32 axiom-free, 26 imported, 5 purchases); `axioms=2 rests=27 …`; vacuity
  `declarations=17902 refutations-skipped=234`. **The next filing's fact-audit base: `8eece67b0`.** **Reference compiled tree for
  `main`: `fs133-wk1`** (its build is the gated one; it is on branch `fs131-f5`, merged).
- Kooshi has had a report at each landing (port; density equality). The next is due at the next gate.

## 3. Running now (four jobs, four slots)

1. **FS131-IJ1 — the chain's join, then M10, M2a, M3, M2b** (tree `fs131-wq1`, branch `fs131-wt3`; the join `3ae198eac` builds, item
   854). Then `Counting.toL` → `ofUnitRing`; `ChainAtTA`'s two lemmas public; the four modules. Carries item 847 and item 850 ruling 2.
2. **FS131-IKC1 — the certificate checker's soundness, p = 11 in four segments, p = 19 in form F2** (tree `fs131-wnf`, branch
   `fs131-wc14`). **It found the checker unsound** (a kernel counterexample, item 853): `certOK` is being strengthened; the soundness
   theorems' statements unchanged; p = 11's 185 s / 12 GB are superseded until re-measured. Search request row 24 (a smaller
   relaxation) is queued for the Searcher.
3. **FS131-IDB1 — the density bound's lanes C then B** (tree `fs131-w10g`, branch `fs131-wdb1`): **the whole J₀ covering passes in
   the kernel** (`BesselCert.Cells.phiApprox_ge`, standard three, item 861) and lane B's 17 leaves are proved; its report is coming.
4. **FS131-ICL1 — the count's lanes Λ1 (the plane) then Λ4 (the extension)** (tree `fs131-wch`, branch `fs131-wcl` from the join
   `3ae198eac`; the first build compiles the proof line's modules).

## 4. Where each line stands

**The five-colour chain** — one line again: `fs131-wt3` (the join of `fs131-wt2`, where lane T, M8b and the zero-entropy side are
proved — `zeroEntropyCarried_of_numberField` on the standard three, item 850 — with `fs131-wk12`, the map's six typed modules and the
count's eight). Branches growing from it: `fs131-wt3` (IJ1), `fs131-wcl` (ICL1). Still to prove: the count's Λ2 (`FiniteZhang`,
`CountResidue`, `CountDescent`; it repairs `Counting.finite_quot`'s missing `[NumberField F]`, item 847) and Λ3 (`CountTorus`,
`CountCompletion`), both after IJ1's replacement in those files; M13's K3–K5 with Lemma P (on the chain's line, reading `ClassRatio`)
after IKC1's soundness; M11 (a planner first); lane A `exists_admissiblePair` (a planner first); M5-E/M5-P; the split's leaves 2–6;
M9-S; M15. **Rulings to carry at the chain's landing:** `entropySplit`/`zeroEntropyCarried` move to `ZeroEntropyClosed` (items 761,
811); the declared printed theorem `positive_entropy_rigidity` registered with the audit; lane N's five unread binders dropped by a
planner with a dump (item 770); Lemma F made public if read twice (item 801).

**The density bound** — `fs131-wdb` (the planner's skeleton, `Plane/DensityBound/*`, 28 leaves) and `fs131-wdb1` (IDB1: lanes C and
B). Still to prove: lanes F (`Autocorr`, 900 planned lines), P (`Pattern`, `Window`, and `Plane/OneAvoidingDensity`'s one leaf — a
proof in that file, approved, item 845), X (the `X23` instance and the theorem, 700; the atom check in about 75 theorems). Then its
landing on its own line from `main`; the chain reads it.

**Rank 4, the p-adic result (row 75):** unplanned; after the chain.

## 5. The queue (four slots; launch into each as it frees)

1. When IDB1 hands back: **the density bound's lanes F, P, X** (one or two implementers; F and P first, X reads P's definitions).
2. When IJ1 hands back: **the count's Λ2 and Λ3** on the joined line (one implementer each, or one for both), Λ2 carrying item 847's
   repair; then **the M11 planner**.
3. When IKC1 hands back: **M13's K3–K5 and Lemma P** on the chain's line, with the strengthened checker's p = 11 and p = 19 checks.
4. **Planners**: M11; lane A. **Landings in order:** the density bound → its filing → the chain → the W6 publication pass.

Generators: `data/fs131/briefs/scripts/mk-*.py` on `mkbrief.py` (`fresh(JOB)` refuses a used id — and an id whose lower-case form
names a folder under any `data/fs13*/`, item 844). Gate every brief (`python3 .claude/skills/keryx/scripts/brief_gate.py all <brief>`)
and **commit only inside `if <gate>; then … fi`**. Paths in full under the job's tree; a file not yet written goes in words. Filing
generators: `mk-fs131-fc4.py`, `mk-fs131-fc5.py` (copy the latter for the next).

## 6. Owed, not done

- **The second filing** (base `8eece67b0`): the older handoff's § 7 list; the `LEAN.md` lines drafted in the records of FS131-KN7, KN8,
  KN9, KT1, K8B1, KPD1, KR1, K12A, KDB1, KC13, ITK1, IN1L, IDG1, IG1, IPA1, IPB1, IPD1, IP23, ITT1 and the port's classes; bibliography
  reading-status lines (`[EinsiedlerLindenstrauss2022]`, `[OAIMath2026]`, `[Rudin1962]`, `[AmbrusEtAl2023]`, `[KMOR2016]`, and those KR1,
  K12A and KC13 drafted); corrections: `plans/EXT-OAI1-audit.md` "about 16,600 lines" → 12,005 (15,964 with scaffolding);
  `scripts/Vacuity.lean` line 561's history paragraph; the density bound's price in items 818 and 823; M13's price (KC13: the q ∈ {11,
  19} branch alone 3,500–6,700 lines); a grade note on J26/J49's records (no Watson needed, item 845); the `--dupes` +1 run of FC5;
  FS-133's deriver's predictions to score (`plans/FS133-close-inventory.md` § The close).
- **One sweep of older docstrings and proof hygiene** (the last handoff's list; the unread `have hne` in `residual_fourier_model`).
- **The tooling list**: `slot.py` reads a cap kill only at 137; `data/fs131/lc1/code_only_diff.py` plants at the first `:=`; dumpers
  under `#eval` buffer; the assumptions step cannot see a discharged written-out hypothesis, nor a projection's model; the brief gate's
  "independent" false positive; the port generator's textual statement guard; `fresh()`'s cross-milestone folder match; **a skeleton
  `instance`/`def` with a `sorry` body drops the section's instance variables** (item 847 — a planner's dump must check class binders);
  `tools/fs133_ipq1_moved.py --binder-dropped`'s first-binder pick.
- **Cleanup pass** (folded into W6's publication pass, each irreversible step with his word).

## 7. Rules from today

Times from `date -u`. Hand-backs quoted "from its hand-back message". A fact is proved once: move a statement upstream rather than copy
it. An unread binder of ours is dropped with a dump. A port keeps the source's statement and silences a linter in the file by name with a
reason. **A landing is announced only when the gate is green on one commit, merged into `main`, and `main` checked equal to it outside
`plans/` and `data/`** (items 808, 844) — the merge is mine, after the hand-back, once the commits after the green one are shown to touch
only records. **The size budget is met by a move to a file read by address, its lost tokens given that home in the fact audit's
`EXTERNAL_HOMES`** (item 859). Read a probe's "does not exist" with its import list and namespace (items 811, 855). A memory or disk
reading near its limit is reported at once.
