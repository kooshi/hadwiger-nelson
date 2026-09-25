# POROS — FS-86 competition advisor record

*The competition's advisor for FS-86 (is every four-colouring of the plane over ℚ(√59) periodic — `F(R) ≠ 0` — or not?). Only writer:
this Poros. Lives in scratch until both competitors hand back (protocol rule 1); the owner then moves it into `plans/`. Competitors:
Coxeter (tango), de Bruijn (wooden boats). Owner: "main". Started 2026-09-25 03:12 UTC (system clock).*

## 0. Expectation — written before any card, before either working file existed (both absent at 22:12)

### 0.1 The situation as I read it (from the brief, Addendum 1 and 2, the plan §0/§IQ/§S/§P/§R-review, the protocol, HELD.md)

- The field question is binary and sharp: `F(R) ∈ {0, R ∩ 𝔓⁴}`; `F(R) ≠ 0` ⟺ `(0, 4)` is four-colour forced (V4, proved given V2, V3).
  `P(R) = R ∩ 𝔓⁴` is free. A yes is Soifer-strength; a no is one non-periodic four-colouring (necessarily gap-free, not a finite
  perturbation of a pullback, not a character colouring if HD1 holds).
- What any colouring must look like if it is not a pullback (my own derivations, one mind, not sent):
  - it cannot differ from a pullback on a finite set (every vertex has infinitely many neighbours, dyadically dense in `z + S₄`);
  - it cannot be a pullback on each side of a sharp archimedean wall with two different `P₄`-colourings (the wall's points see every
    residue of `S₄` across it, and pullbacks are gap-free, so the two colourings agree);
  - so a non-periodic colouring is "non-pullback everywhere", or its defect set is thick.
- **Second moments are blind on type-B planes for a one-line reason** (my hunch H-J0 below, derived): `C(z) = 3·J₀(2πr₀|σ₁z|)` with
  `J₀(2πr₀) = −1/3` (`2πr₀ = 3.25242`; `min J₀ = −0.402759` at 3.83171) is positive definite on `R` (through `σ₁`), has `C(0) = 3` and
  `C(u) = −1` on every unit vector, and its spectral measure is purely archimedean. So pair correlations cannot pin the spectrum onto
  torsion characters; the 11-adic place (Hoffman ratio 0.2855, so `λ_min/d ≈ −0.3996 < −1/3`) gives a second fake. This is C14's
  format transferred, not new.
- **HD1's open step closes by a fractional bound** (my hunch H-HD1c, derived, not sent): a finite-order `τ` with `τ(S) ⊆ (1/4, 3/4)`
  strictly is a circular colouring of the finite product `P_m × H` with ratio `< 4`, but `χ_f(P_m × H) = min(χ_f) = 4` (`[Zhu2011]`;
  `P_m` tight) and `χ_c ≥ χ_f`. HD1's first bullet ("a component at a non-stable place") is only defined modulo the global dual lattice
  (a torsion character of a stable place is represented with non-zero components at the archimedean and finitely many non-stable places),
  so bullet 1 needs a real proof; I rate HD1 true (0.8).
