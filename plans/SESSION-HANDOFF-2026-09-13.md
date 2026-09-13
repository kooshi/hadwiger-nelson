# Session handoff — 2026-09-13 (de Bruijn; written before a compaction, for the session that opens FS-38)

You are arriving with no conversation memory. This file is the letter. Read it, then the read order in §5, then
open FS-38 per WORKFLOW step 3. Nothing is in flight on the machine; the gate is green on `main` (0092367).

## 1. What this session did, in order

1. **Reviewed Opus 5's `backlog` branch** — 458 commits, 2026-09-07..12, about fourteen work items well beyond the ten in
   `plans/BACKLOG-FOR-OPUS.md` (Kooshi granted it documentation authority at 85be4b7 and steered it throughout). Method:
   eighteen Sonnet readers (three slices of the verbose commit log; three sections of the compressed `CLAUDE.md`; four
   kernel readers; gate tooling; hygiene; six measured-milestone readers), my own read of the headline statements, and
   all four gates run on the tip in a worktree sharing the build cache (build: 1,631 modules up to date; axioms: 846
   clean, the SAME five declared purchases as before the branch; lint: passed; vacuity: OK).
   **Verdict: kernel clean, measured work honestly labelled, defects in the record only.** The kernel side: Theorems A and
   B (`ResidueColouring.lean`, `FieldWall4.lean` — χ(ℚ(√3,√11)²) = 4 stated on the real plane over the seam field as a
   subset of ℂ, exact), FS-36 (`SquareClass`, `TwoColourResidue`, `Instances/CompositumFive`), `Mascot`, `ValuationLaw`,
   `PlaneRotation`/`Instances/PlaneFreedom`, `SeamCert`, `Palette`, `BrickDistance`; twenty existing modules generalized
   with NO statement weakened (HexShell even pins the old types with an `example` block); no `sorry`, no new purchase.
   The measured side: ledger row 64 (the ρ₆₃ arena, 51,133 vertices in the 6-open field ℚ(√3,√7,√11), χ = 5 exactly)
   is SOLVER-ONLY — twenty refusals on half instances, their DRAT/LRAT never committed and gone; row 65 (dropping Parts's
   coordinate shape kills the object) is a derivation whose certificate sits only under the gitignored `build/`.
2. **Fixed the record in place** (4833a2f) and **merged `backlog` into `main`** by fast-forward, pushed both. The fixes:
   Madore 2015 attributed in the two kernel modules; `CLAUDE.md` rows 26/38/40/44/63/64/65 corrected or restored; the
   Grokkings' "demoted with its refutation recorded, never deleted" rule and G28's demotion record restored; G31's markdown
   and merged tag repaired; the dated OOM / shell-edit / checkpoint-loss incidents restored to the operational rules;
   M62's superseded "412 rotations" marked and its bare UNSAT reworded; FS-32's vertex-criticality hedged (solver-only, no
   record); `data/m62/README.md` (81 rows over 236 entries) and `data/m63/README.md` written, each ending with a **"Not
   recorded here"** list — the [504, 509] joint bracket, M62's "55 patterns", phase H3's certificate, phase H4's free-deletion
   census, pilot and 1.3-billion-pair compulsion sweep, FS-32's 1,065 asks, phase H2's proofs have NO artifact on disk;
   `scripts/Vacuity.lean` made loud on a declaration it cannot telescope and `vacuity.sh --baseline` made shrink-only.
   `chats-bak/` (739 MB) is Kooshi's own transcript backup, kept; remove before any public release.
3. **The forward-looking pass**: four Sonnet readers (the frontier set, the literature, the six-question from below, the
   case for five), then a Poros wall-breaking pass with full context (`plans/POROS-2026-09-13-wall-breaking.md`), which
   minted **FS-38 the residue tower** at rank 1 and **FS-39 the bridge to the plane**, and reconciled the two rankings
   (`plans/FRONTIER-STUBS.md` is authoritative; `CLAUDE.md` § Paths forward mirrors it). Committed as 0092367. Kooshi
   agreed.

## 2. The motivation for FS-38, in full

