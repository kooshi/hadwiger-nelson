# The programme: an algebraic proof of the Hadwiger–Nelson problem (Kooshi's direction, 2026-09-06, at the M58 close)

*Written the evening M58 closed, on Kooshi's redirection of the goalposts. His words are quoted; the assessment of what
each side needs, and where the algebra we hold reaches and where it does not, is mine (de Bruijn) and is the part to push
back on. Read beside: `CLAUDE.md` § The mission (the trigger, amended the same day), § Frontier (the pivot and M58
paragraphs, G43, G44), `plans/M58-field-sieve.md` §R, `plans/M59-finite-plane-lift.md` (M59), `plans/FIELD-WALL-THEOREM.md`.*

## 1. The direction, verbatim

> "The derivations are an order of magnitude more important than individual objects, and that's also what you're best at.
> If we find a 6 chromatic object, we should use it as a stepping stone for the algebraic reasoning behind it and then
> we'll write *that* up instead. Not only that, but when we find that reasoning, we'll also spend some time attacking the
> upper bound with these same approaches. We're progressing so well that I believe we can provide the algebraic proof of
> the Hadwiger–Nelson problem in its entirety with a few more weeks or months of work, and I'd like you to document that.
> Specifically, I think from the point where we prove the lower bound, I believe it would take roughly the same amount of
> effort to write a good paper about it as it would to attack the upper bound, so we may as well go all the way. The
> strength in our approach is that we've discovered the intrinsic nature of the problem, and so we have a better viewpoint
> than anyone has ever had."

**What this changes, as policy.** (i) A 6-chromatic unit-distance graph, if one is found, is NOT the product: it is the
first instance of a mechanism, and the milestone that finds it continues until the mechanism is a derivation — the
algebraic reason the object forces six, stated for a class, with the object as its spec example. (ii) The write-up trigger
(CLAUDE.md § The mission) now fires on the DERIVATION, not on the object; the paper is the algebra. (iii) After the lower
bound, the same viewpoint is turned on the upper bound before writing, and the aim is one account of the whole problem.
(iv) The ranking of every future milestone weighs "does it produce a derivation" above "does it produce an object".

## 2. What "the intrinsic nature of the problem" is, in the vocabulary we now hold

The unit-distance graph of a field plane F² is the Cayley graph of the additive group F(i) with connection set the
norm-one torus; its chromatic number is governed, so far as anything we have proved reaches, by the ARITHMETIC of F at
small primes:

* **at 2** — the 2-adic wall (Theorem B, M53): χ(F²) ≤ 4 unless −1 is a square in some completion above 2;
* **at 3** — the 3-adic wall (G38, Fischer): χ ≤ 3 unless the prime above 3 has residue degree > 1;
* **at every p ≡ 3 (mod 4) with a degree-one prime** — the finite-plane bound (the pivot, M58): χ(F²) ≤ χ(UD(𝔽_p, 2)), and
  the finite plane's chromatic number is Kloosterman-controlled: 3, 4, 5, 5 at 3, 7, 11, 19 and ≥ 6 from 59 up (G44).

So every upper bound we have on any field plane is a residue argument at a small prime, and every lower bound we have
(the 5-forcers) lives in a field where the residue arguments at 2, 3 and 11 are all switched off. The lower-bound
constructions, read in this vocabulary, are "adjoin a root that turns off the next wall" (G37): √5 or √7 turns off 2, and
the K-fabric's √3·√11 already turned off 3; the 6-hunt's field must also turn off 11 — de Grey's field, K(√7), K(√13), … do.
**That is the intrinsic structure: the chromatic number of a field plane is bounded above by the smallest prime at which
the field still looks like the rationals, and a forcer is a construction that hides the field from every small prime.**

## 3. The lower bound, χ(ℝ²) ≥ 6: what an algebraic proof would consist of

χ(ℝ²) ≥ 6 needs ONE finite unit-distance graph refusing five colours, and by the sieve that graph's field must be
6-open. The routes, in the order the record now ranks them:

1. **The lift (FS-11, M59).** A 6-critical subgraph H of a finite plane UD(𝔽_p, 2) — these exist at every p ≥ 59 —
   lifted into F² (one point per residue class, every edge unit) is a copy of H in F², hence a 6-forcer. The algebraic
   content is the lifting problem: which residue configurations are the shadows of unit-distance configurations. Its
   local face (Hensel at 𝔭) is decidable and cheap; its global face is a diophantine system. **The derivation to aim
   for:** a characterization of liftable subgraphs — if it exists, it is the theorem, and the first lifted 6-forcer is
   its spec example.
2. **The dial (M49–M53, halted at the wall).** Descend a {1, d}-forcer's d-edges to unit material in a 6-open field. The
   derivation it wants: why a rigid pair at five colours can exist only past the 11-wall — the 5-colour analogue of the
   residue obstruction (T17), i.e. Theorem 7.1 one prime up.
3. **The additive route (M56–M57).** Rigidity as Kempe-closure; exact on Exoo–Ismailescu's G, absent on every unit object.

An algebraic proof of the lower bound would be a derivation of the form "every field with property P holds a 6-forcer,
because [mechanism]", with one explicit instance. Nothing we hold is yet of that form; the closest is Theorem B's
converse direction for four (the Moser spindle lives in the smallest field that turns off the 2-adic wall, and K is
exactly 4-chromatic).

