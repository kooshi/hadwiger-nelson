# Handoff — consolidation package P2 (FS-25 items E4, E3, E5)

*Written 2026-09-09 by de Bruijn, for a reader with no memory of this work. Branch
`consolidate/p2`, worktree `/home/kooshi/source/lean-wt-p2`.*

---

## 1. What landed

Three of the six items in `plans/STUB-explain-the-unexplained.md` — the milestone whose subject is
*places where this project's record established something by listing instances when a theorem was
available* — were worked out, and **each of the three turned up something the stub had wrong**. The
full write-up is `plans/FS25-P2.md`; the stub's three sections carry short banners pointing at it,
with their original text left underneath.

Nothing was written in Lean and nothing was built. The package is mathematics on paper plus
verification against the repository's own committed data; §4 below says why, and §5 lists the Lean
statements it leaves as candidates.

### 1.1 E4 — de Grey's graph forces no pair of vertices to share a colour at five colours, by theorem

The project's record reports this as a completed exhaustive sweep of 1,248,990 vertex pairs
(milestone M48, recorded in grokking `G31`). Half of it — the "forced to be the *same* colour" half
— was measuring a theorem this repository has held since milestone M54.

**The stub's proposed argument does not survive, and that is the item's first finding.** It wanted
to take three "critical" vertices (vertices whose deletion makes the graph 4-colourable) from
grokking `G10`'s *"two edges PROVEN critical end-to-end"*. That claim is real, but **its witnesses
are not on disk**: the probes behind it were run ad hoc during milestone M30, their outputs lived
under the untracked `build/` directory, and the record never names which edges they were. A theorem
resting on it would carry the status *"measured, witness lost"*.

**It was replaced by a better input, which needs no solver.** De Grey's graph is a **1-sum**: two
791-vertex halves meeting in the single vertex `14`, plus one edge `(11, 802)` between them, and
**every one of its 7,877 edges lies inside a half or is that one edge** — re-derived here from the
exact-arithmetic generator and checked exhaustively, zero exceptions. From that shape the three
seam vertices `11`, `802` and `14` are critical by a palette permutation, using only the fact that
each half is 4-colourable — which was verified end to end here, with the three resulting colourings
committed at `data/e4-critical-vertices.json` and re-checked edge by edge by code sharing nothing
with the search. Three critical vertices contradict the kernel theorem's cap of two, so no pair is
forced.

**And the second finding is a correction to my own work**: the seam's forcing structure — *every
proper 4-colouring of half A gives vertices `14` and `11` the same colour*, likewise `14` and `802`
in half B, and `(11, 802)` is an edge — is **milestone M06's own argument, already kernel-checked**
(`plans/M06-chi-ge-five.md:102`; `Instances/DeGrey/Forcing.lean:35–72`). I re-derived it with two
solver calls before noticing. It is recorded as a re-derivation, not a discovery, because writing it
up as a find would have been exactly the failure mode this milestone exists to catch.

**What does not promote, and it must be said in the same breath**: the *virtual-edge* half of that
sweep (pairs forced to differ) is **not** implied — its bound is the size of a neighbourhood union,
at most 120 here, so it would need about 121 more solver asks or a full edge-criticality sweep. And
**arity 3 and arity 4 are untouched**: M48's 3.3-billion-question triple sweep keeps its full value.
Only the pair layer's forced-equal half collapses.

### 1.2 E3 — the periodic quotient of a finite Euclidean plane is one explicit circulant

Milestone M61 showed that every *periodic* colouring of the finite plane over `𝔽_p` is a colouring
of a circulant graph on `p` vertices, then computed that circulant's chromatic number **one prime at
a time with a SAT solver**. It never says which circulant.

It is `Cay(ℤ/p, D)` with **`D = { t : t² − 4ν is a non-square mod p }`** for any fixed non-square
`ν` — equivalently, the traces of the elements of `𝔽_{p²}` of norm `ν`. Verified here **against the
direct construction at eight primes** (build the real circle, find every line missing it, project
along each, compare) and against M61's own chromatic and independence numbers at the seven primes
where its table is exact. The record's unexplained *"`0 ∉ D`"* falls out in one line: `−4ν` is a
square precisely because `p ≡ 3 (mod 4)`.

