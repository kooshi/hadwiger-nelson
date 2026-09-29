# TC1 — four owed corrections to the front files' scope (Ephodos)

*Job TC1, brief `data/workflow3/briefs/TC1-theory-corrections.md`, 2026-09-28. Record of the derive lane; every replacement below is
drafted for Keryx to file verbatim. Working files: `data/workflow3/tc1/`.*

## Theorems this phase proved

- TC1-SQRT3-DYADIC — over a number field containing √3 (and not i), no place above 2 ramifies in F(i), and a place above 2 splits
  there iff its residue degree is even — [hand], one mind — § Argument for TC1-SQRT3-DYADIC.
- TC1-DEGREE-BELOW-12 — below degree 12, a place above 2 not split in F(i) is ramified or inert of norm ≤ 32 — [hand], one mind —
  § Argument for TC1-DEGREE-BELOW-12.
- TC1-STANDING-FOUR — over a multiquadratic field or one of degree ≤ 11, a standing wall four-colours the plane — [derived], one mind
  — § Argument for TC1-STANDING-FOUR.
- TC1-STANDING-FIVE — K·E₇ (E₇ the septic subfield of ℚ(ζ₂₉)) contains K, its wall stands (two places above 2, inert of norm 128),
  L ≥ 7, and given MR its plane needs five — [derived] from the lemma and exact PARI decompositions, given MR — § Argument for
  TC1-STANDING-FIVE.

## Would have searched here

None. The counterexample field was chosen by hand (2 has order 28 modulo 29, so it is inert in the septic subfield of ℚ(ζ₂₉)) and
checked by PARI's exact prime decomposition — a check of a derived statement, not a search.

## Stage 1 — SAVED: the readback and the four verdicts

### The first act

Before any tool call but the brief's own reading (the brief had to be read to learn what the first act was), from my context, not
from the file: a skill block is present, and its base-directory line reads

> Base directory for this skill: /home/kooshi/source/lean-dir/.claude/skills/grokkings

and G87's entry opens "G87 — The invention signal: two truths that contradict," (eight words, the dash not counted). The preload
works in a fresh Ephodos launch. I did not read `.claude/skills/grokkings/SKILL.md` for the entries' text; I read it only by search, in
Stage 2's sweep.

### The readback

`python3 data/workflow3/tc1/tc1_quotes.py` matches each of the brief's seven quotations, whitespace normalised, against its source.
All seven are found, each exactly once (`quotes: 7 of 7 found`). With `TC1_FAULT=1`, which changes "(norm 2 or 4)" to "(norm 2 or 8)"
in the first quotation, the run prints `quotes: 6 of 7 found`. The brief quotes every text correctly.

**One framing finding about the brief.** It calls text 4 "the conflation Poros's close re-read corrected everywhere else". Poros's
F9 (`plans/POROS-2026-09-28-close-reread.md` § 6) did correct it elsewhere, and it ruled on this very sentence:

> Read beside F1 the old phrase says FS-116's uniform radius is seven, which is card 1's open question; ‹R111-a›'s own sentence carries the formula and can stand.
> — source: plans/POROS-2026-09-28-close-reread.md

‹R111-a› is row 139 (the row's text is `plans/FS111-C-close.md` line 427's draft, filed verbatim). So the owed correction is Keryx's
ruling against Poros's (`plans/WORKFLOW-AUDIT-2026-09-28.md` § 9), not an oversight of Poros's. My verdict (text 4, below) sides with
Keryx, on evidence Poros did not have.

**TP1's finding, in my words.** Three places in the front files use "the wall" or "the wall is broken" as though a standing wall
always four-colours a plane, and so a plane needing five always has a broken wall. G56's own definition says the wall is broken when
every place above 2 splits in F(i). But G56 also names U₆₄, the target of a place above 2 that is *inert* in F(i) with norm 64, as a
window member for six. Such a place stands the wall in G56's sense and does not four-colour anything, since U₆₄ needs six. So G56's
*Do* asks for a condition no field can meet. G35's "(norm 2 or 4)" is right only when residue degrees above 2 are at most 2, as in
multiquadratic fields. CLAUDE.md item 1 inherits the scope. The exact general form is row 123's CLS: a place above 2 four-colours when
it is ramified in F(i)/F or inert there of norm at most 32. Separately, row 139's first sentence keeps a phrase ("the map NO made
uniform in the complexity bound") that Poros's F9 replaced everywhere else.

