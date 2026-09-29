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

## Stage 2 — SAVED: the replacements and the sweep

**How to file them.** Each draft below names its file and slot, the old text exactly as the file wraps it, and the new text to put
in its place. `python3 data/workflow3/tc1/tc1_apply.py` holds the same sixteen triples (this section is its `--md` output, pasted
unedited). It refuses to write anything unless every old text occurs exactly once, and it writes only scratch copies, under
`data/workflow3/tc1/copies/`. Grades and citations are kept; each new clause carries its own grade through its citation (row 123 and
G56 for the dyadic bounds; this record's entries, [hand], one mind, for TC1-SQRT3-DYADIC, TC1-STANDING-FOUR and TC1-STANDING-FIVE).
Where a draft cites a new address, it is this record's, because the lemma and the counterexample have no other home yet. K·E₇'s home
becomes G35 (T1), and the other files point there, one home per fact. T1 adds a one-sentence demotion record to G35, whose clause
was a false general claim; the other drafts narrow a scope or reword, and carry none.

**T1 — `.claude/skills/grokkings/SKILL.md`, G35's second clause.** Replace

```text
one above 2 exists iff −1 is not a square in some
  completion above 2 (norm 2 or 4).
```

with

```text
one above 2 exists iff −1 is not a square in some
  completion above 2 — of norm 2 or 4 when F is multiquadratic, any power of 2 in general. One ramified in F(i)/F gives
  χ(F²) ≤ 2, and one inert there, over a place of norm Q, gives the target U_Q, four-colourable exactly when Q ≤ 32 (G56, row 123);
  so a standing wall four-colours F² over a multiquadratic field and below degree 12, and not in general: K·E₇, E₇ the septic
  subfield of ℚ(ζ₂₉), keeps its wall at two places inert of norm 128, and given MR its plane needs five (`plans/WORKFLOW3-TC1-theory-corrections.md`
  TC1-STANDING-FOUR, TC1-STANDING-FIVE). *Demotion record: this clause read "(norm 2 or 4)" for every real number field;
  ℚ(ζ₇)⁺'s prime above 2 has norm 8 (TC1).*
```

**T2 — `.claude/skills/grokkings/SKILL.md`, G56's Do line.** Replace

```text
*Do: for any field, list
  its usable q first — six is possible only if one lies in {23, 27, 31, 43, 47}, or a prime above 2 is inert of norm 64, and
  the wall is broken; otherwise L is 2, 3, 4, 5 or ≥ 7 before any solver, and over any F ⊇ K it is 5 or ≥ 7.
```

with

```text
*Do: for any field, list
  its usable q and its places above 2 first — six is possible only if a usable q lies in {23, 27, 31, 43, 47} or a place above 2
  is inert in F(i) of norm 64, and no place above 2 is ramified in F(i) or inert there of norm ≤ 32 (row 123; over a multiquadratic
  field or below degree 12, that is the broken wall); otherwise L is 2, 3, 4, 5 or ≥ 7 before any solver. Over any F ⊇ K no place
  above 2 ramifies in F(i) or has norm 64 (TC1-SQRT3-DYADIC), so L is 4, 5 or ≥ 7, and 4 when a place above 2 is inert of norm ≤ 32.
```

**T3 — `CLAUDE.md`, § Where the problem stands, item 1.** Replace

```text
1. **The 4/5 wall is 2-adic.** A unit-distance graph forces a fifth colour only if its coordinates break the
   2-adic wall (G1, G35).
```

with

```text
1. **The 4/5 wall is 2-adic.** Over a multiquadratic field, or one of degree at most 11, a unit-distance graph forces a fifth colour
   only if its coordinates break the 2-adic wall (G1, G35); over any real number field, only if each place above 2 splits in F(i)
   or is inert there of norm 64 or more (row 123), which a field whose wall stands can meet (G35).
```

**T4 — `LEDGER.md`, row 139, its second sentence.** Replace

```text
Seven, `χ_m⁰(ℝ²) ≥ 7`, is the map NO made uniform in the complexity bound:
```

with

```text
Seven, `χ_m⁰(ℝ²) ≥ 7`, is the NO's hole bound made uniform in the complexity bound:
```

**S1 — `.claude/skills/grokkings/SKILL.md`, G35's Do line.** Replace

```text
for any F, is 1/2 ∈ ℤ[U], i.e. does every prime above 2 split in F(i) — and
  expect no odd-degree field to break it.
```

with

```text
for any F, is 1/2 ∈ ℤ[U], i.e. does every prime above 2 split in F(i) — and
  expect no odd-degree field to break it; where it stands, call the null free only once a place above 2 is ramified in F(i) or inert
  of norm ≤ 32, which is automatic over a multiquadratic field or below degree 12.
```

**S2 — `.claude/skills/grokkings/SKILL.md`, G1's fourth sentence.** Replace

```text
A 5-forcer's
  coordinates must break the 2-adic wall — contain an odd square class ≡ 7 (mod 8), such as √5, √7 or √247
  (G35).
```

with

```text
A 5-forcer's
  coordinates must break the 2-adic wall when their field is multiquadratic or of degree at most 11 — for a multiquadratic
  field, contain an odd square class ≡ 7 (mod 8), such as √5, √7 or √247 (G35); in general they need only avoid a place above 2
  ramified in F(i) or inert of norm ≤ 32, and given MR a field whose wall stands can hold one (G35's K·E₇).
```

**S3 — `.claude/skills/grokkings/SKILL.md`, G1's Do line.** Replace

```text
*Do: before any solver on a candidate,
  read its field's square classes for an odd one ≡ 7 (mod 8) (G35's congruence); none means Theorem B four-colours the
  object and the null is free — never run it. Nothing kills it; it kills every five-colour design in a wall-standing field.*
```

with

```text
*Do: before any solver on a candidate
  over a multiquadratic field, read its square classes for an odd one ≡ 7 (mod 8) (G35's congruence); none means a residue
  colouring at a prime above 2 (Theorem B's, over K) four-colours the object and the null is free — never run it; over any other
  field, read its places above 2 (G35's Do). Nothing kills it; it kills every five-colour design in a wall-standing field that is
  multiquadratic or of degree at most 11.*
```

**S4 — `.claude/skills/grokkings/SKILL.md`, G43's fourth sentence.** Replace

```text
For F ⊇ K,
  6-open ⟺ wall broken ∧ 11 inert:
```

with

```text
For multiquadratic F ⊇ K,
  6-open ⟺ wall broken ∧ 11 inert (not for every F ⊇ K: K·E₇ is 6-open with its wall standing, G35):
```

**S5 — `.claude/skills/grokkings/SKILL.md`, G56's exclusion.** Replace

```text
so such a field's usable primes are 11 and then nothing below 83, its local bound is 5 or ≥ 7,
  and **six is arithmetically excluded for all of them**.
```

with

```text
so such a field's usable primes are 11 and then nothing below 83; its places above 2 never ramify in F(i) and, when
  not split, have norm 2, 8, 32, 128, …, never 64 (`plans/WORKFLOW3-TC1-theory-corrections.md` TC1-SQRT3-DYADIC); its local bound is 4
  (a place above 2 inert of norm ≤ 32), 5 or ≥ 7, and **six is arithmetically excluded for all of them**.
```

**S6 — `.claude/skills/grokkings/SKILL.md`, G56's enumeration clause.** Replace

```text
the second condition being what makes a local bound
  of 6 worth anything, since a wall-standing field is four-colourable by the residue at 2.
```

with

```text
the second condition being what makes a local bound
  of 6 worth anything, since a wall-standing field below degree 12 — every field these enumerations reach — is four-colourable
  by the residue at 2 (TC1-STANDING-FOUR; from degree 12 a place above 2 inert of norm ≥ 64 keeps the wall without four colours).
```

**S7 — `CLAUDE.md`, § Notation, 6-open.** Replace

```text
(the wall is broken and every usable plane needs ≥ 6; over K, row 53's criterion)
```

with

```text
(every usable plane and every target at a prime above 2 needs ≥ 6; over a multiquadratic field, the wall is broken and every usable
  plane needs ≥ 6; over K, row 53's criterion)
```

**S8 — `CLAUDE.md`, § Where the problem stands, item 2.** Replace

```text
2. **The field sieve.** For F ⊇ K: 6-open ⟺
```

with

```text
2. **The field sieve.** For multiquadratic F ⊇ K: 6-open ⟺
```

**S9 — `LEDGER.md`, row 53.** Replace

```text
over K, 6-open ⟺ wall broken ∧ 11 inert —
```

with

```text
over multiquadratic F ⊇ K, 6-open ⟺ wall broken ∧ 11 inert (not over every F ⊇ K: G35's K·E₇) —
```

**S10 — `LEDGER.md`, row 57.** Replace

```text
— the same algebra whose ramification set is the 2-adic wall (G35) —
```

with

```text
— the same algebra, `(−1,−1)`, whose ramification at a place above 2 keeps the 2-adic wall standing there without being the wall (G35) —
```

**S11 — `LEDGER.md`, § B, M58-T2.** Replace

```text
| M58-T2 | M58 | for `F ⊇ K = ℚ(√3,√11)`:
```

with

```text
| M58-T2 | M58 | for multiquadratic `F ⊇ K = ℚ(√3,√11)`:
```

**S12 — `LEDGER.md`, § B, ASTRA-2026-09-14-T7.** Replace

```text
— wall-broken sufficient, not only necessary, over `K` |
```

with

```text
— wall-broken sufficient over `K`, not only necessary (necessary over multiquadratic `F ⊇ K`; not over every `F ⊇ K` given MR: G35's K·E₇) |
```


### The sweep

Searched in the six files the brief names, for "wall" in every form ("wall is broken", "wall stands", "wall-standing", "standing
wall", "wall-break", "breaks the wall", "keeps the wall", "2-adic wall", "the wall"), "norm 2 or 4", "residue at 2", "fifth colour
only", "5-forcer's coordinates", "5 or ≥ 7", "6-open ⟺", "4/5 wall", "ramification set is the 2-adic", and for row 139's phrase and
its kin ("made uniform", "NO made", "map NO", "uniform in"). 105 hits on the wall family outside the ledger's scan and 17 in it; every
one is classed below. **Drafted:** S1–S12 above. **Stands, with the reason:**

- *Over K or a field reached from it by square roots.* Every construction here — spindles, rotations, descents, fabric plus a root —
  lives in such a field. Its residue degrees above 2 are powers of 2, and it contains √3, so by TC1-SQRT3-DYADIC a place above 2 that
  does not split in F(i) has f = 1 and norm 2, and a standing wall four-colours (U₂). So these stand as written:
  - `CLAUDE.md` item 5 ("the endgame needs a wall-breaking adjunction into a 6-open field");
  - G7 ("`n = 4` breaks the wall"; "a member whose radicand keeps the wall"), G16, G19, G40 ("a wall-breaking root/field"), G37 (the
    necessity of a wall-breaking adjunction — TC1-SQRT3-DYADIC is the step that carries it past multiquadratic fields), G52, G62;
  - LEDGER rows 64, 89, 103 and § B's MASCOT-T4, M58-T3 and M63G's σ-criterion line.
- *General and correct.* These stand:
  - `CLAUDE.md` § Notation's pointer "The (2-adic) wall stands or is broken: G35";
  - item 2's "The wall is broken exactly when 1/2 lies in the unit-vector ring, and over K that is sufficient for five";
  - G35's 1/2 ∈ ℤ[U] criterion, its reciprocity parity, its trichotomy and its multiquadratic congruence (already scoped);
  - G55's "wall broken" is "1/2 ∈ R" and its sufficiency over K (also FRONTIER-STUBS line 114);
  - G56's definition ("every prime above 2 splits in F(i)");
  - the theory paragraph, which states row 123's general form.

  **G35's killing test** ("a field whose plane needs five colours and whose `(−1,−1)` ramifies at a finite place") stands as a test of
  the parity step, but on a different chain. A plane needing five has no place above 2 ramified in F(i). A place of odd local degree
  over ℚ₂ has odd ramification index and so ramifies in F(i). So every local degree above 2 is even, and `(−1,−1)` splits there.
- *True as written, and more supported now.* `CLAUDE.md` item 11 ("No field containing K can use any member") covers U₆₄ as well:
  over a field containing √3, no place above 2 has norm 64 (TC1-SQRT3-DYADIC). That is the step G56 never wrote for this member.
- *Specific fields or degrees.* These stand:
  - `CLAUDE.md` line 182 (the wall-standing fields Theorem A four-colours);
  - LEDGER row 76 (ℚ(√3,√5)), § B's FS54-T4 and FS105-SCOPE;
  - FRONTIER-STUBS line 127 (real quadratic fields, degree 2 — TC1-STANDING-FOUR covers them).
- *A different wall.* These use "wall" for the wall at six (G56, G59, G64; `CLAUDE.md` items 12 and the conjecture paragraph; LEDGER
  rows 70–71 and § B FS54-T8; FRONTIER-STUBS lines 99, 106, 108), the regularity wall (every atlas hit, `STUB-regularity-wall`), a
  solver's wall (G65, LEDGER row 81), FS-86's wall lemma, COL-E's "wall's exact form" (LEDGER row 126), or a wall in G79's generic
  sense. They are outside this defect.
- *History.* GROKKING-INSTANCES lines 87, 122 (G35's 2026-09-22 correction), 377 and 423, and LEDGER row 77's record of that
  correction, stand as history.
- *Row 139's phrase.* It survives in the six files only in row 139 (T4). `CLAUDE.md` item 31 and the theory paragraph,
  FRONTIER-STUBS lines 87 and 156, and the atlas's node (line 213) already read "the NO's hole bound made uniform". Every "uniform in
  the complexity" elsewhere (row 137, G83, FRONTIER-STUBS 84 and 155, the atlas's LOCALF edges, § B's N114-COMPACT) says the radius
  suffices for the NO, which is right.

**Flagged, not drafted (outside the defect; its intent is unclear to me).** G56's "A six-chromatic number field, if one exists,
contains no √11 and none of the known five-forcers". G57 says 11 is a square at 43, so 43 can serve a field with √11 and no √3. And
nothing shown here stops a field with √11 and no √3 from holding U₆₄. The clause's support looks like "contains no copy of K", which
the exclusion does prove. A question for whoever owns G56's wording.

**Proposed § B index lines** (the theorem-tracking rule is for milestones; TC1 is none, so whether to file these is Keryx's call):

```text
| TC1-SQRT3-DYADIC | TC1 | over a number field with √3 and without i, no place above 2 ramifies in F(i), and a place above 2 splits there iff its residue degree is even; a non-split one has norm 2^f, f odd, never 64 | hand; one mind | `plans/WORKFLOW3-TC1-theory-corrections.md` TC1-SQRT3-DYADIC | declined |
| TC1-DEGREE-BELOW-12 | TC1 | below degree 12 a place above 2 not split in F(i) is ramified there or inert of norm ≤ 32 | hand; one mind | `plans/WORKFLOW3-TC1-theory-corrections.md` TC1-DEGREE-BELOW-12 | declined |
| TC1-STANDING-FOUR | TC1 | over a multiquadratic field, or one of degree ≤ 11, a standing 2-adic wall four-colours the plane | derived; one mind | `plans/WORKFLOW3-TC1-theory-corrections.md` TC1-STANDING-FOUR | declined |
| TC1-STANDING-FIVE | TC1 | K·E₇ (E₇ the septic subfield of ℚ(ζ₂₉)) contains K, keeps its wall at two places inert of norm 128, has L ≥ 7, and given MR needs five | derived (PARI exact); one mind; given MR | `plans/WORKFLOW3-TC1-theory-corrections.md` TC1-STANDING-FIVE | declined |
```

## Stage 3 — SAVED: the front page's audit with the drafts substituted

Copies made by `python3 data/workflow3/tc1/tc1_apply.py` (all sixteen drafts; the copies are not committed, since the script rebuilds
them and a second LEDGER.md in the tree would pollute every later grep). Every exit status was read directly. The summary lines are in
`data/workflow3/tc1/audit-summary.txt`.

- **Baseline, the files as they stand:** `python3 tools/claude_md_fact_audit.py`, exit 0: `AUDIT PASSED`, `dangling: none`,
  CLAUDE.md 70,055 of 80,000 bytes.
- **The brief's form:** `python3 tools/claude_md_fact_audit.py --new data/workflow3/tc1/copies/CLAUDE.md`, exit 0: `AUDIT PASSED (0
  failure(s))`, `pointers: 108 distinct row references, 87 grokkings; dangling: none`, 70,396 of 80,000 bytes, no fact token lost.
- **The whole corpus with all three copies in place** (a local clone with the copies at their real paths, so the tool's HEAD side is
  the real files), exit 0: `AUDIT PASSED`, `dangling: none`, CLAUDE.md 70,396 of 80,000, the grokkings 162,397 of 200,000 bytes.
  *A mistake of mine, recorded:* my first run passed the copies through `--ledger` and `--also`. The tool then reads those same paths
  at HEAD for the old side, where they do not exist. Its old corpus fell to 387,493 bytes against the baseline's 1,089,233, and it
  failed on "grokking G21 status tag changed: None -> [method]". That run measured my invocation, not the drafts; the clone run
  replaces it.
- **Repeated runs:** `--dupes` on the files as they stand and `--dupes --new <copy>` print the same, `23 repeated runs of >= 10 words,
  1,781 bytes`, both exit 0. A first draft of item 1 added one run ("ramified in F(i) or inert there of norm at most 32 (row", which
  the theory paragraph already says). It now says "each place above 2 splits in F(i) or is inert there of norm 64 or more", the same
  condition stated positively.
- **The plant fires:** `TC1_FAULT=1 python3 data/workflow3/tc1/tc1_apply.py` writes item 1 with `(row 199)` for `(row 123)`. The
  brief-form audit on it exits 1: `FAIL: dangling pointer: row 199 is cited and no such entry exists`, `AUDIT FAILED (1 failure(s))`.
  The clean copies were then rebuilt.

**The controls behind the verdicts**, each seen to fire:
- TC1-FIELDS, in the derivation gate: `CHECK: PASS`, and `CHECK: FAIL [0, 1, 1, 0, 1, 0, 0, 0]` with its fault planted.
- A syntax error planted inside its check block prints `CHECK: FAIL 0`. Found on the way: gp exits 0 after an error, and an unparsed
  block once printed PASS. The block is now braced, with `ok` set to 0 first.
- The quotation check: 7 of 7 found; with the misquote planted, 6 of 7.

`python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/WORKFLOW3-TC1-theory-corrections.md`: `GATE: PASS (0 failures, 2
warnings)`. The warnings are the two entries whose prior art is marked owed, a standing finding.