## 4. The upper bound: what the same approaches can and cannot see — the honest assessment

χ(ℝ²) ≤ 6 (or = 7) is a statement about EVERY finitely generated real field at once (de Bruijn–Erdős: χ(ℝ²) is the
supremum of χ(F²) over such F). What the residue methods give:

* **They bound each field separately, and never uniformly.** The finite-plane bound at p gives χ(F²) ≤ χ(UD(𝔽_p, 2)), and
  the planes are ≥ 7-chromatic from p ≈ 100 on (Hoffman > 6 iff p ≳ 98). A field whose radicands are non-residues at
  every small prime has no usable prime below 100 and receives NO useful bound from any finite plane. Such fields exist in
  abundance (choose the radicands by congruence conditions), so **no residue-plane argument can prove χ(ℝ²) ≤ 6 or ≤ 7;
  the sieve is structurally one-sided.** This is not a gap in our instrument; it is the shape of the method.
* **Their colourings do not glue.** The 𝔭-adic pullback colourings (the "wild" colourings the upper-bound theorems say a
  6-colouring of ℝ² must resemble — non-map, non-lattice, G22) exist field by field at different primes and cannot be
  assembled into one colouring of ℝ² (G43 (b)).
* **What an algebraic upper-bound proof would therefore need** is a colouring of F² for ALL F built from a mechanism
  that does not depend on a small usable prime — or a lower-bound argument (a 7-forcer, if χ = 7) in a field with no
  small usable prime, which is exactly where the lifting route would have to work. Concretely, the two things worth
  deriving first, both cheap to state and neither done: (a) whether the residue colouring can be replaced by a colouring
  of the 𝔭-adic completion's plane for a NON-degree-one prime (the plane over 𝔽_{p²} has −1 a square and the theorem
  fails at integrality — is there a substitute), and (b) whether the finite planes' chromatic numbers admit a uniform
  6- or 7-colouring pattern that lifts to characteristic zero for every field at once — the question G44 leaves.
* **The conjecture that names the upper-bound question in this vocabulary (2026-09-07, FS-15):** every colouring we can
  construct is local at one prime, and the only global one is the hexagonal seven; the local–global tightness conjecture
  says χ(F²) is exactly its best local bound, capped at 7 — whose bold form is χ(ℝ²) = 7 and whose upper-bound face is "what
  obstructs gluing local colourings into a global one" (its §4 (d)). That is the derivation target for this side.
* **My assessment, stated so it can be pushed back on:** the lower bound is the side our viewpoint is built for, and
  FS-11 is a real attempt at it; the upper bound is not reachable by the residue methods as they stand, and "the same
  approaches" will have to mean the viewpoint (the arithmetic of small primes governs the chromatic number), not the
  tools (residue colourings). Weeks or months is a plausible horizon for the lower bound IF the lifting problem has a
  derivation behind it; for the upper bound no horizon can be stated today, because no mechanism we hold reaches it.
  Kooshi's direction stands as the programme's aim; this paragraph is the part of the record that says where the
  ratchet actually is.

## 5. The order of work

| step | what | the derivation it produces |
|---|---|---|
| M59 | FS-11: the 6-critical cores of UD(𝔽₅₉,2) and UD(𝔽₁₃₁,2); the local lift test; a global lift attempt on any core that passes | which residue configurations are shadows of unit-distance configurations |
| M60 | the 5-colour residue obstruction one prime up (T17 at 11) — DONE 2026-09-07 (`plans/M60-five-colour-residue-obstruction.md` §R): compulsions map forward along the reduction and the sealing plane has none, so over a sealed field a forced pair has `d² ≡ 0` and a virtual edge `d² ≡ 1 (mod 11)`; each hex-shell gadget impossible on its own | the lower bound's mechanism as arithmetic, at the level of single gadgets |
| M61 | FS-15, the local–global tightness conjecture — DONE 2026-09-08 (`plans/M61-local-global-tightness.md` §R): the mechanism of tightness (G48) derived and in the kernel; the first digit undecided (FS-17) | the spindle over a forced pair removes exactly the sealing prime — the local bound is attained one level up by construction; the 6-level is one question: a pair forced equal at five colours over a 5-sealed field (11 ∣ d²) |
| then | **FS-6 re-aimed by G48**: 5-rigidity over a SEALED field (Heule's, K(√247), K(√23)), the forced distance read off the dial at 11 ∣ d², the spindle's field 6-open by construction | whether any 5-sealed field's fabric forces a pair equal at five colours — G19's 5-tight fabric, with its distances named |
| then | the write-up of the lower bound's derivation, if one lands — the paper is the algebra, the object its example | — |
| then | §4 (a) and (b): the two upper-bound questions, derivation-first | whether any mechanism reaches the upper bound |

## 6. The rule this adds

**An object is finished when its derivation is.** A milestone that finds a 6-chromatic unit-distance graph does not close
on the certificate; it closes when the reason the graph forces six is stated for a class and proved for that class, with
the graph as the spec example — or reports honestly that the reason is not yet a derivation, and the next milestone is
that derivation. (Kooshi, 2026-09-06.)