**The payoff is exact and is smaller than the stub hoped.** The circulant's eigenvalues are
*literally half* the finite plane's own, so they are the same Kloosterman-sum family and inherit the
same Weil bound. Hoffman's inequality then gives `χ(C_p) ≥ 6` for every `p ≥ 67` with no
computation, and the exact spectrum adds `p = 59` — **so the registered prediction that
`χ(C_p) ≥ 6` for every `p ≥ 23`, currently "measured to 71", becomes a theorem plus four small
finite checks at 23, 31, 43 and 47**, each a SAT instance on at most 376 variables and genuinely
kernel-promotable. It does **not** become a bound proved outright; the stub rated that *medium*
confidence and was right.

Two corrections to the stub's phrasing: *"traces of the non-split torus"* is loose (the norm-`ν`
fibre is a coset, not a torus, and `ν` must be a non-square), and the observation that the circulant
is a **power of a cycle** stops at `p = 11` — at `p = 19` no dilation makes it one.

### 1.3 E5 — the 16-pair residue is the exponent of a group of order four

On a 1,953-point object drawn in the field `K = ℚ(√3, √11)`, an algebraic method forces 187 pairs of
points to share a colour at four colours while the solver forces 171, and the record calls the
16-pair gap *"the non-additive residue"* and asks whether they are two recolouring-moves apart.

**Every number was re-read from the committed artifact rather than from the prose, and they check
out**: the 16 sit at distances `8/3` (13 of them) and `8/√3` (3), exactly the two distances at which
`[Parts2020a]`'s Table 1 records minimal gadgets, at which our own rigidity dial forces pairs on this
same object, and at which the Polymath16 wiki recorded a monochromatic pair in 2018.

**One correction to the stub**: it says those distances are *"forced on three other objects and not
on `U`"*. They **are** forced on this object — **171 of the 189 pairs at those two distances**, and
no pair at any other distance is forced at all. The 18 that are not forced were then measured to be
the peripheral, thinly-surrounded ones: no forced pair lies further than 3.212 from the object's
centroid and five of the eighteen lie beyond that, with median local density 530 against 742. It is
a tendency, not a separator — three of the eighteen sit in dense interior — and the write-up says so.

**The theorem underneath is simpler than the stub expected, it was already in the kernel, and — the
prior-art gate's finding — its main half is Fischer's from 1990.** An algebraic ("additive")
colouring is a homomorphism from the object's difference lattice into a group of `k` elements; since
`k` times anything in a group of order `k` is zero, everything in `k·Λ` gets one colour. At four
colours that means **every additive four-colouring, of every object, over every field, identifies
every pair whose difference lies in `4Λ`** — a floor, not a coincidence. **That much is
`[Fischer1990]`'s own central obstruction, checked in our copy of his paper, and it is on the
Polymath16 wiki from 2018; no novelty is claimed for it.** The refinement that is not published is
that the bound is the group's **exponent** rather than its order, so a non-cyclic target sees one
level further. Three
things follow: the "depth 2" boundary needs no identification of the six exotic colourings the stub
wanted to identify; the valuation law (kernel-checked, and the source of the weaker "depth ≥ 1"
condition) is exactly the **exponent-2 member** of the same family, which is the whole of the
one-level gap; and the 16 residue pairs sit at depth 3, where every additive colouring is blind **by
theorem** — so the record's open question about them is a question about recolouring moves and
cannot be answered by arithmetic. That last one is a genuine negative and it redirects the work.

---

## 2. The amendments I would have made to `CLAUDE.md`

*`CLAUDE.md` belongs to package P1 and then to the coordinator, so these are quoted rather than
applied. The house rule is followed: amend in place, keep what was measured, add what is now proved.*

