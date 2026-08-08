# M22 — Partner closure and the shape of the pressure (stub)

*Stubbed at M21's close (2026-08-08). M21 measured the first nonzero extension pressure
this project has ever seen (52% of pattern pairs killed locally, 32% of the survivors
killed ambiently at the strongest-coupled pivot pair, every kill verified through an
independent encoding) and proved the pair's fork-independent geometry in Lean
(`Coupled.lean`: the reflection package, the interlock, the four gluing
classifications, the superset lower bound). The χ of the d = 1 pair system is carried
open in both directions, each with a reopening gate (M21 subplan §2.4). This stub
collects the carry-forward, ranked.*

## Candidate threads, ranked at M21 close

1. **The partner-closed sample** — the named enrichment that forces the χ fork: adjoin
   cross-chord partners to the pair lattice, one √-extension per generation (partners
   generically leave ℚ(√3,√11); the growth of the coordinate field is the honest cost
   meter). Gate it reopens: UNSAT at k = 4 on a partner-closed sample would be a
   two-point continuum χ ≥ 5 candidate — re-verify, shrink, kernel route immediately.
   SAT at every affordable closure depth keeps the two-pivot cap conjecture alive on
   measured ground. The promoted instrument's `--pair` builder is the seed; the
   partner-adjunction move is new code.
2. **The kill-structure census** — WHICH pattern pairs die (the shape of the 229
   ambient kills + 785 local kills at (695,2044)): by cross-chord incidence profile, by
   π_a/π_b class shapes, by whether the killing core is the compulsion triangle. The
   verified kills are already in `Fan.of_unsat` pin-cube form; naming their structure
   is the cheapest route to a *mechanism* — and a mechanism is what a gadget design
   needs (M20's battery said closure-flavoured gadgets clamp too narrowly).
3. **Kernel certification of the kills** — if any claim comes to rest on the kill set,
   each is one LRAT certificate away from the kernel (the profile IS the cube split).
   Deferred until a claim needs it; the instrument records exact pins per kill.
4. **Non-sector construction search** — the ≤ 4 branch's gate: the mesh scan killed
   every sector pair, so a χ ≤ 4 proof for the pair needs a colouring shape nobody has
   named. The strip's window-extension freedom (M20) is the one known source of
   non-sector colourings; the probe's k = 4 model corpus is the evidence base to mine.
5. **General-radius two-circle theorem** — unchanged from the Frontier's parked list;
   M21's cross-chord classification did not force it (the d = 1 gluings needed only the
   strip operators). Trigger stays: a milestone that needs an off-{1, 1/√3} class.

## What M21 hands over

* `Proofs/HadwigerNelson/Coupled.lean` — the pair's certified geometry: `reflAcross`
  (the one symmetry), the interlock, the four two-point gluing classifications, and
  `four_le_chromaticNumber_of_system_subset` (the superset-quantified lower bound; the
  pairSystem corollary is premise-free).
* `tools/couple.py` — the promoted suite (census / phase / joint+verifier / pair /
  mesh / floor / self-test), wired FAIL-loud into `scripts/regen-check.sh`. The joint
  verifier runs inside `--joint`, never separately. Honesty notes in the docstring
  bound what the sampled instruments claim.
* `build/m21-*.json` — the §0 triage artifacts (untrusted; census and phase reproduce
  deterministically; the pair lattice reproduces up to a documented +20-point constant
  seed difference from its session-mortal ancestor).
* The negative knowledge, kernel-checked where it could be: no coupled-automaton
  quotient (incommensurability, exact); no sector mesh at d = 1 (tools-side, full
  sweep); no floor raise from coupling (forbid-last-t, both pairs).
