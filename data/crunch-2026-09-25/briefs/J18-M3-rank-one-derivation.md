*Brief for crunch job **J18**, milestone M3 (FS-76 in rank one), derivation. Opus 5.5, 2026-09-25. Written by J06
(`plans/M3-exotic-colourings.md` §S, §M).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the derivation agent for M3's first question**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk (the copy loaded at your start may be stale).
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** The owner (the orchestrating session)
coordinates and reviews by artifact.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`,
and continue at the first stage not SAVED. Redo nothing saved.

**No children.** Do not use the Agent tool, a fork, a workflow or anything else that starts another agent (`CLAUDE.md` § Delegation —
one level deep). The reason: staffing is Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows
your context, stop at a saved stage and say what is left; that is a good report, never a failure.

## The question, and why now

Every lower bound above five colours must cross the four-colour wall, where a colouring carries no height and no slope (`CLAUDE.md` G71,
G73). The cheapest open item there is in rank one. For a finite set `D` of positive integers, the proper four-colourings of the distance
graph `G(ℤ, D)` form a one-dimensional shift of finite type. FS-79 proved that a four-colouring separating a pair every periodic
four-colouring identifies exists exactly when every phase is rigid and a wall exists (FS79-T35), and a scan to `max D = 14`, `|D| ≤ 5`
found none. The reading R2 — every phase rigid ⟹ no wall — would prove **rank-one inheritance at four colours** (`P₄ = F₄` for every `D`).
In symbolic dynamics' words (the planner's recognition, `plans/M3-exotic-colourings.md` "The milestone in the theory's terms"): R2 says
**a countable (zero-entropy) four-colouring shift of a distance graph is finite.** General one-dimensional SFTs violate that; colouring
shifts have reflection, colour permutations and Kempe structure, which is what a proof must use.

**Every outcome counts** (standing rule 4): a proof, a counterexample (a finite `D` with every phase rigid and a wall — a rank-one failure
of inheritance, notable in itself), or a stall at a named step are all findings. Do not lean toward a yes.

## The statements (verbatim, from `plans/M3-exotic-colourings.md` §S)

**Definitions for Q1 (J18's and J20's briefs quote these):** for finite `D ⊂ ℤ_{>0}`, `G(ℤ, D)` has vertex set ℤ and `x ~ y` iff
`|x − y| ∈ D`; `X_k(D) ⊆ [k]^ℤ` is the set of proper `k`-colourings; with `m = max D`, the **window-state graph** has as vertices the
words of length `m` occurring in some point of `X_k(D)`, and an edge `w → w′` when `w′` is `w` shifted by one position inside an
`(m+1)`-word occurring in some point; a **phase** is a strongly connected component containing a cycle, **rigid** if it is a single
cycle; a **wall** is a path from one phase to a different phase; `F_k(D)` is the set of `δ ∈ ℤ` with `c(x) = c(x + δ)` for every
`c ∈ X_k(D)` and `x`, and `P_k(D)` the same over the periodic `c`. (FS79-T35 states its criterion with phases taken modulo colour
permutation; the claims below hold in either form, and a derivation says which it uses.)

- **A-T1 (R2).** "For every finite `D ⊂ ℤ_{>0}`, if every phase of the window-state graph of `X₄(D)` is rigid, then no wall exists."
- **A-T1′.** "For every finite `D ⊂ ℤ_{>0}`, `X₄(D)` is finite or has positive topological entropy."
- **A-T2.** "For every finite `D ⊂ ℤ_{>0}`, `P₄(D) = F₄(D)`."
- **A-K0.** "If every phase of `X₄(D)` is rigid, then every periodic `c ∈ X₄(D)` has all four colours on the closed neighbourhood of
  every vertex, and every two-colour Kempe component of `c` is infinite."
- **A-K1.** "If every phase of `X₄(D)` is rigid and `X₄(D) ≠ ∅`, then `χ(G(ℤ, D)) = 4`."
- **A-K2.** "If `c ∈ X₄(D)` and for every `x ∈ ℤ` the colours `{c(x − d) : d ∈ D} ∪ {c(x)}` are all four colours, then every
  `c′ ∈ X₄(D)` that agrees with `c` on `{y : y < x₀}` for some `x₀` equals `c`; so a wall leaves a phase `C` only through a state at
  which the next colour is not determined by the window."
- **A-Kq.** "Every phase of the window-state graph of `X₄(D)` is rigid iff every phase of its quotient by colour permutations is rigid,
  and a wall exists in one iff it exists in the other."
- **A-K3 (the reversal lemma).** "If every phase of `X₄(D)` is rigid, then for every wall from a phase `C` to a phase `C′` there is a
  wall from `C′` to `g·C` for some colour permutation `g`." (With FS79-T34's orbit step it gives A-T1.)
- **A-C.** "There is a finite `D ⊂ ℤ_{>0}` (named) such that every phase of `X₄(D)` is rigid and a wall exists." (the alternative to
  A-T1; with T35 it gives `P₄(D) ≠ F₄(D)`)

The source statements behind them, verbatim: the FS-76 stub (`plans/STUB-four-colour-inheritance.md`, "Re-aimed at FS-79's close"):
"the rank-1 criterion is exact (T35: `P ≠ F` iff every cyclic phase is rigid and a wall exists), and a scan to `max D = 14`, `|D| ≤ 5`
found no counterexample (T36). **Rank 1 closes if "every phase rigid ⟹ no wall" is proved** (the reading, unrefuted on 377 of 377
all-rigid sets) — the cheapest open item here." FS79-T35: "The exact rank-1 criterion at four colours: `P ≠ F` iff every cyclic phase of
the window-state graph is a single cycle and a wall exists." FS79-T34: "a counterexample to inheritance periodic in `r − 1` directions has
two distinct rigid ends, at least one chiral, so never an additive end; with Coxeter's repair when `Λ/W` has torsion."

## Read first, from disk

- `plans/FS79-derivation.md` T3, T6, T34, T35, T36 (and §6 R2); `plans/FS79-C-deBruijn.md` §3 (T34's proof) and §3a (T35, the scan, the
  table of FS73-T30's walls). **Note:** the brief that launched the planner cited "FS79 T30"; the rank-1 walls are **FS73-T30**
  (`plans/FS73-derivation.md`, "Rank-1 walls at four colours, and the wall criterion"); FS79-T30 is a face-flux no-go, not an input.
- `plans/FS73-derivation.md` T24 (three colours: density, so no walls — your `k = 3` control) and T30.
- `plans/FS85-derivation.md` FS85-dB1 (the embedding lemma) and dB2 (`G(ℤ, D)`, `|D| = 70`, exactly 24 four-colourings) — `LEDGER.md`
  row 86: an all-rigid, wall-free inhabitant far outside T36's range, and the construction tool for a counterexample.
- `plans/FS86-derivation.md` FS86-dB-H (Theorem H, unique continuation from a half-space) — A-K2 is its rank-one form.
- `LEDGER.md` row 45 (the entropy floor, `EntropyFloor.lean`) — for A-K1.
- `plans/M3-exotic-colourings.md` §M (the obligation tree and two candidate moves for A-K3) and §PA.2.
- **A prior-art debt that bears directly:** `[EggletonErdosSkilton1990]` (Graphs Combin. 6 (1990) 17–32) states "There are finite sets D
  for which there exists aperiodic proper colourings using only χ(D) colours" (zbMATH review). If any such example sits in a
  zero-entropy four-colouring shift, it is A-C. Try `rd.springer.com` once (the memory note on paper fetch routes); if it is not
  reachable in ten minutes, record it unread and move on.

## Stages

1. **The quotation check and C0** (about 60k). Check every quotation above against its source and log the result. Then C0: a probability
   for each claim (A-T1, A-T1′, A-T2, A-K0, A-K1, A-K2, A-Kq, A-K3, A-C) before any derivation, and the EES attempt. **Save.**
2. **The local lemmas** (about 80k): A-K0, A-K1, A-K2, A-Kq, and A-T1′'s equivalence with A-T1 (the one-dimensional SFT facts you use,
   stated with their source). **Save.**
3. **The hard step** (about 100k): A-K3 — or A-C. The planner's two candidate moves (a Kempe swap on a one-sided component; a
   reflection-invariant potential) are in §M; use them, or don't. State at which step four colours enter, since at three colours the
   claim is true for another reason (T24). If you look for a counterexample, meet §M's checklist first and build it (the embedding lemma is
   the tool); an exact check of **one derived `D`** — its window graph computed once, walls and rigidity read off — is at the ban's edge
   and allowed, logged; a scan over many `D` is not. **The gate, at about 2.5 hours of wall time:** a proof, a counterexample, or a stall at
   a named step, saved. A stall names the smallest statement you could not prove, verbatim, so that a second mind (J19) can be launched on
   exactly it. **Save.**
4. **Claims and the reviewer's view** (about 40k): the claim list, each with its grade (§ Notation's), the address of its proof, and what
   someone who trusts none of this must check (`CLAUDE.md` § The standard of evidence); your registered C0 scored. **Save, then report.**

**Theorems this phase proved:** your record carries that heading, one line per theorem, with its grade and address.

## Record and paths

- **Record:** `plans/M3-S1A-rank-one.md`. **Working files:** `data/m3/j18/`. **Tools:** `tools/crunch_j18_*.py`, each with a planted
  fault watched to fire; a wall detector reports "walls: 0" only beside a control with walls (`{1,5,7,10}`).
- **The ban** (to 2026-10-01): no scans, no SAT, no solvers; exact arithmetic of seconds that checks a derived claim is in. Keep the
  **"would have searched here" log** in your record.
- **Machine:** anything over about 2 GiB or 2 minutes runs under `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`; a window graph has up
  to `4^(max D)` states, so price it first. Never `lake build`.
- **Commits** by explicit path, subjects "J18: stage n".
- **Budget:** about 350k in the harness's count; hand back with your record saved by 420k.
- **Report:** standing rule 9's form, to `data/crunch-2026-09-25/reports/J18.md`, committed, and sent to `"main"` by SendMessage. Your
  RESULT line gives each of A-T1, A-K0–A-K3, A-C as TRUE / FALSE / GAP-at-step. On a named stall, add a SPAWN line for J19 with the step
  verbatim. Your turn's final text: "J18 idle; report sent to the owner by SendMessage".
