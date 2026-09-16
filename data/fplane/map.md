# The field-to-prime map

*Rebuilt 2026-09-15 (FS-53). Read the two notes before the table.*

**The `6-open` label is now weaker than it sounds, and every field carrying it has local bound ≥ 7.**
It was minted when "no usable prime's plane is five-colourable" was the strongest thing known. Since
FS-50 and FS-53, six colours are refused by exact certificate at 83 and by Weil from 98 upward, and
every `6-open` row here has smallest usable prime 83 or larger. So for K(√7), K(√13), K(√79),
K(√127), de Grey's field and K(√5,√7,√247) the residue method now yields **7 and never 6**:
L(K(√7)) = 7 is the sharp statement, and the others are ≥ 7.

**Consequently no field that this project has ever built in can have local bound 6** — each is
4-sealed, 5-sealed, or ≥ 7 — which is G56's reciprocity exclusion seen from the field side: every
one of them contains ℚ(√3,√11), and 3 or 11 is a non-square at every window member.

**Which field would a six-colouring at q buy?** The smallest field — by discriminant, over every number
field — whose FIRST usable residue plane is a window member *and* whose 2-adic wall is broken (the second
condition is what makes it worth anything: a field with the wall standing is four-colourable by the residue
at 2). Found by complete enumeration, not by this generator (`tools/fs54_fields.gp`, PARI `nflist`, FS-54):
**23 → ℚ(√167); 27 → the cyclic cubic field of conductor 13 (x³ − x² − 4x − 1, disc 169, the smallest of
all five); 31 → the cyclic quartic x⁴ − 30x² + 45 (disc 1125), smallest quadratic ℚ(√1055); 43 → ℚ(√4703);
47 → ℚ(√2351).** They are the rows tagged `[smallest, sees q]` at the bottom, added by hand from that
script's output. The rows tagged `[sees q]` above them are biquadratic fields that also see their member
first but are not the smallest. *Correction record: this note first said those biquadratic fields were the
smallest and that one radicand could not do it, and it proposed ℚ(√3, α), α³ = α + 1, for 27 — which has a
usable plane at 11. The earlier search stopped at small radicands.*

**Quadratic fields whose local bound is at least 6** (`tools/fs54_quadratic_fields.gp`,
`data/fs54/quadratic-fields.out`): with d ≤ 30,000, sixteen real quadratic fields have the wall broken and
no usable plane in {3, 7, 11, 19, 23, 31}, and every one has 43 or 47 usable, every other usable plane being
≥ 7. Their local bound is **6 exactly when a usable one of 43, 47 is six-chromatic**, and ≥ 7 otherwise.

**What is at stake at the two decisive planes.** Five is refused by certificate at 43 and 47, so a
verified six-colouring at either is that plane's exact chromatic number, and it makes **χ(ℚ(√4703)²) ≤ 6
a theorem** (and at 47 also χ(ℚ(√2351)²) ≤ 6) — the first number field with local bound exactly 6,
predicted 6 by the conjecture. **Both deciding planes are implausible on the measurements** (`data/fs53/CLOSE.md`, `data/fs53/README.md`): six at 47 needs the certificate to be 99.4 % tight, a tightness seen only at q = 7; at 43 every instrument came back empty — the independent set stuck at 258 against the 309 six needs through over three hours aimed at exactly that, the six-colour search stalled at 1,016 monochromatic edges for 2 h 52 m, the equivariant sweep 0 of 21. These are nulls at a budget, not refusals; but they mean these fields most likely have local bound ≥ 7, where the conjecture's bold form predicts seven, and their six rests on a plane the evidence argues against.