### 2.1 Grokking `G31` (`CLAUDE.md:2603`) — insert after the `**[measured, complete; the bracket is kernel]**` clause, before the italicised *"The consequence for the from-below hunt…"*

> **AMENDED 2026-09-09 (FS-25 item E4, consolidation package P2): the arity-2 line's forced-equal
> half is a COROLLARY, and the sweep was measuring a theorem.** `CriticalSet.encard_criticalSet_le_two_of_forces`
> (M54, kernel) caps at **two** the critical vertices of any injectively drawn unit-distance graph
> that forces a pair equal at its own chromatic number — and de Grey's 1581 has at least **three**,
> because it is a **1-sum**: two 791-vertex halves meeting only at vertex `14`, plus the single cross
> edge `(11, 802)`, with all 7,877 edges verified to lie inside a half or be that edge. Deleting `11`
> or `802` removes the only crossing edge and leaves a 1-sum of two 4-colourable halves; deleting `14`
> leaves them joined by that edge alone; each glues by one palette permutation. The three 4-colourings
> are held at `data/e4-critical-vertices.json`, each re-verified edge by edge, with both halves shown
> to refuse three colours as the red. **So `Forces` is empty on all 1,248,990 pairs by theorem.**
> **What does NOT follow: the virtual-edge half** (its localization bounds the critical set by
> `|N(p) ∪ N(q)| ≤ 120`, so it needs ~121 four-colour asks or the full edge-criticality sweep), **and
> nothing at arity 3 or 4** — M48's 3,286,925,350-question triple sweep and its 25,782,585-question
> neighbourhood sweep keep their full value. The measurement is not retracted; it is re-labelled.
> `plans/M54-five-colour-dial.md:419` had already run this argument for the *other* witness and it
> was never carried back. `plans/FS25-P2.md` §1.

### 2.2 Grokking `G10` (`CLAUDE.md:2043`) — append to the bracketed status clause

> **SCOPE NOTE 2026-09-09 (FS-25 item E4): three of this graph's critical vertices are structural,
> not evidence.** `11`, `802` and `14` — the endpoints of the single cross edge and the shared vertex
> — are critical because the graph is a 1-sum, by a palette permutation and no search
> (`plans/FS25-P2.md` §1.5). The random single-edge probes behind this entry almost certainly never
> hit that seam (one edge in 7,877) so the *"distributed, not organ-like"* reading is untouched — but
> any re-run of the probe should exclude the seam and say so, and **the two edges this entry calls
> "PROVEN critical end-to-end" have no witnesses on disk**: the probes were ad hoc, their artifacts
> lived under the untracked `build/`, and the record does not name the edges. Treat that clause as
> *measured, witness lost* until re-run.

### 2.3 Grokking `G41` (`CLAUDE.md:3119`) — insert a new amendment paragraph above the existing FS-18 one