**Where TP1 is right and where not.** Right on G35 and G56. **Wrong on item 1's scope**: TP1 says item 1 is "true over fields
containing K"; TC1-STANDING-FIVE is a field containing K whose wall stands and whose plane, given MR, needs five. The dividing line is
not K but the residue degrees above 2: item 1 holds over every multiquadratic field and every field of degree at most 11
(TC1-STANDING-FOUR).

### The verdicts

**Text 1, G35's second clause — too wide.** Its "iff" holds for every number field without i: a conjugation-fixed prime of F(i)
above 2 lies over a place w of F with i ∉ F_w. Its bound χ(F²) ≤ N(𝔭) is true (the residue colouring) and weak. The parenthetical
"(norm 2 or 4)" holds when F is multiquadratic: then F(i) is multiquadratic, its residue degrees above 2 are at most 2 (the maximal
unramified subextension of an elementary 2-extension of ℚ₂ is at most ℚ₄), and N(𝔭) ∈ {2, 4}. It fails in general, by exact
computation (control TC1-FIELDS). ℚ(ζ₇)⁺ has one place above 2, with f = 3, ramified in F(i), so its prime 𝔭 of F(i) has norm 8.
ℚ(√3)·ℚ(ζ₇)⁺ has one, with f = 3, inert in F(i), so its 𝔭 has norm 64. Grade: [hand + tools exact], one mind. TP1 is right.

**Text 2, G56's *Do* line — wrong, in two places.** (a) Under G56's definition, a place above 2 inert in F(i), of any norm, stands the
wall, so the branch "a prime above 2 is inert of norm 64, and the wall is broken" is never met, and the Do rules U₆₄ out of the window
it names. The condition the branch needs is row 123's: no place above 2 is ramified in F(i) or inert there of norm at most 32. (b) Its
last clause, "over any F ⊇ K it is 5 or ≥ 7", is false at K itself: L(K) = 4, through its places above 2, inert of norm 2 (row 57;
TC1-FIELDS prints them). By TC1-SQRT3-DYADIC, over any F ⊇ K a place above 2 never ramifies in F(i), and it is inert exactly when its
residue degree is odd, so its norm is 2, 8, 32, 128, … and never 64. With G56's reciprocity exclusion of the odd members, and G59's
"χ(U_Q) ≠ 6 is settled everywhere except Q ∈ {23, 27, 31, 43, 47, 64}", no target of a field containing K has chromatic number 6. With no
place of residue field 𝔽₃ (11 is a non-square mod 3) or 𝔽₇ (3 is a non-square mod 7), L is 4, 5 or ≥ 7, and it is 4 when some place
above 2 is inert of norm at most 32. Grade: [hand], one mind, on G56's, G59's and row 123's grades. TP1 is right on (a); (b) is new.
Incidentally, TC1-SQRT3-DYADIC also supplies the step G56 never wrote for U₆₄: that no field containing K can use *that* window member.

