*Brief for crunch job **J20**, milestone M3 (FS-76 in rank one), blind verifier. Opus 5.5, 2026-09-25. Written by J06
(`plans/M3-exotic-colourings.md` §S) **before any claim of J18 (or J19)'s existed** (FS-89's V-A: a fixed list, written first).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the blind verifier of J18 (or J19)'s claims**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** The owner (the orchestrating session) coordinates and forwards what the phases below say.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`,
and continue at the first stage not SAVED. Redo nothing saved.

**No children.** Do not use the Agent tool, a fork, a workflow or anything else that starts another agent (`CLAUDE.md` § Delegation —
one level deep). The reason: staffing is Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows
your context, stop at a saved stage and say what is left; that is a good report, never a failure.

## The question, and why blind

M3's first question is FS-76 in rank one: for a finite set `D` of positive integers, are the proper four-colourings of the distance
graph `G(ℤ, D)` ever a countably infinite shift — phases all rigid, yet a wall between two of them? If never, every pair identified by
all periodic four-colourings is identified by all four-colourings (`P₄ = F₄`), rank-one inheritance at four colours. A derivation agent
(J18, or a second mind J19 on a step J18 names) attacks it; you verify its claims blind.

You are blind so that your verdicts are a second derivation from the statements, not a re-reading of one. The seventh run's lesson
(`plans/PROTOCOL-competitor-and-advisor.md` §3): a blind verifier's value is in the fixed list and in re-derivation; it cannot supply a
missing idea, and the lemma-statement phase (B2) is the cheap fallback that turns a stall into a verification. **Every verdict counts
equally** (standing rule 4): TRUE, FALSE with a counterexample, or GAP with the missing step named. Audit a claim you like as hard as one
you dislike.

## The statements (verbatim; your fixed list)

**Definitions for Q1 (J18's and J20's briefs quote these):** for finite `D ⊂ ℤ_{>0}`, `G(ℤ, D)` has vertex set ℤ and `x ~ y` iff
`|x − y| ∈ D`; `X_k(D) ⊆ [k]^ℤ` is the set of proper `k`-colourings; with `m = max D`, the **window-state graph** has as vertices the
words of length `m` occurring in some point of `X_k(D)`, and an edge `w → w′` when `w′` is `w` shifted by one position inside an
`(m+1)`-word occurring in some point; a **phase** is a strongly connected component containing a cycle, **rigid** if it is a single
cycle; a **wall** is a path from one phase to a different phase; `F_k(D)` is the set of `δ ∈ ℤ` with `c(x) = c(x + δ)` for every
`c ∈ X_k(D)` and `x`, and `P_k(D)` the same over the periodic `c`. (FS79-T35 states its criterion with phases taken modulo colour
permutation; the claims below hold in either form, and a derivation says which it uses.)

**The fixed list.** Each claim below is quoted verbatim from `plans/M3-exotic-colourings.md` §S (a file you may not open; this list is
the whole of what you need from it). J18 (or J19) may prove some, refute some, or stall; your verdicts are per claim, whatever it claims.

- **A-T1 (R2)** — "For every finite `D ⊂ ℤ_{>0}`, if every phase of the window-state graph of `X₄(D)` is rigid, then no wall exists."
- **A-T1′** — "For every finite `D ⊂ ℤ_{>0}`, `X₄(D)` is finite or has positive topological entropy."
- **A-T2** — "For every finite `D ⊂ ℤ_{>0}`, `P₄(D) = F₄(D)`."
- **A-K0** — "If every phase of `X₄(D)` is rigid, then every periodic `c ∈ X₄(D)` has all four colours on the closed neighbourhood of
  every vertex, and every two-colour Kempe component of `c` is infinite."
- **A-K1** — "If every phase of `X₄(D)` is rigid and `X₄(D) ≠ ∅`, then `χ(G(ℤ, D)) = 4`."
- **A-K2** — "If `c ∈ X₄(D)` and for every `x ∈ ℤ` the colours `{c(x − d) : d ∈ D} ∪ {c(x)}` are all four colours, then every
  `c′ ∈ X₄(D)` that agrees with `c` on `{y : y < x₀}` for some `x₀` equals `c`; so a wall leaves a phase `C` only through a state at
  which the next colour is not determined by the window."
