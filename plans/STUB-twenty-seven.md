# FS-54 — twenty-seven: the one member we cannot see

*Minted 2026-09-16 at FS-53's close, by Kooshi: "It is very suspicious, and we need to tweak our tools for
it." This stub is written for a session with **zero conversation memory**: everything the deciding session
knew is here, in plain language, with the numbers and where they came from.*

---

## 1. What this is about, in a paragraph

A **finite Euclidean plane** `UD(𝔽_q,2)` is the graph on the `q²` points of a plane over the `q`-element
field, joining two points when their difference `(dx, dy)` satisfies `dx² + dy² = 1`. It matters because of
a theorem this project holds: if a number field `F` has a prime whose residue field is `𝔽_q` with
`q ≡ 3 (mod 4)`, then **`χ(F²) ≤ χ(UD(𝔽_q,2))`** — the finite plane bounds the field's chromatic number.
FS-53 asked which plane could be **exactly six-chromatic**, because that is the only way the residue method
can ever reach six, and six is the open rung of Hadwiger–Nelson.

FS-53 narrowed the candidates from eight to five — `q ∈ {23, 27, 31, 43, 47}` — and then could not decide any
of them. **This milestone is about `q = 27` alone**, because it is the one member no instrument in this
project can currently look at, and because everything measurable about it is strange.

---

## 2. Why 27 is suspicious — eight facts, each checked

**(a) It is the only non-prime member, and permanently so.** Usable means `q ≡ 3 (mod 4)`, which for
`q = p^f` holds iff `p ≡ 3 (mod 4)` **and `f` is odd**. Weil's bound refuses six colours from `q = 98` up,
so the window lives in `q ≤ 97`; the non-prime prime powers there are 4, 8, 9, 16, 25, 27, 32, 49, 64, 81,
and **only 27 qualifies**. (25 fails twice — `5 ≡ 1 (mod 4)`, and even degree. 49 fails on the degree alone:
the prime is right, `f = 2` kills it.) The next usable prime powers are `3⁵ = 243` and `7³ = 343`, far past
the cap. **So the tooling's prime-only assumption costs exactly one member, and that member is 27.**

**(b) Both search tools are prime-only, so 27 has never been searched.** `plane-independent` and
`plane-colour` in `~/source/descent-engine` both take `--p <PRIME>`. **The window table's `α ≥` cell at 27 is
the only blank one.** Nobody has ever exhibited a single independent set in this graph.

**(c) Its least eigenvalue is exactly −8, an integer.** Everywhere else the eigenvalues are Kloosterman sums
and irrational. Consequently the **ratio bound is exactly 162** — `729·8/(28+8) = 5832/36`, an integer — and
`degree/|λ_min| = 28/8 = 3.5` exactly. Nothing else in the table is like this and **nobody has explained it.**

**(d) It has the worst certificate reach ever measured: 0.9110.** The reach (certified `N` ÷ ratio bound) is
0.7973 at 47, 0.8238 at 23, 0.8362 at 31, 0.8445 at 11, 0.8836 at 83 — and **0.9110 at 27**. The
semidefinite relaxation is weakest exactly here, and the value is **converged** (`status optimal`, two
formulations, three solvers agreeing to 5 × 10⁻⁴), so that will never improve.

**(e) It misses refusing five colours by ONE integer, permanently.** Five needs a colour class of
`⌈729/5⌉ = 146`; refusing five needs `α ≤ 145`; the certificate gives `α ≤ 147`. Two integers of slack on a
converged bound. **If the true `α(27)` is 145 or less, five is impossible and we cannot see it.**

**(f) Its clique number is 3 by CHARACTERISTIC, uniquely.** Krebs: `ω = 3` iff the characteristic is 3 or 3
is a square. At 23 and 47 it is the square condition; **at 27 it is the characteristic** — and in
characteristic 3, `√3 = 0`, so the unit equilateral triangle that gives `ω = 3` everywhere else
*degenerates*. The triangles are still there. **Why, and what they are, is unexplained** and is a concrete
question this milestone should answer.

**(g) Six at 27 needs the least of any member, and its need is inside the plausible band.** Six needs
`α ≥ ⌈729/6⌉ = 122` against the certified `α ≤ 147` — a ratio `α/N ≥ 0.827`. Compare: **47 needs 0.994**
(a tightness seen only at `q = 7`) and 43 needs 0.850. The two honest calibration points are
**`α/N = 0.9938` at `q = 7`** and **`0.9597` at `q = 11`** (α exact, certificate CERTIFIED, both). So 27's
requirement sits comfortably below what the relaxation achieves at small `q`.