- **A class-level observation (my card C-S2, to send after first routes):** S2 asks whether triangles decide, but the record names no
  member of the class with triangles. Candidates: ℚ(√2,√3) (G55's 18-vertex chain field; one dyadic place, `F_𝔓 = ℚ₂(√2,√3)` with
  `e = 4, f = 1`, inert in `F(i)`, level one `K₄`; odd stable places `p ≡ 23 mod 24`, all `χ_f > 5`) and ℚ(√3,√14). Each is in S2
  exactly when its dyadic tower (a different local tower from row 67's: `ℚ₂(ζ₂₄)/ℚ₂(√2,√3)`) is Hoffman-tight at every level —
  unchecked (G54's propagation sentence is withdrawn, Addendum 1 item 4).

### 0.2 Predictions (scored at the close; each also in the hunch ledger)

| id | prediction | p |
|---|---|---|
| E1 | both first routes are the same in kind (FS-79, FS-85 precedent): the tetrahedral/vector-colouring embedding and a spectral (least-eigenvalue or spectral-measure) attempt at a pinning operator on `Cay(R, U_F)` | 0.6 |
| E2 | at least one competitor meets the archimedean obstruction (`J₀`'s minimum below −1/3, or an equivalent fake spectrum) in round 1 | 0.6 |
| E3 | at least one competitor tries the "no" through character colourings (G74/FS-83) or gapped lattice quotients (HD2's shape) in round 1 | 0.6 |
| E4 | no K4 (yes) claim in round 1 | 0.98 |
| E5 | no field-level K2 (no) in round 1 | 0.9 |
| E6 | at least one K3 claim is in a format already recorded (second moments, radius-1 averaging, cell-local) and does not pass | 0.35 |
| E7 | the killing test fires | 0.40 |
| E8 | if it passes, it passes on K1 or K3, not K2/K4 | 0.9 |
| E9 | retractions in round 1, both competitors together, ≥ 1 | 0.6 |
| E10 | a lattice-level result is presented as field-level at least once (needs policing) | 0.4 |

### 0.3 What I will police (the failure shapes I expect)

1. Scope: a `Λ₅₁₀` or `Λ_M` result scored as a field result (`F(Λ) ⊆ F(R) ∩ Λ`; `P(Λ) ⊊ P(R) ∩ Λ` in general, V1).
2. The free outcome: `P(R) ≠ 0`, the dichotomy, the sharp form restated as progress.
3. K1 conditions that are compactness restatements, properties pullbacks visibly have (balance, gap-freeness, `𝔓⁴`-periodicity,
   frozen Kempe classes, zero entropy; T 2, 8, 9), or need a finite colouring search. Free control: an X whose proof uses nothing K
   fails must hold on K's plane (`F(R_K) = 4R_K`, VK).
4. K3 claims in formats already recorded (0.4 below), and K3 "no-gos" that are equivalent to `F(R) = 0` (then they are K2 and need
   a blind verifier, and the owner told at once).
5. Transfer: G75's mechanism, Parts's trees, dB6's splitting, `[Fischer1994]`'s colouring, FS38-D2-B used on ℚ(√59) without a
   re-walk; FS38-L1's tightness half or G54's "propagates up a tower" sentence (withdrawn); 83 and 131 claimed "by the same argument"
   without their stable-place lists (19 needs FS-66's `U(19)`, Addendum 2 D4).
6. A lean toward yes ("a pinning identity exists; the witness will follow").
7. A "no" from a gapped colouring found by search (banned; excluded by K2).

### 0.4 K3 format pins — written now, before any proof exists

- **Excluded as already recorded (rows 80, 87):** edge-local heights, loop windings, face fluxes, coindex bounds (row 80); second
  moments / pair correlations at unit distance (C14); radius-1 window-frequency averaging (row 87); plain density of periodic
  colourings in rank 1 (row 80). **My reading of "not implied by rows 80 and 87":** a no-go in one of these formats transferred to
  type-B planes counts as implied unless its proof needs an argument the recorded one lacks; for second moments the transfer is one line
  (H-J0), so it is implied.
- **Formats I would accept as named** (each must be defined by the claimant and pinned by me in writing before I read the proof):
  - (P1) neighbourhood-sum eigen-identities `A_W g = λg`, `W ⊆ U_F` finite (G75's format proper), with a stated restriction on `W`
    or on how the identity is certified (unrestricted, a no-go of P1 for balanced `W` is equivalent to `F(R) = 0`, so it is K2, not K3);
  - (P2) `k`-point correlation identities, `k ≥ 3`;
  - (P3) window-frequency (invariant-measure) certificates of radius `≥ 2`;
  - (P4) identities certified by every proper four-colouring of a bounded configuration (radius or size stated).
- A no-go that says "this identity fails for some periodic colouring" is not K3 (every periodic colouring satisfies every identity of
  `P₄` pullbacks).

### 0.5 The held items: plan

- All four (HD1–HD4) go to both at one moment, after both first routes are written (ruling R1), each with its status as its author
  left it plus one caution each where I found one: HD1 bullet 1's decomposition is modulo the global dual lattice; HD2's gapped
  colourings on `Λ₅₁₀` need a period beyond `128Λ` at 2 (B2's T1), and a search for them is banned — formula only; HD3 is lattice-level
  (`P(Λ)`, Draw (lattice)); HD4 predicts a null for Kempe escapes at the field level.
- **Frame-level release before first routes:** none of HD1–HD4 is frame by the brief's definition (each hands or kills a route). The
  one frame-level item I send before first routes is my K3 adjudication standard (0.4), to both at once, because it is about scoring.

### 0.6 The predictions scored (at advising's end)

| id | p | outcome |
|---|---|---|
| E1 first routes the same in kind, spectral | 0.6 | **lost as stated.** The same in kind — each transferred forcing to a completion (de Bruijn the stable anisotropic one, rigidity; Coxeter the split isotropic ones, non-four-colourability) — but neither was spectral |
| E2 the archimedean (Bessel) obstruction met in round 1 | 0.6 | **lost narrowly**: de Bruijn met it in round 2 (§4.1 C0); Coxeter in round 2 (C14's controls) |
| E3 a "no" tried through characters or gapped quotients in round 1 | 0.6 | won (de Bruijn §2.3 in round 1) |
| E4 no yes in round 1 | 0.98 | won |
| E5 no field-level no in round 1 | 0.9 | won |
| E6 a K3 claim in a recorded format, refused | 0.35 | lost: no K3 was claimed at all (de Bruijn wrote C0 and named it C14's format itself) |
| E7 the killing test fires | 0.40 | lost: it passed (K1) |
| E8 if it passes, on K1 or K3 | 0.9 | won |
| E9 at least one retraction in round 1 | 0.6 | won (de Bruijn 1) |
| E10 a lattice result presented as field-level | 0.4 | lost: both sides kept scope throughout |

## 1. Evidence inventory

- `data/fs86/briefs/C-advisor-brief.md` — read against: the protocol's advisor template — surprised: yes (I started late because of
  the three-agent cap; fine; and "don't run git log", which I had already broken, E0)
- `data/fs86/briefs/C-competitor-brief-coxeter.md` — read against: the plan's §C plus Addendum 1 — surprised: no
- `data/fs86/briefs/C-addendum-2.md` — read against: B1 confirms the frame — surprised: no (VK proved blind; the D8 false side claim)
- `plans/FS86-dyadic-rigidity.md` §0, §PA, §IQ, §S, §C.2, §P, §M–§Y, §R-review — read against: the frame FR-1 — surprised: yes (the
  class S2 is described only through triangle-free members; "does it depend on triangles" has no in-class control named)
- `plans/PROTOCOL-competitor-and-advisor.md` §0–§3 — read against: rules 1–11 — surprised: no
- `HELD.md` (plan-phase Poros) — read against: route hunches — surprised: yes (HD1's circular step closes by `χ_c ≥ χ_f`; bullet 1 is
  stated place-by-place where characters are only defined modulo the global dual)
- `POROS-fs86-plan.md` (plan-phase Poros) — read against: its hand-off — surprised: no
- `FS86-C-deBruijn.md` §0–§3 (read 22:33, 18,535 bytes) — read against: E1 (vector-colouring/spectral first route) — surprised: **yes**.
  The first route is the *local plane*: Theorem A (every four-colouring of the unit-distance graph on `ℚ₂(√3)²`, arbitrary, is a
  `P₄`-pullback, via VK's finite forcer embedded by `K ⊂ ℚ₂(√3)` plus a 2-adic submersion), A1 (F(R) ≠ 0 ⟺ every colouring extends
  to the local plane), B (2-adically locally constant colourings are pullbacks). Spectral work is second (§2: star identities, the wall
  lemma = my §0.1 wall observation, independently; §2.3 = HD1's core with my circular step, independently). Checked Theorem A step by
  step: no gap. §3 records a Hasse-principle conjecture predicting yes (lean toward yes, recorded as conjecture with killing test).
- `FS86-C-Coxeter.md` at 23:25 (11,157 bytes) — read against: C2's informativeness — surprised: yes. **C7** (hand; VK + Krasner + weak
  approximation): every stable place of every real extension `F′ ⊇ ℚ(√59)` lies over a stable place of ℚ(√59); odd ones never
  four-colourable at any level; dyadic ones have completions `E ⊇ ℚ₂(√3) ⊇ K`, and a gapped level would give `F(R_{F′K}) = 0` against
  `F(R_{F′K}) ⊇ F(R_K) ≠ 0` — so **no residue target of any real extension of ℚ(√59) has a gapped four-colouring**; equivalently a local
  theorem proved globally: every finite `E ⊇ ℚ₂(√3)`, `i ∉ E`, has only gap-free four-colourings at every level. I checked the
  climbing step (conjugation restricts), the odd-place list (3, 7, 19 inert, so even residue degree), and the contradiction with VK:
  correct. Unclaimed. Note for the adjudication: as a necessary condition (X′ = "no real extension has a gapped four-colourable stable
  target") it **fails at ℚ(√11)** (7) and **holds at ℚ(√59)** — discriminating where de Bruijn's X is not. C4 (products with split
  places; a Hedetniemi-type product) stated. On C-S2 Coxeter notes C7 makes ℚ(√2,√3)'s tower gap-free at every level (K(√2) ⊇ K has that
  completion), tightness not implied.
- `FS86-C-deBruijn.md`, final state as stood down (41,266 bytes; read ~23:30) — read against: round 1's K1 claim plus whatever round 2
  held — surprised: **yes** (round 2 was already under way before the stand-down). Round-1 report sent (K1 "shown to hold", X).
  Round-2 sections: §4.1 **C0** = my H-J0 exactly (pair correlations cannot pin on any real field; the Bessel minimum; the 11-adic
  second obstruction noted) — derived independently; §4.2 **Theorem C** (non-real fields with the same dyadic tower and odd stable
  circle means `> −1/3`, e.g. ℚ(√−709): every invariant random four-colouring is a pullback, `F_μ = P`; equidistribution lemmas
  sketched) — I checked the product step (`f ≥ −1/3` with equality only on the 45 minimisers) and the value ranges; the equidistribution
  is sketched, not checked; **scope: a non-real class, outside S2**; §5 T1 (`4 ∈ F_tf` ⟺ some number field in `ℚ₂(√3)` has a
  triangle-free forcer; one external citation, existential closedness of henselian fields); §5.3 reading "the obstruction at ℚ(√59) is
  its real place" with killing test; §6.1 **Theorem D₀** (no threshold walls: two-phase colourings split by a level set of an additive
  function with residue-dependent offsets are single pullbacks) — I checked the descent: correct; §6.2 Proposition D conditional on a
  Waring-type lemma.
- `FS86-C-Coxeter.md` (read 23:13, 3,708 bytes) — read against: E1 — surprised: **yes**. First route: the *split* places. C1: at a place
  of F split in `F(i)`, `Cay(R, U)` embeds in `H(F_v) = Cay(F_v², {(t, 1/t)})` (the isotropic local plane); C2: `F(R) ∋ δ ≠ 0` ⟹ `H(F_v)`
  has no four-colouring (the scalings `s_λ` are automorphisms; the translations `(λd₁, d₂/λ)` generate `F_v²`) — checked, correct; C3:
  the control at K gives `χ(H(ℚ₃₇)), χ(H(ℚ₂₅)) ≥ 5` by transfer. Its X ("every split local plane of F refuses four colours") is honest
  about being informative only if some `χ(H(E)) ≤ 4`. **The two first routes are mirror images:** de Bruijn transfers forcing to the
  stable (anisotropic) completion and gets rigidity there; Coxeter to the split (isotropic) completions and gets non-colourability.
  E1 lost for both (neither first route is spectral). Not to be carried between them.
- `plans/FS86-B1-verification.md`, `plans/FS86-B2-profile.md` — read against: Addendum 1/2's summaries — surprised: unread (the
  addenda are my reading; the primaries are unread)
- `~/source/poros` skills (core, anomaly hunt; reframing not yet) — read against: identity — surprised: no

## 2. Hunch ledger

hunch: H-J0-second-moments-blind
  claim: on `Cay(R, U_F)` for any type-B field the unit-distance pair-correlation constraints admit a purely archimedean spectral measure (`C = 3J₀(2πr₀|σ₁·|)`), so second moments cannot pin
  basis: derived
  falsifier: an error in positive-definiteness through `σ₁`, or a pair constraint I have not listed that a genuine colouring's correlation must satisfy and this `C` violates
  registered: 2026-09-24
  status: confirmed (by: de Bruijn §4.1 C0, an independent derivation written without this hunch)

  (status note ~23:30: **confirmed by an independent derivation** — de Bruijn's §4.1 C0, written without this hunch.)

hunch: H-HD1c-theta4-torsion-only
  claim: `Θ₄(F)` for a type-B field holds only torsion characters: the circular step closes because `χ_c(P_m × H) ≥ χ_f(P_m × H) = 4`
  basis: derived (the circular step); prior (HD1's bullet 1, the non-stable components)
  falsifier: a character of `R` with bounded range on `U_F` and a component, modulo the global dual lattice, at a non-stable place
  registered: 2026-09-24
  status: confirmed for finite type (by: de Bruijn §2.3 and §7.2 HD1-fin; Coxeter C10, class-wide); open for characters with
  infinitely many split components in both files (the same named obstruction on both sides, §3)

hunch: H-S2-triangle-member
  claim: the class S2 contains a field with triangles (ℚ(√2,√3) or ℚ(√3,√14)), provided its dyadic tower is tight at every level
  basis: derived (the place lists); prior (the tightness)
  falsifier: a slack level of the `ℚ₂(ζ₂₄)/ℚ₂(√2,√3)` tower, or a stable odd place of ℚ(√2,√3) with `χ_f ≤ 4`
  registered: 2026-09-24
  status: confirmed (by: Coxeter-2's C12 — exact levels 1–8 plus the C12.1 induction; de Bruijn-2's §6.5, levels 1–5 exact; field
  membership argued via the frame's transfer, not re-derived — a verification item)

hunch: H-prior-no
  claim: `F(R) = 0` for ℚ(√59) (some non-periodic four-colouring exists)
  basis: prior
  falsifier: a finite triangle-free unit-distance graph over ℚ(√59) forcing `(0, 4)`
  registered: 2026-09-24
  status: open — NOT sent as advice. Nothing this week bears on it as evidence: the no-gos exclude structured *constructions of a no*
  (bounding the constructions, G21), and nothing moved toward a yes.

## 3. Cards sent (fates filled as they come)

- **#0, 2026-09-24 ~22:20, to both at once (identical text), frame (scoring):** the K3 standard of §0.4 (recorded formats excluded;
  transferred no-gos of recorded formats count as implied unless the proof needs an argument the recorded one lacks; format definition
  sent before the proof; "fails for some periodic colouring" is not K3; a no-go equivalent to `F(R) = 0` is K2), the K1 standard
  (hold or fail both count; free control at K; T policing), scope, and the request to be told in one line when a first route is written.
  Fate: —
- **To the owner, same time:** expectation written; E0; inventory notes (HD1's circular step closes by `χ_c ≥ χ_f`; H-J0).
  Owner's reply (22:18): notes (a), (b) held in the owner's scratch inventory, label-only line in `plans/`; E0 caused no loss; the
  policy-to-both use of the frame exception approved.

- **#1, 2026-09-24 ~22:45, to de Bruijn alone (asymmetric: answers its own route; logged here for Coxeter to read at hand-back):**
  question `which-part-of-local-rigidity-survives-without-triangles` — is `(0, 4)` forced by a finite configuration of the plane over
  `ℚ₂(√3)` whose induced unit-distance graph is triangle-free? (Evidence: Theorem A's forcer comes from K and has triangles; X holds at
  ℚ(√11) where F = 0; images of ℚ(√59)-configurations are triangle-free.) If no: `F(R) = 0` for every triangle-free field in `ℚ₂(√3)`
  (class no, to the owner at once). If yes: that is the local half of its Hasse principle, §3 restated with it; realisability over F is
  the global question, which ℚ(√11) fails through 7. Plus a policing note: §3's evidence is two excluded constructions (G21), and no
  field satisfying its hypothesis has a known answer (K has two places). No provisional killing-test ruling given (adjudicated at round
  end). **Fate (22:40): taken.** de Bruijn's §1.6 (Proposition A-tf): triangles enter Theorem A only at step 1; `F_tf` (the
  triangle-free local forced set) all-or-nothing by chaining rotated copies (genericity a sketch); `4 ∈ F_tf` open ("the 2-adic
  Soifer 55.1 in forced-pair form"); §3 restated with `4 ∈ F_tf` as hypothesis and "Evidence: none toward the conclusion" (my policing
  note adopted). Also a new §2.4: a K3 no-go on type-B planes whose format contains a pullback-valid would-be pinning identity implies
  `F(R) = 0` (K2 in disguise); no K3 claimed.
- **#1a, 22:45, to de Bruijn alone (logged): scope note on §1.6 (iii).** The class-level no needs only `4 ∉ F_tf` (by (i),
  `F(R_F) ⊆ F_tf ∩ R_F`, and V4), not `F_tf = {0}`; (ii) is not needed for it; if (ii) is proved, `F_tf ∈ {0, 𝔓ⁿ (n ≥ 4)}`. **Fate:
  taken** (§5.2 states the sweeping "no" as `4 ∉ F_tf`; T1 reduces it to number fields in `ℚ₂(√3)`).
- **Pending for the held-items message (to both):** sharpen card #0's wording — a no-go that *implies* `F(R) = 0` (not only one
  equivalent to it) is a K2 claim. (My own rule's wording; the logic is generic. De Bruijn's §2.4 reached the same point.)

- **Owner timing note (to me alone, ~22:50):** Coxeter effectively restarting now (output-limit cut-offs); rules unchanged; hold
  HD1–HD4 until both first routes; say nothing to either side about the other's pace. Acknowledged; nothing sent.

- **#2, ~23:25, to Coxeter alone (asymmetric: answers its own route; logged for de Bruijn's side at hand-back):** question
  `does-the-split-plane-over-Q-already-refuse` — `H(ℚ) = Cay(ℚ², {(t,1/t)})`, the isotropic (Minkowski) unit-distance graph over ℚ,
  sits inside every split local plane; does it refuse four colours? If yes: X holds identically at every field (ℚ(√59) and ℚ(√11)
  alike), C2's contrapositive never fires, and C3 becomes a corollary of the ℚ-statement. If no: X's informative instances are
  ℚ(√59)'s split completions with no known forcing field, ℚ₅ first (`√3 ∉ ℚ₅`). Checked C1–C3 first: no gap. No hunch registered.
  **Fate (23:25): taken.** Coxeter answered from the record: open in print (`[Madore2015]` ¶6.4, read first-hand: plain χ of the real
  Lorentz plane not known to be finite; `[BardestaniMallahiKarai2017]` Rem. 1.3 leaves plain χ open). Added C2′ (in a hyperbola graph a
  forced nonzero pair at `k` colours proves `χ > k`, the boost acting as the spindle's rotation), so the card's question is itself a
  four-colour forced-pair question in a triangle-free plane; **withdrew X (C2) from K1** ("undecided at every member; transfer theorem
  only"). Also: at ℚ(√59) the split places over inert `p` contain de Grey's field (free ≥ 5); live ones have `√3 ∉ F_v` (ℚ₅, ℚ₉, ℚ₁₇, …).
- **C-S2, ~23:20, to both at once (identical text):** does S2 contain a field with triangles? ℚ(√2,√3) (one totally ramified dyadic
  place, inert in `F(i)`, completion `ℚ₂(ζ₂₄)`, level one `K₄`; odd stable `p ≡ 23 mod 24`, all `χ_f > 5`; `1/3 ∈ R`) is a member iff
  its dyadic tower is tight at every level; ℚ(√3,√14) similar, unchecked. Branches: in-class triangle control with actual hexagons,
  or triangle comparison only across the class boundary with K. **Fate: taken by both, answered yes.** Coxeter-2 (C12.1, C12): an
  induction for every unramified quadratic dyadic tower ("tight at every level iff tight up to the `M`-exponent"), levels 1–8 exact,
  `𝔓⁴ ⊆ M` — so ℚ(√2,√3) is in S2 with triangles (field membership argued via the §0.3 frame's transfer, not re-derived); my place list
  re-derived. de Bruijn-2 (§6.5): levels 1–5 exact, tight, multiplicities 3, 9, 21, 45, 45. Coxeter-2 then C13: at ℚ(√2,√3)
  `F(R) ≠ 0` iff `(0, 2)` forced; the sharp in-class triangle question is "is √3 a four-colour virtual edge there?".

- **Owner (~23:50):** verdict logged; Coxeter told "passes; round 2 to 2026-09-29 18:00" with my X_ext ruling. **de Bruijn successor
  launched, id a1870239e0b49ab00**, resuming from its predecessor's file and preamble; knows the pass and the verifier's corrections.
- **Replay (~23:55), to the successor alone, one message, at the owner's request:** card #0, HD1–HD4 with cautions, the sharpened
  wording, C-S2 (all verbatim as both sides received them), cards #1 and #1a (verbatim, its predecessor's), and its predecessor's own
  last note on the overlaps (HD1 = §2.3, HD4 considered, §6.1 D₀). Nothing about Coxeter; card #2 (Coxeter's) not sent.

- **Owner (~00:00):** old Coxeter stood down (~420k, at its own recommendation); **Coxeter successor a5d43b5c29772ef48** launched.
- **Replay (~00:10), to the Coxeter successor at its request:** HD1–HD4 with cautions, the sharpened wording, C-S2 (verbatim, as both
  received), a summary of card #0; on HD1's scope: exactly the claim as written (Θ₄(F) torsion only), nothing more told, no view on its
  proof given to either side. Nothing about de Bruijn's side; #1/#1a not sent.

- **Owner (staffing):** de Bruijn successor a1870239e0b49ab00 **stood down** (~385k), never message; its file holds round-2 theorems
  for my hand-back reading. A quiet blind verifier ("verifier X") runs on that side's round-2 theorems (rule 11), reports only to the
  owner. Only Coxeter's successor a5d43b5c29772ef48 is working.

- **Owner (staffing, 2026-09-25):** Coxeter successor a5d43b5c29772ef48 **stood down** (~320k, clean hand-off), never message. Both
  sides idle with successor preambles; the owner plans to launch the next successors for both sides together after the quiet verifier
  finishes, and will send their ids. Round 2 still ends 2026-09-29 18:00.

- **Owner (launch, 2026-09-25):** third successors live — **de Bruijn-3 ad2d8b0756257885b**, **Coxeter-3 a8b60e0003eef1dd0**; all
  earlier competitor ids stood down; verifier X finished and stood down. If a successor asks for its side's released items, the same
  texts apply (both-sides texts to either; #1/#1a only to de Bruijn's side).

- **Replay (2026-09-25), to de Bruijn-3 at its request:** HD1–HD4 with cautions and the sharpened wording, verbatim as sent to both
  and to seat II; nothing added. It named a candidate round-2 line ("HD1 made rigorous": the split-place components) — its choice,
  no advice given.

- **Owner (staffing, 2026-09-25):** Coxeter-3 a8b60e0003eef1dd0 **stood down** (clean boundary), never message; de Bruijn-3
  ad2d8b0756257885b still working.

- **The fates of HD1–HD4 (read at the end, both final files):**
  - HD1: de Bruijn had its core before release (§2.3); seat III made it precise (§7: intrinsic classes, HD1-fin, HD1-cert, a no-go of
    weak approximation as a method) and found the gap in its own Theorem C; Coxeter C8, C10 (finite type, class-wide), C14 (every
    measurable window at finitely many places), C15 (the homogeneous part is torsion). **Both stop at the same obstruction, independently:**
    characters reading infinitely many split places need an `S`-adic measure-rigidity (Berend-type) theorem with isometric archimedean
    directions (de Bruijn §7.5; Coxeter C15). My caution (a) was the definitional step both used.
  - HD2: declined as a route by both; de Bruijn's D₀/D/D′/H and Coxeter's C7 exclude the gap mechanisms it hoped for.
  - HD3: declined by both (lattice-level).
  - HD4: proved (de Bruijn-3 §7.6: Kempe swaps of pullbacks are pullbacks).

## 4. Held items log

- **Decision (23:20): release all four at once, to both, now.** Alternative weighed: hold HD3 (lattice-level) for round 2. Why all
  four: ruling R1 says the held items go at one moment once both first routes are written, and withholding one would itself be a
  judgment of relevance the competitors can make for themselves; HD3 is marked lattice-level so it cannot be mis-scored. Confidence:
  high.
- **Order within the message:** HD1, HD2, HD3, HD4 as numbered (author's order), each with its status; my cautions marked "Poros:"
  (HD1(a) modulo the global dual; HD2 = V1 proved for part 1, B2's T1 and the ban; HD3 lattice-level). Plus the scoring sharpening
  ("implies F(R) = 0" is K2).
- **Delivery:** Coxeter live (23:20). **de Bruijn had been stood down by the owner (~557k tokens) before arrival; my messages resumed
  it twice (~1.4k tokens); it stayed idle, file untouched, and reported the overlaps: HD1's torsion-plus-archimedean case = its §2.3
  (its "split-free" definition met my HD1(a) caution); HD4 = a Kempe transfer it considered and did not file; its §6.1 Theorem D₀
  covers the one sparse-level-gap mechanism it could build by formula (HD2's shape).** A successor de Bruijn needs HD1–HD4, the
  sharpening, C-S2, #1, #1a — owner's call.

- **Owner (~23:35):** point 4 (the wake-up) logged as the owner's error; de Bruijn stopped at a clean boundary at its own proposal
  (~555k), idle — do not message it; no successor yet (cap: Coxeter plus a quiet verifier running); if one is launched, my §3–§4 go
  into its preamble and I am told first; Coxeter's round-1 report outstanding; the owner will announce every stand-down and launch.

## 5. Retraction tally (final)

- **de Bruijn side: 2.** (1) Seat I, §2.2 (S-iii)/(S-iv), within the hour, before any report. (2) Seat III, §7.4, partial: Theorem C's
  equidistribution step was representative-dependent; downgraded to spectral measures on `T + A + Fin`; found by that side, unprompted.
- **Coxeter side: 1.** Coxeter-2's C11 as first reported to the owner ("an annihilator exists iff `F(R) ≠ 0`"; the ⟹ direction never
  proved), caught on re-reading, before anyone relied on it. Not counted: Coxeter-1's withdrawal of C2's X from K1 on my card #2 (a
  candidate never claimed).
- **Poros: 0.** All retractions in the free window. G51's reading: little disagreement between sides (they never met); the contest ran
  inside each side and in the quiet verifiers, as FS-85's rule 11 predicts.

## 6. My own errors

- **E1 (2026-09-24 ~23:20).** I sent the held items and C-S2 to de Bruijn without knowing it had been stood down; two resumes of a
  retired agent (~1.4k tokens). No content loss, no edit. Remedy asked of the owner: tell me when a side is stood down.
- **E0 (2026-09-24 22:1x).** I ran `git log --oneline -40` in my first tool batch, in parallel with reading my brief, before reading its
  "don't run git log". What I saw: subjects down to `fb18fc3e bookkeeping (items 34-35)`; every competition-period subject is neutral
  ("bookkeeping (items …)"); the rest are stage A/B subjects whose content is public in `plans/` (B1, B2 records). I also listed
  `plans/` filenames (the close inventory's existence, not its content). No competitor content reached me. Reported to the owner.

## 7. The killing-test adjudication (plan §S.4), written 2026-09-24 ~23:40, on the owner's word that both round-1 reports are in

**The standard applied** is the one pinned in §0.4 and sent to both at ~22:20, before any proof existed (card #0): K1 counts "shown to
hold" as well as "shown to fail"; the free control at K; X must not reduce to an item of T; K3 formats already recorded are excluded;
a no-go implying `F(R) = 0` is K2. I did not tighten it after seeing the claims.

**Verdict: PASSES, on K1 (de Bruijn's X). Nothing else meets a K item.**

| item | candidate | the check I ran | ruling |
|---|---|---|---|
| **K4** (a yes at F, with inhabitant) | none claimed | read both files for any claim that `(0, 4)` is forced over ℚ(√59): none; de Bruijn §3 is a conjecture with "Evidence: none toward the conclusion" | not met |
| **K2** (a no by derivation) | none claimed | de Bruijn's class-level "no" is conditional on `4 ∉ F_tf` (§1.6, §5), undecided; Theorem C (§4.2) is `F_μ = P`, not `F`, and on non-real fields outside S2; Coxeter's C2 contrapositive is conditional on a four-colouring of a split local plane, undecided (C2′, Madore ¶6.4, BMK Rem. 1.3) | not met |
| **K3** (a pinning-format no-go) | none claimed | de Bruijn's C0 (§4.1: pair correlations cannot pin on any real field, the Bessel minimum) is in the second-moment format, pre-pinned in §0.4 as excluded (C14's format transferred; the transfer is one line); de Bruijn says so itself and claims no K3. §2.4 (a K3 with a pullback-valid would-be pinning identity is a K2 in disguise) is an observation, agreeing with my sharpened rule. Theorem B, Lemma W, Theorem D₀ are no-gos of *constructions of a no*, not of pinning formats | not met |
| **K1**, Coxeter's flagged candidate X_ext ("no real finite extension of F has a stable place with a gapped four-colourable target at any level", C7) | flagged for judgement, not claimed | **Reduces to T(2)** (every four-colouring gap-free), by a two-line restriction: if a stable target `G′` of an extension `F′ ⊇ F` has a gapped four-colouring `γ` with gap vertex `x`, pick `w ∈ R_{F′}` over `x` (the residue map is onto); `z ↦ γ(π′(w + z))` is a proper four-colouring of `Cay(R_F, U_F)` (since `R_F ⊆ R_{F′}`, `U_F ⊆ U_{F′}`) with a gap at `0`. So ¬X_ext ⟹ ¬T(2), composite targets included. (Coxeter's own caveat named T(3) plus monotonicity; the sharper reduction is to T(2).) What C7 proves — that this consequence of T(2) holds at ℚ(√59), by VK — is real, and it is a no-go for the gap-transport route to a "no" through every extension; it is not K1 | **excluded (T(2))** |
| **K1**, Coxeter's C2 X ("every split local plane refuses four colours") | withdrawn by Coxeter | undecided at every member (C2′: deciding it is itself a four-colour forced-pair question in the triangle-free Lorentz plane over a subfield of `ℚ₅`); not shown to hold or fail | not met |
| **K1**, de Bruijn's §1.6 `4 ∈ F_tf` | not claimed | necessary for `F(R) ≠ 0` at every triangle-free `F ⊂ ℚ₂(√3)` and discriminating in its fail branch, but undecided | not met (a round-2 target) |
| **K1**, de Bruijn's X ("(0, 4) is four-colour forced in the plane over `ℚ₂(√3)`", §1.2, §1.5) | **claimed, "shown to hold"** | (1) *Necessary:* a finite forcer over ℚ(√59) embeds by Lemma E, which preserves the norm and hence induced edges; checked. (2) *Proved:* Theorem A, which I walked step by step at 22:40 (VK's finite forcer of `(0, 4)` in `K²` embedded; `F_loc` a `T`-stable subgroup; the 2-adic submersion `(t₁, t₂) ↦ 4t₁ + 4t₂` at `(1, i)`, tangent spaces `iℚ₂(√3)` and `ℚ₂(√3)` spanning `L`, so `F_loc` holds an open subgroup; density of `ℤ[ζ₁₂]` gives `4O = 𝔓⁴`; D2-B gives `⊆ 𝔓⁴`): no gap. **Also proved independently by the owner's quiet blind verifier, by a shorter route** (the owner's fact, used for the check only, passed to neither side). (3) *Not implied by T:* every T item is a statement about `Cay(R, U_F)` or its lattices; restriction carries colourings of the local plane down to `R`, never up, so no T item yields a statement about arbitrary colourings of the local plane; row 67 (behind T(4), T(5)) gives forcing only in the finite levels `P_m`, i.e. for locally constant colourings, and the step to arbitrary colourings needs VK, which is not in T. (4) *Not on the policing list:* not a window or coset restatement of `F(R) ≠ 0`, not a property pullbacks visibly have, no finite colouring search in its check (VK rests on B1's blind derivation and row 85's derivation; row 78's certificate is recorded, not re-searched). (5) *Free control:* holds at K (the same local plane; its proof is K's forcing). (6) *Named member with T holding or undecided:* ℚ(√59): T(1), (3), (4), (5), (6), (10), (11), (13) hold; T(2), (7), (8), (9) undecided | **met, by the letter** |

**The weakness, recorded with the pass, not hidden by it.** X is a property of the local field `ℚ₂(√3)` alone. It holds identically at
ℚ(√11), where `F = 0`, and at K, where `F ≠ 0`, so it separates nothing, and "shown to hold at ℚ(√59)" says only that ℚ(√59) embeds in
`ℚ₂(√3)`. My pre-registered standard counts "holds", so it passes; a standard that also required discrimination would have excluded it,
and I did not announce one. Its value to the milestone is the reframe it carries: Corollary A1 (rigidity of ℚ(√59)'s plane is an extension
problem into the rigid local plane); Theorem B (2-adically continuous colourings are pullbacks); and the discriminating local question it
generated, `4 ∈ F_tf` (§1.6, §5: if it fails, a class-level "no" for every triangle-free field in `ℚ₂(√3)`), which is round 2's sharpest
target.

**What round 1 produced beyond the K items** (grades as the files give them; all field-level unless marked):
- de Bruijn: Theorem A [hand, given VK; blind-verified independently] [local]; A1; B; Lemma W; Proposition S (ii), (iv) and (iii)'s dyadic
  half; §2.3 (Θ₄'s split-free points are torsion; HD1's core, derived before HD1 was released); C0; Theorem C [hand, equidistribution
  sketched] [non-real class]; T1 [hand, one external citation: existential closedness of henselian fields]; Theorem D₀ [hand] (no
  threshold walls); Proposition D conditional on a Waring-type lemma.
- Coxeter: C1, C2 (forcing transfers to split places as non-four-colourability), C2′ (all or nothing in hyperbola graphs), C6, C7 (no
  residue target of any real extension of ℚ(√59) has a gapped four-colouring; local corollary for every finite `E ⊇ ℚ₂(√3)`, `i ∉ E`),
  C4 (products with split places).
- Two independent convergences: the wall lemma (de Bruijn's W; my own §0.1 note) and the Bessel obstruction (de Bruijn's C0; my H-J0).
  The two first routes are mirror images: forcing transferred to the stable (anisotropic) completion gives rigidity; to the split
  (isotropic) completions, non-four-colourability.

**The fallback, if the verdict were to fire (it does not):** HD1 plus de Bruijn's §2.3 answer the fallback's hour-one question except
for the split-place characters, open in both files. If a fallback is ever staffed, give it both.


## 7a. Round 2, read at advising's end (both final files), and my scoring reading for the close planner

**Read against:** the expectation that round 2 would either decide nothing or produce pinning-format no-gos. **Surprised: yes, on the
axis of the product.** Round 2 produced almost no work on the *yes* side's formats, and a large, verified-in-part family of no-gos on the
*no* side: named formats of non-periodic four-colourings shown impossible on type-B planes.
- **Formats of a "no" excluded:** measurable window colourings reading finitely many places (Coxeter C14, class S2, input
  `[AmbrusEtAl2023]`'s `m₁(ℝ²) ≤ 0.2470`, external and computer-assisted; C14′ regular windows); character colourings of finite type
  (C10; de Bruijn HD1-fin); patchworks of two pullbacks and of one pullback plus any residue alternative (de Bruijn D, D′ — blind-verified,
  scope wider than stated); defects confined to a half-space (H — blind-verified, any field); 2-adically continuous colourings (B);
  threshold walls (D₀); stripes (W); gap transport through every real extension (C7, free by V3 via restriction); Kempe swaps (HD4 proved).
- **The frame sharpened:** C-S2 answered yes (ℚ(√2,√3) is in S2 with triangles; its sharp in-class question is whether √3 is a
  four-colour virtual edge); C14 is triangle-blind, so the triangle question lives outside the window format; Theorem A and C2 locate the
  local rigidity (anisotropic completion) and the split-place non-colourability.
- **The one obstruction both sides met independently:** every remaining non-periodic candidate reads infinitely many split places, and
  closing it needs an `S`-adic measure-rigidity theorem whose archimedean directions are isometries (Berend 1984 and
  Einsiedler–Lindenstrauss need expansion). de Bruijn-3 §7.5 and Coxeter-3 C15 reached it separately; de Bruijn-3's HD1-cert turns it into
  one finite exact certificate on two lattices, a post-ban computation. G51's signal: two independent attempts meeting one obstruction.
- **Retractions and downgrades:** Theorem C downgraded by its own side (§7.4: a representative-dependence gap); its corollaries
  (`F_μ = P` on ℚ(√−709), the re-proof of `χ(E²) ≥ 4`) are now conditional.

**Scoring reading against §P's verdict table (a reading, not a ruling):**
- *Paid (yes)*, *Paid (no)*: not met — `F(R)` is undecided for every type-B field.
- *Paid (no-go)*, by its letter: not met. Its first clause names *pinning* formats (the yes side), and the only pinning-format no-go
  written is C0, a recorded format. Its second clause (a K1 shown to *fail*) did not happen.
- *Draw (frame)*, by its letter ("only §0.3's frame verified"): too small — the round went well past the frame.
- **So the outcome falls in a gap of the partition**: verified no-gos of named formats of the *no*, with nothing decided at `F` — the
  mirror image of Paid (no-go). **My reading: it belongs with Paid (no-go)**, because that row's purpose (a proved impossibility of a
  named format, nothing decided at `F`) is met and Kooshi counts no-gos as success; **conditional** on the verifiers' verdicts for C14
  (which I have not seen) and on an audit of C14's external input. The row's letter does not cover it, and ruling R3 warns that
  after-the-fact placement is the least trustworthy kind, so the close planner should state the placement as a ruling with its reason,
  not let it be inferred. *Draw (K)* has a minor candidate (C14-K, a sketch); *Draw (lattice)*: nothing new.

## 8. "Would have searched here" log

- None of mine this run. My checks were hand re-derivations of competitors' steps (Theorem A, D, C1–C2, C7), two float Bessel values
  (`scipy`, seconds) and nothing else; I did not compute C-S2's spectra (both competitors did).

## 9. Hand-off (for a successor) — FINAL, 2026-09-25, advising ended by the owner

**State.** Advising has ended. Both competitor sides stopped at clean boundaries by their own choice; every competitor id is stood down
and must not be messaged: de Bruijn ac0843168c5615e01, a1870239e0b49ab00, ad2d8b0756257885b; Coxeter a797f9a29d11ce2db,
a5d43b5c29772ef48, a8b60e0003eef1dd0. Two quiet verifiers have finished (their verdicts are the owner's). Round 2's clock
(2026-09-29 18:00) still stands if Kooshi adds fourth seats; a fresh advisor would start here.

**If a fresh advisor starts (fourth seats):**
1. Read §0.4 (my pinned K standards), §7 (the killing-test verdict: PASSES on K1, de Bruijn's X, non-discriminating), §7a (round 2 and
   the verdict-table gap), §3 (every card and its fate) and both final working files (de Bruijn §6–§7, Coxeter's round-2 steps 2–6).
2. Released texts to replay verbatim on request: `held-release.txt` and `card-S2.txt` beside this file (both sides), cards #1/#1a
   (de Bruijn's side only, text in §3), card #2 (Coxeter's side only, text in §3).
3. The live questions, both sides converged: (a) the infinite-type characters / `S`-adic measure rigidity with isometric archimedean
   directions (de Bruijn §7.5, HD1-cert; Coxeter C15) — no known theorem, a post-ban certificate route exists; (b) `4 ∈ F_tf`
   (de Bruijn §1.6, §5, T1); (c) at ℚ(√2,√3), "is √3 a four-colour virtual edge?" (Coxeter C13; the triangle-bearing S2 control).
4. Police as before: scope, the free outcome, transfer, any lean toward yes (the no-gos bound constructions of a no; they are not evidence
   of rigidity), and tell the owner at once of any claimed yes or no.

**Verification and close, first items (sent to the owner in the final report):** see §7a and the owner message of this date.

**Tokens.** Own count about 175k at the end; the harness counter reads higher (re-reads on each resume).