**The surprise.** Every five-colour pair sweep this project has ever run reads ZERO on a critical 5-chromatic object —
de Grey's 1581 (de Grey's field, 6-open: 0 over 1,248,990 pairs, 0 at arity 3 over 3.29 billion questions, 0 at arity 4
inside neighbourhoods; M41/M48), Heule-510/553 (sealed), the two-core union in K(√247) (sealed; M54), and now the ρ₆₃
arena (ℚ(√3,√7,√11), 6-open, so M60's residue bar does not apply: 0 forced pairs of 1,307,266,278 and 0 virtual edges of
1,306,721,748, complete; M63 phase H4). The only positive five-colour compulsion anywhere is Exoo–Ismailescu's seed's pair
at distance 5, which needs a retained distance-2 edge. The record explains the nulls only by readings (G31's extension,
G52, G53).

**The unexplained fact beside it.** The four-colour forced pairs that every known 5-forcer's spindle was built from were
NOT found by sweeping a critical 4-chromatic object either. They were read off deep 4-colourable K-fabric at 2-adic depth
3: M53's rigidity dial (`data/m53/rigidity-dial-it4.json`: 163 of 178 forced at valuation 6, 0 at valuations 2 and 4) and
M56 (F_true = 171 of the 189 depth-3 pairs; every depth-2 pair separated). The record has no mechanism for WHY depth 3.

**The frame the two facts expose.** The programme reads a prime at LEVEL ONE only: the finite plane UD(𝔽_p, 2) at 11
(χ = 5, pairwise free — M60), the clique 𝔽₄ at 2 (Theorem B). But the fabric's arithmetic lives in the whole tower
O/𝔭^m, and the one four-colour forcing we hold appears at level 3, not level 1. The level-m residue plane
P_m = Cay(O/𝔭^m, S_m) is `unitQuadrance (ZMod (p ^ m))` — a type that already elaborates, used so far only as M59's
lift obstruction — and it has never been asked as a COLOURING object.

**The question.** At which level m does every k-colouring of P_m become constant on 𝔭^d-cosets ("d-continuity")?
- At 2 with four colours first, on the certified bed: the tower must reproduce M56's depth-3 fact (an afternoon). If it
  does not force the valuation-6 pairs at any small level, continuity is not the mechanism and the frame dies for the price
  of an afternoon — that is the stop rule and the one fact that would change the ruling.
- Then at 11 with five colours: P₂ = UD(ℤ/121, 2), 14,641 vertices, degree 132; M60's origin reduction and plane freedom's
  automorphisms cut the ask to one `Separated` question per origin class (a day). Continuity at level m names the 𝔭-adic
  depth — hence the SIZE — of the fabric a 6-forcer over a 5-sealed field needs, and G48's spindle (√(4d²−1) ≡ √−1 mod 𝔭
  at 11 | d²) finishes it in a field 6-open by construction. No continuity at the affordable levels closes route A at its
  mechanism. Two-sided either way.

**Why this over the alternatives.** FS-6 as ranked buys a fifth null of the same genre unless its central computation
(backlog B9 (i), the forced-distance table at residue norm 0 on Heule-510 ∪ closure and W ∪ cross lattice) is run — it
never was, and it is restored at rank 2 as the cheapest instance test. FS-17 (the first digit at 23) buys one digit of the
conjecture at a solver-day per route and touches no mechanism; it is rank 3 as the disproof-side test (no value above 19
exists anywhere in the literature). FS-38 is the only move that changes the frame's OBJECT rather than adding an instance
inside it, and it obeys G46: the object named in its own discipline — Cayley graphs over O/𝔭^m, the quadratic graph over a
local field — brings that discipline's theorems and prior art with it.

