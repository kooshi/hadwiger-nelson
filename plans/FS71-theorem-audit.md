# FS-71 — the theorem audit: every theorem every prior milestone proved outside the kernel, found and filed

*Subplan, written 2026-09-22 by the product owner at the opening (WORKFLOW 2.0 steps 3–4). Stub: `plans/STUB-theorem-audit.md`
(Kooshi, mid-FS-70: "an audit of all prior milestones to find their theorems and document them this way"). Planner-free by the
stub's own design — the reframe below is the owner's, with `CLAUDE.md` and `LEDGER.md` (rows 1–76, § B) read in full at this
opening; Kooshi scores §G. Implementers: **Sonnet 5**, one per batch, one at a time (Kooshi, 2026-09-22: "mostly reading and
bookkeeping"); every derivation stays with the owner.*

## 0. The mission, in plain language

Every milestone since M17 has proved things outside the Lean kernel — by hand, by derivation from results already held, or at
tools grade (exact arithmetic with controls) — and most survive only as a clause inside a ledger row, a paragraph of a plan, or a
sentence of a grokking. FS-70 had nine such theorems before anyone counted; it now has `plans/FS70-derivation.md` and eleven lines
in `LEDGER.md` § B. FS-71 backfills that shape for every milestone from M17 to FS-66: **one derivation file per milestone that
proved anything** (statement, grade, where the proof lives, what rests on it, its prior art, whether the proof closes, and a
kernel decision), **one index line per theorem in `LEDGER.md` § B**, and three lists — theorems that turn out to be prior art on
re-reading (moved to their bibliography row), theorems whose proof is missing or does not close (demoted to conjectures), and
kernel targets (a stub line each). No solver runs; no Lean is written; the only Lean act is checking that a cited declaration
exists. *"The derivations are an order of magnitude more important than individual objects"* (the programme) — this is the
derivations' census, and a theorem nobody can find is not held.

**Decisions at the opening, stated so they can be pushed back on.**

| decision | alternative weighed | why this one | confidence |
|---|---|---|---|
| **Six batches, not the stub's four**: M17–M36 · M37–M52 · M53–M61 (+ the 2026-09-06/08/09 consolidation rows 52, 57–60) · M62–M64 · FS-24–FS-38 (+ the 2026-09-14 advisor fold-in) · FS-50–FS-66 (+ the 2026-09-17/19 conversations behind G63/G64) | four, as minted | measured volume: the plan files alone are 670 KB, 717 KB, 1.02 MB, **2.7 MB**, 727 KB and 815 KB per batch (plus 30–430 KB of records under `data/`); M62–M64 cannot share a reader with anything | high |
| **Sonnet 5 implementers; the owner does every derivation** | Opus 5 (the standing implementer) | Kooshi's call: the work is reading and bookkeeping; a proof verdict of *unsure* routes the entry to the owner's re-derivation rather than asking the implementer to repair | high |
| **Planner-free**: the reframe and subplan are the owner's | a Fable planner (the standing shape) | FS-71's reframe *is* a walk over the whole corpus, which the owner has just done to write it, and its product (the seed inventory below) is what the batches consume; a planner would re-read 300 KB to reproduce it. The cost: nobody scores §G but Kooshi — so §G is written as a table he can scan | medium — if a batch finds the seed badly incomplete, the reframe measured its own reading (G21) |
| **Implementers write derivation files, `LEDGER.md` § B lines, bibliography rows and stub lines directly; `CLAUDE.md` and `plans/FRONTIER-STUBS.md` are the owner's** — proposed edits to those go in the batch report | implementers propose everything, the owner applies | one writer per file (the orchestration rule); batches are serial, so the shared files have one writer at a time, and the owner's files are the ones a wrong sentence costs most in | high |

## §G — the re-grokking (WORKFLOW 3.1)

*The milestone's question in the theory's terms:* **the object is the corpus of claims graded [hand], [derived], [tools], [cert],
[proof] — and the claims graded [reading] or [measured] that have been consumed as if they were theorems.** The theory's own grade
tags (§ Notation) are the first index of that corpus; the ledger rows' grade-tagged clauses the second; the plans' §R sections and
phase records the third. What the theory predicts: G49 measured on M53–M56 that several "lemmas" were `[Fischer1990b]`'s, so the
gate will re-attribute again; G21 predicts that a record's theorem measured its own hypotheses somewhere and a proof will not
close; G30's failure modes 5–7 predict instances recorded where theorems were available, and theorems whose hypothesis no object
meets. What it supplies: the grade vocabulary, the one-home-per-fact rule, the derivation-file shape (FS-70's), the fact audit as
a gate, the zbMATH procedure. What it forbids: filing a reading as a theorem; keeping a defective proof as a theorem; claiming a
prior-art zero without recording the query. What it can falsify: registered below.

**Verdict vocabulary for this milestone.** *target* — the entry carries a claim outside the kernel that the audit files (with the
batch it falls to); *rule* — the entry shapes how the audit runs; *silent* — kernel only, or a measurement with no theorem in it;
*falsifiable here* — an entry the audit could demote or re-attribute, registered as a prediction.

### G.1 The grokkings, one line each

| entry | verdict | what it says to FS-71 |
|---|---|---|
| G1 | silent | Theorem B and the seam closures are kernel; the wall criterion it cites is G35's (a target there) |
| G2–G6 | silent | measurements about the witnesses' construction; no theorem |
| G7 | **target, batch 4** | the one-integer family: `cos θ = (2n−1)/(2n)` "the ONLY rational cosine" with `sin θ = √(4n−1)/(2n)` (`plans/M63-phaseH2-the-family.md` §3) — is the uniqueness proved or asserted? prior art `[Polymath16wikiMain]` for the family (attributed); Haugland's closure at ρ₁₅ a derivation |
| G8 | silent | the direction group closes 67 classes — a computation; the α question is an open measurement |
| G9–G11 | silent | measured / external |
| G12 | **target, batch 1** | the quadrature law "derived and then confirmed at 26 censuses" (row 27, M31): file the derivation with its proof located or marked *not on disk*; the ρ₁₅ instance is kernel (row 28) |
| G13 | silent | kernel |
| G14 | **target, batch 1** | "a matching is 1-regular and carries no colour pressure, even composed into forced-rainbow triangles" — the stacking law's derivation (row 29, M32) |
| G15 | **target, batch 1** | the criticality factorisation `χ(G) ≥ k+1 ⟺ the fan at a vertex whose deletion is k-colourable` (row 30, M33) — a hand theorem; universality is a reading and is NOT filed |
| G16 | silent | the pigeonhole carriers are kernel (row 31); the √3-circumradius remark is a one-liner |
| G17–G19 | silent | measured; the K half of G19 is Theorem B |
| G20 | **target, batch 1** | "boundary-tight by force (cell diagonal exactly 1)" and "brick colourings reach seven and refuse six and five under the exact certificate" (M35–M36): which half is kernel (`check_pos`) and which derived |
| G21 | **rule** | audit the results you like at the same rate; every verdict names its enumeration — each batch report says which files were read in full, which grepped, for what |
| G22–G23 | silent | kernel + `[SokolovVoronov2025]` |
| G24 | **target, batch 2** | the exactly certified `χ_f` values (130/23, 501/74, ≈ 4.83796 at the 117-core) and the Hoffman bracket at p = 1/7 — cert-grade; file with their certificate addresses |
| G25 | silent | a reading |
| G26 | silent | kernel |
| G27 | silent | the Galois automorphism is a checked computation; its consequences are witnesses |
| G28 | **rule + target, batch 2** | the demotion record: M43's "does not factor" was withdrawn by M45's re-ask — nothing from M43 is filed as a theorem; the seven virtual edges are M45's measurement |
| G29 | silent | the limit lemma is kernel (row 41); the growth rate is measured |
| G30 | **rule** | the per-theorem checklist: #4 correct and second (the gate); #5 a theorem over an empty domain (is the hypothesis ever met?); #6 an instance recorded where a theorem was available (hypotheses narrower than the proof uses); #7 a hypothesis implied by the emptiness of the conclusion's domain |
| G31 | **target, batch 3** | "forcing at χ allows ≤ 2 critical vertices" is row 48 (kernel); "this 1-sum has 3" is computed; the corollary "de Grey's 1581 has no forced pair at five" is a derivation to file under M54 |
| G32 | **target, batch 3** | `μ ≥ 3 inside K` (G36's 2-SAT argument, row 47, M53) and "μ = 1 is impossible in any 5-sealed field" (row 66, kernel) |
| G33 | silent | a reading |
| G34 | **target, batch 2** | "every kept glue point is a parent plus a Moser-lattice unit vector, so every committed descent point lies in K" (row 46, M51–M52) — derivation or checked fact? |
| G35 | **target, batches 3, 5; one defect found at this gate** | the multiquadratic wall criterion (no odd square class ≡ 7 (mod 8)); the glue-point congruence test (−r a square in both 2-adic completions of K; of eight classes exactly 5 and 7 break); the field-level gate. **The quaternion identification is defective and is corrected in this commit**: `(−1,−1)_F` splits at a 2-adic place iff the local degree is even (`(−1,−1)_{F_v} = (−1)^{[F_v:ℚ₂]}`), strictly weaker than −1 being a square — ℚ(√2) and ℚ(√3) split the algebra above 2 with the wall standing; the odd-real-places conclusion survives and its sharp form is `[Moorhouse2010]` §7.1 |
| G36 | **target, batch 3** | the residue colouring proper on every descent stage, monochromatic on distance-2 cheats, separating the seed pair; the 2-SAT transversal criterion; `μ ≥ 3` (M53) |
| G37 | **target, batch 3** | necessity: the unit part of a descent is 5-chromatic only after an out-of-field point (Theorem B's corollary); "over K the 6-open single radicals are the odd squarefree d ≡ 5, 7 (mod 8), non-residues mod 11" and the `3d ≡ 7` reconciliation (M53/M58) |
| G38 | **target, batches 3, 5** | the linear method's thresholds (2, 3, 4, then nothing below 7 — proved where? M56); the multiquadratic two-colour iff [hand, FS-36] — **row 63 says it is unchecked against `[AxenovichEtAl2014]`, `[Johnson2006]`**; the usable-prime characterisation |
| G39 | silent | kernel (row 48) |
| G40 | **target, batch 3** | "a spindle copy hangs by its fused centre plus one chord, so more spindles or centres cannot create a compulsion" — derived from `extends_of_hubs` (row 49, M55); "every K-coset piece is 4-colourable" is Theorem B |
| G41 | silent for the backfill | kernel + `[Fischer1990]`; the 2-adic-embedding reading (today's) is a [reading] with its killing test and is NOT a theorem |
| G42 | **target, batch 3** | rigidity ⟺ every two-colour Kempe subgraph of every admissible hom connected (the gauge γ) — derived or kernel (`forces_of_additivelyRigid`)? (M57) |
| G43 | **target, batches 3, 6** | "for F ⊇ K, 6-open ⟺ wall broken ∧ 11 inert" (row 53); "a composite ideal beats its best prime only through an integrality gap" — derived from `[Zhu2011]`/`[Zhang2012]` at the 2026-09-16 outside review (FS-54); Moorhouse §9's Hedetniemi dependence — a reading of prior art |
| G44 | **target, batch 3** | `Γ_p`'s eigenvalues `−K(1, c/4)` (from `[MMST1998]`); Weil + Hoffman ⟹ χ > 5 from 59 and χ > 6 from 103 — derived (M58/M61); `[Vinh2006]`'s missing factor 2 (row 53) — a finding against prior art, checked at 19 |
| G45 | **target, batch 3** | "a 6-critical subgraph carries ≥ \|V\|/2 + 3 stress conditions"; "a rigid framework's lift is unique and algebraic"; "a field's sealing prime is never its lifting prime" (M59, row 54) |
| G46 | **rule** | the recognition sentence per theorem is its prior-art query; a theorem named in no discipline's words has not been recognised |
| G47 | silent | kernel, subsumed by row 66 |
| G48 | silent | the mechanism is kernel (row 56); the conjecture is a reading |
| G49, G50 | **rule** | the gate runs on each theorem: in the discipline's words, two disciplines, the held bibliography first, zbMATH with the query recorded; a paper a theorem's prior art names is read, not summarised |
| G51 | silent | method, measured |
| G52 | **target, batch 4** | the necessary half: a rotation escapes the residue colouring only through same-colour base pairs realising `d² = σ − (σ−1)/cos θ`; the certificate's defeat is automatic for even `t`; `\|p\|² = n` is free iff `n = k²·m` with `m` realised (M63 phases G–H) |
| G53 | **target, batch 4** | the counting compulsion: `2L > circle count ⟹ not k-colourable` — derived (M63 H2); the `10/30` is provisional and is NOT a theorem |
| G54 | **target, batches 5, 6** | D2-A/B (FS-38; `plans/FS38-derivation.md` exists — complete it: balance and gap-freedom are Blokhuis–Brouwer–Haemers 2007, the periodicity ours); the Weil consequence (no usable prime above 3 tight for k ≤ 7); the inert-tower constancy of `λ_min/d` and U₃₂'s hyperplanes (GPT Astra, FS-54) |
| G55 | **target, batch 5** | GPT Astra's theorems (chain, prime inversion, the two- and three-colour classifications, the 8/3 consequences, the 18-vertex graph, one virtual edge ⟹ six) — read here, identities verified (`reference/ChatGPT-local-global-tightness-conjecture/VERIFICATION.md`); file under a 2026-09-14 derivation file with the credit rule; Harder's 8/3 pair is prior art (row 47) |
| G56 | **target, batch 6** | the exclusion (3 or 11 a non-square at each member; 27 by `11 ≡ −1 (mod 3)`) — derived, script-verified; the 2-adic trichotomy [proof]; **odd degree ⟹ 2-colourable is `[Moorhouse2010]` §7.1**; "27 is the unique non-prime member" — derived; the rounding reading is NOT a theorem |
| G57 | **target, batch 6** | `ω(F²) = 3 ⟺ √3 ∈ F` (`[Krebs2022]` Lemma 5.1 — prior art); the one-direction transfer and "no window member admits √3 and √11 together" — derived; the demoted converse stays demoted |
| G58 | **target, batch 6** | the derived half only ("τ must fix a colour"); the conjecture is a reading; **bibliography keys owed** |
| G59 | **target, batch 6** | W_f (GPT Astra, verified); the normalisation `c = α/q^{3/2}` and the threshold `√q/6`; the Fourier-energy bound at 64; the CRT-product consequence (`[Zhu2011]`, `[Zhang2012]` — prior art) |
| G60 | **target, batch 6** | "every congruence between subsets of `F²` is an isometry of `F²`" ⟹ the blow-up stays in F (hand, `plans/FS56-field-blowup.md`); `χ_f(K²) = 4` (hand + cert); the cap; the ratio-bound shadow is a reading |
| G61 | **target, batch 6** | (1) kernel; (2) "the 3-adic tower is Hoffman-tight at three colours, rigid from level 1" [tools] and "stays rigid tensored with 7 and 11" — **measured, leaned on as if proved (FS-67)**; (4) the "linear in d" non-transfer argument (row 74) — derived; T4 is a reading |
| G62 | **target, batch 4** | `w̄/w = −ρ_n` (verified symbolically); commensurate ⟹ periodic ⟹ finite quotient ⟹ bounded; the `Σ7` identification of `Instances/Seven.lean`'s colouring — derived (M63 H3 §PA.4, promoted 2026-09-17) |
| G63 | **target, batch 6** | `χ(F(t)²) = χ(F²)` — `[Fischer1990]` Thm 6 (attributed); `ℚ(φ) = ℚ(√5)` bipartite — derived; the gap in Fischer's Remark 1 — a finding against prior art (FS-61's gate) |
| G64 | **target, batch 6** | S ⟹ W (given the bridge) and the exact form `χ(ℝ²) ≠ 6 ⟺ every six-chromatic number field has a seven-chromatic finite real extension` — derived, **with the demotion record** (S ⟺ W was claimed); the three mechanism theorems (residue counts are prime powers; coset counts Loeschian / sums of two squares) — derived; the norm reading is NOT a theorem |
| G65 | **target, batch 6** | the degree law `degree = g·φ(R)²` — a derived formula, measured; the phase diagram is measured |
| G66 | **target, batch 6** | FS-66: the fibre-share inequality [hand], Lemmas W, T, Theorem E [hand, the prover's; checked by the owner], links L1–L6 — already named in `plans/FS66-tower-conjecture.md` §3 and `FS66-phase2-certificate.md`; complete to the template; the constancy `α(G_k) = p^{2(k−1)}α(Γ_p)` is a conjecture (FS-68), not filed |
| G67 | **rule** | the form; **and a data point for its killing test**: FS-71's §G verdicts were drawn from grade tags and entry bodies, not from Do lines — expected, since this milestone's object is the corpus itself; recorded, not counted against the form |
| G68, G69 | silent | FS-70, filed (T1–T11) |

### G.2 The ledger rows, by batch — the seed inventory

*Each row's grade-tagged clauses outside the kernel, named as candidates. A candidate is filed, or classified in the batch report as
kernel / measurement / reading / instance / prior art with one line why. Rows not listed are kernel-only.*

**Batch 1 — M17–M36 (rows 1–33; plans `M17…M36`, `m21/m22-predictions`).** Row 12 (extension profile — an instrument, no theorem);
row 13 ("pentagon exclusion is a fact about the coordinate field" — derivation?); rows 15, 16, 19 (measurements; "two-thirds
collide back into the lattice" — computed); row 21 ("the triple-kill population is provably empty" — a derived theorem: find its
proof); row 26 (the 67 classes as words — computed; the 791 forcer's six pairs — computed; "at or near edge-critical" — sampled);
row 27 (**the quadrature law**, G12 — derivation); row 29 (**the stacking law**, G14); row 30 (**the criticality factorisation**,
G15; the carriers 122/49/9 — computed); row 31 (`core9_plane`/`core122_plane` vacuous — a finding; the 4,749-vertex union —
cubes); row 32 (the hex-shell pigeonhole "folklore, formalisation ours"; the five-colour pattern sweep — measured); row 33 kernel.
Expected density: **low** — three or four derivations, the rest kernel or measurement.

**Batch 2 — M37–M52 (rows 34–46; plans `M37…M52`, `M44-from-below-gadget`).** Row 34 (prior art attributed; "the exact value and
the arbitrary-label results" ours — kernel); row 36 kernel; row 37 (**no coset 7-colouring on G\* and the 1/6, 1/7 bands — all
eight index-7 sublattices contain an edge**, exact with witnesses — cert-grade; band values); row 38 ("all five clique-free cores
factor" — measured; the Klein four-group of automorphisms — checked); row 40 (band-by-band sevens — cert; the conditional whole-
family claim rests on `[Voronov2023]`, `[SokolovVoronov2025]` — external, mark so); row 41 (the defect meter — tools; the ν(ε)
points — measured); row 42 (G28: M43 withdrawn; M45's seven — measured); row 43 (arity floor 4 or 5 — complete sweeps, measured);
row 44 (**Exoo–Ismailescu's {1,2} forcer re-derived exactly** — tools; Parts's {1,φ} forcer edge-critical — checked; `29 ≤ μ ≤
252` — measured; **`Instances/OneTwo` cited and absent** — a dangling address); row 45 (**the spare-colour lemma**, `(k−1)`-colourable
⟹ no pair compulsion at k — a hand lemma consumed by G40 and FS70-T3: kernel decision owed; batch halos compose by construction —
derived); row 46 (every unit edge on the Moser lattice, every point in K — G34). Expected density: **medium** — the cert-grade
cell-family values and three or four lemmas.

**Batch 3 — M53–M61 and the consolidation of 2026-09-06/08/09 (rows 47–60; plans `M53…M61`, `FIELD-WALL-THEOREM`,
`MASCOT-DERIVATION`, `DESCENT-ALGORITHM`, `A1-theorem-A-kernel`, `B1-field-wall-kernel`, `Q8-FIVE-CHROMATIC-OBJECTS`,
`COXETER-2026-09-08-mascot`, `POROS-2026-09-08-mascot`, `POROS-2026-09-10-b-closure-equality`; `reference/Chat-analysis/`;
`data/m5{1..7}/`).** Row 47 [hand + tools] (**the residue colouring on descent objects**; the residue obstruction; `μ ≥ 3`; the
wall-break census; `plans/FIELD-WALL-THEOREM.md` in full — **its Prop. 6.4 is corrected by row 63**; the K(√247) and K(√23)
witnesses — solver; Harder's pair — prior art); row 48 (the metric-space generalisation where "≤ 2 does not survive" — kernel);
row 50 (the additive spindle theorem "its chord lies in 4Λ" — kernel or hand?; "the colouring space is exactly the additive
family" — measured; Fischer prior art); row 51 (the gauge characterisation — G42); row 52 [hand + tools] (**the finite-plane bound
with the odd-residue-degree condition** — Moorhouse/Manturov/Madore prior art, the degree condition as stated ours?; the sealed
lists — computed); row 53 [derived] (**Kloosterman refusals from 59 and 103**; 6-open ⟺ wall ∧ 11 inert; `[Vinh2006]`'s factor);
row 54 (the hub scan — tools); row 56 ([tools] ϑ = Hoffman at eleven primes — measured; no symmetric 5-colouring of Γ₂₃ —
solver); row 57 (**the field-level gap** "not proved" — file as the named gap; **`χ(ℚ⁴) ≤ 4` by the Hurwitz order** — an instance of
Theorem A, prior art `[BendaPerles2000]`, "not new" — file as instance); row 58 (`plans/MASCOT-DERIVATION.md` — kernel plus its
hand derivation); rows 59–60 kernel. **M56 (`plans/M56-arithmetic-of-tightness.md`): lemmas L1–L7** — L7 a CONJECTURE proved by GPT
Astra with prior art `[Fischer1990b]` (G55); the others to be re-attributed against `[Fischer1990b]` Thms 1–5 (read 2026-09-16,
bibliography row). G37's radical list; G38's thresholds; G40, G42, G44, G45's derivations. Expected density: **high** — the richest
batch.

**Batch 4 — M62–M64 (rows 62, 64, 65; plans `M62-*`, `M63-*` (30 files), `M64-*`, `POROS-2026-09-11-*`, `POROS-2026-09-12-*`;
`data/m62/`, `data/m63/`).** Row 62 (**the orbit-closure theorem**: rung-H minimum = min \|cl_H(M)\| over minimal refusers — hand;
prior art the symmetry gap of symmetric integer programming, `[HerrRehnSchurmann2013]`, MUS/MCS — the gate decides what is ours);
row 64 (**G7's family theorem**; the four gates' derivations — `sin θ ∉ K ⟹ Theorem B four-colours every base`; the 19 patterns
in `1 + 6·3` orbits — computed; `h(K) = 1` — pari); row 65 (**the additive-pair route theorem**: open iff `4 ∤ n`, dead iff `4 \| n`
— derived; (i) the endpoint bound `1/\|sin θ\|`; (ii) monotone growth; (iii) **the circle at `√(1−1/(4n))` of the bound — the
free-circle theorem's hypothesis never met by any object built** (G30 #5); (iv) the two-case classification of monochromatic
cross-edge kinds over `V = n(g−h)² + gh`; (v) the conjugate-condition cost — measured; (vi) the one-sided kill test — derived);
G52's escape law and the even-`t` automatic defeat; G53's counting compulsion; G62's `w̄/w = −ρ_n` and the periodicity chain;
M63 phases C–G's cost laws (derived or measured — classify); the POROS records' own derivations. Expected density: **high, buried
in 2.7 MB** — the grep discipline (§S.4) is the whole method here.

**Batch 5 — FS-24–FS-38 and the 2026-09-14 advisor fold-in (rows 61, 63, 66, 67; plans `FS25-P2`, `FS26`, `FS27-1`, `FS28`,
`FS32`, `FS36`, `FS38-*` (three files, `FS38-derivation.md` exists), `P3…P6`, `POROS-2026-09-13-*`;
`reference/ChatGPT-local-global-tightness-conjecture/`, `reference/ChatGPT-multiquadratic/`; `data/fs38/`).** Row 61 kernel; row 63
([hand] **the multiquadratic two-colour iff** — unchecked against `[AxenovichEtAl2014]`, `[Johnson2006]`; the square-class
decomposition — ChatGPT's, credited; "granted the factors' hand χ ≤ 4" — a conditional, file as such; χ = 2 ⟺ L = 2 — GPT Astra);
row 66 kernel; row 67 (**D2-A/B** and the depth-4 lattice certificate [hand]; "`Cay(O/𝔓^m, S_m)` is [hand], three constructions
agreeing"; the classifier's Weil consequence; the 3-adic control — solver-free); **G55's theorems** with the credit rule
(`VERIFICATION.md`); FS-32 (`plans/FS32-smus-reduction.md` §R3: "reaching Parts's record by pure reduction" closed — a theorem or
a measurement?); FS-25–28 are method (vacuity) — no theorems expected. Expected density: **medium** — FS-38 (complete, not
rewrite) and the fold-in dominate.

**Batch 6 — FS-50–FS-66 and the 2026-09-17/19 conversations (rows 68–75; plans `FS50-*`, `FS54-*`, `FS56-*`, `FS58-*`,
`FS61-*`, `FS66-*`, `POROS-2026-09-14/15-*`; `reference/wall-at-six/`; `data/fs50/README.md`, `data/fs53/*.md`, `data/fs54/*.md`,
`data/fs56/`, `data/fs58/*.md`, `data/fs61/*.md` (430 KB — `README`, `census`, `readings`, `shapes`, `aiming-167`, `owner/`),
`data/fs62/*.md`, `data/fs66/*.md`.)** Row 68 (`plans/FS50-certificate-soundness.md` — the checker's soundness theorems, hand; the
rounding mechanism — method); row 69 (G56's exclusions — derived; the field naming — pari; the tightness calibration — measured);
row 70 (**the 2-adic trichotomy** [proof] — **odd degree ⟹ 2-colourable is `[Moorhouse2010]` §7.1**; W_f and U₃₂'s hyperplanes and
the inert-tower ratio — GPT Astra, verified by recomputation, `tools/fs54_wall_feedback_verify.py`; the value-set consequence —
derived; `plans/FS54-L3-certificate-soundness.md`); row 71 ([hand] **the blow-up stays in F**, `χ_f(K²) = 4`; the route's cap);
row 72 ([tools] the 3-adic tower tight and rigid — **G61(2) is measured, FS-67 open**); row 73 (the chain at three colours over
ℚ(√11) — derived from G55 + a solver refusal); row 74 ([hand] **the dyadic law's other half** — no primitive unit vector of
denominator ≡ 2 (mod 4) for `d ≡ 7 (mod 8)`; [measured] the non-transfer, with its "linear in d" derivation; `[ZanardoZannier1991]`
Thm 3 **not re-read**; G65's degree law); row 75 ([hand] **the fibre-share inequality**; W, E, T; links L1–L6; the biclique
structure — derived). G58's fixed-colour half (keys owed); G59's normalisation; G63/G64's derivations (`data/fs62/`, `CLAUDE.md`
only — no plan file; file them under `plans/FS62-derivation.md` with the demotion). Expected density: **high**.

### G.3 The method rules that bear

| rule (`CLAUDE.md`) | what it makes the audit do |
|---|---|
| one home per fact; `claude_md_fact_audit.py --base / --dupes` | the derivation file is the theorem's home; the ledger row and the grokking point at it; the § B line is an index, never a retelling — run the audit at every commit that touches `LEDGER.md` |
| "read the final statement aloud against the informal claim" | every filed statement is written out with its quantifiers, then read against the sentence in the row or grokking it came from; a mismatch is a finding |
| "a caveat you write and then step over" | when a record says "not claimed", "conditional on", "provisional", the entry carries it in the statement line, not in a footnote |
| "state the uninformative outcome and confirm it is reachable" | a prior-art zero is reported with the query strings, so a reader can see what the zero measured |
| "carry what a number measures" | a tools-grade theorem's statement names its enumeration (the range, the population) — `[tools]` means *checked on this finite set*, and the entry says which |
| "never issue an instruction against a file you have not re-read" (orchestration) | every brief's file list is produced by `ls`, not from memory; every address in a derivation entry is one the implementer opened |
| G21's "an elimination carries an exact quantifier" | a "declined" kernel decision carries its reason; a "not on disk" proof verdict names where it was looked for |

### G.4 Predictions registered (falsifiable here)

| id | prediction | what decides it |
|---|---|---|
| P1 | in each of batches 3, 4 and 6 at least one filed theorem is re-attributed to prior art by the per-theorem gate (G49's measured rate on M53–M56) | the batch reports' "prior art re-attributed" lists |
| P2 | at least one theorem asserted in a record has a proof that does not close on re-reading — most likely in batch 4 (the 2.7 MB of M63 derivations, written in the phase G21 calls the flattering-defect regime) | a *gap* proof verdict confirmed by the owner's re-derivation |
| P3 | the census lands between 60 and 160 theorems outside the kernel across M17–FS-66 (the stub's "~a hundred"); outside that band the seed or the enumeration was wrong | `LEDGER.md` § B's line count at the close |
| P4 | batch 1 files fewer than six theorems — the early milestones were kernel-and-measurement | batch 1's derivation files |
| P5 | the owner's blind controls (held in the session scratchpad, never briefed; one to three per batch) are found at ≥ 70 % by the batches' own enumeration | scored per batch in §R |

## §PA — the prior-art gate (WORKFLOW 3.2)

FS-71's gate is not one search: it is **a procedure run on every theorem filed**, plus the milestone-level checks below.

### PA.1 The per-theorem procedure (what the implementer does for each entry)

1. **Recognise**: write the theorem's statement in the vocabulary of the discipline it belongs to (G46) — *Cayley graph of an
   abelian group*, *Hoffman bound / ratio bound*, *valuation ring / residue field*, *unit-distance graph over a number field*,
   *coincidence site lattice*, *Kempe chain*, *Hilbert symbol* — never in this project's coined words (`BIBLIOGRAPHY.md` § E is the
   translation table; "field wall", "sealed", "fan gap", "compulsion" appear in no paper).
2. **The held bibliography first**: `BIBLIOGRAPHY.md` § A and § B — is there a held paper on the object? Name it in the entry
   (*nearest held:* `[key]` §n) whether or not it contains the theorem; if its row says the relevant section is unread, say so
   (G50) — an unread section is an owed reading, not a prior-art zero.
3. **zbMATH Open, two disciplines, queries recorded verbatim**:
   `curl -sG 'https://api.zbmath.org/v1/document/_search' --data-urlencode 'search_string=<query>' --data-urlencode 'results_per_page=50'`
   with `ab:"…"`, `ti:"…"`, `au:"Last, First"`, `py:…`, `cc:05C15` joined by `&` / `|` (verified live 2026-09-22: the query
   `ti:"chromatic number" & ab:"additive" & ab:"coloring" & py:1985-2000` returns exactly `[Fischer1994]`, Zbl 0836.05030; the API
   returns `status.nr_total_results: null` and an empty `result` on no match). At least two queries per theorem, in two
   disciplines' words; the entry records the query strings and the hit count. A hit is opened (its review text is in the JSON;
   `editorial_contributions` says whether it is a reviewer's review or an author's summary — record which).
4. **Verdict**, one of: *ours* (queries recorded, nothing found) · *prior art* `[key]` (the theorem is in print; the entry moves
   to the bibliography row's "what of ours rests on it" and the derivation file keeps a one-line pointer) · *partly prior art*
   (what is theirs, what is ours — the usual shape: the mechanism theirs, the general form or the consumer ours) · *check owed*
   (a named paper, unread here, that must be read before the verdict — goes to `BIBLIOGRAPHY.md` § R if not held).
5. A new paper found goes into `BIBLIOGRAPHY.md` the same day, marked *listing only* until read; `tools/bib_audit.py` must pass.

### PA.2 Milestone-level checks, run by the owner at this opening

- **G35's quaternion identification — run and found defective** (the correction is in this commit). The claim "breaking the wall
  says exactly that `(−1,−1)_F` splits at every place above 2" is false: for a 2-adic field `F_v`, `(−1,−1)_{F_v} = (−1,
  N_{F_v/ℚ₂}(−1))_{ℚ₂} = (−1)^{[F_v:ℚ₂]}`, so the algebra splits above 2 iff every local degree there is even — implied by the
  wall's breaking (`ℚ₂(i) ⊆ F_v` forces even degree) and not implying it (`ℚ₂(√2)`, `ℚ₂(√3)` have even degree and no `i`; the
  walls of ℚ(√2) and ℚ(√3) stand). What survives: a broken wall makes the ramification set exactly the real places, so by Hilbert
  reciprocity no field with an odd number of real places breaks it; the sharper statement — odd degree ⟹ 2-colourable — is G56's
  and is **`[Moorhouse2010]` §7.1** (bibliography row, read). The audit's first instance, found before its first batch ran.
- **The odd-degree theorem's attribution** propagates: row 70's "[proof] every odd-degree real field is 2-colourable" and G56 must
  cite Moorhouse §7.1 (batch 6 files it; the owner edits G56 at the close).
- **No literature on "auditing a project's theorems"** is sought — it is process, not mathematics.
- **Owed checks the corpus itself names**, handed to the batches as named targets (each is also in G.2): row 63's iff against
  `[AxenovichEtAl2014]` / `[Johnson2006]` (batch 5); row 74's `[ZanardoZannier1991]` Thm 3 (batch 6); G58's keys (batch 6);
  M56's L1–L7 against `[Fischer1990b]` (batch 3); row 62's symmetric-IP prior art (batch 4).

## §S — the shape

### S.1 The derivation file — `plans/<milestone>-derivation.md`, template `plans/FS70-derivation.md`

One file per milestone that proved at least one theorem outside the kernel (a milestone with none gets a line in the batch report
saying what it holds instead, and no file). Ids **`<milestone>-Tn`** (`M33-T1`, `FS36-T2`); where a milestone already named its
theorems the names stay (`FS38-D2-A`, `FS38-D2-B`, `FS66-W`, `FS66-E`, `FS66-T`, `FS66-L1`…`L6`) and FS-38's file is **completed,
not rewritten**. Sections, in order:

1. Header — the milestone, the batch, the date, the enumeration (files read in full; files grepped, with the patterns).
2. **The theorems** — per entry, in the template's form:
   `**<id> — <title>. [<grade>; who proved it]** <statement, quantifiers explicit, hypotheses named>. *Proof:* <file §section, or
   "not on disk — looked in …">. *Proof verdict:* closes / gap: <the step> / unsure — owner to re-derive. *Rests on it:* <rows,
   grokkings, stubs, later theorems>. *Prior art:* <PA.1 verdict, the nearest held key, the zbMATH queries with hit counts>.
   *Kernel:* kernel (`decl`, module) / stub (which stub, one line added there) / declined — <reason> / priced — <cost>.`
3. **Readings and measurements that were called theorems** — each with the sentence that called it one and where; not filed in
   § B.
4. **Conjectures surfaced, not claimed** — including every theorem whose proof verdict is *gap* (demoted here with the gap stated).
5. **Prior art re-attributed** — one line each, pointing at the bibliography row updated.
6. **Kernel decisions, summarised** — the table.

Grades are `CLAUDE.md` § Notation's; **[tools] entries state their enumeration in the statement** ("on every unit vector of
denominator ≤ 20"; "at the 21 planes below 100"); a *derived* entry names the rows it derives from; a *hand* entry names the
prover (the planner, the implementer, the owner, GPT Astra, ChatGPT — the credit rule of G55).

### S.2 `LEDGER.md` § B — one line per theorem

`| <id> | <milestone> | <the theorem in one line> | <grade> | <derivation file §; the record> | <kernel decision> |`, inserted in
milestone order **above** the FS-70 lines; the placeholder line ("`FS38-D2-A/B, FS66-W/E/T, … indexed by FS-71`") is removed by
the batch that files FS-38. `tools/claude_md_fact_audit.py --base HEAD` and `tools/check_architecture.py` run after every edit.

### S.3 The batch report — `data/fs71/batch-<n>.md`

1. **The census table**: milestone · candidates found (from the seed and from the files) · filed as (ids) · classified as
   kernel / measurement / reading / instance / prior art (one line why each).
2. **Progress and resume**: the milestones filed, in order; the next one to file if the batch stopped early (a successor resumes
   from this line and the committed files — the derivation files are the checkpoint; **commit after each milestone, by path**).
3. **"Theorems this phase proved"** — expected empty: an audit proves nothing new; say so, or state what was proved.
4. **Proposed edits to `CLAUDE.md`** — each as *the exact current sentence* → *the proposed sentence*, with the reason (a
   demotion, an attribution, a grade correction); the owner applies them.
5. **Where the brief was wrong** — a seed entry that was not a theorem, a file that did not exist, a row misread.
6. **The enumeration** — files read in full; files grepped and the grep patterns; files skipped and why.

### S.4 The grep discipline (batch 4 lives or dies by it)

The plan files are too large to read whole (2.7 MB in batch 4). The method: for every file in the batch, `rg -n -i` for
`theorem|lemma|proposition|corollary|claim|derivation|derived|by hand|\[hand\]|\[derived\]|\[cert\]|\[proof\]|we prove|proof:|
QED|∎|iff|if and only if|exactly when|for every|for all|conjecture|not claimed`, read the neighbourhood of every hit (±40
lines), and read in full every §R / "Results" / "Findings" / "Theorems" section and every "Theorems this phase proved" heading.
The report's enumeration section lists the patterns used and the files where each fired. A milestone's ledger row is read first
and its grade-tagged clauses are the seed; the files are then read for what the row compressed away.

### S.5 Acceptance, per batch (scored by the owner before the next batch is briefed)

| # | check | how scored |
|---|---|---|
| 1 | every grade-tagged clause of every ledger row in the batch is accounted for — filed (id) or classified with a reason | the owner reads the census table against the rows |
| 2 | every plan file and record in the batch appears in the enumeration section (read / grepped / skipped-why) | `ls` against the report |
| 3 | every filed entry has all seven fields; **five entries sampled by the owner** — the proof address opens to a proof of the stated theorem; every Lean name cited resolves (`rg` in `Proofs/`) | the owner's spot-check; a missing field or a dead address fails the batch |
| 4 | every entry carries a prior-art verdict with recorded queries or a held key; every *prior art* and every *gap* verdict is checked by the owner (these change `CLAUDE.md`) | the owner reads each |
| 5 | **the owner re-derives one theorem** from its recorded proof, plus every *unsure* | the derivation either closes or the entry becomes *gap* |
| 6 | the owner's blind controls for the batch (P5) | found / missed, recorded in §R |
| 7 | gates green: `tools/bib_audit.py`; `tools/claude_md_fact_audit.py --base <the commit before the batch>` and `--dupes`; `tools/check_architecture.py` | run by the implementer at each commit and by the owner at acceptance |
| 8 | commits by explicit path, one per milestone filed, never push, never amend; no `lake build`; no solver | `git log` |

### S.6 Budget, stop rules, checkpoint

Six Sonnet 5 implementers, one at a time, ~300k tokens each (a fresh one above ~400k — the rotation rule, tightened for a model
we have not run before); no CPU beyond `rg`, `curl` and `lake env lean` for a `#check`; two to three days. **Stop rule:** a batch
ends when every milestone in it is filed, or at the token budget — then the report's progress section names the next milestone
and the successor is briefed from the repository alone. **Checkpoint:** the committed derivation files; **resume:** read
`data/fs71/batch-<n>.md` § progress. A kill redoes nothing committed.

The owner's work per batch: the acceptance table (≈ 30–40k tokens); applying the proposed `CLAUDE.md` edits with the fact audit;
§R below. The close: `LEDGER.md` row 77 (the census's numbers), the grokkings corrected in place with each demotion's refutation
recorded, `plans/FRONTIER-STUBS.md` re-ranked with the kernel targets minted, `CLOSED-QUESTIONS.md` if any re-attribution touches
a posed question, the memory file.

## §R — results (filled per batch by the owner)

| batch | filed | prior art | gap / demoted | controls found / total | re-derived | verdict |
|---|---|---|---|---|---|---|
| 1 | | | | | | |
| 2 | | | | | | |
| 3 | | | | | | |
| 4 | | | | | | |
| 5 | | | | | | |
| 6 | | | | | | |

**Theorems this milestone proved:** none expected; the audit's own products are demotions and attributions. (The G35 correction is
a refutation of a hand claim, recorded in the grokking, not a theorem.)