| field | radicands | 2-adic wall | usable primes | verdict |
|---|---|---|---|---|
| Q | [] | stands | [3, 7, 11, 19, 23, 31, 43, 47] | sealed-at-3 (p = 3, chi-p3); Theorem B: ≤ 4 as well |
| Q(√2) | [2] | stands | [7, 23, 31, 47, 71, 79, 103, 127] | sealed-at-4 (Theorem B: the 2-adic wall stands); the sieve agrees at p = 7 |
| Q(√3) | [3] | stands | [3, 11, 23, 47, 59, 71, 83, 107] | sealed-at-3 (p = 3, chi-p3); Theorem B: ≤ 4 as well |
| Q(√5) | [5] | stands | [11, 19, 31, 59, 71, 79, 131, 139] | sealed-at-4 (Theorem B: the 2-adic wall stands) |
| Q(√7) | [7] | broken | [3, 7, 19, 31, 47, 59, 83, 103] | sealed-at-3 (p = 3, chi-p3) |
| Q(√11) | [11] | stands | [7, 11, 19, 43, 79, 83, 107, 127] | sealed-at-4 (Theorem B: the 2-adic wall stands); the sieve agrees at p = 7 |
| K = Q(√3,√11) | [3, 11] | stands | [11, 83, 107, 131, 167, 227, 239, 263] | sealed-at-4 (Theorem B: the 2-adic wall stands) |
| K(√5) | [3, 5, 11] | broken | [11, 131, 239, 359, 431, 479, 491] | sealed-at-5 (p = 11, chi-p11) |
| K(√7) | [3, 7, 11] | broken | [83, 131, 167, 227, 479, 503, 563] | 6-open (every usable prime's plane refuses five: spectral for p ≥ 67, records below) |
| K(√13) | [3, 11, 13] | broken | [107, 131, 263, 347, 491, 503, 563] | 6-open (every usable prime's plane refuses five: spectral for p ≥ 67, records below) |
| K(√23) [T20b] | [3, 11, 23] | broken | [11, 83, 107, 227, 263, 359, 431, 479] | sealed-at-5 (p = 11, chi-p11) |
| K(√35) | [3, 11, 35] | stands | [107, 131, 263, 347, 479] | sealed-at-4 (Theorem B: the 2-adic wall stands) |
| K(√79) | [3, 11, 79] | broken | [107, 227, 359, 491, 503] | 6-open (every usable prime's plane refuses five: spectral for p ≥ 67, records below) |
| K(√127) | [3, 11, 127] | broken | [83, 167, 239, 347, 359, 491, 563] | 6-open (every usable prime's plane refuses five: spectral for p ≥ 67, records below) |
| K(√247) [T20, W] | [3, 11, 247] | broken | [11, 83, 107, 239, 359, 479, 563] | sealed-at-5 (p = 11, chi-p11) |
| K(√5,√247) | [3, 5, 11, 247] | broken | [11, 239, 359, 479] | sealed-at-5 (p = 11, chi-p11) |
| Heule Q(√3,√5,√11) | [3, 5, 11] | broken | [11, 131, 239, 359, 431, 479, 491] | sealed-at-5 (p = 11, chi-p11) |
| de Grey Q(√3,√5,√7,√11) | [3, 5, 7, 11] | broken | [131, 479] | 6-open (every usable prime's plane refuses five: spectral for p ≥ 67, records below) |
| K(√5,√7,√247) | [3, 5, 7, 11, 247] | broken | [479] | 6-open (every usable prime's plane refuses five: spectral for p ≥ 67, records below) |
| Q(√2,√31) [sees 23] | [2, 31] | broken | [23, 31, 79, 127, 151, 167, 199, 223] | open-pending (p = 23: its plane is undecided) |
| Q(√5,√51) [sees 31] | [5, 51] | broken | [31, 59, 79, 139, 179, 191, 199, 211] | open-pending (p = 31: its plane is undecided) |
| Q(√10,√23) [sees 43] | [10, 23] | broken | [43, 67, 79, 83, 107, 191, 199, 227] | open-pending (p = 43: its plane is undecided) |
| Q(√7,√89) [sees 47] | [7, 89] | broken | [47, 131, 139, 167, 199, 223, 227, 251] | open-pending (p = 47: its plane is undecided) |
| Q(√2,√3,√7) [sees 47] | [2, 3, 7] | broken | [47, 167, 311, 383, 479, 503] | open-pending (p = 47: its plane is undecided) |
| Q(√2,√3,√31) [sees 23] | [2, 3, 31] | broken | [23, 167, 239, 263, 383] | open-pending (p = 23: its plane is undecided) |
| Q(√167) [smallest, sees 23] | [167] | broken | [23, 43, 59, 67, 71, 79, 83] (below 100) | open-pending (p = 23: its plane is undecided) |
| Q(√1055) [smallest quadratic, sees 31] | [1055] | broken | [31, 43, 47, 83] (below 100) | open-pending (p = 31: its plane is undecided) |
| x⁴ − 30x² + 45, cyclic quartic, disc 1125 [smallest, sees 31] | not multiquadratic | broken (fixed prime above 2 of norm 16) | [31, 59] (below 100) | open-pending (p = 31: its plane is undecided) |
| Q(√2351) [smallest, sees 47] | [2351] | broken | [47, 67, 71, 83] (below 100) | local bound ≥ 6; exactly 6 iff UD(F_47,2) is six-chromatic |
| Q(√4703) [smallest, sees 43] | [4703] | broken | [43, 47, 79] (below 100) | local bound ≥ 6; exactly 6 iff UD(F_43,2) or UD(F_47,2) is six-chromatic |
| x³ − x² − 4x − 1, cyclic cubic of conductor 13, disc 169 [smallest, sees 27] | not multiquadratic | broken (2 inert; fixed prime above 2 of norm 8) | [27, 31, 47, 79, 83] (below 100) | open-pending (q = 27: its plane is undecided) |