**Text 3, `CLAUDE.md` § Where the problem stands item 1 — too wide, and false in general given MR.** Over a multiquadratic field, or
any field of degree at most 11, a standing wall four-colours the plane (TC1-STANDING-FOUR). So a graph over such a field forces five
only if its coordinates' field breaks the wall. In general, the unconditional necessary condition is weaker: forcing five needs every
place above 2 to split in F(i) or to be inert of norm at least 64 (row 123's CLS, dyadic half). That weaker condition can hold with the
wall standing. At K·E₇ (TC1-STANDING-FIVE) it does, and given MR that field's plane needs five. De Bruijn–Erdős then gives a finite
five-chromatic unit-distance graph over it. The field its coordinates generate has a standing wall too, because a broken wall passes
up to every larger field. The graph forces a fifth colour without its coordinates breaking the wall. Grade: [hand] given MR, one mind.
TP1's "true over fields containing K" is wrong (K·E₇ contains K). Its "in general only with 'the wall' read as 'a four-colourable
dyadic target'" is right. The item should state the multiquadratic scope and point to row 123's form, which is what TP1's paragraph
already does.

**Text 4, row 139's second sentence — wrong as conveyed; its formula is right.** FS111-C1-UNIF carries `1 − lim µ₆(ε) = inf_K
δ₀(K)`, and hence seven iff `inf_K δ₀(K) > 0`. FS111-C1-PW carries "Q-NO ⟹ δ₀(K) > 0 for every K", whose *not claimed* is "any lower
bound on δ₀(K) uniform in K" (`plans/FS111-derivation.md`). So what seven makes uniform is the NO's hole bound, δ₀(K) > 0, not the NO.
The NO is already a statement about every complexity bound. Read beside row 137 ("its NO follows from an explicit radius, uniform in
the complexity"), "the map NO made uniform in the complexity bound" says FS-116's uniform radius is seven. That is card 1's open
question, and row 139's own next sentence denies it ("FS-114's NO plus the cone scale gives seven only through a third statement").
Poros ruled that the formula disambiguates. The record shows that it did not: TP1 copied the phrase from this sentence into its
theory-paragraph draft, and Keryx had to reword it when filing (`plans/WORKFLOW-AUDIT-2026-09-28.md` § 9). The sentence is read without
its formula. Grade: derived from FS111-C1-UNIF and C1-PW (two minds each, one blind). The replacement is the wording already in
`CLAUDE.md` item 31, the theory paragraph, the Frontier stubs and the atlas.

### The derivations the verdicts rest on

derivation: TC1-SQRT3-DYADIC
  statement: for a number field F with √3 ∈ F and i ∉ F, no place of F above 2 is ramified in F(i)/F, and a place w above 2 splits in
    F(i) if and only if its residue degree f(w|2) is even; when it does not split it is inert, of norm 2^f with f odd
  uses only: √−3 generates ℚ₄, the unramified quadratic extension of ℚ₂; F_w(i) = F_w(√−3) when √3 ∈ F_w; a compositum with an
    unramified extension is unramified over the smaller field; ℚ₄ lies in F_w when 2 divides f(w|2), and not otherwise
  not claimed: anything for F without √3 — ℚ(ζ₇)⁺'s one place above 2 is ramified in F(i) (TC1-FIELDS)
  converse: § Argument for TC1-SQRT3-DYADIC
  argument: § Argument for TC1-SQRT3-DYADIC
  verdict: derived
  grade: hand
  minds: 1
  model: K = ℚ(√3,√11) — two places above 2, each f = 1, each inert in K(i); K(√5) and K(√7) — f = 2, split (TC1-FIELDS)
  prior art: owed — a two-line local lemma from the quadratic extensions of ℚ₂; not searched at its grain
  handoff: none — a two-line local lemma that scopes G56's exclusion; it crosses to de Bruijn with that exclusion if it is formalized

derivation: TC1-DEGREE-BELOW-12
  statement: for a real number field F of degree at most 11, every place of F above 2 that does not split in F(i) is ramified in
    F(i)/F or inert there of norm at most 32
  uses only: an inert place w above 2 has even ramification index e(w|2), since F_w(i) contains ℚ₂(i), ramified over ℚ₂, while
    F_w(i)/F_w is unramified; e(w|2)·f(w|2) ≤ [F:ℚ]
  not claimed: that a field of degree 12 or more escapes — only that one can: ℚ(√3)·E₇, degree 14, has one place above 2, inert of
    norm 128 (TC1-FIELDS)
  argument: § Argument for TC1-DEGREE-BELOW-12
  verdict: derived
  grade: hand
  minds: 1
  model: ℚ(√3)·ℚ(ζ₇)⁺, degree 6 — one place above 2, inert in F(i), of norm 8 (TC1-FIELDS)
  prior art: partly: G56 states the bound for U₆₄ alone ("realised only by fields of degree ≥ 12"); the general form not searched
  handoff: none — a two-line local lemma that scopes G1, G35 and item 1; it crosses with row 52's field-level step if that is formalized

derivation: TC1-STANDING-FOUR
  statement: for a real number field F that is multiquadratic or of degree at most 11, if some place of F above 2 does not split in
    F(i), then χ(F²) ≤ 4
  uses only: TC1-DEGREE-BELOW-12; for multiquadratic F, that F(i) is multiquadratic, so an inert place above 2 has f = 1 and norm 2;
    G56's dyadic bounds (ramified in F(i): χ(F²) ≤ 2; inert of norm Q ≤ 32: χ(F²) ≤ χ(U_Q) = 4, by formula, row 123), each through
    the residue map at the place (row 52's bound at field level, [hand]; row 57's gap is the kernel's)
  not claimed: that a broken wall gives five — ℚ(√7)'s wall is broken and its plane three-colourable (G38); anything at degree 12 or
    more, where TC1-STANDING-FIVE is a counterexample given MR
  argument: § Argument for TC1-STANDING-FOUR
  verdict: derived
  grade: derived from: TC1-DEGREE-BELOW-12
  minds: 1
  model: K — multiquadratic, wall standing, χ(K²) = 4 (row 57)
  prior art: partly: G56 and row 123 hold the dyadic bounds; the scope, multiquadratic or degree ≤ 11, not searched
  handoff: none — a consequence of held bounds; it crosses with row 52's field-level step (row 57's gap)

derivation: TC1-STANDING-FIVE
  statement: F = K·E₇, with K = ℚ(√3,√11) and E₇ the degree-7 subfield of ℚ(ζ₂₉), is a totally real field of degree 28 containing K;
    its two places above 2 are inert in F(i), each of norm 128, and none of its places has a usable residue field of size at most 47;
    so L(F) ≥ 7, and given MR, χ(F²) ≥ 5
  uses only: TC1-FIELDS (the decompositions, exact); TC1-SQRT3-DYADIC (f = 7 is odd, so inert — a cross-check); G56 (every usable
    plane from 59 up refuses six; U₁₂₈'s Hoffman floor is 8); row 123 (χ(F²) ≥ min(L(F), 5), given MR)
  not claimed: any value of χ(F²); that it is the smallest such field — ℚ(√3)·E₇, degree 14, has the same dyadic data and no small
    usable residue field, but does not contain K
  argument: § Argument for TC1-STANDING-FIVE
  verdict: derived
  grade: derived from: TC1-SQRT3-DYADIC
  minds: 1
  model: F itself — TC1-FIELDS prints its places
  prior art: owed — a corollary of row 123 at one field; no search run
  handoff: none — conditional on MR (row 120, [hand]); it crosses to de Bruijn only with row 123's chain

control: TC1-FIELDS
  of: TC1-STANDING-FIVE — the places above 2, and the small usable residue fields, of K, K(√5), K(√7), K(√35) (the controls: G1,
    G43, row 52), ℚ(ζ₇)⁺, ℚ(√3)·ℚ(ζ₇)⁺, ℚ(√3)·E₇ and K·E₇, and that K·E₇ contains K
  run: TC1_QUIET=1 gp -q ../data/workflow3/tc1/tc1_fields.gp 2>/dev/null
  expect: CHECK: PASS
  fault: TC1_QUIET=1 TC1_FAULT=1 gp -q ../data/workflow3/tc1/tc1_fields.gp 2>/dev/null

### Argument for TC1-SQRT3-DYADIC

Let w be a place of F above 2, so F_w ⊇ ℚ₂(√3), and i ∉ F. Since √−3 = √3·i and √3 ∈ F_w, F_w(i) = F_w(√−3). Now −3 ≡ 5 (mod 8), so
ℚ₂(√−3) = ℚ₂(ζ₃) = ℚ₄, the unramified quadratic extension of ℚ₂. Hence F_w(i) = F_w·ℚ₄, which is unramified over F_w, so w does not
ramify. It is trivial over F_w (w splits) exactly when ℚ₄ ⊆ F_w. That happens exactly when the maximal unramified subextension of F_w,
which is ℚ_{2^f} with f = f(w|2), contains ℚ₄, that is, when 2 divides f. Otherwise F_w(i)/F_w is the unramified quadratic
extension: w is inert, and N(w) = 2^f with f odd. **Converse:** both directions of the "if and only if" are the one equivalence
ℚ₄ ⊆ ℚ_{2^f} ⟺ 2 | f, used both ways above. ∎ The control prints the pattern on seven fields, all consistent: split at f = 2, inert at
f = 1, 3, 7.

### Argument for TC1-DEGREE-BELOW-12

If w is inert in F(i), then F_w(i)/F_w is unramified, so e(F_w(i)/ℚ₂) = e(w|2). But F_w(i) ⊇ ℚ₂(i), which is ramified of index 2
over ℚ₂, and ramification indices multiply in the tower ℚ₂ ⊆ ℚ₂(i) ⊆ F_w(i), so 2 divides e(w|2). Then [F:ℚ] ≥ [F_w:ℚ₂] = e·f ≥ 2f.
For [F:ℚ] ≤ 11 this gives f ≤ 5, so N(w) = 2^f ≤ 32. A place that neither splits nor is inert is ramified. ∎ The bound is sharp in
kind: inert with f = 6 needs degree at least 12 (G56's U₆₄), and ℚ(√3)·E₇ (degree 14) has f = 7.

### Argument for TC1-STANDING-FOUR

Let w be a place above 2 that does not split in F(i). If F has degree at most 11, TC1-DEGREE-BELOW-12 makes w ramified in F(i) or
inert of norm at most 32. If F is multiquadratic, F(i) is multiquadratic too. Its residue degrees above 2 are at most 2, because the
unramified part of an elementary abelian 2-extension of ℚ₂ is at most ℚ₄. An inert w doubles its residue degree in F(i), so f(w|2) = 1
and N(w) = 2. In either case G56's dyadic bounds apply, through the residue map at w: ramified gives χ(F²) ≤ 2, and inert of norm
Q ≤ 32 gives χ(F²) ≤ χ(U_Q) = 4. ∎

### Argument for TC1-STANDING-FIVE

2 has order 28 modulo 29 (2¹⁴ ≡ −1), so it is inert in ℚ(ζ₂₉) and in its degree-7 subfield E₇, with f = 7. Over ℚ₂, K ⊗ ℚ₂ is two
copies of ℚ₂(√3), since 33 ≡ 1 (mod 8) puts √33 in ℚ₂ and so √11 in ℚ₂(√3). E₇ ⊗ ℚ₂ = ℚ₁₂₈. So F has two places above 2, each with
completion ℚ₁₂₈(√3), e = 2 and f = 7. By TC1-SQRT3-DYADIC each is inert in F(i), of norm 2⁷ = 128, and F's wall stands. PARI's
maximal-order decomposition agrees (TC1-FIELDS: e = 2, f = 7, not split, prime to the relative discriminant of x² + 1). The control
also finds no place of F with a usable residue field of size at most 47: none with 𝔽₃, 𝔽₇, 𝔽₁₁, 𝔽₁₉, 𝔽₂₃, 𝔽₂₇, 𝔽₃₁, 𝔽₄₃ or 𝔽₄₇.
Every prime below 47 not listed has q ≡ 1 (mod 4) at every residue degree and is never usable. So every residue target of F is
- U₁₂₈, with Hoffman floor 8 (G56); or
- a usable plane of size at least 59, each of which refuses six (G56: by certificate at 59, 67, 79, 83; by exact spectrum at 71; by Weil
  from 98; and no prime power in (47, 97] is usable).

Hence L(F) ≥ 7, and in row 123's CLS F has no place of ratio ≥ 1/4, so given MR, χ(F²) ≥ min(L(F), 5) = 5 (row 123). F is totally
real because E₇ ⊆ ℚ(ζ₂₉)⁺, the subgroup of order 4 fixing it containing −1. ∎

**What it refutes.** Given MR, F² is not four-colourable, so by de Bruijn–Erdős some finite unit-distance graph G ⊂ F² needs five
colours. G's coordinates generate a subfield F_G ⊆ F. If F_G's wall were broken, i would lie in every completion of F_G above 2, hence
in every completion of F above 2, and F's wall would be broken. So F_G's wall stands, and G forces a fifth colour with coordinates that
do not break it. F also contains no √d with d odd and d ≡ 7 (mod 8): its quadratic subfields are K's three, ℚ(√3), ℚ(√11) and ℚ(√33),
since E₇ has odd degree. So G1's "contain an odd square class ≡ 7 (mod 8)" fails at F as well. F is also 6-open with its wall
standing, contrary to G43's criterion read over every F ⊇ K (Stage 2's sweep).