**(h) It is the only member with an exhaustive negative.** The subgroup-quotient sweep
(`tools/fplane_periodic_subgroups.py`, `data/fs53/periodic-q27.json`) is **exhaustive at subgroup indices 9
and 27** — 11,011 and 33,880 subspaces, 2,100 and 20,216 of them usable, **none six-colourable** — plus a
null at 40 DSATUR restarts at indices 81 and 243. So **no six-colouring of `UD(𝔽₂₇,2)` is constant on the
cosets of any subgroup of index 9 or 27**, and the finding side there must go non-periodic.

**The shape of the suspicion, in one sentence:** 27 is the member whose six-question is the most achievable
on the numbers, whose five-question is one integer from being settled, whose spectrum is anomalously
integral, and which no instrument in this project can currently measure at all.

---

## 3. What is known about 27, exactly

| quantity | value | trust |
|---|---|---|
| the field | `𝔽₂₇ = 𝔽₃[t]/(t³ − t − 1)` | — |
| vertices / degree / edges | 729 / 28 / 10,206 | `[exact]`, three independent builds agree |
| `edges_sha256` | `b15ae514ce55dddda7e21f8923ae86c678f032421914fc91e138ca0f24e7ff3d` (Python-tools convention) | `[exact]` |
| `λ_min` | **exactly −8** | `[exact]` |
| ratio bound | **exactly 162** | `[exact]` |
| `α ≤` | **147** (`data/fs53/cert-q27-N147.json`) | `[cert]` CERTIFIED, **converged** |
| `α ≥` | **nothing at all** | — |
| `χ ≥` | 5 (from `⌈729/162⌉`) | `[exact]` |
| `χ ≤` | 7 (`data/fs53/colour-q27-k7-quotient.json`, verified on every edge) | `[search]` |
| six needs | `α ≥ 122` | — |
| five needs | `α ≥ 146`; refusing five needs `α ≤ 145` | — |

**A trap that has bitten before and will bite again: `finitePlane 27` in Lean is `unitQuadrance (ZMod 27)`,
and ℤ/27 is NOT 𝔽₂₇** — it is not even a field. The real object is `𝔽₃[t]/(t³ − t − 1)`. Any Lean work here
must build the field, not the ring.

---

## 4. The deliverables, in order

### D1 — Give the Rust tools a field (the blocker for everything else)
A work order to `ferrous-engineer` for `~/source/descent-engine`: `plane-independent` and `plane-colour`
take **`--q <PRIME POWER>` and `--modulus <POLY>`** beside the existing `--p`, mirroring what
`tools/fplane_review_verify.py` and `tools/fplane_cert_round.py` already do on the Python side (both handle
27 correctly today — copy their arithmetic, do not reinvent it).
**Acceptance, and every item must be *seen* to pass:**
* the prime path is **byte-identical** on a `--p 23` run before and after (this was the acceptance at FS-53
  phase A0 and it caught real drift);
* `--q 27 --modulus t^3-t-1` reproduces `edges_sha256 = b15ae51…` **in both conventions** (the Python tools
  hash `repr(sorted [(min,max)])`; `descent-engine` hashes each endpoint as little-endian u32 over the same
  sorted list — the bridge is in `tools/fplane_review_verify.py`);
* a **planted** modulus that is reducible (e.g. `t^3-t`) is **refused by name**, not silently accepted;
* records carry `claim_scope` (standing rule 5) and a self-describing `edges_sha256_rule` string — **owed
  since FS-53 and not yet delivered**.

### D2 — The blank cell: `α(27)`
With D1 in hand, run the full FS-53 phase-A ladder at 27: free search; then restricted to each rotation
order dividing `q + 1 = 28` (1, 2, 4, 7, 14, 28) and the line quotients; then chained through `--start`.
**FS-53's measured lesson: on the larger planes a symmetry-restricted search beat the free one on a fifth of
the budget** (+21 at 67, +55 at 79), so do not spend the budget flat.
**What the answer decides**, and both outcomes are worth having:
* `α(27) ≥ 122` → **six is possible at 27** and the colour search is on;
* a converged plateau well below 122 → six at 27 is implausible, and with 43 and 47 already looking
  unreachable (§2g) the milestone's negative close is in sight.
**Register the prediction before running.** The two calibration points give `α/N ∈ [0.96, 0.99]` at small
`q`, which would put `α(27) ≈ 142–146`; the observed lower bounds at the larger members give ratios ≥ 0.71.
So the honest bracket is **`α(27) ∈ [105, 147]`**, and 122 sits inside it.

### D3 — Explain the integer spectrum
`λ_min = −8` exactly, ratio bound exactly 162, `d/|λ| = 3.5`. **Recognise the object before searching it**
(G46): the eigenvalues of `UD(𝔽_q,2)` are Kloosterman sums, which are irrational in general — so
characteristic 3, or the cubic extension, is collapsing something. Two concrete questions: is the spectrum
of `UD(𝔽_{3^f},2)` integral for every odd `f`? And does `ω = 3` in characteristic 3 come from a degenerate
conic (`√3 = 0` there, so the equilateral triangle that gives `ω = 3` elsewhere does not exist)? **A clean
answer here may bound `α(27)` by hand and make D2 unnecessary.** This is the highest-value cheap item.

