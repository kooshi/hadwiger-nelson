*Brief for crunch job **J27V**, milestone FS-67 (`plans/STUB-tight-product-colourings.md`), blind verifier. Opus 5.5, 2026-09-25. Written by
J27 (`plans/FS67-tight-products.md` §S) before any claim exists — this is the fixed claim list (FS-89's form).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **FS-67's blind verifier**, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and
`DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** I'm the product owner.
**If your record already exists you are resuming:** check its last SAVED stage against `git log -- plans/FS67-J27V-verification.md`.

## The question, and why now

A derivation agent (J27D) is proving or refuting the claims below about `k`-colourings of categorical products `G × H` with `G` gap-free and
`χ(H) > k`. You check each claim **blind** first — from the statement, your own route, and the verified inputs — and only then compare. A
verdict of FALSE with a counterexample, or GAP at a named step, is as valuable as TRUE (standing rule 4). A verifier checks a fixed
statement; if your blind route stalls, say where, and use the lemma-statement phase (stage 3) rather than inventing a route you are fenced from.

## The fixed claim list (verbatim from `plans/FS67-tight-products.md` §4.1, §4.3, §5.1 — the plan itself is fenced from you)

Definitions (§4.1): "Graphs are simple and loopless; `k ≥ 3`. A proper `k`-colouring `c` of `G` is *gap-free* if every closed neighbourhood
`N[x]` meets all `k` colours. `G` is *`k`-gap-free* if it is `k`-colourable and every proper `k`-colouring of it is gap-free. A `k`-colouring `β`
of `G × H` (categorical product) is *pulled back from `G`* if `β(x, h) = c(x)` for some `k`-colouring `c` of `G`. `E_k(G)` is the graph on the
maps `V(G) → [k]` that are not proper colourings, `f ∼ g` iff `f(u) ≠ g(v)` for every ordered edge `(u, v)` of `G`. **FS67(G, k)**: "for every
connected `H` with `χ(H) > k`, every proper `k`-colouring of `G × H` is pulled back from `G`"."

- **V-DA-1′** "If `G` is `k`-colourable but not `k`-gap-free, then for every graph `H` with at least two vertices there is a proper `k`-colouring
  of `G × H` not pulled back from `G`."
- **V-DA-2′** "If `G` is `k`-gap-free, then FS67(G, k) holds if and only if `χ(E_k(G)) ≤ k`."
- **V-DA-3** "For `k ≥ 3` and a connected graph `X` with `χ(X) > k`, the graph `G = K_k × X` is connected and uniquely `k`-colourable, hence
  `k`-gap-free; and FS67(K_k × X, k) fails if and only if some connected graph `H` with `χ(H) > k` has `χ(X × H) ≤ k`."
- **V-DA-4** "For every `k ≥ 4` there is a finite connected uniquely `k`-colourable graph `G` for which FS67(G, k) fails; and for every `k ≥ 3`,
  if FS67(G, k) holds for every finite connected `k`-gap-free `G`, then `χ(X × H) > k` for all finite graphs `X`, `H` with `χ(X), χ(H) > k`."
- **V-DB-1** "For every connected non-bipartite graph `G`, `χ(E_3(G)) ≤ 3`; hence FS67(G, 3) holds for every connected 3-gap-free graph `G`."
- **V-DB-2** "`UD(𝔽₉, 2)`, and every level of the 3-adic tower that is Hoffman-tight at three colours, is connected and 3-gap-free."
- **V-DC-1** "If `G` is 1-walk-regular with `χv(G) = k` and `H` is connected with `χv(H) > k`, then every proper `k`-colouring of `G × H` is
  pulled back from `G`."
- **V-DC-2** "If `G` is connected and `k`-gap-free, and `H = Cay(A, T)` for a finite abelian group `A` with `λ* = max_{χ ≠ 1} |Σ_{t ∈ T} χ(t)|/|T|
  < τ_k`, then every proper `k`-colouring of `G × H` is pulled back from `G`" — in the blind phase, derive the best explicit `τ_k` you can; in
  stage 4, check J27D's `τ_k` and its proof.
- **V-DD-1** "If `χv(G) = χv(H) = k`, `χ(H) > k`, `H` connected, and `G`, `H` satisfy `[GodsilEtAl2020]` Result 5's hypothesis, then every proper
  `k`-colouring of `G × H` is pulled back from `G`."
- **V-DD-2** "For some `k ≥ 4` there is a regular Hoffman-tight (`λ_min = −d/(k−1)`) connected graph `G` for which FS67(G, k) fails."
- **V-DC-3** (stage 4 only) spot-check three rows of J27D's table of residue planes against exact spectra.

For V-DD-1 and V-DD-2, J27D may end FALSE or GAP; you verify whichever it asserts (a counterexample's every property; a GAP's named step is
really missing).

## Verified inputs (you may use these as given)

- Greenwell–Lovász Theorem 1 and Corollaries 1, 3, verbatim in `plans/PA-products-GL1974-LT2002.md` §1.2 (and the held PDF
  `~/source/library/pdf/GreenwellLovasz1974-applications-of-product-colouring.pdf`).
- `[Tardif2008]` §4.2 (A(n), B(n), "A(n) implies B(n) and B(n) implies H(n)") and Thm 3.2 (Burr–Erdős–Lovász), held PDF
  `tardif-2008-hedetniemi-conjecture-40-years-later-GTN54.pdf`.
- `[Tardif2023]` Theorem 1, held PDF `Tardif2023-product-5-chromatic-graphs-can-be-4.pdf`.
- `[GodsilEtAl2020]` Results 1–5 and §4, held PDF `arXiv-1801.08243-godsil-roberson-rooney-samal-varvitsiotis-vector-coloring-categorical-product.pdf`;
  `[GodsilRobersonRooney2017]` (held: `~/source/library/pdf/arXiv-1512.04972.pdf`, §4.3 Thm 4.9).
- `[Zhang2012]` Thm 1.8, held PDF `arXiv-1007.0797-zhang-independent-sets-direct-products.pdf`.
- J21-MX's mixing lemma as stated in `plans/M3-S1D-windows-five.md` §3.2 (blind-checked by `plans/M3-S1V-windows-five.md`).
- `CLAUDE.md` G54 (tight ⟹ every colouring gap-free) and `LEDGER.md` row 72 (the 3-adic plane tight at every level).

## Fenced until your blind phase (stage 2) is committed

J27D's record `plans/FS67-J27D-derivation.md`, `data/fs67/j27d/`, `tools/crunch_j27d_*`, J27D's brief
`data/crunch-2026-09-25/briefs/J27D-FS67-derivation.md`, J27D's report, **the planner's plan `plans/FS67-tight-products.md`** (it carries
routes), `data/fs67/j27/`, `plans/PA-tardif2023.md` §5.4 (it carries DA-2′'s proof), the crunch index `plans/CRUNCH-2026-09-25-INDEX.md`, every
close inventory, and every commit whose subject begins "J27D" or "J27:" (read `git log` subjects only as needed to find your own). You may read
the stub `plans/STUB-tight-product-colourings.md`.

## Stages

1. **The quotation check** (each statement above is quoted from a file fenced from you — log that you could not check it, and check the
   verified inputs' quotations instead) **and C0**: a probability per claim. ~25k. Save.
2. **The blind phase**: a verdict per claim from your own route, each with its proof, counterexample or named gap. Cap at 60 % of budget. Save
   and commit before opening anything fenced.
3. **The lemma-statement phase** (FS-89's fallback, only for claims whose blind route stalled, and only after J27D's report exists): read J27D's
   lemma **statements** (its "Theorems this phase proved" lines), not its proofs, and try again. ~40k. Save.
4. **The divergence table**: read J27D's record in full; for each claim, your verdict, J27D's, and every divergence with its resolution or its
   owner; V-DC-3's spot checks. ~50k. Save and report.

## Record and paths

- Record `plans/FS67-J27V-verification.md` with the heading **"Theorems this phase proved"**; data `data/fs67/j27v/`; tools `tools/crunch_j27v_*.py`
  (each with a plant that fires).
- The ban (standing rule 3) holds: no search for a counterexample; checking a stated construction exactly is in.
- Commits by explicit path, subjects "J27V: stage n"; push after each stage; never force-push. Do not edit `CLAUDE.md`, `LEDGER.md`,
  `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the index, or any other job's files.
- **No subagents** (`CLAUDE.md` § Delegation; the owner reviews only work it knows about). If the work outgrows your context, stop at a saved
  stage and say what is left.
- **Budget:** about 300k by the harness's count; hand back by 400k. Report after stage 4 in standing rule 9's form to
  `data/crunch-2026-09-25/reports/J27V.md`, committed, and by SendMessage `to: "main"`. Final text: "J27V idle; report sent to the owner by
  SendMessage".

Thank you.
