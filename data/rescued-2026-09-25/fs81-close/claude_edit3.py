exec(open("/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs81-close/helpers.py").read())
t = P.read_text()
# ---- G61 rewrite
i = t.index("* **G61 — Three colours break at arithmetic, not at size")
j = t.index("* **G62 — Every witness is a twisted bilayer", i)
G61 = """* **G61 — Three colours break at arithmetic, not at size — and the arithmetic is the supply of unit vectors. [kernel + certified + hand; one reading]** Over a real
  quadratic field with `d ≡ 2 (mod 3)`: (1) **The barrier** [kernel, row 72]: directions integral at 3 are 3-colourable outright, so a refusal needs a direction with 3 in a denominator —
  met by count in every certified witness (89 to 4,328 such edges, never zero). (2) **The theorem** [hand, two independent derivations; row 82; its method is G74]: `χ(F²) ≥ 4` for
  every `F ⊆ ℝ` with `1/3 ∈ ℤ[U_F]` and `F²` not bipartite — for ℚ(√d) exactly `d ≡ 11 (mod 12)`, by the type-M relation `1 = 2n − nv − nv̄` — so **T4 holds**, χ = L for every
  real quadratic field with L ≤ 4 (`[Fischer1990]` Thms 8–9: χ = 2 iff d ≢ 3 mod 4, χ = 3 for d ≡ 3, 7 mod 12, and at those every three-colouring is additive mod 3), and the
  barrier is its necessary half: `1/3` needs a 3 in a denominator. (3) **Rigidity is periodic and local** [measured]: the 3-adic plane is Hoffman-tight at three colours and rigid
  from level 1, and stays rigid tensored with the residue planes at 7 and 11 (the general statement is FS-67, unproved, and false without gap-freedom); every periodic colouring of
  the 3-integral pools tried is affine, so quotient screens never kill; on ℚ(√11)'s `Λ₁₀` "every colouring is affine" is a theorem (G71). (4) **The rational directions are
  load-bearing** [measured; explained by row 82]: the `√d`-vectors alone force nothing, and two fields' unit vectors in one lattice shape share *only* the rational ones, because the
  norm equation is linear in `d` — the rational pattern `U₅` is the layer every field-level argument reads. (5) **On a finite lattice, supply decided refusal** [measured, row 74]:
  one integral shape refuses over ℚ(√11) with 108 unit vectors and is periodically 3-colourable over five fields with 20–36; refusing lattices are rich in classes, not coarse;
  odd girth ≤ 9 is necessary and far from sufficient; and the congruence class did not decide which lattices refused — 11 and 59 land at `d ≡ 3 (mod 8)`, cutting across
  `[Fischer1990]` Thm 10's split of the family. Since row 82 this is a fact about finite witnesses only: every field in the family refuses, and a finite witness appears where the
  field's `Θ₃` empties at small depth (five layers at depth `5^K`, `K_B(d) ≤ 3` below 500, row 83). *Demotion records:* this entry first read "every field with a usable plane at 7
  has χ = 4" (false at ℚ(√2), ℚ(√7)) and "forcing at small size tracks short odd cycles in a COARSE 3-non-integral lattice" (the census: rich, not coarse); FS-58's plan first
  derived periodic affinity from "finite quotients of the 3-integral group are 3-groups" — false, since the unit vectors' lattice maps onto every stable residue plane. **And until
  FS-81 (2026-09-24) it read "T4 — every such d needs four — is unproved: no proof and no route to one — no witness transfers between fields, and the chain route needs a forcer in
  every field's own 3-integral graph"**: killed by row 82, whose route transfers one relation and one rational pattern to every field and needs no forcer. *Reading, with its
  test:* **the census's mod-8 skew** (13 of 20 certified at `d ≡ 7 (mod 8)` against 2 of 20 at `d ≡ 3`) is configuration A's: `{1, v, v̄}·U^(5^K)` never empties at
  `d ≡ 11 (mod 24)` (FS81-T8), and lattices built around `v` and `v̄` inherit it. Killing test: a census-style search that lands the `d ≡ 11 (mod 24)` fields at the `d ≡ 23` rate.
  *Do: over any real field, decide three colours at the field level first — is `1/3 ∈ ℤ[U_F]` (no conjugation-stable prime above 3) and is the plane non-bipartite — and build
  nothing when it is; for a finite witness take the five layers `{vᵏ : |k| ≤ 2}·U^(5^K)` at the least `K` with `d < 21·5^{K−1}` and certify structurally (row 83). Nothing kills
  the theorem but a defect in its chain (FS73-T22's ⟹ is hand-proved, never kernel); it forbids a three-colouring of any such plane, and every three-colour search over one.*
"""
t = t[:i] + G61 + t[j:]
# ---- G74 new, before G51
G74 = """* **G74 — Read a field's plane one layer at a time: every unit-vector set holds the rational pattern, and one relation among layers decides three colours for the whole field. [hand, two independent derivations (row 82); the lift is FS73-T22's, hand; one reading]**
  A three-colouring of `F²`, for any `F ⊆ ℝ`, carries a **field-level slope** `θ ∈ Hom(ℤ[U_F], ℝ/ℤ)` with every unit vector in `[1/3, 2/3]` — FS73-T22's height on every
  finite set of unit vectors, then compactness (G71 at the field level; in the literature's words, a circular colouring given by a character). `U_F` is a union of **layers**
  `b·U₅`, rotated copies of the rational unit vectors with 5-power denominators (G62's multilayer, for the whole field), and on each layer a slope has **one of two types**: the
  parity character plus a small archimedean part (`|e| ≤ 1/6`), or one of four order-3 characters (C1(5), from FS73-T40's exact cells). A relation `1 = Σ c_j u_j` carries the
  types across layers, and the archimedean parts cannot absorb a finite-order discrepancy, because every layer holds `5^{−k}` for every `k`; so `1/3 ∈ ℤ[U_F]` plus an odd cycle
  leaves no slope and the field needs four. The field is incidental: any multiplicatively closed `U ⊇ U₅`, and five layers `{vᵏ : |k| ≤ 2}·U₅` already suffice (FS81-T5). **The
  mechanism in the discipline's words** [reading]: `U_F` is the rational points of a torus, the layers are its cosets through the rational pattern, and `Θ₃(F)` is rigid only
  modulo the archimedean places; `[Fischer1990]` had the relation and stopped at additive colourings for want of exactly this. **Where it stops:** from four colours up there is
  no height (G71, G73), so a point of `Θ_k(F)` still colours the whole plane but emptiness proves nothing about `χ` — one-sided there (FS-83); and the residual three-colour case,
  primes above 3 of odd residue degree ≥ 3, has no `1/3` to glue with (FS-82). *Do: when a question is three colours over a whole field — any subfield of ℝ, any degree — ask
  whether `1/3 ∈ ℤ[U_F]` and whether the plane is bipartite, and answer before building anything; when a field-level question at any `k` resists, factor `U_F` into layers of a
  base pattern, classify the base pattern's rotation set exactly at the band (T40's cells), and glue by relations — naming the step that uses infinitely many layers, because a
  finite configuration holds points the field does not (FS81-T8: at depth `J` the archimedean parts absorb a parity discrepancy while `5^J ≲ 0.25·d`). Nothing kills the
  three-colour theorem but a defect in its chain; it forbids a three-colouring of every plane with `1/3 ∈ ℤ[U_F]` and an odd cycle. Killing test of the reading that the rational
  layer's rotation set is always a disc plus finitely many torsion points: T40's cells at the band `[1/4, 3/4]` or `[1/5, 4/5]` holding a third kind of cell (FS-83's first step).*
"""
ins_before("* **G51 — A competitor and an advisor beat one mind.", G74)
P.write_text(t)
print("ok", len(t.encode()))