> **AMENDED 2026-09-09 (FS-25 item E5): the additive localization has a FLOOR, it is Fischer's own
> obstruction read as a bound on what the family can DISTINGUISH, and the exponent refinement is
> what reconciles it with the valuation law.** An additive colouring is a homomorphism `φ : Λ → G`
> with `|G| = k`; since `k · G = 0`, `kΛ ⊆ ker φ`. **That much is `[Fischer1990]`'s central
> obstruction** — verified in our own copy, where he uses `k · v(1/k) = v(1) ≠ 0` against `k · G = 0`
> at least three times — **and is restated on the `[Polymath16wiki]` (2018) as "a linear `k`-coloring
> is always periodic with period `k`", and used live in the 2018 blog threads at `k = 5, d = 5/3` and
> at `k = 4, d = 8/3`; no novelty is claimed for it.** What this repository adds is the *sharper*
> form its own kernel already carries (`Additive.addMonoidHom_apply_eq_of_sub_eq_exponent_nsmul`):
> the bound is the **exponent**, not the order, so a non-cyclic target sees one level further. At
> four colours `G` is `ℤ/4` or `ℤ/2 × ℤ/2`, so **`4Λ ⊆ F_add` for every object over every field: no
> additive four-colouring can ever separate a pair of 2-adic depth `≥ 2`.** Three consequences. (i) `T26`'s measured `F_add = {depth ≥ 2}` on
> `K`-fabric is the floor **attained**, not a property of that object — the six `ℤ/4` colourings are
> needed only for the reverse containment, which the artifact confirms (all 12,906 depth-1 pairs
> separated additively). (ii) **The valuation law of ledger row 59 is the exponent-2 member of this
> same family** — the residue colouring's target is the additive group of `𝔽₄`, exponent 2, so it
> sees only `2Λ`, i.e. depth `≥ 1` — and the one level between the two necessary conditions is
> exactly that exponent gap, structural rather than an artefact. (iii) The 16-pair residue sits at
> depth 3, where **every** additive four-colouring is blind by theorem, so `T26`'s question about it
> is a question about the reconfiguration graph and no arithmetic in this family can answer it.
> The general form is free: at `k` colours the floor is `kΛ`, which is exactly what
> `AdditiveRigid.forces_of_additivelyRigid` consumes at five — M56 and M57 use one lemma from
> opposite sides. `plans/FS25-P2.md` §3.

### 2.4 Ledger — no new row is proposed

None of the three items is new mathematics and none should be sold as such. E4 is a re-labelling of a
measurement; E3 is an identification of one of our objects with a classical one, whose spectral half
is Li–Feng (1992); E5 is a reading of a lemma the kernel already holds. **If the coordinator wants a
single Frontier sentence**, this is the one I would offer:

> **FS-25's first three items (package P2, 2026-09-09): the 1581's zero forced-equal pairs at five
> colours is a corollary of M54's critical-set cap — de Grey's graph is a 1-sum and its seam gives
> three critical vertices where the theorem allows two, so a 1,248,990-pair sweep was measuring a
> theorem (the virtual-edge half and arity 3–4 keep their value); M61's periodic quotient is
> `Cay(ℤ/p, {t : t² − 4ν a non-square})`, verified against the direct construction at eight primes,
> with spectrum literally half the plane's — which turns the registered `χ(C_p) ≥ 6` prediction into
> a Weil theorem for `p ≥ 67` plus four small checks; and M56's 16-pair "non-additive residue" is the
> exponent of a group of order four (`4Λ ⊆ F_add` always), which makes the valuation law that family's
> exponent-2 member and puts the residue at a depth no additive colouring can reach.**

---

## 3. Bibliography additions (`BIBLIOGRAPHY.md` belongs to package P1)

Found by the prior-art gate on item E3. None is held here; all are named-only unless marked.

