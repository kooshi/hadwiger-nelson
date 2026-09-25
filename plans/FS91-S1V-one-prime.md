# FS-91 crunch J13 — blind verifier of J12 (one prime): X1 = ONE-a, X2 = ONE-b, X3 = ONE-c

*Record of crunch job J13 (de Bruijn, Opus 5.5), brief `data/crunch-2026-09-25/briefs/J13-M1-one-prime-blind-verifier.md`
with `STANDING-RULES.md`. Data `data/fs91/j13/`; tools `tools/crunch_j13_*.py`. Fence as the brief's, plus
`plans/CRUNCH-2026-09-25-INDEX.md` (owner's message).*

## Stage 1 — SAVED (quotation check and C0)

### Quotation check (standing rule 5)

| quoted in the brief | source | result |
|---|---|---|
| X1 "For every prime `p ≡ 1 (mod 4)`, `Θ₄(R_{{p}}) ⊄ T + A`." | `plans/FS91-character-local-global.md` l. 474 (inside the block "J12 — one prime", l. 473–477) | verbatim |
| X2 "Is every `U₅`-minimal closed subset of `Θ₄(R₅)` contained in `T + A`?" | same file l. 475 | verbatim (the source carries no quotation marks; the brief's added "a verdict 'yes' or 'no' … or GAP" is outside its quotes) |
| X3 "Are the orders of band torsion characters of `R_{{p}}` unbounded at one prime — by a derived infinite family, each member checked by an exact finite computation; never a list extended in search of a pattern." | same file l. 476–477 | verbatim |
| "the brief says §S" | the section heading above l. 473 was not opened (fence) | not checked |
| Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` § Where the problem stands, item 23 | verbatim (the brief adds a final period) |
| "at `p = 5` a heteroclinic character exists (`LEDGER.md` row 97)" | `LEDGER.md` row 97; `plans/FS89-S0B-band-set.md` §3 (S0B-T3) | agrees |
| owner's message: J01-7 (`|S| ≥ 2`, every `k`, `A(R_F) = Hom_ℚ(F(i), ℝ)` mod 1) and CLG verified | other crunch records, fenced | **not checkable** from inside the fence; used only as the owner's statement, and nothing below rests on it |
| verified inputs: S0B §1–§4, FS89-derivation §2, §4, §6, S1V § V-A3, § V-A4, `[Berend1984min]` Lemma 3.3, the torsion list | read in full from disk | the statements I use are quoted where used |

**Fence slip (mine, logged for the owner).** Locating the quoted block by `grep -n` in the fenced plan printed four lines outside
it: l. 423 (a staffing row), l. 503–505 (the planner J03's priors: "P-U3 | ONE-a proved at every `p` | 0.75", "P-MS5 | ONE-b answered
'no' (a non-`T + A` minimal set exists at one prime) | 0.60", "P-U5 | ONE-c answered 'unbounded' by a derived infinite family | 0.35")
and l. 560–561 ("**ONE-a** is a construction (S0B-T3's heteroclinic at a general `p`; the lens `√2/6 < 1/4` is `p`-free, the step rule is
not). **ONE-b** reduces to one construction"). These are the planner's, not J12's; no J12 route was seen. Nothing else of the file was
read. The C0 below is therefore **not** blind to the planner's priors, and was written after about thirty minutes of thinking (not a
clean prior): both facts disclosed.

### C0 — probability per claim (written before any tool ran)

| claim | my verdict will be | probability |
|---|---|---|
| X1 | TRUE at every `p ≡ 1 (mod 4)` (the order-3 and parity leaves exist at every such `p`, and their layer-0 discs meet by the `p`-free lens) | 0.93; TRUE only at named primes 0.03; GAP 0.04 |
| X2 | "no" (a `U₅`-minimal set outside `T + A` exists), with proof | 0.35 |
|    | "yes" (every minimal set is in `T + A`), with proof | 0.15 |
|    | GAP (neither proved in this budget) | 0.50 |
| X3 | TRUE: unbounded, by a derived infinite family of periodic band orbits (a periodic orbit of the orbit model is a torsion character, and periods are unbounded) | 0.80; FALSE (bounded, with proof) 0.03; GAP 0.17 |
