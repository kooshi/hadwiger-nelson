*Brief for crunch job **J08**, milestone M1 (FS-91), derivation with complete lists fixed by derivation. Opus 5.5, 2026-09-25. Written
by J03 (`plans/FS91-character-local-global.md` §S, §M).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the derivation agent for character colourings at the exposed fields**, in the Lean 4
Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** The owner coordinates and reviews by
artifact; the mathematics is yours.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`, and
continue at the first stage not SAVED. Redo nothing saved.

## The question, and why now

The conjecture predicts that the plane over ℚ(√167) needs at least six colours (`CLAUDE.md`, the target). Band rigidity is now verified to
nine colours (J01), so — if the class theorem J07 is deriving holds — a **character** colouring of ℚ(√167)'s plane with `k` colours exists
exactly when one of the field's residue targets (the planes over 𝔽₂₃, 𝔽₄₃, 𝔽₅₉, …, and the ramified 167) carries a band `k`-character.
That is a finite question per target, and a derivation fixes which targets matter. **Characters only, never `χ`**: at `k ≥ 4` the absence of
a character colouring says nothing about `χ` (G71). **Note what a positive would mean:** a band six-character of Γ₂₃ or Γ₄₃ at level one is a
six-colouring of that plane; five colours are refused at both (rows 69, 71), so it would make it **the first exactly six-chromatic finite
Euclidean plane** (G56). The planner puts that at 0.15 (§P, P-W6). **Every outcome counts** (Kooshi: *"A proven theorem about why its
impossible is also valid. All novel knowledge is a success."*); a null is a result, and a positive must be audited hardest (G21).

## The statements (verbatim)

From `plans/FS91-character-local-global.md` §S, "J08 — six at the exposed fields":
- **SIX-a (the reduction).** "For a prime `q ≡ 3 (mod 4)`, every band `k`-character of `Γ_q = Cay(𝔽_{q²}, μ_{q+1})` is
  `λ_a(x) = Tr_{𝔽_{q²}/𝔽_q}(ax)/q` for some `a ≠ 0`, and `λ_a` is band `k` iff no `t ∈ V_{N(a)}` has `|t| < q/k` (`t` read in
  `(−q/2, q/2)`), where `V_c = {t ∈ 𝔽_q : t² − 4c is a non-square or 0}`."
- **SIX-b (the two window members).** "The complete list of `c ∈ 𝔽_q^×` giving band `k`-characters for `q ∈ {23, 43}`, `k ∈ {6, 7, 8}`;
  hence `χ_char(Γ₂₃)` and `χ_char(Γ₄₃)`."
- **SIX-c (every other usable prime).** "For `k ∈ {6, 7}`: an explicit `Q_k` from Weil (or Burgess) above which no `Γ_q` has a band
  `k`-character, and the complete list below it."
- **SIX-d (ramified and higher levels).** "The ramified place above 167 in ℚ(√167) and higher levels at 23 and 43: band 6- and 7-characters,
  or CLG-e's collapse."
- **SIX-e (the fields).** "Given CLG_6 and CLG_7 (J07, unverified): `Θ₆(R_{ℚ(√167)}) = ∅` iff no target of ℚ(√167) carries a band
  six-character, and `χ_char(ℚ(√167)²) = min` over its targets; the same for K(√7) and de Grey's field `K(√5,√7)`."
- **SIX-f (last, if budget allows).** "The band-1/6 torsion characters of `Q` (N₀'s analogue)."

§M.1 converts SIX-b and SIX-c into one number per target: **`κ(Γ_q) = max_c min_{t ∈ V_c} |t|/q`**, with `χ_char(Γ_q) = ⌈1/κ(Γ_q)⌉`.
Report `κ` exactly beside every yes/no. SIX-a is the planner's derivation, one mind: **re-derive it before using it.**

## Read first, from disk

- The plan, `plans/FS91-character-local-global.md`, **all but §P.basis** (fenced from you so your 23 result is independent of the planner's
  hand check).
- `LEDGER.md` rows 50 (`[Fischer1990]` Ex. 4: no additive `k`-colouring with `k < 11` over ℚ(√167) — every torsion band character is additive,
  so a free consistency check), 53 (K(√7)'s usable primes 83 and ≥ 103; de Grey's 131, 479), 68–71 (six refused at 59, 67, 79, 83 by
  certificate; five refused at 23, 43, 47; **verified colourings with ceilings 8, 7, 8, 8, 10 at 23, 27, 31, 43, 47** — the known positives),
  75 (`α(Γ₂₃) ≤ 97`: the ratio 0.183 > 1/6 gives no refusal at six), 96; `CLAUDE.md` G44, G54, G56, G58, G59.
- `plans/FS89-derivation.md` S0A-4, S0A-8 (the middle-half/Weil argument at band 1/4 — your SIX-c is its analogue), S0A-9, S0A-13.
- `data/fplane/periodic-below-71.json` — the verified periodic colourings behind row 69's ceilings; reading an existing file is not a search.

## Fenced

`plans/FS91-character-local-global.md` §P.basis only. Your verifier J11 is fenced from your record, data, tools and brief; write nothing it reads.

## Stages

1. **Quotation check and C0 (about 20k).** Log the quotations' check. Probabilities: SIX-a true; a band six-character at 23; at 43;
   `χ_char(ℚ(√167)²)` given CLG. Save.
2. **SIX-a (about 40k).** Derive the reduction. Check its value-set law against a direct enumeration of `μ_{q+1}` at small `q` (the law is
   derived, so a refusal it produces is the suspect verdict — `CLAUDE.md` § The gate, the measured and derived halves). Tool
   `tools/crunch_j08_*.py`, a planted fault firing for its own reason, and a positive signal written even on a null. Save.
3. **SIX-b (about 40k).** The complete lists at 23 and 43, `k = 6, 7, 8`, and `κ(Γ₂₃)`, `κ(Γ₄₃)` exactly. **Control:** the tool must find a
   class at `k = 8` at both (row 69's ceilings); compare with the colourings in `data/fplane/periodic-below-71.json`. Save.
4. **SIX-c (about 80k).** Derive the explicit threshold `Q_k` (write the character-sum inequality and its constants), then the complete list
   below it; enumerate `c` (the parameter), never colourings met by chance. Six is refused at level one from 59 by certificate and spectrum
   (rows 68–69), which a band six-character cannot beat — use that as a second route at `k = 6`. Save.
5. **SIX-d and SIX-e (about 60k).** Ramified 167 and the higher levels (level collapse at `p > k/2`, CLG-e); then the three fields, stated
   "given CLG_6, CLG_7 (J07, unverified)" and read aloud against "characters only". Save and report.
6. **SIX-f, only if budget allows (about 60k).** The band-1/6 torsion characters of `Q`; a stop at stage 5 is a complete job.

## Record and paths

- **Record:** `plans/FS91-S1D-six.md`, with "Theorems this phase proved" and the would-have-searched log. Your lists are **complete
  enumerations of finite sets a derivation fixed first** — in by standing rule 3 and Kooshi's item-2 ruling; log each as such. "Try `c`
  until one works" is out.
- **Data:** `data/fs91/j08/`. **Tools:** `tools/crunch_j08_*.py`. Each under 2 minutes and 2 GiB, so no slot is needed.
- **Budget:** about 350k harness; hand back with the record saved by 420k. Priority if short: stages 2–3, then 5.
- **No children:** no subagents, forks or workflows — delegation is one level deep (`CLAUDE.md` § Delegation), because staffing is Kooshi's
  budget decision and the owner can only review work it knows about.
- **Report:** after stage 5 (and at any halt), standing rule 9, to `data/crunch-2026-09-25/reports/J08.md` and `"main"` by SendMessage.

Thank you.