| key I would use | work | why it matters to us | read? |
|---|---|---|---|
| `[LiFeng1992]` | W.-C. W. Li and K. Feng, *Character sums and abelian Ramanujan graphs*, J. Number Theory **41** (1992) 199–217 | Contains the **character sum over the norm-one torus of `𝔽_{q²}` with the `≤ 2√q` Weil bound**, under the name *twisted generalized Kloosterman sum*. This is `plans/FS25-P2.md` §2.4's spectral bound as a citation rather than a derivation, and it is also the natural citation for M58's own Kloosterman eigenvalues. | not obtained |
| `[BardestaniMallahiKarai2017]` | M. Bardestani and K. Mallahi-Karai, *On a generalization of the Hadwiger–Nelson problem*, Israel J. Math. (2017), arXiv:1507.05300 | Borel chromatic number of quadratic-form graphs over **local fields**; infinite iff the form is isotropic. The nearest thing found to "periodic colourings of these planes", and the closest neighbour to our own field arc on the analytic side. | not obtained |
| `[Salie1931]` / `[Katz1988]` | H. Salié (1931); N. Katz, *Gauss Sums, Kloosterman Sums, and Monodromy Groups*, Ann. Math. Studies 116 (1988) | The classical and the modern framing of "Kloosterman sum = character sum over the elliptic torus of the conic" — i.e. of the identification in §2.4. Katz Ch. 4 is where a specialist would look; **not verified by us**, reported as a lead. | not obtained |
| — | *Chromatic numbers of circulants with indispensable generators*, arXiv:2607.23841 | Checked and **ruled out** as prior art for E3: it treats a fixed small generator set, not one of size `(p+1)/2`. Recorded so the negative is auditable. | abstract + structure only |
| `[Heule2021b]` | M. Heule, *Easier variants of notorious math problems*, Nieuw Archief voor Wiskunde 5/22(3) (2021) 153–157 — **free on the author's page, cs.cmu.edu/~mheule** | States the odd-distance virtual-edge rule in his own words as an unexplained empirical surprise. **This is a citable, open-access substitute for the paywalled `[Heule2021]` Geombinatorics paper**, which nobody has been able to obtain — it should be added beside that row. | not obtained, but freely obtainable |
| *(no key — a blog thread)* | Jannis Harder, Polymath16 blog, 2018, reported by Tamás Hubai (9 May 2018) and used by Philip Gibbs (6 May 2018) | **The earliest known instance of the valuation law's phenomenon**: that `8/3` is monochromatic in every 4-colouring of the Moser ring. Predates `[Heule2019]`, `[PartsOdd2022]` and `[Ducz2026]`, and it is the distance carrying 13 of item E5's 16 residue pairs. Ledger row 59's provenance list should gain it. | thread text held at `~/source/library/notes/polymath16-threads-1-18-text.txt` |
| *(no key — a wiki page)* | Polymath16 wiki, **"Coloring R_2"** | An unfinished draft attempting a **rigidity** proof for the `ℚ(√−3)` analogue of Theorem B's mechanism — residue field `𝔽₄` at a conjugation-fixed prime above 2, Frobenius = conjugation, built on the square root of the Moser twist — stopping mid-argument at "Corollary 9". **This is the closest anyone has come to attempting Theorem B's argument rather than its statement, and it belongs in FS-20's related work.** Not previously known to this project. | not obtained (offline; Internet Archive) |

Also worth a `§C` line: **`arXiv:2503.01721`** (Lorenz–Zimmermann's diameter/girth sibling to
`[LorenzZimmermann2023]`) was opened during the gate and confirmed to stay on the full vector space,
never the quotient.

---

## 3a. Two things I found that belong to other work

* **A transcription discrepancy in ledger row 59, which is not my item.** Two independent search
  threads read `[Parts2020a]`'s Table 1 differently: the 214-vertex row as `3` versus `√3`, and the
  312-vertex row as `1/3` versus `1/√3`. Both were reading automated PDF extractions, which is
  exactly where a root sign vanishes. **Ledger row 59 quotes `3` and `1/3`.** The two
  *monochromatic* rows (`8/3` at 367 vertices, `8/√3` at 421) are **not** disputed, so item E5 is
  unaffected and so is the law's mono side — but the row should be checked against the actual table,
  and the check is one PDF away. *(The prediction is probably unchanged either way: `3` and `√3`
  have the same 2-adic valuation at the prime in question, as do `1/3` and `1/√3`.)*
* **The Polymath16 wiki has a page nobody here has seen, and it bears on FS-20 (the paper).** Titled
  **"Coloring R_2"**, it is an unfinished, careful draft attempting a *rigidity* proof — not merely
  exhibiting a colouring — for the `ℚ(√−3)` analogue of Theorem B's own mechanism, using the residue
  field `𝔽₄` at a conjugation-fixed prime above 2 with Frobenius equal to complex conjugation, built
  around the square root of the Moser-spindle twist. It stops mid-argument at "Corollary 9" with no
  conclusion. **This is the closest anyone has come to attempting Theorem B's actual argument**, as
  opposed to posing its question, and FS-20's related-work section should read it before it is
  finalised. The page is offline; the Internet Archive has the wiki.

---

## 4. What I did NOT do, and why

