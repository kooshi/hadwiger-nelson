# FS-67 — the close-time prior-art gate (crunch job J40)

*De Bruijn (Opus 5.5), 2026-09-25, FS-67's prior-art reader. Brief: `data/crunch-2026-09-25/briefs/J40-FS67-prior-art-gate.md` with
`STANDING-RULES.md`. Gate: WORKFLOW 3.2's eight questions, run on the theorems J27D filed (`plans/FS67-J27D-derivation.md`, "Theorems this
phase proved"). Touches only this file, `data/fs67/j40/` and `~/source/library/pdf/`. Every negative measures its query's words (G21); nothing
here is called "new" — a statement not located is "not found by these searches". Bibliography rows and `CLOSED-QUESTIONS.md` entries below are
proposals for the front-page lane.*

## Theorems this phase proved

None. This is a reading job: its products are attributions and negatives, graded by what was read (per section, below). One small fact is
checked here by hand where a verdict needed it; it is listed in the stage that uses it with its grade.

## Stage 1 — SAVED (quotation check)

`data/fs67/j40/quotes.sh` (fixed-string `grep -F` of each quoted fragment of the brief against its source; output `quotes.out`): **7 of 7
found** — J27D's "uniquely colorable graph" and "expander" (Stage 5's prior-art debt line), "Lemma W", "is a component invariant" (theorem
row 13), DC-2's row "at `τ_k = 1/(k−1)`, `G` any `k`-gap-free graph", DA-4's row, and J27's §PA quotation of `[Tardif2008]` §4.2 "In [17] it is
proved that A(n) implies B(n) and B(n) implies H(n)." **One condensation logged:** the brief's `"uniquely colorable" × "expander"` occurs
verbatim nowhere; J27D writes it as `"uniquely colourable graph × expander"` (Stage 3, British spelling) and as separate quoted terms
(Stage 5). The condensation is faithful — same words, same scope — and the plant (`PLANT=1`, J27D's Stage-3 spelling in straight quotes, which
does not occur) exits 1, `quotes-plant.out` — the check fires. The brief's unquoted summaries of DA-3/DA-4, DC-2, Lemma W and DB-1 were
compared by eye with J27D's theorem rows 5, 6, 10, 13, 14: faithful at scope (DC-2's "with no other condition on `G`" matches J27D's "`G` any
`k`-gap-free graph", connectivity unused).

**The statements gated, verbatim from J27D's "Theorems this phase proved" table** (each stage quotes its own at full scope):
- row 5 "DA-3: `K_k × X` connected, uniquely `k`-colourable, gap-free; FS67 fails ⟺ a Hedetniemi partner of `X`"
- row 6 "DA-4: FS67 fails for a finite connected uniquely `k`-colourable `G` at every `k ≥ 4`; FS67 on that class ⟹ `H(k)`"
- row 8 "DC-1: 1-walk-regular, `χv(G) = k`, `H` connected, `χv(H) > k` ⟹ pullback"
- row 10 "DC-2 at `τ_k = 1/(k−1)`, `G` any `k`-gap-free graph, connectivity of `G` unused"
- row 11 "DC-3: which `Γ_p` (`p ≤ 103`) meet DC-1's / DC-2's hypothesis at `k = 3, 4, 5`"
- row 13 "Lemma W: `D_C(f) = D_C(g) = 3w_C(f,g)` on every arc of `K_3^G`; `D_C` is a component invariant"
- row 14 "DB-1 partial: components of `E_3(G)` with `D_C ≡ 0` for some odd `C` are 3-colourable"
- row 15 "Lemma T: Hoffman-tight at `k` ⟹ every proper `k`-colouring gap-free"
- row 16 "DB-2: `UD(𝔽₉,2)` and every tight level of `UD(ℤ₃[i]/3^j, 2)` are connected and 3-gap-free"
- row 17 "DD-1: equal `χv`, Result 5's hypothesis, `χ(H) > k`, `H` connected ⟹ pullback"
- rows 2–3 (L1, DA-2′'s characterisation) are gated with DA-3 in Stage 2, since DA-3 rests on them.