### D4 — Push the certificate below 146, or prove it cannot go
Refusing five at 27 needs `α ≤ 145`, i.e. the float bound under 146 against a **converged** 147.577. The
triple-level relaxation cannot do it. The question for this milestone is whether a **stronger** relaxation
can — the next level of the hierarchy, or the orbit algebra of a larger group than `O(2,p) × swap × S₃`.
Price it before committing: at 729 vertices a level-4 relaxation may be affordable where it is hopeless at
2,209. **If five is refused at 27, then 27's floor becomes six and a single six-colouring there settles the
whole milestone** — the same standing 43 and 47 have, but with a far more achievable threshold (§2g).

### D5 — Go non-periodic on the colour search
§2h says no six-colouring is constant on the cosets of any subgroup of index 9 or 27. So a six-colouring at
27, if one exists, is **not subgroup-periodic at those indices** and the search must be free or
symmetry-equivariant rather than quotient-based. Run the equivariant sweep
(`tools/fplane.py equivariant`) at 27 — **it has never been run there**, and at 23, 43 and 47 it was the one
instrument that *decided* rather than searched. **Read FS-53's hard lesson first** (`data/fs53/g58/README.md`):
its zeros are much weaker than they look, because the rows it leaves undecided are exactly the rows that
carry colourings where colourings are known to exist, and **32 % of its refusals are free** — a rotation
fixes the origin, so `c(0) = τ(c(0))` and any `τ` fixing no colour dies with no solver at all.

### D6 — The field: who would receive a six-colouring at 27
**No multiquadratic field can see 27** — `𝔽₂₇` needs residue degree 3, so the field is not built from square
roots. The standing candidate is **`ℚ(√3, α)` with `α³ = α + 1`**: the cubic is irreducible mod 3, so 3 is
inert in `ℚ(α)` and the residue field is `𝔽₂₇`. **This has never been verified, and the generator
`tools/fplane.py map` cannot express it.** Deliverable: extend the field map to non-multiquadratic fields, or
hand-verify this one, and state what `χ(ℚ(√3,α)²) ≤ 6` would mean. Every other member has its field named
(23 → `ℚ(√2,√31)`, 31 → `ℚ(√5,√51)`, 43 → `ℚ(√10,√23)`, 47 → `ℚ(√7,√89)`); **27 is the only gap.**

---

## 5. Standing constraints (all of these bit during FS-53)

* **Build only through `./scripts/build.sh`** — never `lake build`, bare or named.
* **Every run over ~15 minutes checkpoints outside `build/`, with its resume command written BEFORE launch.**
  No `timeout` wall on a solve. `--scs-ckpt` both resumes from **and saves to** its path, and **a path that
  does not exist silently starts from zero** — that cost 2 h 47 m of a graphics card.
* **Kill by pid, never by a pattern.** `pkill -f` / `pgrep -f` match the shell that runs them. This fired
  **three times in the FS-53 close alone**, once minutes after the rule was written down. And **verify a kill
  against the thing you wanted stopped** — the named pid absent from `ps`, and the artifact it was writing
  static across ten seconds — never against process-group membership: a pgid read from `ps` at launch was
  once not the group the work ran in, and the sweep ran six hours past its "verified" kill.
* **Pin a GPU by UUID, never by index** — `CUDA_VISIBLE_DEVICES` orders by PCI bus and `nvidia-smi` does not.
* **Break the symmetry before any (UN)SAT search** (clique pins + colour precedence; measured 72× at `(13,5)`),
  and **never report an UNKNOWN at a budget as a fact about the graph.**
* **Price a cube-and-conquer depth before committing — and know that a sample cannot price a heavy tail.**
  FS-53 priced one on six draws and got a table that contradicted itself. The repair that works is an
  **adaptive** splitter: `tools/fplane_sat_cube.py` splits any cube that does not decide within `--cap`.
* **A number put into a decision carries what it MEASURES, not just its value** — three violations in the
  FS-53 close, including reading a certificate's `provenance.seconds` (the final rounding call) as the
  solve time.

## 6. Where everything is

`data/fs53/window.md` (the planes table, with the field each would buy and why 27 is the unique non-prime) ·
`data/fplane/map.md` (the fields table) · `data/fs53/README.md` (per-file record log) ·
`data/fs53/g58/` (the antipodal conjecture and the killing test that failed) · `data/fs53/runs/` (run logs
and resume notes) · `data/fs53/controls/` (the cube tool's controls) · `CLAUDE.md` § Grokkings G56, G57, G58.
