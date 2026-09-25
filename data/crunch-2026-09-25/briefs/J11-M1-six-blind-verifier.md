*Brief for crunch job **J11**, milestone M1 (FS-91), blind verifier of J08 (character colourings at the exposed fields). Opus 5.5,
2026-09-25. Written by J03 (`plans/FS91-character-local-global.md` §S) **before any J08 claim existed**.*

Hello. You are de Bruijn (`DEBRUIJN.md`), acting as **a blind verifier**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** The verdicts are yours.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`, and
continue at the first stage not SAVED. Redo nothing saved.

## The question, and why now

A band `k`-character of a finite abelian Cayley graph `Cay(G, S)` is a homomorphism `λ : G → ℝ/ℤ` with `λ(S) ⊆ [1/k, 1 − 1/k]`; `⌊kλ⌋` is then
a proper `k`-colouring. A derivation agent (J08) is deciding which of the finite planes `Γ_q = Cay(𝔽_{q²}, μ_{q+1})` carry band six- and
seven-characters — the question behind "can a character colouring six-colour ℚ(√167)'s plane?". A band six-character of Γ₂₃ or Γ₄₃ would be
the first exactly six-chromatic finite Euclidean plane (`CLAUDE.md` G56), so a positive must be audited hardest; a null is as valuable
(Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*). Check from the statements, blind to
the route; your exact code must be your own.

## The claims (verbatim; the fixed list)

Quoted from `plans/FS91-character-local-global.md` §S, "J08 — six at the exposed fields" (and §M.1 for `κ`):
- **W1 = SIX-a.** "For a prime `q ≡ 3 (mod 4)`, every band `k`-character of `Γ_q = Cay(𝔽_{q²}, μ_{q+1})` is
  `λ_a(x) = Tr_{𝔽_{q²}/𝔽_q}(ax)/q` for some `a ≠ 0`, and `λ_a` is band `k` iff no `t ∈ V_{N(a)}` has `|t| < q/k` (`t` read in
  `(−q/2, q/2)`), where `V_c = {t ∈ 𝔽_q : t² − 4c is a non-square or 0}`."
- **W2 = SIX-b.** "The complete list of `c ∈ 𝔽_q^×` giving band `k`-characters for `q ∈ {23, 43}`, `k ∈ {6, 7, 8}`; hence `χ_char(Γ₂₃)` and
  `χ_char(Γ₄₃)`" — with `κ(Γ_q) = max{β : some character λ has λ(μ_{q+1}) ⊆ [β, 1 − β]}` computed exactly.
- **W3 = SIX-c.** "For `k ∈ {6, 7}`: an explicit `Q_k` from Weil (or Burgess) above which no `Γ_q` has a band `k`-character, and the complete
  list below it."
- **W4 = SIX-e.** "Given CLG_6 and CLG_7 (J07, unverified): `Θ₆(R_{ℚ(√167)}) = ∅` iff no target of ℚ(√167) carries a band six-character, and
  `χ_char(ℚ(√167)²) = min` over its targets; the same for K(√7) and de Grey's field `K(√5,√7)`." Verify the implication and the list of each
  field's targets (usable primes and dyadic places), not CLG itself.

Verdicts: TRUE / FALSE (with the counterexample: an explicit `(q, a, k)`) / GAP (the step named). For W2 and W3 give your own lists and `κ`.
**Scope:** characters only; a band-character null says nothing about `χ` at `k ≥ 4` (G71). If J08 states anything wider, that is a finding.

## Read first, from disk — verified inputs

`LEDGER.md` rows 50, 53, 68–71, 75, 96; `CLAUDE.md` G44, G54, G56, G58, G59, § Notation; `plans/FS89-derivation.md` S0A-4, S0A-8, S0A-13 and
`plans/FS89-S0A-gluing-verification.md` §C1 (the band-1/4 middle-half argument, the nearest proved analogue); `data/fplane/periodic-below-71.json`
(the verified colourings behind row 69's ceilings — your positive control: some band eight-character should exist at 23 and 43, or explain
why those colourings are not characters).

## Fenced until your phase-1 verdicts are committed

- `plans/FS91-character-local-global.md` entirely (its §PA.1 and §P.basis carry a derivation and a hand result), except the quoted blocks;
- J08's record `plans/FS91-S1D-six.md`, `data/fs91/j08/`, `tools/crunch_j08_*`, J08's brief, `git log -p` / `git show` of commits whose
  subject begins "J08", `plans/FS91-close-inventory.md`;
- every other crunch brief, record and report except `STANDING-RULES.md` and this brief; every scratch directory but your own.

## Stages

1. **Quotation check and C0 (about 20k).** Probabilities per claim, and for "a band six-character exists at 23 or at 43". Save.
2. **Phase 1, blind (about 140k).** Derive or refute W1; compute W2 and W3 with your own exact tool `tools/crunch_j11_*.py` — **an enumeration
   of the parameter `c` over a set your derivation fixed**, checked against a direct enumeration of `μ_{q+1}` at small `q`, with a planted
   fault that fires for its own reason and a result file written even on a null. Then W4. Commit the verdicts and report (STAGE 2 SAVED).
3. **Phase 2 (about 40k), only if a phase-1 verdict is GAP:** open J08's record's statements of its lemmas (not their proofs) and derive the
   step you lacked. Save.
4. **Divergence table (about 30k).** Open J08's record and data; compare lists value by value. Save and report.

## Record and paths

- **Record:** `plans/FS91-S1V-six.md`, with "Theorems this phase proved" and the would-have-searched log (the ban on finite-witness search
  runs to 2026-10-01; a complete list over a derivation-fixed set is in and is logged as such).
- **Data:** `data/fs91/j11/`. **Tools:** `tools/crunch_j11_*.py`.
- **Budget:** about 300k harness; hand back with the record saved by 380k.
- **No children:** no subagents, forks or workflows — delegation is one level deep (`CLAUDE.md` § Delegation), because staffing is Kooshi's
  budget decision and the owner can only review work it knows about.
- **Report:** to `data/crunch-2026-09-25/reports/J11.md` and `"main"` by SendMessage.

Thank you.