* **No Lean.** The package was scoped as paper work, and correctly: two of the three items would
  touch files (`Additive.lean`, `CriticalSet.lean`) that other packages may own this round, and the
  worktree turned out to have **no `.lake` directory at all** — the pre-warmed build cache the shared
  briefing describes was not created for `lean-wt-p2`, so `./scripts/build.sh` could not have run
  here. Nothing was attempted and nothing is broken; the coordinator should know the cache is absent
  if this branch is ever built in place.
* **The virtual-edge half of E4 was not closed.** It needs ~121 four-colour solver asks on
  1,580-vertex instances, or the exhaustive edge-criticality sweep priced at about a day of processor
  time. Either is affordable; neither is this package.
* **`χ(C_p)` at `p = 23, 31, 43, 47` was not kernel-promoted.** These are the four rows that would
  finish E3's prediction, and they are small enough to `decide`. Left as the natural follow-on.
* **The `p = 47` chromatic number was capped, not decided**, by my own run (cadical, 300 s), and is
  reported as a cap. M61's table reads `[9, 10]`; my run is consistent with it and adds nothing.
* **`T26`'s actual question — are the 16 pairs two Kempe swaps away? — was not answered.** What E5
  contributes is the proof that no *arithmetic* in the additive family can answer it.
* **Items E1, E2, E6, E7 of the stub were not touched.** E1 belongs to package P4; the others are
  held back.

---

## 5. Lean statements this leaves as candidates, in descending value

1. **The 1-sum colouring lemma.** *If `V(G₁) ∩ V(G₂) = {v}` and no edge joins the parts, then `G` is
   `k`-colourable iff both parts are*, for `k ≥ 1`; and *two `k`-colourable graphs joined by a single
   edge are `k`-colourable* for `k ≥ 2`. Classical (the block decomposition), apparently absent from
   Mathlib, and it is exactly what E4's argument consumes. **Belongs in a new leaf module**, per the
   build discipline.
2. **The exponent floor, packaged.** `Additive.addMonoidHom_apply_eq_of_sub_eq_nsmul` already proves
   it; what is missing is the consequence stated in the compulsion vocabulary — *no additive
   `k`-colouring separates a pair whose difference lies in `kΛ`* — beside the existing
   `not_separated_of_addMonoidHom`. Ten lines. **This one is squarely inside `Additive.lean`, which
   another package may own; coordinate before touching it.**
3. **The circulant identification.** A real number-theory milestone rather than a lemma. It should
   wait for its consumer, which is the four-row finite check in §4 above.

---

## 6. Files this package changed

| file | what |
|---|---|
| `plans/FS25-P2.md` | **new** — the whole write-up, including the `§PA` prior-art gate |
| `plans/STUB-explain-the-unexplained.md` | three status banners inserted under the `E3`, `E4`, `E5` headings; original text untouched beneath them |
| `plans/HANDOFF-p2.md` | **new** — this file |
| `data/e4-critical-vertices.json` | **new** — the 1581's 1-sum structure and three verified 4-colourings, one per critical vertex |
| `tools/fs25_e4.py` | **new** — regenerates the above from `tools/degrey_graph.json`, with `--red` running the negative controls (both halves refuse three colours; a planted corruption is caught; the degree-≤3 control is reported as an empty population) |
| `tools/fs25_e3.py` | **new** — checks the circulant's closed form against the direct construction at eight primes, with `α`, `χ` and (under `--hoffman`) the exact spectral bound out to `p = 131` |

`tools/degrey_graph.json` and `tools/degrey_cert.json` were regenerated by
`python3 tools/degrey.py` and are gitignored, as intended.

**A note for whoever merges**: the three banner insertions in
`plans/STUB-explain-the-unexplained.md` sit at the `E3`, `E4` and `E5` headings. Package P4 owns item
`E1` in the same file, whose section ends immediately above the `E3` heading. If the merge conflicts,
the banners are self-contained blocks and can be re-applied by hand from this file's §1.
