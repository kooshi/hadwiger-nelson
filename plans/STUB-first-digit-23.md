# FS-17 — The first digit at 23: is UD(𝔽₂₃, 2) exactly 5-chromatic? (STUB, 2026-09-08; minted at the M61 close — M61's phase A, undecided)

> **Answered in part 2026-09-16 (FS-56): UD(𝔽₂₃, 2) is not 5-chromatic.** The level-3 relaxation certifies `α ≤ 105`
> (`data/fs54/cert-q23-l3-N105.json`; CERTIFIED on the product owner's re-run, `data/fs56/q0/recheck-po.log`), below the 106 that
> five colours need, so `χ(UD(𝔽₂₃,2)) ∈ {6, 7, 8}` (eight in the kernel, `colorable_finitePlane23_eight`). The question is now
> six against seven: six needs `α ≥ 89`, and the best set found is 87 (`data/fs53/alpha-q23-ge87.json`). The re-descriptions
> below are kept as the record of how the question narrowed.

> **Re-described 2026-09-13 (FS-38 close; rank 6).** The plane at 23 is **slack** at five colours (λ_min = −7.96 against
> −24/5 = −4.8; `plans/FS38-derivation.md` D-3), so FS-38's tightness screen does NOT decide this stub's question: slack
> says gaps are permitted *if* a five-colouring exists, and whether one exists is exactly the question, untouched. What
> it adds: if a five-colouring exists, P-D4 predicts one with a fan gap, and then every unit-distance graph over a field
> that 23 seals is pairwise free at five colours by ledger row 66 (`Slack.forces_iff_of_hom`). The 6-open sibling is
> FS-40 (`plans/STUB-first-digit-83.md`).

> **Re-described 2026-09-14 (FS-50).** The α route (D2) is now bracketed exactly: `87 ≤ α(23) ≤ 108`, the upper bound an
> exact certificate — and the triple-level relaxation that produced it has its own optimum at 108.55, so **it cannot reach
> the 105 that would refute five colours**; CDCL cannot refute sizes above the ratio bound at 23 in 14 minutes
> (`data/fs50/race23/`, `nscale/`); the finding side's best set is 87 (`plane-independent`, 300 s). The digit stays open on
> both sides. What would move it: a set of 106 (the finder's plateau is 87), or a strictly stronger relaxation (a higher
> Lasserre level, priced in `plans/STUB-triple-certificate-kernel.md`'s neighbourhood — not minted).

> **Build triage 2026-09-08 (for Opus 5, `plans/BACKLOG-FOR-OPUS.md` B3):** see that file for the spec, the acceptance gate and the stop rule before starting; results go into a `## §B. Built` section here.

*Read beside: `plans/M61-local-global-tightness.md` §S2–§S4 and §R3 (what was tried and what it cost), `plans/STUB-finite-plane-cores.md`
(FS-13, the same solver question one rung up), `data/fplane/{theta,periodic,alpha,equivariant}-*.json`, `chi-p23-k5.json`.*

## 1. Mission context, in plain language

The finite Euclidean plane UD(𝔽₂₃, 2) — 529 points, each joined to the 24 points at "unit distance" modulo 23 — is the smallest plane
whose chromatic number is unknown: at least 5 by its spectrum, at most 8 by a periodic colouring, and a five-colouring has refused every
solver run (four hours with a pinned clique, M58). The local–global conjecture (M61) makes the value the first digit of its own
prediction: a plane exactly 6-chromatic names, by congruences, the fields whose unit-distance graphs can be 6-chromatic; if no plane
below 59 is exactly 6 and 59's is 7, the conjecture predicts that no field plane is exactly 6-chromatic at all. M61 derived why the
value is hard: every linear relaxation collapses to Hoffman's bound (the plane is arc-transitive), no periodic colouring uses fewer than
eight colours, and no rotationally symmetric colouring of order ≥ 3 exists — the value is integrality-carried, exactly as the real
plane's is.

## 2. What we know

| fact | trust | where |
|---|---|---|
| χ ≥ 5 (Hoffman 4.015; ϑ = Hoffman) | a derivation + floats | `theta-below-83` |
| χ ≤ 8 (a periodic colouring; the least periodic colouring needs exactly 8) | verified colouring; the refusal of 7 periodic is the solver's | `periodic-below-71` |
| **α(UD(𝔽₂₃,2)) ∈ [87, 108]** (2026-09-14, FS-50): 87 by a verified set (`data/fs50/alpha-p23-ge87.json`), **108 by an exact rational certificate of the triple-level SDP bound** (`data/fs50/cert-p23-N108.json`, checked by `tools/fplane_cert_check.py` from the number 23 alone); the five-colour threshold 106 is **not reached and cannot be by that relaxation** (its own optimum is 108.55), and no CDCL formulation refutes even sizes above the ratio bound at 23 (`data/fs50/race23/`) | verified set / exact-rational / the solver's silence | `data/fs50/` |
| no equivariant 5-colouring under any rotation of order 3, 4, 6, 8, 12, 24, nor the half-turn with τ = id or one swap | the solver's (≤ 2 s each) | `build/m61/partF.log` (M61 §R3) |
| the half-turn with a colour double-swap: REFUSED (external cadical, 1,110 s, the sound encoding) — **no 5-colouring at 23 has any rotational symmetry** | the solver's | `equivariant-p23-k5` |
| ω = 3 (23 ≡ 11 mod 12: triangles exist); the origin's neighbourhood is four disjoint hexagons | exact | M59 |

## 3. Derivations first

**D1 — price the split before running it.** The origin and its 24 neighbours: a 5-colouring gives the origin one colour and each of the
four hexagons a proper colouring in the other four — 732⁴ ≈ 2.9·10¹¹ neighbourhood colourings, ~2.5·10⁸ up to the stabilizer O(2)
(order 48) and the palette (24). Too many as cubes. The half-turn family is REFUSED (M61's last run), so every 5-colouring is asymmetric and
no symmetry can shrink the cube space; the first split is on one hexagon's colourings (732, ~15 up to O(2) and the palette) of the
PLAIN instance, each cube a 5-colouring ask with 24 vertices pinned — priced at hours per cube on the M58 evidence.

**D2 — the α route.** `card_le_mul_of_colorable` (kernel): a 5-colouring needs an independent set of size 106. The cardinality
instance is small (1.5 MB) but undecided at two hours; a cube-and-conquer on it (fix the intersection with the origin's neighbourhood)
is a second priced route, and its refusal would be a CERTIFIED χ ≥ 6 modulo the solver — the one route whose success needs no
colouring search.

**D3 — what a 6 would mean.** If χ(UD(𝔽₂₃, 2)) = 6, then by T1 every wall-broken field whose smallest usable prime is 23 (23 ≡ 11 mod
12 — fields without √3 whose radicands are residues mod 23 and non-residues mod 11, 19, and with 7 non-usable) hosts a 6-chromatic
unit-distance graph — a target field named by congruences before any object exists. Enumerate those fields first (`fplane.py map`).

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D3's field list; D1's symmetric cube split written and priced | half a day |
| A | the half-turn family by cube-and-conquer (one hexagon's colourings as cubes); the α instance likewise | a day, on the desktop's cores |
| B | if 5 is found: the plane joins the kernel (a 529-entry table, or a symmetric one); if refused everywhere: FS-13's cores at 23 | a day |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | χ(UD(𝔽₂₃, 2)) = 5 | low-medium (Hoffman is 1.4 below the truth at 11 and 19, which would put 23 at 5 or 6) |
| P2 | the half-turn family is refused (no symmetric 5-colouring at 23) | **MET at minting** (M61's last run; carried here as the datum, not a prediction) |
| P3 | the α instance at 106 is SAT (the fractional face is silent at 23) | medium |

## 6. Bearing on 6, honestly

Medium as a FRAME (a plane exactly 6 turns the conjecture into a design target), low as work (a SAT question with no algebraic shortcut,
M61 §R7). Under G46 it is a reading room until a split is priced under a day.

## 7. Addresses

`tools/fplane.py` (`chi --pin-clique`, `alpha`, `equivariant`, `periodic`, `theta`), `build/m61/derive.py` (the scratch, incl. the
half-turn CNF dump), `data/fplane/`, `Proofs/HadwigerNelson/LocalGlobal.lean` (`card_le_mul_of_colorable`).