- **A-Kq** — "Every phase of the window-state graph of `X₄(D)` is rigid iff every phase of its quotient by colour permutations is rigid,
  and a wall exists in one iff it exists in the other."
- **A-K3 (the reversal lemma)** — "If every phase of `X₄(D)` is rigid, then for every wall from a phase `C` to a phase `C′` there is a
  wall from `C′` to `g·C` for some colour permutation `g`."
- **A-C** — "There is a finite `D ⊂ ℤ_{>0}` (named) such that every phase of `X₄(D)` is rigid and a wall exists."

Where J18 (or J19) states a claim in a different form, the owner forwards the exact text at B2; you verify the fixed list's form and say
whether the two agree.

## Read first, from disk (the verified inputs)

- `plans/FS79-derivation.md` T6, T34, T35, T36 (the rank-one criterion and its setting: FS79-T35, verbatim, "The exact rank-1
  criterion at four colours: `P ≠ F` iff every cyclic phase of the window-state graph is a single cycle and a wall exists."); FS79-T34
  and its proof in `plans/FS79-C-deBruijn.md` §3 (a verified input).
- `plans/FS73-derivation.md` T24 (three colours: periodic colourings dense, so no walls) and T30 (rank-1 walls at four colours, all
  beside positive entropy).
- `plans/FS85-derivation.md` FS85-dB1, dB2 (`LEDGER.md` row 86); `plans/FS86-derivation.md` FS86-dB-H; `LEDGER.md` row 45.
- Standard one-dimensional symbolic dynamics (Lind–Marcus), cited as you use it.

## Fenced until your B1 verdicts are committed (and B2's, for everything but the lemma statements the owner forwards)

- J18's record `plans/M3-S1A-rank-one.md`, `data/m3/j18/`, `tools/crunch_j18_*.py`, its brief
  (`data/crunch-2026-09-25/briefs/J18-M3-rank-one-derivation.md`) and its report; the same for J19 (`plans/M3-S1B-rank-one.md`,
  `data/m3/j19/`, its brief and report);
- the M3 plan `plans/M3-exotic-colourings.md` (it carries routes) and the close inventory `plans/M3-close-inventory.md`;
- commits whose subject begins "J18:" or "J19:" (`git log`'s subject line is harmless; do not `git show` them);
- `data/crunch-2026-09-25/READY.md` beyond its job list, and any record the owner has not named here.
If you open a fenced file by accident, say so in your record at once; it is a slip to report, not a failure to hide.

## Stages

1. **The quotation check and C0** (about 40k): check each quotation in this brief against its source where you can open the source (the
   fixed list's source is fenced: record that), and a probability per claim before any derivation. **Save.**
2. **Phase B1, blind** (about 150k): attempt each claim from its statement alone, by your own route; a verdict per claim — TRUE, FALSE
   (with the counterexample), or GAP (the missing step named verbatim). The deciding claim first. **Save**, and report the B1 verdicts to
   the owner by SendMessage, one line each.
3. **Phase B2, the lemma statements** (about 100k; only if B1 left a GAP): the owner forwards J18 (or J19)'s lemma statements **without
   proofs**; re-derive each from its statement, and re-assemble. **Save.**
4. **Phase B3, the divergence table** (about 50k): now read J18 (or J19)'s record; one line per divergence of truth, scope, route or wording;
   and **read each final statement aloud against the informal claim** (`CLAUDE.md` § The standard of evidence). **Save, then report.**

**Theorems this phase proved:** your record carries that heading, one line per theorem, with its grade and address.

## Record and paths

- **Record:** `plans/M3-S1V-rank-one.md`. **Working files:** `data/m3/j20/`. **Tools:** `tools/crunch_j20_*.py`, each with a
  planted fault watched to fire; never edit another job's tools.
- **The ban** (to 2026-10-01): no search for a finite witness; exact arithmetic of seconds that checks a derived claim is in. Keep the
  **"would have searched here" log** in your record.
- **Commits** by explicit path, subjects "J20: stage n". **Budget:** about 350k in the harness's count; hand back by 420k.
- **Report:** standing rule 9's form, to `data/crunch-2026-09-25/reports/J20.md`, committed, and sent to `"main"` by SendMessage;
  the RESULT line gives a verdict per claim. Your turn's final text: "J20 idle; report sent to the owner by SendMessage".