**The derivations already written** (`plans/STUB-residue-tower-rigidity.md` §3): D1 the tower and its homomorphisms in
the kernel's vocabulary (`unitQuadrance.map (ZMod.castHom …)`, d-continuity as `∀ v, Forces (P_m) k 0 (p^d • v)` through
`forces_iff_forces_zero_sub`; a refutation is one non-periodic table, kernel; a forcing verdict is solver-side unless the
level is decidable); D2 the transfer to a fabric (a fabric's colourings need not factor through P_m — the honest transfer
is compactness of the local plane's colouring space; the chunk size is the design number, measured on the 2-adic bed);
D3 the two primes are opposite at level one (2 a clique, 11 pairwise free) and the question is whether they meet above it;
D4 the prior-art gate first — MMST on finite Euclidean graphs over rings ℤ/p^r (recalled, not read, not in the
bibliography), Bardestani–Mallahi-Karai's local-field object, "colourings of Cayley graphs on ℤ/p^m × ℤ/p^m".

**The honest disproof branch** (in the Poros record): the 11-adic tower never forcing at five colours while the 2-adic
tower reproduces the four-colour forcing, plus every plane at 23–47 five-colourable, would move the bet toward five.
Neither is a proof of χ ≤ 5; the record names no route to that, and the residue methods are one-sided by derivation.

## 3. Also minted: FS-39, the bridge to the plane

χ(ℝ²) = sup over real number fields of χ(F²) rests on de Bruijn–Erdős compactness AND an algebraic-drawing lemma (a finite
graph with a real unit-distance drawing has one with real-algebraic coordinates — the drawing variety is defined over ℚ,
and a real point gives a real-algebraic one by the completeness of real closed fields). The record has invoked the bridge
in prose since M58 and never stated, proved, or cited it; the bold conjecture's χ(ℝ²) = 7 stands on it. Kernel work for a
slack day; rank 4; not blocking FS-38.

## 4. Standing rules that bit this week (read them before the first run)

- ALWAYS `./scripts/build.sh`; never `lake build` bare or named. One heavy job at a time (Opus admitted 35 processes on 16
  physical cores, d1ff212). The desktop is 16 physical cores / 32 threads.
- A solver refusal is never a fact; a found colouring is evidence only once verified against every edge; every headline
  names its population and its trust word (G21). Records go under `data/` WITH a README row — this week's largest defect
  was 763 records with none.
- Kill by PID or process group; never `pkill -f` a self-matching pattern (five incidents last week). Checkpoint anything
  over 15 minutes; a checkpoint under `build/` or `/tmp` is one cleanup from unrecoverable — phase H2's proofs are gone
  that way.
- Prior-art gate (WORKFLOW 3a) before deriving; name the object for a stranger in the discipline that owns it (G46).
- `CLAUDE.md` holds current state only, under 150,000 characters (146,698 now); a grokking that dies is demoted with its
  refutation recorded, never deleted.
- Python 3.14 defaults to `forkserver`: a parent's module-level global is empty in a worker.

## 5. Read order for the FS-38 session

1. This file. 2. `plans/POROS-2026-09-13-wall-breaking.md` (the question cards and the hunch ledger — score them at the
close). 3. `plans/STUB-residue-tower-rigidity.md` (the stub: context, D1–D4, phases, predictions, failure/jackpot clauses).
4. `plans/M60-five-colour-residue-obstruction.md` §S and `Proofs/HadwigerNelson/ResidueObstruction.lean` (the origin
reduction and the one-table decision that FS-38 lifts to ℤ/p^m). 5. `plans/M56-arithmetic-of-tightness.md` §R1 and
`data/m53/rigidity-dial-it4.json` (the depth-3 fact the 2-adic bed must reproduce). 6. `Proofs/HadwigerNelson/Lift.lean`
(the only prior use of `unitQuadrance (ZMod (p ^ m))`). 7. `CLAUDE.md` § Frontier M58–M61 and § Grokkings G43–G48, G53.
Then WORKFLOW step 3: subplan + skeleton, the three modeling passes freshly invoked, commit each.

## 6. State of the machine and the repository

`main` = `backlog` = origin, tip 0092367. Nothing running. The main checkout's `.lake` holds the current build; a build
is a no-op. `data/m62/ckpt/` files show as untracked on disk — they are gitignored resume state, not evidence. The reading
worktree `../lean-dir-backlog` was removed. Memory (`~/.claude/.../memory/hadwiger-nelson-project.md`) is current.
