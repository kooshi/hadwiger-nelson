*Brief for crunch job **J27D**, milestone FS-67 (`plans/STUB-tight-product-colourings.md`), derivation. Opus 5.5, 2026-09-25. Written by
J27 (`plans/FS67-tight-products.md` §S, §4.3, §5.1).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **FS-67's derivation agent**, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and
`DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** I'm the product owner.
**If your record already exists you are resuming:** check its last SAVED stage against `git log -- plans/FS67-J27D-derivation.md` and continue
at the first stage not SAVED.

## The question, and why now

Take a graph `G` whose every proper `k`-colouring is *gap-free* (every closed neighbourhood sees all `k` colours) — Hoffman-tight graphs are
like this — and a connected graph `H` that needs more than `k` colours. Must every `k`-colouring of the categorical product `G × H` ignore the
`H` coordinate? Greenwell–Lovász (1974) say yes for `G = K_k`; Zhang (2012) says yes for vertex-transitive factors with a strict ratio gap. The
planner's reframe found that the question contains Hedetniemi's conjecture at `k` (so the gap-free form fails at every `k ≥ 4`), that the
vector-colouring literature (`[GodsilEtAl2020]`) answers its strict spectral regime, and that at three colours El-Zahar–Sauer's argument may
settle it outright. Your job is to derive each claim below: TRUE with a proof, FALSE with a counterexample, or GAP at a named step. **Every
outcome counts** (standing rule 4): a counterexample is worth as much as a proof; do not lean toward a yes.

## Definitions and statements (verbatim from `plans/FS67-tight-products.md` §4.1, §4.3, §5.1)

Definitions (§4.1): "Graphs are simple and loopless; `k ≥ 3`. A proper `k`-colouring `c` of `G` is *gap-free* if every closed neighbourhood
`N[x]` meets all `k` colours. `G` is *`k`-gap-free* if it is `k`-colourable and every proper `k`-colouring of it is gap-free. A `k`-colouring `β`
of `G × H` (categorical product) is *pulled back from `G`* if `β(x, h) = c(x)` for some `k`-colouring `c` of `G`. `E_k(G)` is the graph on the
maps `V(G) → [k]` that are not proper colourings, `f ∼ g` iff `f(u) ≠ g(v)` for every ordered edge `(u, v)` of `G`. **FS67(G, k)**: "for every
connected `H` with `χ(H) > k`, every proper `k`-colouring of `G × H` is pulled back from `G`"."

- **DA-1′** (§5.1) "If `G` is `k`-colourable but not `k`-gap-free, then for every graph `H` with at least two vertices there is a proper
  `k`-colouring of `G × H` not pulled back from `G`."
- **DA-2′** (§5.1) "If `G` is `k`-gap-free, then FS67(G, k) holds if and only if `χ(E_k(G)) ≤ k`."
- **DA-3** (§4.3) "For `k ≥ 3` and a connected graph `X` with `χ(X) > k`, the graph `G = K_k × X` is connected and uniquely `k`-colourable, hence
  `k`-gap-free; and FS67(K_k × X, k) fails if and only if some connected graph `H` with `χ(H) > k` has `χ(X × H) ≤ k`."
- **DA-4** (§4.3) "For every `k ≥ 4` there is a finite connected uniquely `k`-colourable graph `G` for which FS67(G, k) fails; and for every
  `k ≥ 3`, if FS67(G, k) holds for every finite connected `k`-gap-free `G`, then `χ(X × H) > k` for all finite graphs `X`, `H` with
  `χ(X), χ(H) > k`."
- **DB-1** (§4.3) "For every connected non-bipartite graph `G`, `χ(E_3(G)) ≤ 3`; hence FS67(G, 3) holds for every connected 3-gap-free graph `G`."
- **DB-2** (§4.3) "`UD(𝔽₉, 2)`, and every level of the 3-adic tower that is Hoffman-tight at three colours, is connected and 3-gap-free."
- **DC-1** (§4.3) "If `G` is 1-walk-regular with `χv(G) = k` and `H` is connected with `χv(H) > k`, then every proper `k`-colouring of `G × H`
  is pulled back from `G`." (State the link between `χv(G) = k` and Hoffman-tightness for 1-walk-regular `G`, with its source.)
- **DC-2** (§4.3) "If `G` is connected and `k`-gap-free, and `H = Cay(A, T)` for a finite abelian group `A` with `λ* = max_{χ ≠ 1} |Σ_{t ∈ T}
  χ(t)|/|T| < τ_k`, then every proper `k`-colouring of `G × H` is pulled back from `G`" — with `τ_k` an explicit function of `k` that you state
  and prove (the target is Pak–Vilenchik's `1/(k−1)`; any explicit positive `τ_k` is a result). Delete "connected" once and record whether the
  proof breaks.
- **DC-3** (§4.3) a table: for `k = 3, 4, 5` and the residue planes `Γ_q` of G44's exact spectra, which satisfy DC-1's or DC-2's hypothesis on
  `H` (exact arithmetic of seconds; no search).
- **DD-1** (§4.3) "If `χv(G) = χv(H) = k`, `χ(H) > k`, `H` connected, and `G`, `H` satisfy `[GodsilEtAl2020]` Result 5's hypothesis, then every
  proper `k`-colouring of `G × H` is pulled back from `G`" — TRUE, FALSE with a counterexample, or GAP at a named step; and whether it reaches
  `[Zhang2012]`'s IS-imprimitive exception.
- **DD-2** (§4.3) "For some `k ≥ 4` there is a regular Hoffman-tight (`λ_min = −d/(k−1)`) connected graph `G` for which FS67(G, k) fails" — or its
  negation for a named class, or GAP naming the missing ingredient.

## Read first, from disk

- `plans/FS67-tight-products.md` §IQ (4.1), §4.3 with its **Routes** paragraph, §5.1 (the obligation pass: children and hypothesis uses). The
  routes are suggestions; a better route is welcome.
- `plans/STUB-tight-product-colourings.md` in full; `plans/PA-products-GL1974-LT2002.md` §1.2, §4, §7 (GL Thm 1, Cor. 1, Cor. 3 verbatim;
  PA-P1–P5); `plans/PA-tardif2023.md` §5.1–§5.4, §8 (PA-T6).
- `plans/M3-S1D-windows-five.md` §3.2 (J21-MX and its mixing lemma; blind-checked in `plans/M3-S1V-windows-five.md`);
  `plans/M3-PA-mixing.md` Stages 2, 4, 6 (Tardif–Wrochna, Pak–Vilenchik Thm 3 verbatim).
- Held PDFs under `~/source/library/pdf/`: `arXiv-1801.08243-godsil-roberson-rooney-samal-varvitsiotis-vector-coloring-categorical-product.pdf`
  (Results 1–5, §4; the 1-walk-regular passage); `[GodsilRobersonRooney2017]` = `~/source/library/pdf/arXiv-1512.04972.pdf` (§4.3, Thm 4.9: optimal vector colourings of 1-walk-regular graphs);
  `tardif-2008-hedetniemi-conjecture-40-years-later-GTN54.pdf` §3–§4; `Tardif2023-product-5-chromatic-graphs-can-be-4.pdf` (Thm 1);
  `arXiv-1007.0797-zhang-independent-sets-direct-products.pdf` (Thm 1.8); `TardifWrochna2019-…pdf` (for DB-1: strong multiplicativity of odd
  cycles and its covering-space proof).
- `CLAUDE.md` G54, G71, G24, G44 and `LEDGER.md` rows 72, 85, 86, 88, 89.

**Not held, owed** (do not claim their content): Duffus–Sands–Woodrow 1985, El-Zahar–Sauer 1985, Tardif 2006 (algorithmic 3-colouring of
products), `[Tardif2022frac]` (*Counterexamples to Hedetniemi's conjecture with large fractional chromatic numbers*). If you fetch one, record
the route (`BIBLIOGRAPHY.md` is the front-page lane's; propose the row in your record).

## Fenced

Nothing is fenced from you. **Your record is fenced from J27V (the blind verifier) until J27V's blind phase is committed**; write nothing to
J27V.

## Stages

1. **The quotation check** (every quoted statement above against its source; log it) **and C0**: a probability per claim (TRUE/FALSE/GAP) before
   you derive anything. ~30k. Save.
2. **DA-1′, DA-2′, DA-3, DA-4.** ~60k. Save.
3. **DC-1, DC-2, DC-3.** For DC-2, derive the best `τ_k` you can and prove it; plant a fault in `tools/crunch_j27d_*` checks (e.g. a gapped `G`
   or a `λ*` just above threshold) and watch it fire. ~90k. Save.
4. **DB-1, DB-2.** If El-Zahar–Sauer's colouring cannot be reconstructed from held sources, derive a colouring of `E_3(G)` yourself (the pair
   `(f, g)` is one proper 3-colouring of the bipartite double cover `G × K₂`; G71's heights) or end GAP at the named step. ~80k. Save.
5. **DD-1, DD-2**, the theorem list, the "would have searched here" log, and your report. ~80k. Save and report.

**The ban (standing rule 3):** checking a *given* construction (that a stated `β` is proper and not a pullback) by exact arithmetic is in;
enumerating all colourings of a fixed small product whose extent your derivation fixed first is at the edge and must be logged; searching for
a counterexample is out — write it as a dated post-ban stage (≥ 2026-10-01) instead.

## Record and paths

- Record: `plans/FS67-J27D-derivation.md`, with the heading **"Theorems this phase proved"** (one line per theorem, grade, address), a
  divergence-ready claim table (claim id, verdict, where the proof is), and the would-have-searched log.
- Data: `data/fs67/j27d/`; tools: `tools/crunch_j27d_*.py` (each with a plant that fires).
- Commits by explicit path, subjects "J27D: stage n"; push after each stage; never force-push. Do not edit `CLAUDE.md`, `LEDGER.md`,
  `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the crunch index, the M1–M3 files, FS-84's or row 88's files, or J27's plan; propose edits in
  your record.
- **No subagents:** do not use the Agent tool, a fork or a workflow (`CLAUDE.md` § Delegation; the owner reviews only work it knows about). If
  the work outgrows your context, stop at a saved stage and say what is left.
- **Budget:** about 350k by the harness's count; hand back by 420k. Report after stage 5 (or at any foreseeable halt) in standing rule 9's
  form to `data/crunch-2026-09-25/reports/J27D.md`, committed, and by SendMessage `to: "main"`. Final text: "J27D idle; report sent to the owner
  by SendMessage".

Thank you.
