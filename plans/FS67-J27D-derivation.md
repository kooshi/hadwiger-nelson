# FS-67 — derivation record (crunch job J27D)

*De Bruijn (Opus 5.5), 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J27D-FS67-derivation.md` with `STANDING-RULES.md`. Plan:
`plans/FS67-tight-products.md` (§4.1, §4.3, §5.1). Data `data/fs67/j27d/`; tools `tools/crunch_j27d_*.py`. **Fenced from J27V until J27V's
blind phase is committed.***

## Theorems this phase proved

*(Filled at stage 5; grades per `CLAUDE.md` § Notation.)*

## Stage 1 — SAVED (quotation check, C0)

### 1.1 Quotation check (standing rule 5)

`tools/crunch_j27d_quotes.py` extracts every claim statement the brief quotes (`**ID** (§x.y) "…"`, the §4.1 definitions block and FS67's
inner quote) and requires each to occur verbatim (whitespace-normalised) in `plans/FS67-tight-products.md`. Result
`data/fs67/j27d/quotes.out`: **12 quotes, 0 missing** — DA-1′, DA-2′, DA-3, DA-4, DB-1, DB-2, DC-1, DC-2, DD-1, DD-2, the definitions, FS67.
Plant (`--plant`: `k ≥ 3` → `k ≥ 2` in one quote): exit 1, 1 missing (`quotes-plant.out`) — the check fires.

Unquoted brief text, compared by eye: DC-3's "(exact arithmetic of seconds; no search)" against the plan's "(exact, seconds; no search)" —
a faithful paraphrase; DC-2's "that you state and prove" against "that J27D states and proves" (outside the quotation marks) — faithful. The
brief's "Delete 'connected' once" for DC-2 is an instruction, not a quote.

External statements this record rests on, quoted from the held PDFs (text extracted with `pdftotext -layout`):
- `[Tardif2023]` Theorem 1: "For any integers n ≥ 4 and m > n, there exist graphs G, H such that χ(G) ≥ m, χ(H) > n and χ(G × H) ≤ n."
- `[GodsilEtAl2020]` Result 1: "For any graphs G and H, we have that χv (G × H) = min{χv (G), χv (H)}." Result 4: "Let G and H be graphs such
  that χv (G) < χv (H) and H is connected. If G admits a strictly complementary dual solution with strictly positive diagonal, then every
  optimal vector coloring of G × H is induced by G." §1.2: "It follows from results in [5] that any 1-walk-regular graph has a strictly
  complementary dual solution with strictly positive diagonal." Result 5: "Let G and H be graphs such that χv (G) = χv (H). If both G and H
  admit connected strictly complementary dual solutions, then every optimal vector coloring of G × H is a convex combination of vector
  colorings induced by the factors." Definition (§1): "a vector coloring of G × H is induced by G if and only if the (i, ℓ)(j, k)-entry of its
  Gram matrix only depends on i and j."
- `[TardifWrochna2019]` §1.1: K is strongly multiplicative if "If G and H are connected graphs and C, C′ odd cycles in G and H, respectively,
  such that (G × C′) ∪ (C × H) admits a homomorphism to K, then G or H admits a homomorphism to K." Theorem 1 ("[ES85; Häg+88]"): "The odd
  cycle graphs are strongly multiplicative."
- `[Tardif2008]` §4.2: "In [17] it is proved that A(n) implies B(n) and B(n) implies H(n)." (as the plan quotes).

### 1.2 C0 — priors per claim (TRUE / FALSE / GAP)

*Honest deviation:* registered after reading the sources and after informal reasoning on DA-1′–DA-3 and DC-2 had begun (not before any
derivation, as the brief asked); the priors on those claims are therefore informed, and are marked so.

| claim | TRUE | FALSE | GAP | note |
|---|---|---|---|---|
| DA-1′ | 0.97 | 0.02 | 0.01 | informed |
| DA-2′ | 0.95 | 0.03 | 0.02 | informed |
| DA-3 | 0.93 | 0.04 | 0.03 | informed |
| DA-4 | 0.85 | 0.05 | 0.10 | rests on `[Tardif2023]` Thm 1 (finiteness to be checked) |
| DB-1 | 0.35 | 0.20 | 0.45 | the nonzero-winding components are the risk |
| DB-2 | 0.80 | 0.05 | 0.15 | "tower" must be identified |
| DC-1 | 0.85 | 0.05 | 0.10 | rests on GRRSV Result 4 |
| DC-2 at some τ_k > 0 | 0.95 | 0.02 | 0.03 | informed |
| DC-2 at τ_k = 1/(k−1) | 0.70 | 0.10 | 0.20 | informed (a bootstrap reaching it was sketched) |
| DD-1 | 0.60 | 0.10 | 0.30 | rests on Result 5's convex form |
| DD-2 | 0.15 | 0.05 | 0.80 | |
