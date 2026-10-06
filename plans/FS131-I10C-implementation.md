# FS-131, wave 10 — the implementation of `Arith/StandingFive` (TC1-STANDING-FIVE)

*Job FS131-I10C (de Bruijn, the implementer), 2026-10-06, branch `fs131-w10c` (from the planner's `f919973e`). Brief:
`data/fs131/briefs/FS131-I10C-wave10.md`. The plan: `plans/FS131-w10-kernel-plan.md` § 5.4 (the leaves), § 5.5 (the named hypotheses).*

**What I may change**: the proofs of the nine `sorry` leaves of `Proofs/HadwigerNelson/Arith/StandingFive.lean`; new helper declarations in that
file, under names no other module declares; a block of my own in `scripts/Axioms.lean`; this record; `tools/fs131_i10c_*.py`; `data/fs131/i10c/`;
my report. **What I may not**: any statement or definition of the skeleton (a theorem's text up to its `:=`, a `def` whole, a docstring); a new
`axiom`; `native_decide`; the wave's other files; a landed module beyond new declarations; `main`; the gate; a merge.

## Theorems this phase proved

*(filled at each saved stage; one line per kernel theorem, its declaration, its axioms)*

## Stage 1 — SAVED (FS131-I10C): the readback, the build as given, the route

**Quotations** (standing rule 3), by script — `grep -F` of each quoted string in the file the brief names, with a control string that must not
match; `data/fs131/i10c/logs/quotations.txt`: **eight of eight match** (`CLAUDE.md` § Counter-priors; inventory items 484, 485, 477, 478, 493 in
`plans/FS131-close-inventory.md`, read on `main`, where they are filed; the plan's §§ 5.4 and 5.5 headings in this worktree); the control reads
MISMATCH.

**Read**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` §§ Building, Make the gate fail; the planner's record whole;
`StandingFive.lean` whole; `SpectralChain.lean` lines 1–62 and 232–305 (`fieldI`, `conjO`, `StablePrime`, `levelTarget`, `localBound`); the row's
entry and its argument (`plans/TC1-derivation.md:60–72`, `:110–124`); inventory items 477, 478, 484, 485, 493, 506, 507; the first implementer's
record (`fs131-w10`'s `plans/FS131-I10A-implementation.md`, Stages 1–5 and Findings).

**The branch as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, 451 of 451 batches, 8m9s;
**five modules rebuilt** — `Arith.StationaryRatio`, `Arith.StandingFive`, `Arith.SpectralInputs`, `Arith.CharacterColouring` (the wave's four,
which the copied build predates) and `Proofs` (the import surface); 21 `declaration uses 'sorry'` warnings: `StationaryRatio` 3, `StandingFive` 9,
`SpectralInputs` 8, `CharacterColouring` 1 (`data/fs131/i10c/logs/build-0-as-given.log`).

**The route, where it differs from the plan's § 5.4** (one mind, before any Lean; each difference is confirmed or withdrawn at its leaf):

1. **No irreducibility of `g` over `ℚ`, and none mod 7.** The plan gets `[E₇:ℚ] = 7` from `g` irreducible mod 2 and `[F:ℚ] = 28` from coprime
   degrees. The degree instead falls out of the dyadic count: at every prime `P ∋ 2` of `𝓞 (F(i))`, `e ≥ 2` (`(1 + i)² = 2i`) and `14 ∣ f`
   (the residue field holds a root of `g`, of Frobenius period 7, and `ω`, of period 2), so `e·f ≥ 28`; two such primes exist; and
   `Σ e·f = [F(i):ℚ] ≤ 2·[F:ℚ] ≤ 2·(2·2·7)`. So the sum is exactly 56, there are exactly two primes, `f = 14`, and `[F:ℚ] = 28`. What `g`
   must supply is only `g(η) = 0`, `x¹²⁸ ≡ x (mod g, 2)` and `g(0), g(1)` odd. At 7 the plan read `g` irreducible mod 7 to exclude `7³ = 343`;
   3 is not a square mod 7, so no residue field above 7 of odd degree exists at all.
2. **The usable clause is one statement about an abstract finite field**: a finite field of `Q ≡ 3 (mod 4)` elements holding square roots of 3
   and 11 and a root of `g` has `Q ≥ 347`. `usable_card_ge` applies it to `𝓞 F ⧸ w`, `stablePrime_card` to the fixed field of conjugation on
   `𝓞 (F(i)) ⧸ P` — so `stablePrime_card` never compares `𝓞 F ⧸ (P ∩ 𝓞 F)` with that fixed field (the plan's "what is hard").
3. **The finite check needs no primality**: for every natural `p < 347`, `p ≡ 3 (mod 4)`, prime or not, not all of "3 is a square, 11 is a square,
   `g` has a root" hold mod `p` (`tools/fs131_i10c_data.py` (d)).
4. **Totally real** by seven sign changes of `g` at `−4, −2, −5/4, 0, 1/5, 1, 2, 3` (the plan's route; the points are (b) of the tool).

**The tool**: `tools/fs131_i10c_data.py` — Horner's scheme for `g` at `1_H` in `ℤ[C₂₉]` (the last vector is constant, 289); the sign points; the
Frobenius orbit of a root of `g` in characteristic 2 with its cofactors; the finite check below 347 over all naturals; `g − 16x − 1 = (x² − x)·Q`.
PASS, exit 0 (`data/fs131/i10c/logs/data-tool.log`); its planted fault (`--fault`: the coefficient 14 of `x²` moved to 15) reads FAIL, exit 1
(`data/fs131/i10c/logs/data-tool-fault.log`).

## Stage 2 — SAVED (FS131-I10C): group 1 — the foundation, and three leaves (`numberField_`, `isTotallyReal_`, `usable_card_ge`)

**The foundation** (new declarations in `StandingFive.lean`, before the leaves):

- **`g_eta`: `g(η) = 0`**, a certified computation. `ℤ[C₂₉]` as vectors `Fin 29 → ℤ` under cyclic convolution (`cconv`); evaluation at the
  character `k ↦ e^{2πik/29}` is multiplicative (`cev_cconv`, proved once); Horner's six steps for `g` at `1_H` are literal vectors, each
  step one `decide +kernel` (`horner1`–`horner7`), and the last is the constant vector 289, whose value is `289·Σζᵏ = 0`. No polynomial of
  degree 196, no trigonometric identity beyond `cos(2π − x) = cos x`.
- **The finite-field layer**, with no number field in it: `dvd_of_pow_pow_eq` (the period lemma: `x^{p^n} = x`, `x^{p^m} = x`, `m` prime,
  `x^p ≠ x` give `m ∣ n` — in any monoid); `fourteen_dvd_of_char_two` (a field of `2ⁿ` elements with a root of `g` and a primitive cube root
  of unity has `14 ∣ n`; the Frobenius orbit of the root by five `linear_combination`s with the tool's cofactors);
  `card_ge_of_usable` (**the usable clause on an abstract finite field**: `Q ≡ 3 (mod 4)`, square roots of 3 and 11, a root of `g` ⟹
  `Q ≥ 347`), over `usableBelow_347` (`decide +kernel`, all naturals below 347, no primality) and `squaresBelow_11`;
  `card_fixed_of_involution` (an involution moving a square root of `−1`: the fixed field has `Q ≡ 3 (mod 4)` elements and the field `Q²`).
- **The field**: `gPoly`, `standingIF = ℚ⟮√3, √11, η⟯` with `standingField = standingIF.toSubfield`, `finrank_standingField_le` (`≤ 28`);
  `im_eq_zero_of_aeval_gPoly` (every complex root of `g` is real: seven sign changes at `−4, −2, −5/4, 0, 1/5, 1, 2, 3`, the intermediate
  value theorem, and a root count).

**Leaves**: `numberField_standingField` (from `standingIF`); `isTotallyReal_standingField` (closure induction; the generators' images are
`±√3`, `±√11` and a root of `g`); `usable_card_ge` (`card_ge_of_usable` at `𝓞 F ⧸ w`; finiteness of the quotient is read off the hypothesis
`Nat.card … % 4 = 3`).

**The statement check** is `tools/fs131_i10c_statements.py <base> <file>`: every declaration of the base commit's file appears verbatim in the
working tree (a theorem up to its first ` :=`, anything else whole, docstrings and module docs included). It caught a change of mine: I had
written the first leaf's proof with `where`, which removed its ` :=`; restored. `--self-test` plants two faults (one character of a theorem's
statement; one line of a definition) and sees both.

**Evidence.** Build: `data/fs131/i10c/logs/build-1-group1.log` (exit 0, 8m21s; `Arith.StandingFive` rebuilt in 9.1 s and `Proofs`; its
warnings: the six open leaves, lines 675, 683, 688, 694, 718, 744, and ten missing docstrings, added in the next stage). Axioms:
`data/fs131/i10c/axioms-group1.lean`, log `data/fs131/i10c/logs/axioms-group1.log` — twelve records on the standard three
(`usableBelow_347` on `propext` alone), and the control (`le_localBound`, open at this stage) prints `sorryAx`. Statements:
`data/fs131/i10c/logs/statements-group1.log` — PASS, 37 base declarations unchanged; self-test PASS. The finite check's own control: at
`usableBelow 348` the `decide` reports the proposition false (347 passes all three tests), kept in the file as a spec example in stage 3.

**Re-priced from these leaves** (the brief's ask). The plan priced the file at 1,300 lines and 300k harness tokens. Group 1 — the period
identity, the whole finite-field layer, the degree bound, total realness and three leaves — is about 560 lines of Lean and took seven
elaboration rounds of 3–10 s each on scratch files, about 60k of my own tokens after the readback. The six leaves left are proved on a
scratch copy at this stage's commit (`data/fs131/i10c/scratch/Final.lean`: the whole file with no `sorry`, elaborated by `lake env lean`,
which is iteration and not evidence); stage 3 is their build. The job stays inside the brief's guidance.

**A Lean fact met here** (draft for `LEAN.md` § Building, Keryx's file): `lake env lean <file>` does not report a missing docstring on a
public `def`; the build does (ten here). It is the same gap as `autoImplicit`: the lakefile's linter options are not in force.
