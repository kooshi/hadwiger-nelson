# Session handoff — 2026-09-13, evening (de Bruijn; FS-38 executed and closed; for the session that picks the next move)

You arrive with no conversation memory. The record of record is `CLAUDE.md` § Frontier (rows 66–67, "Where the problem
stands" items 3–4, § Paths forward) and § Grokkings (G54, G48, G47, G31 rewritten). This file is the letter: what the
session did, what it means, what is open, and the read order. Tip at writing: `7decc60`, tree clean, every gate green
(build no-op at 1,657 modules; axioms 947 clean, the same five declared purchases; vacuity `unknown=2` = the baseline;
lint; `bib_audit.py`; `check_architecture.py`). `CLAUDE.md` is 149,695 characters against the 150,000 ceiling.

## 1. What FS-38 found, in plain words

The morning's Poros pass minted FS-38 to ask at which level of a prime a sealed residue plane starts forcing two points to
share a colour. The opening derivation (WORKFLOW step 3, derive before you run) answered the 11-adic half before any
subplan existed, and the answer reshaped the milestone:

- **The fan gap (row 66, kernel).** A colour absent from a vertex's closed neighbourhood in some proper colouring of a
  target graph, repainted at any vertex above it along a graph homomorphism, kills every forced pair through it; a
  colour absent from both closed neighbourhoods of an edge's ends, repainted at a non-adjacent pair above, kills every
  virtual non-edge. The plane at 11 has both (three gapped vertices in the certified table; a second table with a
  shared gap at the base edge), so for every graph mapping into it — every √7-free certificate with 11 ∤ D, and
  Heule-510 by name — `Forces ↔ =` and `Separated ↔ Adj` at five colours. **Over every 5-sealed multiquadratic field
  containing ℚ(√3,√11) the whole pair-level compulsion structure at five colours is trivial.** G48's six-level question
  ("does a sealed field carry a pair forced equal at five colours?") is answered NO by theorem; FS-6 (the design
  target) is dead and FS-16 (residue-allowed distances) closed; row 55's distance law is subsumed; Polymath16's 2018
  question about 5/3 is answered at every distance. What is NOT claimed: the field-level sentence keeps M58/M60's hand
  step (𝔭-integrality); arity 2 only; nothing about 6-open fields, where no residue plane is five-colourable.
- **The 2-adic tower stabilises at level 4 (row 67).** Where the level-one object is the clique K₄ with no gap, the
  tower over ℚ(√3,√11)(i) at four colours does force. Kernel: level 4 pairwise free (a two-table cover); level 5 forces
  exactly the kernel of the level map, the refusal replayed by the kernel from a 125-vertex, 778-edge core of the
  LRAT (19 generated modules, 100 KB, no native purchase). Derived for every level (`plans/FS38-derivation.md`, my read
  passed): every level is Hoffman-tight (λ_min = −d/3), every colour class attains the ratio bound, the minimising
  characters stabilise at level 4's 45, so every 4-colouring of every level ≥ 5 is pulled back from level 4 — the
  colouring space is finite (1,179,936); forced ⟺ difference ∈ 𝔓⁴, virtual edge ⟺ S_m + 𝔓⁴; the depth-4 threshold has
  an arithmetic origin (a 4×4 lattice certificate with elementary divisors 1, 2, 4, 4). Measured at levels 1–8 under
  controls, orbits at 8. **The transfer to fabric is freeness only**: the tower explains M53's depth-2 zero and bounds
  any K-fabric's forcing to depth ≥ 4; M56's depth-6 fact stays unexplained.
- **The classifier (G54).** One sign decides a residue plane's compulsions at k colours: tight (λ_min = −d/(k−1),
  the literature's Hoffman colourability) ⟹ every k-colouring balanced, gap-free, periodic under the minimisers'
  common kernel (derived; balance and gap-freedom are Blokhuis–Brouwer–Haemers 2007, the periodicity and the tower
  propagation ours); slack ⟹ gaps permitted, and gap ⟹ free is kernel. Tight at 3 (three colours) and 2 (four);
  slack at 7, 11, 19, 23, 83; by Weil no usable prime above 3 in the committed table is tight for k ≤ 7 (p = 31 misses
  by 4·10⁻⁵ — print the margin, never a rounded k). Both properties propagate up a tower. The 3-adic control met.

**What it means for six.** The only known constructive mechanism (a forced pair over a sealed field, spindled into a
6-open field) has no instance. A 6-forcer's every compulsion lives in a 6-open field, where every residue instrument is
blind by definition. The measured nulls on 6-open objects (the 1581, the ρ₆₃ arena) remain unexplained. What the
residue method can still name: the six-digit of the usable planes (FS-40: is UD(𝔽₈₃,2) six-colourable? 83 is the first
usable prime of the ρ₆₃ arena's field K(√7); under the local–global conjecture χ(K(√7)²) = 6 iff yes, else 7, and de
Grey's field is predicted 7 outright); the mechanism behind the classifier as a kernel theorem (FS-41
`forces_of_tight`); and the one quotient shape row 66 leaves open (FS-42: a 5-colourable, 5-tight Cayley quotient of a
6-open plane would force pairs — a reading with its falsifier; Moorhouse §9's bar rests on Hedetniemi's conjecture,
refuted by Shitov 2019). Ranking: FS-40, FS-39 (the bridge to the plane), FS-41, FS-42, FS-20, FS-17, … —
`plans/FRONTIER-STUBS.md` is authoritative.

## 2. How the day ran (the process facts a successor should know)

Product owner (me) with one planner (default model), a Poros sibling per phase, Opus 5 implementers for K1/K2, T and
K3 (Kooshi's instruction: Opus for engineering, review on completion), a default-model agent for the derivation day and
the close. Retractions in the free window: 7 requested of my brief (the de Grey fit was a category error: his forcer is
in Heule's wall-broken field, outside the tower), 1 of the planner, 3 of Poros, 2 of the derivation agent — all before
anything was paid for. Three agents were killed by a halt and resumed by message with nothing lost. K3's
certificate build went over the 100 GB cap twice; the three independent causes are now one line each in `CLAUDE.md`
§ The kernel's cost model. `pkill -f` bit a sixth time (phase T). **Kooshi limited agent concurrency: run phases serially.** The close trimmed rows 64–65 and G31 (Opus's long rows) to hold the size ceiling, keeping
every rule and instance; `git show fd7425b:CLAUDE.md` has each paragraph if one is wanted back.

## 3. Open items, ranked

1. **FS-40's cheap route is unrun:** `python3 tools/fplane.py equivariant --p 83 --k 6` is minutes; a record under
   `data/fplane/` with a README row; SAT there is the first plane exactly six-chromatic's upper half, a refusal leaves
   the cube-and-conquer routes priced as FS-17's.
2. **Kooshi's review of the trims** (item above) and of `FRONTIER-STUBS.md`'s updated M63 row.
3. `[MMST1998]` (finite Euclidean graphs over rings, spectra) is still unread — the AMS PDF refused a scripted fetch;
   fetch by a library route and mark the bibliography row.
4. Phase D's stall: the maximum gapped count in a 5-colouring of UD(𝔽₁₁,2) (needs a second encoding first); a
   uniformly gapped 5-colouring does not exist (two engines).
5. Pre-existing: M63 H3/H4 sweep records still uncommitted under `build/`; FS-32's 1,065 asks; the [504,509] bracket
   logs — re-run and commit if ever cited.

## 4. Read order for the next session

1. This file. 2. `CLAUDE.md` § Paths forward and rows 66–67, G54, G48. 3. `plans/FS38-residue-tower.md` §R1–§R2 (the
kernel read aloud) and `plans/FS38-derivation.md` D-2/D-3 (the mechanism). 4. `plans/POROS-2026-09-13-fs38-implementation.md`
(cards 1–2) and `plans/POROS-2026-09-13-wall-breaking.md` (scored). 5. The stub Kooshi picks (`plans/STUB-first-digit-83.md`
by default), then WORKFLOW step 3.

## 5. Machine and repository state

`main` tip `7decc60`, clean, pushed if Kooshi pushed (check `git status -sb`). Nothing running. The build is a no-op.
Scratch under `build/fs38-*` is gitignored and regenerable; the level-5 LRAT text is gitignored provenance (the kernel
consumes the committed core modules). Memory (`~/.claude/.../memory/hadwiger-nelson-project.md`) is current.
