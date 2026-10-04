# FS129-MA2 — pass 2 of the cross-application audit, lane A (the arithmetic era), second part: the record

*Job FS129-MA2, brief `data/fs129/briefs/FS129-MA2-pass2.md`; a `general-purpose` agent on Opus reading Ephodos's identity
(`.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the workflow` to its end). Plan:
`plans/FS129-cross-application-audit.md` § 3 Stage 3. Continues FS129-MA1 (`plans/FS129-MA1-audit.md`, its § 5.4 the starting list). Writes
only this file, `data/fs129/ma2/`, `tools/fs129_ma2_*.py` and `data/fs129/reports/FS129-MA2.md`. Started 2026-10-04 00:07 UTC. A successor,
FS129-MA3, continues from the last SAVED stage (`plans/FS129-close-inventory.md` item 52).*

## Theorems this phase proved

Each `derived`, one mind, prior art owed; handoff de Bruijn.

- **FS129-MA2-FALC-DICHO** — a Falconer fan at five colours has χ(H) ≥ 4, and when χ(H) = 4 it forces its apex and tip equal at four colours (so in
  any four-colourable host it is a four-colour forcer). [hand] — § 2.2
- **FS129-MA2-FALC-GAP4** — a Falconer fan at five colours has no homomorphism into a graph with a proper four-colouring gapped at the tip's image
  (MA1's FALC-T clause (3) at the class its argument carries). [hand, control FS129-MA2-GAPK] — § 2.2
- **FS129-MA2-FALC-HOSTS** — no Falconer fan at five colours over a real number field with a usable prime of residue field 𝔽₃ or 𝔽₇ or a dyadic place
  ramified in F(i), nor in a lattice with a gapped four-colourable quotient; in de Grey's lattice t − a ∈ 8Λ; over ℚ(√59), ℚ(√83), ℚ(√131),
  t − a ∈ R ∩ 𝔓⁴ and one fan would make every four-colouring of the plane periodic (row 88). [derived from the two above, rows 78, 88; control
  FS129-MA2-G7GAP] — § 2.2

## Stage 1 — SAVED (readback, registered expectations)

### 1.1 Readback of the brief's quotations (standing rule 3)

Checked by script, `data/fs129/ma2/readback.py` (exact substring, whitespace normalised), 2026-10-04 00:09 UTC; with `--fault` (a word
appended to every quotation) it reports 5 of 5 mismatches, so it reads the claim.

| quotation | source named | found |
|---|---|---|
| "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." (full text) | `plans/STUB-cross-application-audit.md` § The request | verbatim |
| "1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, … so it'll pick up the latest changes." (full text) | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "Also a note for the whole plan that not only are "hubs" important, but deep "roots", … even if it has only one offshoot" (full text) | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "where else can we use that identity?" | `plans/FS116-close-inventory.md` item 142 | verbatim |
| MA1's method, "take a held composition, … meets the wider hypothesis." | `plans/FS129-MA1-audit.md` § 5.4 note (3) | verbatim |

The brief's item references check: FS-116 inventory items 122 (FS116-Y4 DONE), 124 (the vacuity corrections), 127 (the G83 instance), 142
(Kooshi on V6-HUG); FS-129 inventory items 52 (successive agents) and 70 (the ownership finding: G71 split, G13 two, G54's last paragraph
separate, row 66 under four grokkings). **No mismatch; no finding about the brief.**

### 1.2 What I had read when I registered

The brief; the identity in full and the lane workflow (§ Where you sit to § What leaves your lane); `plans/STANDING-RULES.md`; the plan; the
stub's § Why now, § The question and § Bearing on the answer; `data/fs129/demand-judged.md` §§ 1–2; `plans/FS129-MA1-audit.md` in full and its
report; `plans/FS129-close-inventory.md` items 50–74. **Not yet read:** any grokking body on my list, pass 1's records beyond what MA1 quotes,
the index, any derivation file.

### 1.3 Registered expectations (before reading the corpus; scored at FS129-Z1)

My prior, from MA1's scored registration: the yield in lane A came from reading held compositions at the class their arguments carry, not from
the rarely-cited grokkings, which were mostly retired finite-witness methods. My list is MA1's remainder: by mentions it starts with G1 (the 4/5
wall's mechanism), G21 (a method), G35 (the 2-adic wall), then a long tail of entries cited one to eight times. The tail's mechanisms are
mostly field-level (residue targets, towers, characters, `Θ`-certificates, the local–global theorem's pieces); they can bear unapplied inside
the arithmetic era (a field or target a milestone did not name) more readily than across eras. The regularity era reaches the arithmetic only
through the collapse field and through finite configurations seen by a measurable colouring (pass 1, MA1).

| id | expectation | value |
|---|---|---|
| MA2-E1 | mechanisms I reach in this job (of 47) | expected 28; range 15–47 |
| MA2-E2 | of those reached, mechanisms that bear somewhere unapplied (a composition, a miss, or a near miss with its failing hypothesis named, beyond pass 1's and MA1's) | expected 6; P(≥ 3) = 0.65 |
| MA2-E3 | compositions derived (block entries) | expected 3; range 0–7 |
| MA2-E4 | misses of the FS116-Y4 kind (a milestone worked a step the mechanism would have shortened or emptied) | expected 0.7; P(≥ 1) = 0.4 |
| MA2-E5 | cross-era bearings (a lane-A mechanism on a regularity-era site) beyond pass 1's and MA1's | expected 0.6; P(≥ 1) = 0.35 |
| MA2-E6 | a composition of this pass changes the bearing on the answer (item 31's open list or the top three) | P = 0.05 |
| MA2-E7 | a held result found false on reading | P = 0.03 |
| MA2-E8 | of my mechanisms, the share that are nulls because they are retired finite-witness or search methods | expected 0.3 |
| MA2-E9 | the roots' chains (G74's `Θ₄` layers, G77's torsion local–global theorem) yield a strengthening that travels the chain | P = 0.2 |

These are instruments for G21, never caps.

## Stage 2 — SAVED (the Falconer fan one colour below: G43's plane at 7, G48's tightness, G54's slack face, G68's gapped quotients, G76's type-(B) frame)

*Read for this stage: the bodies of G1, G4, G7, G9, G12, G14, G16, G21, G23, G24, G26, G27, G29, G31, G32, G34–G38, G40–G45, G48, G52, G53,
G57–G65, G68–G70, G73–G76, G79, G80, G2, G3, and G13 and G54 (MA1's, for the two faces the brief names); `LEDGER.md` rows 34–41, 59, 78, 88, 111,
131, 133, 145; `Proofs/HadwigerNelson/Instances/PlaneFreedom.lean` (the plane at 7) and `FanGap.lean`'s `Slack`; `plans/FS89-derivation.md` §§ 2–5
(the lane-A roots); pass 1's lane-A record § 3.2–4.1; the regularity-era reframe tables (`plans/FS107-stability.md`, `FS110-tangency-seam.md`,
`FS111-cone-scale.md`, `FS112-unit-arc-half.md`, `FS114-unit-arc-question.md`) for every grokking on my list; the index's mention contexts
(`data/fs129/ma2/mention-contexts.txt`, written by `data/fs129/ma2/q.py`).*

### 2.0 Ownership received (the coordinator, 2026-10-03, during stage 2)

G2 (construction grammar) and G3 (radially crystal, angularly detuned) are added to my list: lane R's pass 2 reports them lane A's by content,
item 51's majority having come from homonyms (FS-106's `[G2]`, `[G3]` labels; FS-125's open places G1–G3). The same homonym inflates G1's and
G4's counts here: G1's six lane-R mentions are FS-106's gap label `[G1]`, FS-111's condition `(G1)` and FS-116's case list; FS-89's "G1, the
gluing" is a step name; G4's two are FS-106's `[G4]`; G27's FS-56 mentions are a graph named `G27`; G31's M49 mention a graph named `G31`. Both
are audited in stage 3's table.

### 2.1 The mechanism family, and why it comes first

FS129-MA1-FALC-T (`plans/FS129-MA1-audit.md` § 3.1) has three clauses about a Falconer fan at five colours mapped into a target `T`. MA1 drew
its consequences at five colours (Γ₁₁, Γ₁₉, by orbit computations) and two corollaries — no fan over a field with `L ≤ 3`, and the apex–tip pair
forced at four colours in any four-colourable field plane, such as K's. **What its argument uses is less than its clause (3) assumes**: clause (3)
spends two absent colours; the contradiction needs one colour absent everywhere (any four-colouring read as a five-colouring supplies it) and
one gap at the tip's image. So the class the argument carries is every target with a four-colouring gapped at `ρ(t)`, and the record holds such
targets under four of my grokkings, none of them applied to the fan: **G43's plane at 7** (four-colourable, the kernel's `circ7Table`), **G54's slack
face** ("gaps … found at 7, 11, 19"), **G68's gapped quotients** (FS70-T9's hexagonal fabric over ℚ(√3,√5), FS81-T24's 49 lattices over ℚ(√47)), and
**G48's tightness mechanism**, which is the same repaint seen from the field (a pair forced at `k` over a field sealed at `k` by a usable prime
whose plane is `k`-colourable is trivial). And clause (2), read with `T = H` itself, turns a four-colourable fan into a four-colour forcer — the
object **G69** and **G76** classify (rows 78, 88). The site is J13 (FS-104 route (b): a Falconer fan at five colours gives `χ_m(ℝ²) ≥ 6`,
FS129-OA1-FALC-RED), and the Searcher's held request for fans (`plans/SEARCH-QUEUE.md` row 3).

**Kind of input delivered** (the card's list): a modification lemma (the repaint at the tip) and a compulsion read through a target's colouring —
here used to exclude whole fields and lattices as hosts, and to place the rest inside the four-colour rigidity theory.

### 2.2 The entries

derivation: FS129-MA2-FALC-DICHO
  statement: let H be a finite graph with an apex a and a tip t, t ≠ a and t not adjacent to a, forming a Falconer fan at five colours (every
    proper five-colouring of H − a in which N(a) avoids two colours c₁, c₂ gives t one of c₁, c₂); then χ(H) ≥ 4, and if χ(H) = 4 then every
    proper four-colouring of H gives a and t one colour
  uses only: FS129-MA1-FALC-T clauses (2) and (3), with T = H and ρ the identity map
  not claimed: that any Falconer fan at five colours exists; the converse — a pair forced equal at four colours need not be a fan at five
    (Harder's 745-point graph forces its pair at distance 8/3 at four colours over K, and is no fan at five with that apex and tip, since 8/3 is a
    unit at K's primes of residue field 𝔽₁₁, FS129-OA1-FALC-11); anything about a fan with χ(H) ≥ 5 beyond that bound
  argument: § 2.3 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: no fan at five colours is known; the argument one colour down, on the unit rhombus a, b, c, t (a Falconer fan at four colours, MA1's
    model): χ = 3 and every proper three-colouring gives a and t one colour (row 58: the rhombus forces) — control FS129-MA2-GAPK
  prior art: owed — in-house inputs (FS129-MA1-FALC-T); not searched
  handoff: de Bruijn — two lines over FS129-MA1-FALC-T's lemma: `Fan H 5 t [a₁, a₂]` with `H.Colorable 4` gives `Forces H 4 a t`

derivation: FS129-MA2-FALC-GAP4
  statement: let H, a, t be a Falconer fan at five colours as in FS129-MA2-FALC-DICHO and ρ : H → T a graph homomorphism; then no proper
    four-colouring of T leaves a colour absent from the closed neighbourhood N_T[ρ(t)]
  uses only: that a proper four-colouring C of T, read as a five-colouring, leaves the fifth colour absent everywhere; that C∘ρ restricted to
    H − a is a proper five-colouring in which N(a) avoids C(ρ(a)) and the fifth colour; row 66's single-vertex repaint at t (t is not adjacent to
    a, and its neighbours map into N_T(ρ(t)))
  not claimed: the five-colour analogue (a five-colouring of T gapped at both ρ(a) and ρ(t) only confines the tip's colour to {C(ρ(a)), the gap},
    FS129-MA1-FALC-T clause (1)); anything about targets whose four-colourings are all gap-free at ρ(t) (K's dyadic targets, U₃₂, the type-(B)
    planes), where FS129-MA2-FALC-HOSTS's confinement clauses take over
  argument: § 2.3 The arguments
  verdict: derived
  grade: hand
  minds: 1
  model: no fan at five colours is known; the argument one colour down (a fan at four colours, a three-colouring gapped at ρ(t)) holds on every
    graph with at most six vertices receiving the unit rhombus — 26,979 labelled graphs, no violation; reading the gap on the open neighbourhood
    instead, 36,030 violations at five vertices (control FS129-MA2-GAPK)
  prior art: owed — FS129-MA1-FALC-T clause (3) is the case of a three-colourable T; not searched
  handoff: de Bruijn — a lemma beside `not_fan_of_fanGap` (`FanGap.lean`), for `Fan H′ 5 t [a₁, a₂]` with H′ the doubled-apex graph and a
    `T.Coloring (Fin 4)` with `FanGap C (ρ t) γ`

derivation: FS129-MA2-FALC-HOSTS
  statement: let H ⊂ F² be a finite connected unit-distance graph over a real number field F, with apex a and tip t forming a Falconer fan at five
    colours; then (i) F has no usable prime of residue field 𝔽₃ or 𝔽₇ and no place above 2 ramified in F(i); (ii) if H is drawn in a lattice Λ
    with its complete unit-vector set U and some finite quotient Cay(Λ/NΛ, U mod N) has a proper four-colouring with a colour absent from a closed
    neighbourhood, there is no such H; (iii) if H is drawn in de Grey's lattice, t − a ∈ 8Λ; (iv) if F is ℚ(√59), ℚ(√83) or ℚ(√131), then
    t − a ∈ R ∩ 𝔓⁴ (R = ℤ[U_F], 𝔓 the dyadic prime) and every four-colouring of F² is periodic
  uses only: FS129-MA2-FALC-GAP4 and FS129-MA2-FALC-DICHO; for (i), the residue map at a usable prime 𝔭 as a homomorphism of H, translated to put a
    vertex at 0, into Γ_q (FS129-MA1-FALC-19's step: −1 a non-square in 𝔽_q), the kernel's gapped proper four-colouring of Γ₇ (`circ7Table` along
    `projAlong (1, 2)`, `Instances/PlaneFreedom.lean`; control FS129-MA2-G7GAP) moved by a translation of Γ₇ to put its gap at the tip's image,
    χ(Γ₃) = 3, and a place above 2 ramified in F(i) giving χ(F²) ≤ 2 (G35); for (ii), the quotient map Λ → Λ/NΛ and the quotient's translations;
    for (iii), row 78 (`F = P = 8Λ` on de Grey's lattice); for (iv), row 88 (`F(R) ∈ {0, P(R)}`, `P(R) = R ∩ 𝔓⁴`) and that H connected puts t − a
    in R
  not claimed: that any fan exists in the planes (iii) and (iv) leave open; anything over K beyond MA1's (FS129-OA1-FALC-11 at the primes of residue
    field 𝔽₁₁, and row 59's dyadic law, already confine t − a there); the fields whose only four-colourable residue targets are dyadic inert U_Q
    with Q ∈ {4, 8, 16} — whether those targets have a gapped four-colouring is not decided (a search request); fields with L(F) ≥ 5, where H may
    be five-chromatic and nothing here applies
  argument: § 2.3 The arguments
  verdict: derived
  grade: derived from: FS129-MA2-FALC-GAP4, FS129-MA2-FALC-DICHO
  minds: 1
  model: (i) at ℚ(√11) — 11 ≡ 2² (mod 7), so 7 splits and the prime above it has residue field 𝔽₇, and the plane is four-chromatic (row 73) — so
    no finite connected unit-distance graph over ℚ(√11) is a Falconer fan at five colours; (ii) FS81-T24's 49 gapped lattices over ℚ(√47);
    (iii), (iv): hypotheses inhabited by the lattice and the fields themselves, the conclusion conditional on a fan
  prior art: owed — in-house inputs; not searched
  handoff: de Bruijn — (i) over `finitePlane7` and `PlaneRotation`'s residue homomorphism; (iii) and (iv) wait on rows 78 and 88's Lean forms

control: FS129-MA2-G7GAP
  of: FS129-MA2-FALC-HOSTS — clause (i)'s input: the kernel's four-colouring of Γ₇ is proper and gapped (14 of 49 vertices; every vertex by a translation)
  run: python3 ../tools/fs129_ma2_fangap.py gamma7 | tail -1
  expect: proper=True gapped=14/49
  fault: python3 ../tools/fs129_ma2_fangap.py gamma7 --fault | tail -1

control: FS129-MA2-GAPK
  of: FS129-MA2-FALC-GAP4 — the argument one colour down: on every labelled graph with five vertices receiving the unit rhombus, no proper three-colouring is gapped at the tip's image, and the rhombus satisfies DICHO's analogue
  run: python3 ../tools/fs129_ma2_fangap.py gapk 4 5 | tail -1
  expect: K=4 N=5 violations=0
  fault: python3 ../tools/fs129_ma2_fangap.py gapk 4 5 --fault | tail -1

### 2.3 The arguments

*FS129-MA2-FALC-DICHO.* By FS129-MA1-FALC-T clause (3) with `T = K_{χ(H)}` and `ρ` a proper `χ(H)`-colouring, `χ(H) ≥ 4` (MA1's own reading of
the clause). If `χ(H) = 4`, take `T = H`, `ρ = id`: `T` has a proper four-colouring, so by clause (2) every proper four-colouring of `H` gives `a`
and `t` one colour. ∎ *Why it matters:* in a four-colourable host a fan has `χ(H) ≤ 4`, hence `= 4`, and is itself a finite four-colour forcer of the
pair `(a, t)` — so its tip distance `|t − a|` is a four-colour forced distance, and everything the record knows about four-colour forced pairs
applies to it: row 66 (none survives a slack target), G55's chain theorem (every four-colouring of the plane periodic under `(t − a)ℤ[U_F]`), G48's
tightness mechanism, rows 59, 78, 88.

*FS129-MA2-FALC-GAP4.* Suppose `C` is a proper four-colouring of `T` and `γ′` a colour absent from `N_T[ρ(t)]`; read `C` as a five-colouring whose
fifth colour `5` is absent everywhere. `C∘ρ` restricted to `H − a` is proper, and `N(a)` maps into `N_T(ρ(a))`, which misses `C(ρ(a))` (properness)
and `5`; so it is admissible for the fan with `{c₁, c₂} = {C(ρ(a)), 5}`, and `C(ρ(t)) ∈ {C(ρ(a)), 5}`, so `C(ρ(t)) = C(ρ(a))`. Repaint `t` alone with
`γ′`: still proper (`t ∉ N(a)`, and `t`'s neighbours map into `N_T(ρ(t))`, which misses `γ′`), still admissible, so `γ′ ∈ {C(ρ(a)), 5}`, so
`γ′ = C(ρ(a)) = C(ρ(t))` — but `γ′` is absent from `N_T[ρ(t)] ∋ ρ(t)`. ∎ The three-colourable case is MA1's clause (3); the general case needs
one colour absent everywhere and one gap at the tip, which a gapped four-colouring supplies.

*FS129-MA2-FALC-HOSTS.* (i) Translate `H` to put a vertex at 0. At a usable prime `𝔭` of residue field `𝔽_q`, `q ≡ 3 (mod 4)`, every unit vector of `F`
is `𝔭`-integral (`−1` is a non-square in `𝔽_q`), so `H` (connected) lies in the `𝔭`-integral plane and reduction is a homomorphism `ρ : H → Γ_q`
(FS129-MA1-FALC-19's step). At `q = 7` the kernel's colouring `c(x, y) = circ7Table[y − 2x]` is a proper four-colouring of Γ₇ with gapped vertices
(control FS129-MA2-G7GAP: 14 of 49, gap colour 3); a translation of Γ₇ is an automorphism, so some translate is gapped at `ρ(t)`, against
FS129-MA2-FALC-GAP4. At `q = 3`, Γ₃ is three-colourable (`finitePlane3_colorable_three`), which gaps every vertex. A place above 2 ramified in `F(i)`
gives `χ(F²) ≤ 2` (G35), and with `T = F²`, `ρ` the inclusion, a two-colouring read as a four-colouring gaps every vertex. (ii) The quotient map is
a homomorphism of `H` into `Cay(Λ/NΛ, U mod N)` (`U` complete, none of it in `NΛ`), a Cayley graph, so a gap anywhere is a gap at the tip's image
after a translation. (iii) De Grey's lattice graph is four-colourable, so `χ(H) = 4` and `H` forces `(a, t)` at four colours (DICHO, and clause (2)
with `T` the lattice graph): every four-colouring of the lattice identifies `a` and `t`, and by translation every pair at difference `t − a`, so
`t − a ∈ F = 8Λ` (row 78). (iv) `F²` is four-colourable for these fields (row 88's periodic colourings), so as in (iii) `t − a`, which lies in `R`
because `H` is connected, is a difference every four-colouring of `F²` identifies: `t − a ∈ F(R)`. Since `t ≠ a`, `F(R) ≠ 0`, so by row 88's
dichotomy `F(R) = P(R) = R ∩ 𝔓⁴`: every four-colouring of the plane is periodic. ∎

**Consequences, read off the entries (not separate claims).** (1) *Where a fan can live.* By G54's list ("a stable place's target is
four-colourable iff … only 𝔽₃, 𝔽₇, dyadic inert `Q ≤ 32` and dyadic ramified"), a Falconer fan at five colours in a four-colourable field plane
needs every four-colourable residue target of its field to be a dyadic inert `U_Q` gap-free at four colours: `U₂ = K₄` and `U₃₂` (Hoffman-tight, G54)
are; `U₄`, `U₈`, `U₁₆` are undecided (search request). Elsewhere a fan is five-chromatic and lives only in a plane needing five. (2) *What it is
there.* A four-colour forcer of its apex–tip pair, with the tip at irrational-angle distance `r > 1/2` (FALC-RED's hypothesis) and FALC-11's and
FALC-19's congruences at every prime of residue field 𝔽₁₁ or 𝔽₁₉. **The search the Searcher's row 3 describes is therefore a search among four-colour
forcers in rigid fabric** (K-like, or type-(B), where one fan would answer row 88), or among five-chromatic graphs in planes needing five — never in
loose fabric. (3) *Two routes, not independent.* HOSTS (i) also follows from DICHO and row 66's `Slack.forces_iff_of_hom` at four colours (Γ₇ is slack
at four, `Slack` in `FanGap.lean`); both routes are the same repaint, so they count as one.

**A generalization for pass 3 (not an entry).** FS129-MA1-NOAFF5's argument uses five colours only through the slackness of `T` at five; at any `k`
it reads "a finite graph with a homomorphism into a target slack at `k` satisfies no affine identity on the `(k − 1)`-simplex embedding across its
proper `k`-colourings". At `k = 4` its instances are Γ₇ (the gapped table above) and every three-colourable target: so G75's four-colour annihilator
format has nothing to find over any field with a usable prime of residue field 𝔽₃ or 𝔽₇ — the affine form of row 66's "every pair free" there, and
consistent with FS86-Cx-C11 (on type-(B) planes such an identity exists iff `F(R) ≠ 0`).

### 2.4 The mechanisms this stage audits

| G | what it is (address) | used where (ids; homonyms removed) | bears unapplied |
|---|---|---|---|
| **G43** the residue plane seals fields (`.claude/skills/grokkings/SKILL.md` G43; rows 52, 53) | a usable prime's residue map is a homomorphism into Γ_q | M53-T1, M58-T2, M59-T6, M63H2-T3, R52-T4; every field listing | **yes — a composition**: Γ₇ as a target for the fan, never asked (FS129-MA2-FALC-HOSTS (i)) |
| **G48** the tightness mechanism (G48; rows 61, 66) | a pair forced at `k` over a field sealed at `k` by a `k`-colourable usable plane is trivial | ASTRA-T8, FS50-T6, FS91-J02-T3, J17-T3, M61-T1, M61-T5, M63H2-T11, MASCOT-T4 | **yes, the same composition**: at `k = 4` with Γ₇ the mechanism kills the four-colour forcer DICHO makes of a fan (§ 2.3 (3)); MA1's note (row 66's consumer) stands for `k = 5` |
| **G54**'s slack face (MA1 audited its tight face; brief: check the gap-free pullbacks) | slack permits gaps; "found at 7, 11, 19" | MA1 § 3.3's 23 ids | **yes** at 7 (above). **Gap-free pullbacks in products** (rows 114–115): null — no audit site has a product target the fan or a regularity-era step meets; FS121-D3-SWAP1D's circle is a disjoint union of five-cycles, not a product (MA1 § 3.3) |
| **G68** ask the quotient, read it for a gap (G68) | a gapped quotient colouring frees every pair on the lattice | FS73-T32, FS79-T40, FS81-T22, FS81-T24 | **yes**: the gapped lattices exclude fans (HOSTS (ii)) |
| **G69** rigidity is arithmetic, decided on the quotient (G69; row 78) | periodic colourings are residue colourings; forced pairs need Kempe-rigid targets | none by number (the index lists no mention; FS-70, FS-73 by content) | **yes**: DICHO places every four-colourable fan among four-colour forcers, so in G69's rigid fabric only (HOSTS (iii)) |
| **G76** four-colour rigidity over a field is local plus one extension question (G76; rows 88–92, 111–113) | `F(R) ∈ {0, P(R)}` on type-(B) fields | FS91-J12-MS, R88-TC | **yes**: a fan in a type-(B) plane answers row 88 (HOSTS (iv)); cross-era null — its measure half (row 124) is already FS-104's input |
