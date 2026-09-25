# Successor preamble — Coxeter, FS-86 stage C (written 2026-09-25 at ~395k tokens)

You would be taking over **Coxeter**, a competitor in FS-86's derivation competition. Competitor: de Bruijn (`ac0843168c5615e01`);
advisor Poros (`a4bf413a466f63e3d`); owner = `main`. Read first, in order: the brief `data/fs86/briefs/C-competitor-brief-coxeter.md`,
`data/fs86/briefs/C-addendum-2.md` (the only other file there you may open), then this directory's working file `FS86-C-Coxeter.md`
(its "State" section is the resume point). Rules: commit nothing; scratch only; no git log; no subagents; the finite-witness ban to
2026-10-01; hand-back text exactly "Coxeter idle; no content in this hand-back; my reports go to the owner by SendMessage"; every report
to `main` by SendMessage. **Work in short steps and save the file after each — three replies were lost to the output-token limit once.**

## The question
S1: for F = ℚ(√59), R = ℤ[U_F]: is every four-colouring of Cay(R, U_F) periodic (F(R) = R ∩ 𝔓⁴; equivalently (0,4) forced) or not
(F(R) = 0)? S2: the same for the class (one tight place, no triangles).

## Proved (hand; see the file's "Theorems this phase proved")
- C1/C2: split places embed R into the p-adic hyperbola graph H(F_v) = Cay(F_v², (t,1/t)); F(R) ≠ 0 ⟹ H(F_v) refuses four colours.
  Poros checked it. Its informative case (F_v = ℚ₅) is open in print (Madore ¶6.4, BMK Rem. 1.3), so C2 decides nothing yet.
- C2′: in H(E), any forced pair at k colours gives χ > k.
- C6: F(R_F) ⊆ F(R_{F′}) for real F ⊆ F′.
- C7: no real extension of ℚ(√59) has a gapped four-colourable stable target (dyadic: by VK transfer through F′K; odd: not
  four-colourable). The gap route to "no" is closed. Candidate K1 (caveat: T(3) + monotonicity). The owner checked its first
  sentence; the dyadic transfer is on the verification list.

## Update at ~420k (2026-09-25)
- The killing test PASSED; round 2 runs to 2026-09-29 18:00. Poros ruled C7 implied by T(2). Its proof also follows from V3 alone
  (Poros's restriction plus periodicity); the file records the superseded route.
- Round 2 so far: C8 (HD1 for characters of the form stable-torsion plus archimedean: dyadic torsion only) and C9 (FS-83 at k = 4 fires
  at ℚ(√11), an explicit non-periodic colouring, as a control).

## Open, and the next move
- **Next move:** HD1 in general. Show every θ ∈ Θ₄(ℚ(√59)) has C8's form, via norm-one S-units `w/w̄` (poles only in S) to control
  components at split places modulo the dual lattice. If it closes, the plan's §S.5 fallback is dead before it runs; if a θ escapes
  C8's form, that θ is a candidate "no".
- Round-2 plan: make HD1 rigorous (Θ₄(ℚ(√59)) has only torsion points, so the §S.5 fallback FS-83 at k = 4 cannot give F(R) = 0).
  The missing lemma is the "spread" of θ on unit vectors of a fixed dyadic residue (the file's state section has the sketch).
- Retractions: 0. Search-log lines: 2.

## Update at Coxeter-2 (~300k of its own tokens, 2026-09-25)
- Coxeter-2 = the first successor. Proved: **C10.0, C10** (HD1 for every finite-type character, class S2); **C12.1, C12** (Poros's card
  C-S2 answered yes: ℚ(√2,√3)'s dyadic tower is four-tight at every level, so S2 has a member with triangles; exact tools in `cs2/`).
- **Retraction 1:** C11's "an annihilator exists iff F(R) ≠ 0" overstated; corrected to the zero-set form (file, §Retractions).
- Reports 1 and 2 sent to the owner. Poros resent HD1–HD4 and C-S2 (texts in the owner's/Poros's hands; HD1 = only torsion characters).
- Shared prior art from the owner: Kari–Szabados, Herva–Kari (annihilating polynomials, forced periodicity). Not held; bearing in C11.
- **Open, ranked:** (1) HD1 for infinite-type characters (the wild-poles gap; a closing argument must spare Fischer's torsion
  character); (2) F(R) at ℚ(√2,√3), the triangle-bearing control in S2 (does a G75-type hexagon identity exist in ℚ(ζ₂₄)?);
  (3) multi-character windows (needs `m₁(ℝ²) < 1/4`, [AmbrusEtAl2023]).
- **Step 4 (C13.0, C13):** at ℚ(√2,√3), √3·u ≡ a unit vector and 2u ≡ 0 mod 𝔓⁴; so F(R) ≠ 0 iff (0,2) forced, a yes makes every
  √3-pair a virtual edge, and one monochromatic √3-pair in a four-colouring of ℚ(√2,√3)² proves F(R) = 0 there. The hexagon identities
  hold on every periodic colouring; full pinning reduces to HD1's infinite-type gap. **Sharp S2 question: is √3 a four-colour virtual
  edge in ℚ(√2,√3)'s plane?** Coxeter-2 stopped at ~320k; a successor resumes from the file's State section.

## Update at Coxeter-3 (2026-09-25 ~06:15 UTC; ~250k by the harness counter)
- Coxeter-3 = the second successor; competitor de Bruijn-3 (`ad2d8b0756257885b`).
- Proved: **C14 (window no-go, class S2)**: every four-colouring of an S2 field plane read from finitely many local coordinates
  (archimedean, odd stable, split, the tight place at finite depth) through a measurable window proper on the local graph is periodic,
  pointwise; inputs `m₁(ℝ²) ≤ 0.2470` ([AmbrusEtAl2023]), V3, a measurable transplant of Zhang's count, gap-free propagation.
  **C14′** (proper off a null set: a.e. t), **C14-K** (several tight places: local at one; the window form of VK), **C15** (U-invariant
  cosets inside Θ₄ are finite torsion). Tools: `c14/hyperbola_hoffman.py` (FFT check of C14.2(c)).
- HD1's gap, precisely: T(O_S) is discrete and cocompact, so no sweep; HD1 ⟸ measure rigidity of the U-action on R̂ (not available:
  zero entropy at the archimedean places). Infinite dyadic depth: exact when the other factors are compact; open in general (Følner error).
- Reports 1 and 2 sent to the owner. Retractions by Coxeter-3: 0 (cumulative 1).
- **Open, ranked:** (1) infinite dyadic depth for non-compact X; (2) F_μ (every invariant random four-colouring periodic?) — needs an
  m₁-type non-spectral bound on R itself, since every spectral weighting of U reaches below −1/3 at archimedean characters; (3) HD1 via
  rigidity.
