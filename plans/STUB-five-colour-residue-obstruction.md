# FS-14 — The five-colour residue obstruction at 11: what a 5-sealed field's colourings force (STUB, 2026-09-06; minted at the M59 close — the programme's named next derivation)

*Read beside: `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §5 ("next: the 5-colour residue obstruction one prime up — why a rigid pair at
five colours needs the 11-wall broken"); `plans/FIELD-WALL-THEOREM.md` §7 (T17: inside K no pair compulsion at five colours — the
residue 4-colouring plus a spare colour); M56 (`Additive.lean`: the pairs every additive colouring identifies contain the forced
pairs); `Instances/FinitePlane11.lean` (χ(UD(𝔽₁₁,2)) = 5, the pulled-back colouring of Heule-510).*

## 1. Mission context, in plain language

Theorem B says no unit-distance graph over K = ℚ(√3, √11) forces a pair at five colours: the residue 4-colouring leaves a colour
spare. The finite-plane bound says every unit-distance graph over a 5-SEALED field (11 usable: K(√5), K(√247), Heule's) is
5-coloured by pulling back a 5-colouring of UD(𝔽₁₁, 2) through the reduction — and the reduction is a homomorphism, so every
5-colouring of the finite plane gives a 5-colouring of the graph that is CONSTANT on residue classes and PROPER across adjacent
ones. A pair of vertices forced equal in every 5-colouring of the graph is therefore forced equal in every pulled-back one:
its two residues must be identified by EVERY 5-colouring of UD(𝔽₁₁, 2). A pair forced distinct (a virtual edge) must have
residues separated by every 5-colouring of the plane. Both are finite questions on a 121-vertex graph: the set F₁₁ of residue
pairs every 5-colouring of UD(𝔽₁₁, 2) identifies, and the set S₁₁ of residue pairs every 5-colouring separates (the plane's own
virtual edges at five colours, M56's F_add and M45's virtual edges one prime up). **The derivation to aim for:** the exact
statement "in a 5-sealed field a pair compulsion at five colours lives only on pairs whose residues lie in F₁₁ ∪ S₁₁", with the
two sets computed — if F₁₁ is empty off the diagonal, no forced-equal pair at five colours exists in any 5-sealed field at
any distance whose endpoints have distinct residues; and the 6-forcer's field must escape 11 for the reason the 5-forcer's
escaped 2: the sealing prime's plane has no rigid pairs of its own.

## 2. What we know

| fact | where |
|---|---|
| χ(UD(𝔽₁₁,2)) = 5 (kernel); the plane is vertex-transitive with automorphism group ⊇ 𝔽₁₁² ⋊ O(2, 𝔽₁₁) (order 121 · 24) | M58 |
| the pulled-back 5-colouring of Heule-510 is proper (kernel) — so its 5-colouring space contains every pullback | M58 |
| M56: the seed's forced pair is exactly the pair every additive 5-colouring identifies; the witnesses' additively forced pairs are all separated by non-additive colourings | M56 §R |
| M45/M48: a compulsion is a partial colouring that does not extend; arity 2 = forced/separated | `Arity.lean` |

## 3. Derivations first

**D1 — the transfer.** For G a unit-distance graph over F with 11 usable and r : V(G) → 𝔽₁₁² the reduction: every 5-colouring c
of UD(𝔽₁₁,2) gives the proper colouring c ∘ r of G. Hence Forces G 5 u v ⟹ ∀ c, c(r u) = c(r v), i.e. (r u, r v) ∈ F₁₁; Separated
G 5 u v ⟹ (r u, r v) ∈ S₁₁. Kernel: `Colorable.of_hom` in M45's `Forces`/`Separated` vocabulary through `UDCert.drawingHom` —
an afternoon.

**D2 — F₁₁ and S₁₁, exactly.** Enumerate the 5-colourings of UD(𝔽₁₁,2) up to the automorphism group (how many? the M58 record has
one; M20's strip-automaton genre suggests a structured count), then intersect. Prediction: F₁₁ is the diagonal only (no two
residues are identified by every colouring) and S₁₁ is exactly the edge set plus possibly the distance-… classes the hex-shell
pigeonhole forces (compare M35's k = 5 class sweep, all clean). If so: **no forced-equal pair at five colours exists over any
5-sealed field between points of distinct residue, and every virtual edge over such a field lies on a residue pair in S₁₁.**

**D3 — the same at 19 (for fields without √3) and the meaning of "escape".** A 6-forcer's field must have every sealing prime
inert; D1–D2 say WHY at the level of compulsions: the sealing plane's colourings are too free to force anything the graph does
not already force through residues.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D2: the 5-colourings of UD(𝔽₁₁,2) up to symmetry; F₁₁ and S₁₁ | a day |
| A | D1 in the kernel; the transfer theorem with the two sets as decided data | a day |
| B | the reading against the descent's cheats (every cheat pair's residues at 11 on the seed and the it-4 object: which lie in S₁₁) | hours |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | F₁₁ off the diagonal is empty | medium-high |
| P2 | S₁₁ is the plane's edge set plus no other class | medium |
| P3 | every one of the seed's 446 cheat pairs has residues in S₁₁ or F₁₁ at 11 | medium |

## 6. Bearing on 6, honestly

Medium as a DERIVATION (the programme's stated next step): it turns "5-sealed" from a chromatic-number statement into a
compulsion statement, the 5-colour analogue of T17, and names the mechanism the 6-forcer's field must escape. No object.

## 7. Addresses

`tools/fplane.py chi`, `data/fplane/chi-p11.json`, `Proofs/HadwigerNelson/Instances/FinitePlane11.lean`, `Arity.lean`, `Additive.lean`.
