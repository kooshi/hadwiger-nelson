# Poros — M63 phase C, before the subplan is committed (2026-09-11)

*Advisory record. Poros states questions; de Bruijn owns every answer, and every construction here is
offered in the hypothetical mood. Not committed by me; the phase's engineer commits it by path at the
close. The paper is `~/source/library/pdf/arXiv-2010.12665-parts-509-minimization.pdf`, extracted
with `pdftotext -layout`; `parts:N` is a line of that extraction, quoted beside the number. Scratch
scripts: `/tmp/claude-1000/-home-kooshi-source-lean-dir/461b308c-55b7-48c5-b5df-641026e31b79/scratchpad/poros-phaseC/`.*

## Survey

**The goal, in the principal's words (Kooshi, 2026-09-11, relayed verbatim by the product owner).**
*"Resume M63 as the product owner … The goal is to reproduce or beat Part's record. […] We can
absolutely beat the record, it is just a matter of implementation."* And, later the same day: *"After
we match or beat it, the next high value tweaks are different base graphs, and the additional ~400
rotation angles that were discovered previously, which should hopefully let us go even smaller."* The
record is `[Parts2020a]`'s 509 vertices / 2,442 edges, `L(374) ∪ ρ₁₅·S(136)` sharing the centre.

**The frame on its five axes, each with where it lives.**

| axis | as the record and the proposed sequence hold it | address |
|---|---|---|
| object | his algorithm: reduction (done), expansion + outer loop (open), rungs; L and S each against a frozen companion | `M63 §2`, `§4`; `parts_stage.py:46-48` |
| question | *can our pipeline walk his recorded path and generalize to held-out problems?* | `M63 §0` ("works on a problem he did not publish the answer to"), `§3` |
| discipline | covering / MCS–MUS duality; symmetric integer programming for rungs | `M63 §O`, `M64 §PA`, `§R10` |
| audience | this repository (a calibration bed for M62) | `FRONTIER-STUBS.md:32` "Bearing: none directly — it is M62's calibrated bed" |
| product | was reproduction and explicitly *not* beating 509 (`M63 §6`); now reproduce **or beat**, then phase G at other rotations and bases | `M63 §6`; Kooshi 2026-09-11 (twice) |

**The gap the survey opens on.** The product axis moved twice today and the question axis did not.
The proposed order C → D → E → F → G still puts *proving we own his loop by walking his path* ahead of
two things the goal needs first: the cheapest test of whether the record needs a loop at all (card 1),
and an expansion rule that finds moves unaided, which is the only kind G can use, since at a new
rotation nothing is published to replay (card 3). His own recorded move is not what his sentence says
(§Measurements M1–M2), so even on his path the move has to be inferred from his files. The data adds one more: the L stage already agrees
with more of his published numbers than the record says, and the one disagreement the record reads as
a fact about *our* stage may be a defect in *his* table (card 2).

## Evidence inventory

*Expectation written before each reading; one item per line, as the gate reads them.*

- `plans/M63-parts-reproduction.md`, whole (794 lines) — read against: gates on |M|, the {M} ranges, the edge decomposition and "{M} grows at fixed M", with the L-side run recorded — surprised: yes; it ends at §R1 (S side) and the L run is recorded only in M64; its phase E table calls state 4 "reduce again" and "the single most diagnostic row … of the algorithm" (M63:420-424), but his own relation A ⊆ W (parts:437) gives |W4| ≥ 412 > 406 = A3, so state 4 re-reduces state 3's working graph at a smaller rung and is a rung relaxation, not a loop move
- `plans/M64-orbit-filling-polytope.md`, whole (765 lines) — read against: L level 3,264 minima, rung lattice free from Y, phase E / P9 unrun — surprised: yes; phase E concludes "our stage is genuinely wider" (M64:355-357) from the tail's multiplicity alone, and the S side's count convention (8 up to Aut(A), M63:760) was never applied to the L level
- `data/m62/m63-L451-reduction.json` — read against: minima counted up to a named group — surprised: yes; `M_set.up_to` reads "as-found frames (no canonicalisation yet)", n = 3264; `A_atoms` = 402, plus the centre = 403, his Table 1 A for this row (parts:772); asks: 11,942 colourable at 0.006 s, 4,741 refusing at 0.02 s, 605 s
- `data/m62/m64-faces.json`, L `symmetry.census` — read against: invariant counts per subgroup of the order-12 stabiliser — surprised: yes; Burnside over it is already his number: identity 3,264, three involutions 40 each, the other four involutions and both cyclic subgroups of orders 3 and 6 at 0, so (3264 + 120)/12 = 282, his |{M}| for L-subgraph M6A at 375 (parts:772 "1 (2) 375 1920-1930 403 282"), and nobody has computed it
- `[Parts2020a]` extraction, whole (1,098 lines) — read against: M63 §PA says every section read — surprised: yes; three details no plan carries: (i) a separate M6B row at 375, "1 (2) 375 1916-1926 403 66" (parts:775), with "The subtypes M6A and M6B do not differ at all (except for the auxiliary orbit (0, 0, 2, 6))" (parts:756-758) and Table 2's 375 {M} column headed "M6A&B" (parts:934), one range column for runs of 282 and 66 minima; (ii) the only expansion on the recorded L path is described by one sentence, which M1–M2 show under-describes it, "adding orbits (0, 0, 0, 4) and (0, 0, 6, 6), and filling orbit (4, 0, 0, 0)" (parts:808-810); (iii) "A 509-vertex graph can be found from scratch in about 100 laptop hours" (parts:862-863) and "Not all options have been studied yet" (parts:872-873)
- `plans/M62-evolutionary-type-m.md` §R11–§R23 — read against: the record attempt's frame failures and the 757 closure — surprised: no; consistent with my 2026-09-10 records; nine 1-minimal descents at 582–609 and pure descent cannot reach the record (§R23)
- `plans/STUB-expansion-measure.md` (FS-35) — read against: re-aimed to a look-ahead with a half-hour precondition on his path — surprised: no
- `plans/STUB-consume-rotation-list.md` (FS-30), sequenced today as phase G — read against: a list of rotations with a non-vacuity gate already run on some — surprised: yes; step 3's one-ask-per-rotation gate has never run on any of the 412 classes, step 2 says the cross-edge law is specific to ρ₁₅ and generalising it is the first code task, and `parts_stage.py:57` builds every stage's cross edges with `T.cross_edges_rho15_fast`
- `data/m62/rotations-moser-r2.05.json`, `rotations-r2.05.json` — read against: rotation classes with families counted — surprised: no; 1,336 classes escape K, 412 type-M admissible, the record's rotation ranked 58 by families; 2,042 and 396 on the other base
- `plans/POROS-2026-09-10-*.md`, `POROS-2026-09-08-mascot.md` (my own track record) — read against: what landed and what the engineer corrected — surprised: no; landed: the fixed-point defect (M62 §R11), §2 and §5.6 unread (§R12, §R19), the closure equality and the free rung lattice (M64 §R10); corrected against me: "3 of the 6 involutions" is 3 of 7 (M64:453-455), and my tail-truncation hunch fired its falsifier (M64:352-354)
- `plans/FRONTIER-STUBS.md` rows M63 and FS-35 — read against: a current-state mirror of the plans — surprised: no
- `tools/parts_stage.py:45-127`, `tools/parts_faces.py:465-538, 671-756` — read against: stage = one deletable side against a frozen companion; rung = subgroup of Aut(A) — surprised: no; `Stage.__init__` refuses any side but L or S, "L and S are minimized separately against a frozen companion" (parts_stage.py:46-48), so a joint stage is unwritable today
- Phase C planner's second report, 2026-09-11 — read against: card 1 adopted and its frame settled — surprised: yes; the relative frame is not one frame but a double coset Stab(W_L)\G/Stab(W_S), giving at most TWO inequivalent joint problems (12 and 6, two cosets of size 12) and four for the M6B stage, so card 1 is two runs and not one; and card 1's positive control is derivable rather than needing a run, since any refusing proper subset of the record with both halves deletable would give a side below 374 or 136 against his published minimality; also measured there: the joint stage is 577 vertices and 576 atoms, his M6B L refuses with S141 in 12 of 24 frames and never with S136, and the S stage's order-3 rung closes at 142 where M64 §R10 had only ">= 139"
- Phase C planner's third report, 2026-09-11 — read against: cards 6 and 7 answered with reasons — surprised: yes; card 6 caught a gap in the audit itself (the 8-4-2-1 accelerator was named among the drops in its report to the product owner while its table carried no row for it at all, now row B-12), which is the second time this phase a card found something the table asserted without carrying; and it corrected my card 6 evidence — the 2^m induced-matching bound is NOT our pipeline's "refused before any ask" guard, since that guard was written for his explicit candidate list and the implicit hitting set never builds one, so X-7 is a re-scope rather than a drop and its replacement forecast lives in phase D
- Phase C planner's fourth report, 2026-09-11 — read against: card 8 either adopted or refused — surprised: yes; it un-drops two audit rows (C-5, the §5.10 indicators, whose sizing role is superseded while its ranking role was never seen; and B-12, 8-4-2-1, on my unverified necessary-atom construction, its phase-1 half staying conditional), restates P6 as "do the indicators rank the orbits his move used above the rest", and leaves the drop list at four cost-control rows plus idealness. It also names the mechanism of its own three misses: the audit was built by walking the plan's promises, so it inherited the plan's blind spots, and what caught all three was reading his paper for a purpose the plan had not named
- Product owner's flag, 2026-09-11: `tools/parts_verify.py` rewrote the tracked `data/m62/parts-ref11-verified.json` (date stamp only) — read against: none of my commands write tracked files — surprised: no; I ran no `tools/` script; every command so far read, or wrote into the scratch directory

## Hunch ledger

*Registered before any check in §Measurements was run.*

hunch: the-L375-level-set-is-his
  claim: the 3,264 minima of the L451 reduction, counted up to the stage's order-12 stabiliser, are exactly 282 orbits, his Table 1 M6A count at 375 (derived by Burnside over the data/m62/m64-faces.json L symmetry census)
  basis: derived
  falsifier: a direct orbit count of the 3,264 minima under the stage's 12 atom permutations that is not 282
  registered: 2026-09-11
  status: confirmed (by: the phase C planner's solver-free probe that rebuilt the L451 stage with a matching fingerprint, reported 2026-09-11 — 282 up to Aut(A) of order 12, also 282 under the full base group, 3,264 with the companion fixed; our A equals his v403e2112 literally, 0 vertices differ; his v375e1920 is one of our minima, 12 group images in the level set; his M6B v375e1916 is not in the level set nor inside our A under any group element)

hunch: the-tail-is-in-his-282
  claim: his 282 includes the two tail profiles, f(2,0,6,4) = 5 and 6, so the printed 375 ranges for (2,0,6,4) "0-4" and (10,0,2,4) "8-12" are the defect, not our stage (with the tail's 144 raw minima removed the body gives at most 270 orbits)
  basis: derived
  falsifier: the body minima alone give 282 orbits, or a tail minimum's L-edge count lies outside his attested 1920-1930
  registered: 2026-09-11
  status: confirmed (by: the planner's re-derivation, 2026-09-11 — 282 minima up to Aut(A), our A equal to his v403e2112 literally, the tail minima at 1925-1926 L-edges, inside his attested 1920-1930, and the fewest-edge members' stabiliser 2 matching his "1 (2)"; so his printed 375 range column is the defect and our stage is his). Earlier note: P9 is moot by mechanism, not only by count: the stage has 24 off-centre connection edges (W's auxiliary fill is 12) but every one of the 3,264 minima realises exactly 18, through one 6-subset of the auxiliary orbit shared by all, and deleting atoms no minimum uses leaves the level unchanged (planner 2026-09-11)

hunch: the-recorded-path-has-one-expansion
  claim: his M6A L path is a rung relaxation (1 to 2), one named expansion with a rung change (2 to 3, parts:804-810), and a rung relaxation on the same working graph (3 to 4, since A ⊆ W gives |W4| >= 412 > 406); so A406 = v406e2082 and A412 = v412e2106 each lie, up to a group element, inside A403 = v403e2112 plus the full orbits (0,0,0,4), (0,0,6,6), (4,0,0,0), and A406 lies inside A412 (rung-2 minima of W3 at size 374 are rung-1 minima of the same W at the same size)
  basis: derived
  falsifier: v406e2082 or v412e2106 not inside any group image of v403e2112 plus those three orbits, or v406e2082 inside no group image of v412e2106
  registered: 2026-09-11
  status: killed (by: §Measurements M1 (b), (c), (e), minimum leftovers 6, 12 and 6 over all 24 group elements, located by M2 in the other halves of (0,0,2,2) and (0,0,2,6); the sub-claim A406 ⊆ g(A412) held, M1 (d), 12 of 24 elements; what the miss cost: one wrong sentence in the card-1 message to the planner, corrected within the hour)

hunch: his-stated-priority-singles-out-the-unnamed-fills
  claim: in v403e2112 the partially filled base orbits of size 6 or 12 are exactly (0,0,2,2) and (0,0,2,6), so the priority at parts:522-524 ("priority should be given to partially filled base orbits, and especially to orbits with a small number of vertices (6 or 12)") picks out the unnamed half of state 3's move
  basis: measured
  falsifier: any other partially filled base orbit of size 6 or 12 in v403e2112
  registered: 2026-09-11
  status: killed (by: §Measurements M3 — v403e2112 has four partially filled size-12 orbits, (0,0,2,2), (0,0,2,6), (10,0,0,2) and (14,0,0,2), each 6/12, and none of size 6; the move filled the two of lowest degree into A403, maximum degree 4 at ranks 33 and 34, and left (10,0,0,2), degree 6 at rank 8, and (14,0,0,2) at 6; what it cost: nothing sent on it)

hunch: the-named-additions-meet-his-reserve-condition
  claim: (0,0,0,4) and (0,0,6,6) each have a vertex of unit-distance degree at least 4 into v403e2112, the condition for joining the reserve graph at parts:517-521 ("if, when added to the graph A, the degree of some of its vertices is at least 4")
  basis: prior
  falsifier: either orbit's maximum degree into v403e2112 below 4
  registered: 2026-09-11
  status: open — the pre-registered exact test passed (§Measurements M3: (0,0,0,4) has maximum degree 6 into v403e2112 with exactly 3 of its 6 absent vertices at degree 4 or more, (0,0,6,6) maximum degree 6 with 12 of 12, ranks 6 and 7 of 49 reserve-eligible orbits; into M6B's v403e2106 both again at degree 6, ranks 6 and 8); left open until the engineer re-derives M3, because a prior hunch is confirmed only by a derivation or a registered replication, and my scratch script is neither

hunch: the-joint-minimum-on-his-accumulators-is-509
  claim: over L ⊆ A412 and S ⊆ A166 in the record's frame, both sides deletable and the centre shared, the minimum refusing union has exactly 509 vertices (the accumulators were grown by alternating runs against these companions; about 35% on strictly fewer)
  basis: prior
  falsifier: a joint refusing selection of 508 or fewer vertices
  registered: 2026-09-11
  status: open

hunch: 509-is-still-the-record
  claim: no 5-chromatic unit-distance graph with fewer than 509 vertices has been published or posted as of 2026-09-11 (recalled, not read)
  basis: prior
  falsifier: a paper, preprint or Polymath16 post with a smaller certified graph
  registered: 2026-09-11
  status: open — a web search on 2026-09-11 ("smallest 5-chromatic unit distance graph fewer than 509 vertices new record") returned a generated summary saying the 509-vertex Parts graph remains the smallest known as of August 2026, beside arXiv:2608.04542 (Haugland, August 2026); that paper is not read here, so this stays a held claim addressed to the phase's prior-art gate

## Cards

*Ranks are file-wide and in the order the cards were written, not in order of what is live: cards 1–5
are adopted or answered, and of those only card 1's run is still outstanding. **This turn's lead is card
6**, the ask-cost regime, with card 7 behind it; both went to the planner on its second consult.*

*Card 1 sent to the phase C planner (`a08bd9467b4d58bc3`) in full before its skeleton, cards 2–4 by
pointer. Dispositions reported by the planner on 2026-09-11, provisional until the product owner
approves: card 1 ADOPTED as phase C's record-bearing experiment, gated on an exact-resume path for
`reduce_stage` (its checkpoint pickles state and has no resume); card 2 ADOPTED and answered in its count
half (282), retiring most of "make L agree"; card 3 sent to the product owner with the planner
recommending the rule-must-find-the-move branch; card 4 reassigned as G's opening gate, with Stage taking
the cross-edge law as a parameter in C and full rotation generality declined until the census runs.*

question: does-the-record-survive-joint-reduction-on-his-own-accumulators
  evidence: Stage(v374e1860, v136e564) in their stored frames IS the 509, with 2,442 edges and 18 connection edges (M63:748-751). v374e1860 ⊆ v412e2106 literally (M63:164), and six of the 24 group elements put v136e564 inside v166e774 (M63:161-163), so W = A412 ∪ ρ·g(A166) in the record's frame contains the record. Every run so far froze one side (parts_stage.py:46-48 refuses a joint stage), and Table 1's M-type rows have blank A and {M} (parts:768-769), so he never reduced jointly either. The stage instrument is cheap: the L451 exhaustive level took 11,942 colourable asks at 0.006 s and 4,741 refusing asks at 0.02 s, 605 s in all. His recorded L path's one expansion is only partly named (parts:808-810): his own files show it also filled the other halves of (0,0,2,2) and (0,0,2,6), and "filling orbit (4, 0, 0, 0)" is a no-op on v403e2112 (§Measurements M1–M2). Phase G runs the loop at rotations and bases where no accumulator is published and no companion exists to freeze.
  expected: C, D, E, F run the loop and the held-out set before the cheapest test of whether beating 509 needs a loop at all
  ask: with both sides deletable over his own published accumulators A412 and A166, is the minimum refusing union 509 vertices, or fewer?
  if 508 or fewer: the goal is met on his data before any loop; certify it in the kernel, D and E become reproduction studies, and the joint stage goes to G as its starting instrument
  if exactly 509: the record is a joint local optimum of his material, so beating it needs vertices outside A412 ∪ A166; D's expansion is then necessary, the state it should expand is the joint level set rather than the L level set, and G inherits the same joint stage
  answered by: run — a joint side in Stage (deletable = both halves minus the centre and the pin), then reduce_stage bounded to closing the optimum with a small max_minima, before any loop is built
  cost: a few lines of code plus one run; unmeasured at about 576 atoms, estimated tens of minutes to a few hours from the L451 ask costs
  hunch: exactly 509, with about 35% on fewer
  falsifier: a joint refusing selection with 508 or fewer vertices
  rank: 1

question: is-the-L375-level-set-already-his
  evidence: data/m62/m64-faces.json, L symmetry census over the 16 subgroups of Aut(A), order 12: identity 3,264; three involutions 40 each; every other cyclic subgroup 0. Burnside gives (3264 + 120)/12 = 282, his M6A count at 375 (parts:772, "1 (2) 375 1920-1930 403 282"). A_atoms 402 plus the centre = 403, his A for that row. The record's M_set.up_to is "as-found frames (no canonicalisation yet)"; the S side's convention, 8 up to Aut(A) (M63:760), was never applied to L. With the tail's 144 raw minima removed the body gives at most 270 orbits.
  expected: M64 phase E's reading, "our stage is genuinely wider" (M64:355-357)
  ask: does a direct orbit count of the 3,264 minima give 282, and do the tail minima's L-edge counts lie inside his attested 1920-1930?
  if both hold: his 282 contains the tail, so the defect is Table 2's 375 range column (headed "M6A&B", parts:934, one column for runs of 282 and 66 minima); P9 is moot and phase C's agreement gate is met by reading, so close it in an hour and move on
  if either fails: the 282 and 403 agreements are coincidences against an attested number; the stage is not his, and identifying his L-run companion becomes phase C's real work before any loop
  answered by: run — orbits under parts_faces.stage_symmetry's 12 permutations; the L-edge count of each minimum from the stage's edge list
  cost: seconds, no solver
  hunch: both hold (ledger: the-L375-level-set-is-his, the-tail-is-in-his-282)
  falsifier: a direct count other than 282, or a tail minimum with an L-edge count outside 1920-1930
  rank: 2

question: what-does-reproduce-or-beat-accept
  evidence: the goal is "reproduce or beat" (Kooshi, 2026-09-11); M63 §0's product was "we own the loop that can, and it works on a problem he did not publish the answer to" (M63:16-17). His recorded path's one expansion is only partly named (parts:808-810; M2 finds two unnamed half-orbit fills and a no-op), states 3–4 replay as one reduction of his own A412 with no expansion step (M2 reading), his own stated rule applied literally to A403 does not select that move (M3), and phase G, at rotations nobody has published, can replay nothing. His tie-break is fewest edges (parts:83-85, "it is customary to choose among these the graph with the fewest edges"). The kernel pipeline already certifies Heule-510 (CLAUDE.md Frontier), and M63 §O(4) priced certifying the 509 at an afternoon and declined it (M63:639-647).
  expected: one acceptance sentence per claim, each a test that can fail
  ask: does "reproduce" mean replaying his named moves, a pre-registered rule finding the move, or held-out generalization, and does "beat" mean strictly fewer vertices?
  if replaying suffices: M63 closes its reproduction claim on the replay of states 3 and 4, whose inputs and outputs are both published, E is optional, and scoring an expansion rule moves to G's opening
  if a rule must find the move: D freezes an expansion rule and scores it by outcome, whether it reaches a 374-vertex level from A403 within a stated budget of expansions and asks, not by whether it ranks his move first, since his own stated rule does not select his move (§Measurements M3); G inherits a rule tested on the one path whose answer is known
  answered by: Kooshi, through the product owner
  cost: one message
  rank: 3

question: how-many-admissible-rotations-refuse-four-colours-at-all
  evidence: data/m62/rotations-moser-r2.05.json: 1,336 rotation classes escape K and 412 admit both essential kinds; the record's rotation ranks 58 by family count. The files store only the top 150 and top 200 classes, not all 412 and 396, and were sieved on the Moser lattice's radius spectrum rather than his §5.6 lattice, so G must re-sieve (planner, 2026-09-11). The planner derived that any rotation with cos θ ∈ K and sin θ ∉ K keeps the ρ₁₅ law's shape (cross edges only between centre-collinear points, one parameter), so only classes with cos θ ∉ K need a new law. STUB-consume-rotation-list.md step 3 names a one-ask non-vacuity gate per rotation and it has never run; its step 2 says the cross-edge law is specific to ρ₁₅, and parts_stage.py:57 builds every stage with T.cross_edges_rho15_fast. parts:288: "Working constructions of type M with other rotations are not known yet."
  expected: the product owner has asked C to F to take rotation and base as parameters where cheap, before anyone knows whether the rotation menu has more than one item
  ask: of the 412 admissible rotation classes, how many give a full arena that refuses four colours?
  if only the √15 class: G is a base-graph phase; rotation generality in C to F buys nothing and should be declined rather than paid for
  if several: G is a real menu, the cross-edge law and Stage must be rotation-generic before D is built, and each passing rotation is a working type-M construction of the kind parts:288 says is not known, before any minimization
  answered by: run — the cross-edge law generalised in exact arithmetic, then one refusal ask per rotation on a base that passes at ρ₁₅
  cost: the law is up to a day of code; the census is 412 asks at seconds each
  rank: 4

**Default proposed for card 3 (superseded by the answer below; its held-out clause was rejected):** *reproduce* = the replay of states 3–4 from our own A403 plus
the assembled `L374 ∪ ρS136` at 509/2,442 refusing four colours, built from our own minima; *beat* = a
kernel-certified unit-distance graph with fewer than 509 vertices as the headline, and 509 vertices
with fewer than 2,442 edges reported as a secondary record under his own convention; held-out runs
reported as not run if not run.

**Fate of card 3 — answered by the product owner, 2026-09-11.** A rule must find the move, and the
held-out runs are required; the default's clause *"held-out runs reported as not run if not run"* is
rejected. *Reproduce the record:* our own `L374 ∪ ρS136`, 509 vertices and 2,442 edges, refusing four
colours (SAT on exact geometry; no kernel certificate for a known object). *Reproduce the algorithm:* the
replay of states 3–4 kept as a control only; a rule registered before it runs, started from A403 without
his orbits, must reach |M| ≤ 374; where the move his files imply ranks under that rule is reported as a
diagnostic (M3 says his own stated rule would not rank it first); `{M}` must grow at a fixed |M| at least
once in an iteration the rule drove (card 5 asks whether a rung relaxation counts). *Generalization:*
phase E required, with at least one held-out run starting below his accumulator, for example from a
single published minimum. *Beat:* fewer than 509 vertices as the headline, 509 vertices with fewer than
2,442 edges as the secondary, either a record only once kernel-certified. Confidence as given: high,
medium on the start-below-A form of E.

question: does-a-rung-relaxation-satisfy-the-growth-clause
  evidence: the product owner's acceptance test requires "{M} must grow at a fixed |M| at least once in an iteration the rule drove" (2026-09-11). M64 §R1 (M64:446-451): on the L451 stage with no expansion, the live involution's rung returns 375 vertices with 40 minima and the trivial rung returns 375 with 3,264, so a rung relaxation alone grows {M} at fixed |M|. His own 78 to 1092 at 374 (parts:770-771) looks like the same kind of event: A406 lies inside a group image of A412 (§Measurements M1 d), which one working graph reduced at rung 2 and then at rung 1 predicts (M2 reading). M64 §R10 makes every rung's minimum free from Y.
  expected: the clause is meant to show the loop's expansion step working, as M63 §3's gate row 4 intended ("a pipeline that can grow {M} at fixed M is running his loop", M63:422-424)
  ask: does growth of {M} from a rung relaxation on an unchanged working graph count, or only growth after the rule added vertices, at a fixed rung?
  if a rung relaxation counts: the clause is met by any live rung at no expansion cost and tests nothing about the rule, and the acceptance sentence should say so
  if only expansion-driven growth counts: D must show, at one fixed rung, an expansion the rule chose after which |M| is unchanged and {M} is strictly larger, which is the event M63's gate row 4 meant
  answered by: Product owner (the main session)
  cost: one message
  rank: 5

**Fate of card 5: adopted as recommended by the product owner, 2026-09-11.** The clause now reads:
`{M}` grows at a fixed |M| **and a fixed rung**, in an iteration where the rule has added vertices. A rung
relaxation alone does not count, and his 78 → 1,092 stays a replay-control comparison. The planner has
the change. The M3 priority and degree rankings went to the planner as diagnostics to re-derive before
use.

question: is-the-drop-argument-conditional-on-a-regime-F-and-G-leave
  evidence: the gap audit proposes dropping seven items — the cheap Y statistics (component profile, alpha, the 2^m induced-matching bound), P4-P7, the 8-4-2-1 accelerator, the symmetry-setting pendants, the per-lever measurement and the parallel level sweep — argued from ask costs measured on the two FROZEN-COMPANION stages: L451, 11,942 colourable at 0.006 s and 4,741 refusing at 0.02 s; S166, 13,176 at 0.009 s and 3,076 at 0.108 s (the two reduction records), against his own 1 and 10 s (parts:643-644). On this project's own type-M objects with no frozen companion the same asks cost 10-15 s refusing and up to 2.8 s colourable, with one refusing ask killed at 17 minutes (M62 §R23), and M62 §R22 derives that the variable is slack over the nearest refutation, not size. The joint stage is the first object in this milestone with no frozen side: 577 vertices, 576 atoms. The dropped items are exactly the cost-control ones, including M63 §E's level forecast, whose 2^m bound is what REFUSES a level before any ask.
  expected: a drop argued from a measured regime carries that regime as its condition
  ask: what do a full-W refusing ask and a handful of near-optimal asks cost on the joint stage, and do they stay within an order of magnitude of the frozen-companion stages?
  if within an order of magnitude: the drops stand for C to E, with the measured regime recorded as their condition and re-tested at F's first expanded W and at G's first non-rho15 arena
  if they rise tenfold or more: the 8-4-2-1 accelerator, the 2^m level forecast and the parallel sweep are exactly the instruments F and G need, so they are kept rather than dropped, and card 1's run needs its resume path in fact and not only as hygiene
  answered by: run — about twenty asks on the joint stage as built, before the drops go to the product owner
  cost: minutes, and a by-product of building the joint stage anyway
  hunch: the pin and the incremental solver carry most of the speed, so costs rise but stay under a second; I would not bet past 60%
  falsifier: joint-stage asks at the frozen-companion costs (about 0.02 s refusing), or above one second
  rank: 6

question: which-held-out-problem-tests-the-loop-hardest
  evidence: the product owner requires at least one held-out run starting below his accumulator. The planner proposes the S side from a rung-2-symmetric 138-vertex minimum, whose containment of any 136-minimum is forbidden by M64's closure gap. But the S stage is this milestone's tuning case (M63 §R1's decisive experiment, A166 to 136 with 8 minima), so it is no longer held out, and its companion is a frozen L-graph, the companion type already exercised. Unrun, in Table 1, and on the base: the 8/3 mono-pair, A375 to M367 with 27 minima and Table 5's own ranges, whose companion C is an edge — which M63 §3 calls the sharpest of the held-out set, because it exercises the companion abstraction, the piece most likely to be modelled as a special case. His v367e1822 is a single published minimum and M63 §1(vi) confirms it is on the base.
  expected: one run that is held out, starts below A, and exercises a companion type nothing has exercised
  ask: should E's required run be the 8/3 mono-pair started from his single published minimum v367e1822, with the S-138 run kept as the expansion-mechanism control?
  if yes: E tests held-out generalization, the edge companion and expansion at once, against three attested targets — 367 vertices, 27 minima up to the group, and A = 375 with Table 5's ranges
  if the S-138 run stays the required one: E tests expansion on the tuning case with an already-exercised companion, and the held-out requirement is carried only by the other runs, which do not start below A
  answered by: Planner (de Bruijn, phase C), with the product owner's acceptance in hand
  cost: one decision; the mono-pair run is one reduction plus expansions, comparable to the S runs
  hunch: the mono-pair from v367e1822 is strictly stronger, and the S-138 run is worth keeping as the control, because its obstruction is derived
  falsifier: the mono-pair cannot start from a single minimum because the expansion rule's reserve needs an accumulator that one minimum does not supply
  rank: 7

**Fates of cards 6 and 7, and of the roadmap answer — the planner, 2026-09-11.** Card 6 adopted as
**C4.0**: the joint stage measures its own ask costs as a by-product of being built, before the drops
take effect; the drops stand for C–E only, with the measured regime as their condition, re-tested at F's
first expanded W and G's first non-ρ₁₅ arena, and the cost-control items return if costs rise tenfold. My
hunch is registered there as **P-C4.0 at 60%** with my falsifier. Card 7 adopted with the roles swapped:
the **8/3 mono-pair from v367e1822** is phase E's required held-out loop run, against 367 vertices, 27
minima up to the named group and A = v375e1862 with Table 5's ranges, and the S-138 start becomes the
mechanism control. The roadmap answer is adopted in both halves: the disk-radius re-test is **F(g)**, and
the kernel-certification budget is carried in F's acceptance; the joint runs go first in wall-clock order
(§3). **Correction to card 6's evidence, accepted:** the 2^m bound is not our guard (see the inventory).

question: is-his-published-expansion-ranking-device-the-one-D-should-register
  evidence: M3 scored his §5.6 priority sentence and his §5.6 reserve rule, and neither selects his recorded move. His paper carries a third device I did not test: §5.6's third strategy, "preliminary cycle of quick verification (to a small hyperedge degree) of the entire list of new vertices (with the addition of one or two orbits at each iteration) and allocation for further study of the most promising orbits by numerical indicators (see 5.10)" (parts:546-549), whose indicators are "the number of free vertices, the number of hyperedges of some small degrees, the order of the maximum independent set for hyperedges of degree 2" (parts:710-712). Those are hypergraph quantities rather than geometry, and they are the only published device that ranks candidate expansions. M63's P6 — that the §5.10 indicators are subsumed by exact.py's hitting-set bound — is among the P4-P7 predictions the audit proposes dropping, so nothing in the phase now tests them.
  expected: D registers a rule of our own, because his stated rules failed M3
  ask: does his §5.6 third-strategy device, run on candidate orbit additions to A403, rank the four orbits his move used above the rest?
  if it ranks them top: D registers his own published device as the rule, M3's negative localises to two sentences rather than to his method, and the rank diagnostic the product owner asked for becomes informative
  if it does not: no published device predicts his own recorded move, so D's rule is ours alone and can only be scored by outcome, as the owner's clause already requires, and the record says plainly that his expansion craft is not reproducible from the paper
  answered by: run — the indicators, beside our hitting-set bound, on about fourteen candidate expansions of A403 (the four partial fills and the top ten reserve orbits), each needing a small-degree hyperedge census of the enlarged stage
  cost: roughly six thousand asks, tens of minutes at the stage's measured costs, and it discharges P6, which is on the drop list
  hunch: the indicators separate his four from the rest better than degree does, being about the constraint structure rather than the geometry; held at about 50%, since M64 §R9 measured that summaries at this level can wash out a real coupling
  falsifier: his four orbits do not all rank in the top half under any single §5.10 indicator
  rank: 8

**Fate of card 8 — adopted by the planner, 2026-09-11.** C-5 and B-12 leave the drop list, P6 is
restated as the ranking question rather than retired, and phase D now scores HIS device before
registering anything of ours, with the card's if/then written in. My necessary-atom construction is
recorded in D as mine and unverified.

question: what-does-a-capped-joint-level-leave-as-the-loops-state
  evidence: card 1's own "answered by" line says reduce_stage "bounded to closing the optimum with a small max_minima", and the planner adopted that as C4.0/C4a. But A is his loop's state variable and is defined as the union of ALL minima (parts:437-439), and his §5.5 permits stopping a step when its candidate count exceeds a threshold (parts:496-497) — which is why M63 §3(b) calls his {M} "complete-or-truncated and he does not say which" and his 1092 un-gateable. His §5.7 documents the enumeration ORDER, deleted sets "ordered by decreasing number of vertices" (parts:567-569), so a truncated run of his carries a stated bias; our implicit hitting set has no stated order, so a capped level is a sample of {M} with nothing bounding which members it holds. The joint level may be large: the L level alone is 3,264 and the S level 48.
  expected: the audit carries §5.7 in its sizing role, his explicit enumeration superseded by the implicit hitting set, and the cap as a budget knob
  ask: if C4a caps the joint level, is that capped union used as A anywhere downstream, and if it is, what bounds its bias?
  if the value only: the artifact says so — the run answers "is the minimum below 509", its union is a SAMPLE and never A, and no loop may start from it
  if the loop will continue from it: the level is run to exhaustion, or its completeness is checked by the control M64 §0(ix) describes, with the predicted affine hull coming from correction sets derived by ask rather than from the level set itself, since that circularity is why M64's P10 went unscored
  answered by: Planner (de Bruijn, phase C)
  cost: one line in the plan, or one completeness check per capped level
  hunch: the value only for C4a, and F's continuation is where a capped union would silently become the state
  falsifier: the plan already names the capped union a sample rather than A
  rank: 9

**Fate of card 9 — adopted by the planner, 2026-09-11, and its falsifier did not fire.** The plan called
the capped union a sample nowhere, and phase F(a) read *"if C4 reads 509, run the rule-driven loop on the
joint level set"* — a loop starting from a capped union, a sample standing in for the state variable. Now:
a capped record writes `A_sample` and no `A` field at all; no loop may start from one; F(a) must first
exhaust the level or check completeness by M64 §0(ix)'s affine-hull control, with the hull predicted from
ask-derived correction sets. Both side notes adopted: his §5.6 symmetry guess becomes a free check in C2
against his own fifteen rows, surviving into G's fresh arenas where no stage exists yet; and the √3 timing
provenance becomes a caveat on B-11's drop, so a timing compared with his 0.2 s must say whether the
five-vertex assignment was on.

## Expectations registered before the implementation reports

*Written 2026-09-11, before the implementer (`a08e74175d1c85358`) reported anything. The plan is
approved: `plans/M63-phaseC-joint-stage.md` §A, commit `6db2230`, with every card's fate in its §7.
C4b is approved, the joint run launches as early as it is safe, and the table-shading extraction is
capped at about two engineer-hours before the partition is reported unattested.*

- **C4.1, the joint positive control** — over `W` = the record itself, both halves deletable, the
  minimum must be **509, the whole working graph**, i.e. exactly M63 §O(5)'s verdict word
  **`no-reduction`**. The derivation, with the planner's correction and upward closure doing the work
  it needs: any refusing proper subset, trimmed on either side or on both, is contained in
  `L' ∪ ρS136` with `L' ⊊ L374` (or in `L374 ∪ ρS'`), which then refuses by upward closure and
  contradicts his published minimality. So **every vertex is critical** and the census should read 508
  critical atoms, 0 droppable, 0 undecided. **A reduction here is a fault in our stage — cross edges the
  record's frame does not have, a mishandled pin or companion — and never a find.**
- **C4a, the joint run proper** — minimum ≤ 509 by construction. My ledger hunch says exactly 509, with
  about 35% on fewer. If it reads below 509, the first act is not celebration but the geometry: exact
  arithmetic on every edge of the object, and its refusal certified, before the word record is used.
- **C4.0, the ask costs** — registered as `P-C4.0` at 60%: above the frozen-companion regime
  (0.006 s colourable, 0.02–0.11 s refusing) but under one second.
- **C2's M6B run** — reducing `v403e2106` against companion `v141e594` (the planner measured that his
  M6B L refuses with S141 and never with S136) at rung 1 should return **375 vertices, 66 minima up to
  the stage stabiliser, A = v403e2106 as a set, edges 1916–1926** — his own Table 1 row.
- **Card 8's run** — his four orbits rank in the top half under at least one §5.10 indicator, at 50%.

**The implementer registered all five on 2026-09-11** (`a08e74175d1c85358`), scoring each by name,
and added its own order: the cross-edge law as a parameter, the ask wall, exact resume and the minimum
driver, then c4.1–c4.3 and C4.0, then the predictions committed and C4a launched, with C1.3–C1.8, C2 and
C3 running while it goes. It also recorded a probe incident worth keeping: its first wall probe hung
because an unwalled hard ask followed the walled one, and *"the wall did nothing"* and *"the wall worked
and the next ask hung"* are indistinguishable from outside — which is the failure mode the wall exists to
make visible.

**One hardening sent on that order, 2026-09-11.** C4.0's numbers decide four drop rows at a tenfold
threshold, and contention can manufacture a tenfold reading on its own. Its order does measure C4.0
before the concurrent work starts, so this is hardening and not a fault: record the ask costs in **CPU
seconds, user plus system, minimum of three runs, with the machine and the concurrent load named**
(`CLAUDE.md` § Two machines), and apply the same discipline to the re-tests at F's first expanded W and
G's first non-ρ₁₅ arena, where the box will not be quiet.

**c4.1 scored, 2026-09-11: met exactly, no departure in either direction.** Verdict `no-reduction`;
bound *minimum 508 over all selections* (508 atoms + the shared centre = 509 vertices); level 1 minimum,
`exhaustive-level`, 0 undecided; phase-1 census 508 critical, 0 droppable, 0 unknown; about 510 asks, 72 s
on one core with another light job on the box, so reported as indicative and **not** as the C4.0
measurement. It also discharges the unchecked half of M63 §4 phase B's control (B-10), and the planted
S-omission fired solver-free, because the buggy expression is literally the L-only stage's deletable set.
**A no-surprise reading, and the finding is that the sharper form was load-bearing:** "it refuses" would
have passed on a stage carrying spurious cross edges; 508 critical with exactly one minimum would not.

**P-C1.2 falsified by the implementer, and the shape is this phase's recurring one.** PySAT's CaDiCaL does
not implement `interrupt()`: it raises `NotImplementedError` inside the timer thread, where it is printed
and swallowed while the ask continues. The wall is now a loop of conflict slices under a time wall, with
a control showing that `unknown` is neither impossible nor automatic, and every undecided count is
reported with its slice size and slice count. **My C4.0 hardening is adopted** — user+sys, three runs, the
32-core desktop named, no other job of its own running, and the discipline recorded so the F and G
re-tests inherit it.

question: has-the-resume-path-been-killed-on-purpose
  evidence: card 1's run was gated on an exact-resume path, because reduce_stage's checkpoint pickles state and has no resume (planner, 2026-09-11), and WORKFLOW's rule asks in writing "if this process dies at any instant, what does the relaunch redo?" This phase has already produced one instrument that looked right from outside and was not: PySAT's CaDiCaL raises NotImplementedError inside the timer thread, printed and swallowed, while the ask continues. A resume that silently restarts, or that resumes with a stale Y or a stale incumbent, is indistinguishable from a working one except in the wall clock — the same shape, on the one run the milestone's goal rides on.
  expected: the resume path is built, and its correctness inferred from reading the code
  ask: has a kill been planted mid-run, and the relaunch watched to continue from the checkpoint with the same bound, Y and level members?
  if it resumes exactly: C4a launches, with one line recorded — what the relaunch redoes at worst, which should be the in-flight conflict slice
  if it restarts, or resumes stale: fix it before C4a launches rather than after, because a silent restart reads as a slow run and not as a fault, and the long run is the one that pays
  answered by: run — one planted kill on an S-sized reduction, comparing the resumed record's bound, |Y| and level members against the checkpoint's
  cost: minutes
  hunch: it resumes; the risk is not the restart but a stale Y silently narrowing the level, which would read as a clean run with a smaller level set
  falsifier: a planted kill whose relaunch reproduces the pre-kill bound, |Y| and level members exactly
  rank: 10

**Card 10 answered, 2026-09-11, and answered before the driver existed.** `parts_reduce.py
--resume-control` on the S166 stage at its order-3 rung: uninterrupted it reproduces the fixture (55
atoms, 21 minima, minimum 141 + centre = 142, 129 correction sets, 67 s); killed at iteration 58 of 82 by
a planted exception and relaunched, it returns **resume-identical: True** — the 21 minima as a set, the
bound and the method all agree — with the pre-kill Y prefix preserved (92 of 92) and Y overall 129
against 135, reported and not gated. The plant is watched to fire. **My stale-Y risk is derived away
rather than waved off:** Y enters only as hitting-set constraints, so a stale, smaller Y is *fewer*
constraints, admitting more candidates at a lower-or-equal optimum, each verified by an ask before it is
recorded; only a blocking clause ever removes a selection, and those are added only for recorded members.
A stale Y costs iterations, never members. **The mirror direction is the fault**, and it is the
implementer's own: a checkpoint restoring an *unverified* correction set adds a constraint that is not
true, and `mhs(Y)` could then exceed the truth, turning the lower bound into an unsound optimality claim.
`--verify-checkpoint` is not wired, and §R2 will say so rather than imply otherwise. **What a relaunch
redoes at worst:** the in-flight ask, an in-progress correction-set shrink entire (up to a few hundred
asks on the joint stage), and up to 30 s of completed level iterations — never a restart.

**c4.2 and c4.3 fired** (`pin-agrees-everywhere`, 12 checks; `joint-degenerates-to-L`, 20 of 20 seeded
selections agreeing verdict for verdict with the L-only stage), so C4a's three controls are complete.
**Slice granularity:** no ask has yet exhausted a slice — c4.1 used exactly 509 slices for 509 budgeted
asks — and the longest single ask observed anywhere is **4.18 s CPU**, the full-graph refusal on the
record stage.

**The early cost reading, on the record stage rather than the joint one.** Colourable asks **0.093 s CPU**
against 0.006–0.009 with a frozen companion; refusing asks **4.18 s** against 0.02–0.11. That is 10–15×
and 40–200×. **`P-C4.0` (mine, at 60%: above the frozen-companion regime but under one second) is
provisionally falsified on the expensive population and met on the cheap one**, and the implementer will
score it on the joint stage's own numbers, which is what the prediction names. Recorded here before those
numbers land, so the scoring is not retrofitted.

question: is-C4a-affordable-un-accelerated
  evidence: the early reading above gives 10-15x on cheap asks and 40-200x on expensive ones. The condition attached to card 6 was "if they rise tenfold or more, the cost-control items come back", and two dropped rows are exactly what pays here: 8-4-2-1, which turns eight expensive refusing asks into one on a phase-1 census (parts:649-656), and the parallel level sweep. Scaling the L451 run's own ask counts (11,942 colourable, 4,741 refusing) at the record stage's costs gives about 1,100 s plus 19,800 s — roughly six hours on one core — and C4b doubles it. M63 §E's rule is that a level is forecast before it is entered, never after, and the forecast prints the assumption it rests on.
  expected: C4.0 is measured, P-C4.0 scored, and C4a launched at whatever it costs
  ask: before C4a launches, what does its own C4.0 numbers forecast for it, and is it worth launching un-accelerated at that price?
  if the forecast is about an hour: launch as planned, and the drops stay conditional for F and G only
  if it is hours: re-instate 8-4-2-1 for the phase-1 census, where by construction it is eight expensive asks into one, and the parallel sweep for the level, before launching rather than after — the resume path makes a long run survivable, not cheap
  answered by: run — arithmetic on C4.0's two populations and the stage's atom count, minutes
  cost: minutes, and it is M63 §E's own discipline applied to the run the milestone rides on
  hunch: hours rather than an hour, because the joint stage's late asks sit at the threshold where the 4.18 s was measured
  falsifier: a joint-stage refusing population averaging under half a second
  rank: 11

**Card 11 answered empirically, 2026-09-11, and my hunch is killed.** C4a was already running when the
card arrived. In-run, the joint stage reads **1,231 colourable at 0.029 s and 322 refusing at 0.27 s**
(phase 1: 576 asks, 85 s, 423 critical / 153 droppable; level loop at iteration 57, lower bound 440, 479
correction sets). That is **6× and 6.5× cheaper than the isolated C4.0 figures** (0.170 and 1.758), and
the reason is the incremental solver: C4.0 asks on a fresh oracle, minimum of three, which is the right
way to measure one ask reproducibly and the wrong way to forecast sixteen thousand of them on a solver
that keeps every clause it learns. **`P-C4.0` is killed** — its falsifier (a joint refusing population
averaging under half a second) fired at 0.27 s — and with it my card-11 forecast of six hours; the
implementer expects under an hour, reporting rather than killing at four. **The residue that matters:
the drop condition attached to card 6 ("if they rise tenfold or more") must name the IN-RUN population,
because the isolated figures overstate a run by about six-fold and four rows hang on that threshold.**
Also: C4b now runs **concurrently** with C4a on the product owner's call, measured rather than assumed —
C4a's resident memory is 273 MB, and the one-heavy-job rule exists for jobs that have taken this desktop
down. And one instrumentation incident the implementer reported against itself: its pgid file held the
pid of the `setsid` wrapper, which forks and exits, so `kill -0` reported the job dead while it ran at
100% CPU; it gathered the facts before reporting, and both files now hold the real process group. **A
monitor that says "dead" when it has lost the handle is the same class as a wall that says nothing when
it cannot fire** — the third instance of that shape today.

question: what-predicts-a-batched-group-ask
  evidence: 8-4-2-1's payoff was modelled as p^8 in the per-atom droppable density — 153/576 = 27% on the joint stage, 0 on the record stage — concluding the lever loses. But a group ask deletes the UNION, and deleting D preserves refusal exactly when D contains no correction set (M63 §O's duality), so a group clears iff its union is INDEPENDENT IN Y, not iff its members are individually droppable. The implementer's own numbers show how far apart those are on this very stage: 153 atoms are droppable alone while at most 68 can be dropped together (576 atoms against a minimum of at most 509). So per-atom density overestimates the clear rate in one direction, and the independence model understates what is knowable in the other, because with Y stored the outcome of every group ask is computable with NO asks — and on a harvested Y it is an upper bound on the clear rate, which is the honest direction.
  expected: the lever's payoff is a density question, settled by measuring density
  ask: on the two stored stages, what fraction of groups of eight has a Y-independent union under the natural order against an order built inside a maximum independent set of Y, and what group size does the slack allow?
  if an ordering lifts the clear rate materially: B-12's reframed question is answered constructively — order candidates inside a maximum independent set of the harvested Y, which exact.py already computes — and the lever earns its row in D at a group size no larger than the slack
  if it does not: the lever is dead for our pipeline for a stated structural reason — the slack bounds the group size below what batching needs — which is a better negative than a density estimate and transfers to F and G, where the slack is known before any ask
  answered by: run — zero asks: the stored Y on both records, a greedy packing, and the arithmetic |W| - |M|
  cost: minutes, no solver
  hunch: an ordering lifts it a long way at group size 2 to 4 and not at 8, because the slack is 28 and 30 on the two stored stages and about 68 on the joint one
  falsifier: the clear rate under the best ordering stays within a few points of the natural order's
  rank: 12

**Card 12 adopted with a correction to my correction, 2026-09-11, and the correction is right.** The
slack does not bound the group size where it matters here: a group of eight sits well inside a slack of
68. What kills the lever on this stage is that **423 of 576 atoms are singleton correction sets**, so a
uniformly drawn group of eight almost surely contains one, and a singleton is a correction set. The
implementer's own 0.3% was therefore an upper bound on something already negligible — the lever is worse
than it said, not better. Its constructive form, and the one that goes to D: **draw the group from the
153 non-necessary atoms and ask whether eight of those are jointly droppable**, on the stored Y, under
the natural order and under an order built inside a maximum independent set, at group sizes 2, 4 and 8,
with no solver. **Scope: not run in phase C** — B-12 is D's row, this run does not need it (phase 1 cost
85 s of a run finishing inside the hour), and the reason is recorded rather than the row quietly dropped.
**My drop-condition clause is adopted verbatim into §R2:** the condition is judged on the IN-RUN
population, measured on one incremental solver across the whole run, with the isolated minimum-of-three
figure reported beside it as the per-ask cost it actually is.

**The instrument pattern is now four, and the fourth is the same trap this repository already has a
standing rule for.** The pid file caught the `setsid` wrapper a second time, on C4b, because setsid's own
argv contains the python command line, so a `ps` resolution taken eight seconds after launch matched the
wrapper; the waiter then reported C4b dead after two minutes. Both runs were alive (C4a at iteration 260,
lower bound 457; C4b through phase 1). The fix — the job writes its own pid and then `exec`s — is exactly
`CLAUDE.md`'s standing background-job rule, re-learned. **Four instruments, one shape: each said "nothing
to see" when it meant "I could not see".**

question: are-the-two-relative-frames-one-problem-or-two
  evidence: C4b's phase-1 census is 423 critical / 153 droppable, identical to C4a's, on a stage with a different fingerprint (implementer, 2026-09-11), and it declines to upgrade that to a claim, rightly, since O4 proves only "same double coset implies isomorphic" and not the converse. But agreeing invariants can never settle it, and one test can. This repository already records automorphisms of a unit-distance object that no plane isometry induces — G27's Galois flip on de Grey's 1581, whose Klein four-group orbit yielded three new witnesses — so an isomorphism outside the base group is a phenomenon here and not a curiosity.
  expected: the two double cosets are two problems, and C4b is independent evidence
  ask: are the two joint stages isomorphic as atom-marked graphs, by an explicit isomorphism rather than by agreeing invariants?
  if isomorphic: the double-coset enumeration overcounts the problems, C4b is a REPLICATION control rather than a second problem, F and G need not enumerate frames, and it is a second instance of G27's hidden arithmetic symmetry
  if not: the "at most two" is exactly two, C4b's verdict stands as independent evidence, and every later frame enumeration is load-bearing
  answered by: run — one graph-isomorphism test on two 577-vertex atom-marked graphs, after the verdicts, never before
  cost: minutes, no solver; VF2 or a canonical labelling
  hunch: isomorphic, because the census matching exactly is a strong coincidence otherwise; held at 60%, and the invariants agreeing is precisely the weak evidence that makes the test worth running
  falsifier: any invariant that differs — edge count, degree sequence, Y's by-size profile, the level count
  rank: 13

**The warm/cold gap is a thousand-fold, not six-fold (implementer, 2026-09-11).** The same refusing ask:
**0.02–0.11 s warm mid-run against 186 s and 229 s cold** through `parts_stage.refuses`, on the M6B pair
(`v375e1916` against a framed `v141e594`, 544 vertices, a **frozen** companion — the cheap kind of
stage), while a cold *colourable* ask stays at 0.49 s. It explains the silent 99%-CPU job: C3's frame
search asks one refusal per group element and 12 of 24 refuse, so it is a ~40-minute job, arithmetic
rather than a wedge — **the pattern's fifth instance**. The implementer's reading: this does not move the
drop condition (C4.0's cold figures and the frozen-companion baseline were both cold, like for like), it
does explain why both our forecasts were wrong in the same direction, and for D it is a design rule —
**one incremental solver per search, never one per ask**, since `refuses` builds a fresh solver per call.

**A reading of mine, recorded beside it: one threshold is doing three jobs, and the three now read
differently.** (i) **Absolute in-run cost** governs run duration, the resume path and scheduling —
0.029 s and 0.27 s, so runs of about an hour. (ii) **The warm refusing:colourable asymmetry** governs
whether 8-4-2-1's premise holds — 0.27/0.029 ≈ **9×**, close to his own 1 s against 10 s (parts:643-644),
so **his premise survives warm** and the lever still fails on structure (card 12's singleton density), not
on the asymmetry; the two conditions are separable and should be reported separately. (iii) **The
warm/cold ratio** governs whether parallelism helps — 32× on the joint stage, ~2,000× here — and it
argues *against* fanning out on this family, where M62 §R21 measured only 2× per-ask loss on its own
family and still capped the speedup near half the core count. **If F or G re-instates the parallel sweep
because "costs rose", it will be using quantity (i) to decide a question governed by (iii).**

**The C2 controls are firing, and my card 2 is now fully confirmed on the instrument's own side:** c2.1
gives **282 under his convention** with closure under Aut(A) and a planted removal breaking it; c2.2
reads `A-equal` against his `v403e2112` literally, naming the vertex when one is removed; **c2.3 reports
the L451 level differing from his printed 375 column in exactly the two orbits predicted — (2,0,6,4) and
(10,0,2,4) — and nowhere else**, with a planted +1 shift reading `differs`; c2.4 reads
`unstable-constant-count` for (2,0,2,4), never `stable`. **Status of the verdicts:** both joint runs open
and healthy at 39 and 34 minutes, C4a at iteration 869 and C4b at 723, **both with the lower bound pinned
at 468**, Y at 1,291 and 1,145 and climbing, zero undecided — the bound plateauing while Y fills is the
expected harvesting shape.

question: is-the-thousandfold-warm-up-or-a-missing-accelerator
  evidence: the same refusing ask reads 0.02-0.11 s warm and 186-229 s cold on a 544-vertex frozen-companion stage, while a cold colourable ask stays at 0.49 s. Warm-up is plausible — thousands of prior asks on one oracle leave learned clauses that nearly prove the next refusal. But "cold" and "missing an accelerator" are indistinguishable in a log, which is this phase's recurring shape at five instances: `refuses` constructs a fresh Stage CNF per call, and §5.9's pin and distance ordering are applied where the CNF is built and are worth a reported 10x (parts:673-696). A 2,000x ratio on a frozen-companion stage against 32x on the joint stage is a spread wide enough to want attribution before the number becomes D's design rule.
  expected: warm-up explains all of it, and "one oracle per search" is the rule D inherits
  ask: cold, with the pin and the distance ordering explicitly on and then off, does the same refusing ask still cost 186 s?
  if warm-up owns it: the consequence for F and G is sharper than "hold one oracle" — parallelism is contraindicated on this family, since a cold worker discards a state worth 10^2 to 10^3 where M62 §R21 measured 2x on its own family and still capped the speedup near half the core count
  if the pin or the ordering owns a slice: the cold baselines are not like for like, C4.0's cold-against-cold comparison needs re-checking, and the threshold behind four drop rows moves
  answered by: run — two cold asks on the same pair, minutes
  cost: minutes, and it precedes the number becoming a design rule
  hunch: warm-up owns most of it and the pin owns a visible slice; the spread between 32x and 2,000x is what makes me want an attribution rather than an average
  falsifier: cold-with-pin and cold-without-pin within a factor of two of each other at 186 s
  rank: 14

**The implementer's own self-correction, 2026-09-11, and it is deeper than card 14's second branch.**
Its "cold against cold, like for like" defence of the drop condition is false: C4.0's joint figures are
cold (fresh solver, minimum of three), while the frozen-companion baseline they were compared against is
the stored records' `asks` block — the **in-run mean over a whole run on one incremental oracle**, warm.
So the 16–88× firing the condition behind four drop rows was computed **across the warm/cold seam**, the
seam just measured at up to three orders of magnitude; the cell it needed was never measured. The honest
pair: **warm against warm is about 3× cheap and 3–13× expensive — straddling the threshold**, not
clearing it; cold against cold is now running. It also credits card 14's pin branch further: `frames`
builds with `pin=False` and gave 186–229 s, while C4.0 built through `Stage.cnf` with **the pin on** and
gave 5.7 s, so those were never the same experiment, and the warm-up reading is marked under test in §R2
rather than left standing. The run now measures one cold refusing ask on four stages — L451, S166, the
joint one and the M6B pair — **with the pin on and off**, which settles card 14's falsifier and fills the
missing cell in one pass. **The three-quantities reading is adopted verbatim into §R2, with its risk
sentence.**

question: does-the-tenfold-condition-govern-any-row-it-gates
  evidence: the condition reads "if ask costs rise tenfold or more, the cost-control rows come back", and it gates four conditional rows plus idealness. But each row's need is now traceable to its own quantity, and three are already measured: 8-4-2-1 needs the warm refusing:colourable asymmetry (9x, so his premise survives) AND clearability, where card 12 kills it structurally on the singleton density, so the threshold decides nothing for it; the parallel sweep is governed by the warm/cold ratio (32x to 2,000x, contraindicating fan-out), not by absolute cost; a level forecast is governed by the LEVEL'S SIZE and the enumeration's shape, not by the price of one ask; the per-lever measurement is governed by comparability with his attested timings (his 0.2 s for √3 triples was measured with the five-vertex assignment, parts:678-684, 845-847); and the pendants were superseded structurally and were never a cost question. Meanwhile the pair that would fire the condition has just been shown to straddle the threshold warm and to be unmeasured cold.
  expected: the cold-against-cold pair lands, the condition fires or does not, and four rows follow it
  ask: which of the gated rows has its need governed by per-ask cost at all, and should the single threshold be replaced by the per-row quantity now that three of them are measured?
  if at least one is genuinely governed by per-ask cost: keep the condition for that row alone, named in the same sentence, and retire it for the others, so a later "costs rose" cannot move rows it does not govern
  if none is: the cold-against-cold measurement is still worth having as the per-ask figure it is, but the drop decisions are made per row on their own quantities, and F and G inherit a table — row, governing quantity, current reading, verdict — rather than one dial
  answered by: derivation — five rows against the quantities already measured, no asks
  cost: zero, and it is the natural completion of the three-quantities reading §R2 just adopted
  hunch: none of them is governed by per-ask cost alone, and the condition has been a proxy standing in for four different questions
  falsifier: a gated row whose need rises and falls with per-ask cost while its own quantity holds still
  rank: 15

**Card 15 answered by derivation as §R2.4b, 2026-09-11, and the hunch holds:** no gated row's need is
governed by per-ask cost on the object the condition was measured on. B-8 (the cyclic implication chain)
is governed by per-ask cost **on a stage phase E has not built**, a √3 triple, so the measured number is
on the wrong object; B-11 by provenance against his attested timings; D-6 (the level in parallel) by the
warm/cold ratio, whose own reading argues against fan-out; X-7 by the level's size and enumeration shape
(the joint level at 509 holds ≥ 13k raw L-minima); B-4 (pendants) and M64-6 (idealness) were never cost
questions; and B-12 was killed on singleton density by card 12, not by the dial. **The decision the dial
produced — cost-control rows return for D, F and G — is right for those rows for their own reasons**,
and F and G inherit the table rather than the dial, with my risk sentence attached. **My falsifier is
unfired but not vacuous:** B-8 could still fire it on E's √3 triple, which is exactly where B-11's
provenance caveat bites, so those two rows are re-read together when E builds that stage.

**C3 has landed** (its predictions unscored until its audit finishes): `reduced`, minimum 374 atoms →
**375 vertices**, **360 minima** exhaustive with zero undecided, `A` = 402 atoms + the shared centre =
**403**, `Y` = 514, the reduction itself **87 s** after the 40-minute frame search. Against my
registered expectation — 375 vertices, 66 minima up to the stage stabiliser, A = `v403e2106` as a set,
edges 1916–1926 — the vertex count and A agree; **the count convention is the open half**: 360 raw under
his convention needs a stabiliser of order about 6 with 36 fixed members to read 66, where the M6A stage's
was order 12 (3,264 → 282). Consistency check that passes meanwhile: his two counts are in ratio 4.3 and
ours in ratio 9.1, which agree once the two stabiliser orders differ by two. And `A` = `W` here is the
expected self-consistency, since reducing an accumulator should return it.

question: can-a-search-over-configurations-share-one-oracle
  evidence: C3's frame search cost 40 minutes because each of 24 frames is one COLD refusing ask, and cold is worth 10^2-10^3 on this family. The design rule just adopted — one incremental solver per search, never one per ask — was stated for a search over SUBSETS, where the CNF is fixed and the selection rides on assumptions. A search over CONFIGURATIONS can have the same shape: build one CNF over the union of all framed copies, guard each copy's edge clauses with a selector (¬s ∨ ¬v_i,k ∨ ¬v_j,k), and ask under assumptions, so every frame runs warm on one oracle. The same shape fits G's rotation census exactly, and it corrects my own card 4, which priced that census at "412 asks at seconds each" — at cold prices it is nearer eleven hours.
  expected: a configuration search is a sequence of separate problems, each with its own CNF
  ask: does one guarded union-CNF with per-configuration selectors reproduce the frame search's 24 verdicts, and at what cost against 40 minutes?
  if it reproduces them warm: G's rotation census stops being an overnight job, C3's own search becomes a control with a known answer, and the design rule generalises from "one oracle per subset search" to "one oracle per search, configurations included"
  if the verdicts differ anywhere: the guarding is unsound as built — most likely an absent vertex left constrained, or a selector not covering every clause a configuration owns — and that is worth knowing before G prices anything on it
  answered by: run — rebuild C3's 24 frames as one guarded CNF and compare verdict for verdict, after the verdicts land
  cost: an hour of code, minutes of solving; not urgent, and not before C4a and C4b
  hunch: it reproduces them, and the cost falls by at least an order of magnitude, because the 24 stages share their whole L side and differ only in the S-side image
  falsifier: any frame whose guarded verdict differs from its standalone one
  rank: 16

**The M6B level lands and my last prediction is FALSIFIED, 2026-09-11.** Complete, zero undecided:
|M| = 375 = his; edges 1916–1926 = his; `A` = his `v403e2106` **literally**; **|{M}| = 66 up to Aut(A) of
order 6 = his 66**; fewest-edge stabiliser 2 = his "1 (2)". So the count convention resolves as predicted
(360 raw under an order-6 stabiliser gives exactly 66) and the ranges refute the hunch: **(2,0,6,4) reads
2–6 on the M6B level against his printed 0–4**, so an M6B member reaches 6 and the registered falsifier
fires. **The printed column is strictly narrower than BOTH complete levels in the same two cells** — not
the union, not the intersection, not either run.

question: does-completeness-plus-count-equality-close-the-range-tension
  evidence: both 375 levels are COMPLETE (`exhaustive-level`, zero undecided); his counts reproduce exactly under the convention §R1 established — 282 at stabiliser order 12 on M6A, 66 at order 6 on M6B; his `A` equals ours LITERALLY on both rows (v403e2112, v403e2106); |M| and both edge ranges agree. The derivation, offered in the hypothetical mood for the engineer to check: any member of his {M} is a minimum-size refusing selection of the same stage, hence a member of ours by completeness, so his ⊆ ours; equal counts then force his = ours; so the range over his set IS the range over ours, and the printed 0–4 cannot be his set's range. A truncated enumeration is a proper subset and must count strictly FEWER, which his does not — so the early-stop reading is refuted rather than merely disfavoured, and it is refuted twice, on two rows with different stabiliser orders.
  expected: the tension between matching counts and narrower ranges stays open and travels to D as two live readings
  ask: does completeness plus count equality close it to the printing-defect reading alone, or is there a stage difference that breaks "same stage" while leaving A literally equal, |M| equal, the edge range equal and the count equal?
  if it closes: D inherits one reading rather than two, the column is a defect with two independent witnesses, and §S.2 #4's conclusion is derived rather than economical
  if a stage difference survives: name the difference, because it must produce the same union, the same minimum, the same edge range and the same count while holding a different level set — and that object is worth more than the range question that found it
  answered by: derivation — the engineer's, against its own two records; no asks
  cost: zero
  hunch: it closes; the weak joint in my own argument is step 2, "the same stage", which rests on A matching literally rather than on the stage fingerprints agreeing
  falsifier: a stage difference consistent with all four attested agreements
  rank: 17

**Two smaller things from the same report.** `P-C2.1` is met on six of seven clauses and the seventh is
reported **not-compared**: Table 4 was never transcribed, so the S166 audit prints *0 of 14 orbit rows
compared, 14 not-compared* rather than an empty differing-list — the silent-omission trap caught by the
instrument's design rather than by anyone noticing. And **M64's P7 has its unchecked half**: L's Aut(A)
has three involution classes of sizes 3, 3, 1, and M64's seven stored order-2 rung values partition as
three 375s, three 376s and one ≥377 — the multiset agreement the class-function property requires, with
the row-to-class pairing recorded as **not computed**, which is the honest form.

**Card 17 checked against data, and a third reading survives (implementer, 2026-09-11).** His own
published minima sit inside the printed column: `v375e1920` and `v375e1916`, 35 orbits each, **0 outside**,
both with (2,0,6,4) = 4 and (10,0,2,4) = 8. So the column does not contradict his own files — the test
that would have settled it outright, and the one his own method invites. **My steps 1, 4 and 5 are
accepted**, including that completeness plus count equality *refutes* early stopping rather than
disfavouring it. **Step 2 is not closable from his artifacts:** his companion for that row is unnamed,
his files are vertex lists rather than stages, so there is no artifact of his to fingerprint against
ours. The third reading, which mixed provenance inside one column makes unexotic: **the column and the
count come from different runs**. D inherits three readings, and what phase C establishes stands on its
own — the column describes neither complete level, and early stopping is refuted by the counts.

**My reading of the new datum: it does not rank the three.** The two cells are one fact, not two — the
conservation law ties (2,0,6,4) + (10,0,2,4) = 12, so a member at 4 is at 8 by arithmetic — and a = 4 is
a common value in our level (the body profiles carry ~125 minima each). "His files do not contradict his
column" is equally consistent with a printing defect, with mixed provenance, and with a narrower set of
his; it removes a contradiction without discriminating. **What would discriminate is a sensitivity
control on our own side**, which is card 18.

question: how-much-does-a-stage-depend-on-which-companion-is-frozen
  evidence: step 2 of card 17 — "his row is our stage" — rests on four agreements (A equal vertex for vertex, |M|, the edge range, the count) plus one of his members verified inside our level, and it cannot be closed from his side because his companion for that row is unnamed and his files are vertex lists, not stages. But the inference is testable from OUR side: it says the four agreements pin the companion. Meanwhile every later claim of the form "our stage is his stage" — D's replay, E's held-out rows against Table 5 — rests on exactly this inference, uncalibrated.
  expected: the companion is pinned by the agreements, and the inference is safe to reuse
  ask: on the same working graph A451 at rung 1, does swapping the frozen companion (v141e594, or Heule's own S136) move A, |{M}| and the level?
  if they move: the four agreements pin the stage, step 2 is supported by a control rather than by plausibility, the range tension narrows to two readings, and every later "his numbers reproduce" claim inherits a measured calibration
  if they barely move: step 2 stays open, AND the L level is largely insensitive to which S is frozen — a finding in its own right, since it would mean the joint problem nearly decomposes, which bears directly on card 1's verdict and on whether the record's two halves are independently optimal
  answered by: run — one reduction on the same W with a different companion, warm, comparable to the 605 s the original took
  cost: about ten minutes of solving, after the verdicts
  hunch: they move, and materially — the M6A and M6B stages already differ in A by three vertices each way with both W and C changed, so C alone should be visible
  falsifier: A and the count unchanged under a different companion
  rank: 18

**The instrument pattern gains a sixth entry, and it is a new variant: a control that fires FALSELY.**
The first corrected-L-rung script reported *"BELOW the stored lower bound — refutes the duality"*, and
refuted nothing: it filtered subgroups to the one with 225 orbits and then passed that filtered index to
a lookup over the *unfiltered* list, running a 232-atom rung against the 225-atom rung's bound. The S
side was immune because all three of its order-2 subgroups have 86 orbits. **A control that fires loudly
on a mismatched pairing is as dangerous as one that cannot fire** — the implementer's sentence, and the
first of the six that is a false positive rather than a false silence. Meanwhile all three S involutions
close at **138 vertices**, confirming M64's `≥ 138`.

**Card 14 settled, 2026-09-11, and it resolves to the accelerator rather than warm-up.** Cold, fresh
solver, minimum of three, one refusing ask, the pin the only difference: **L451 3.07 s pinned against
190.60 s unpinned (62×)** and **S166 3.58 s against 224.67 s (63×)** — replicated to 1.6% on two
independent stages; the joint stage reads 6.66 s pinned. **My falsifier — the two within a factor of
two — did not fire.** So the 186–229 s came from `frames` building `pin=False` while C4.0 built pinned:
never the same experiment, and a log cannot tell those apart. Warm-up is real but second-order:
cold-and-pinned against warm-in-run is ~30–150×, and the ~2,000× was mostly the pin. **My third quantity
survives restated:** the ratio governing fan-out is ~30–150× for a *pinned* cold worker, which still
argues against it by a margin M62 §R21's 2× never approached — the conclusion stands and only the number
moves. **And the drop condition does not fire on either honest pairing** — cold-pinned against
cold-pinned is 1.9–2.2×, warm against warm 3× and 3–13× — so with card 15 on top the position is: the
dial does not fire, and would not have governed those rows if it had. The rows return on the per-row
grounds, and the implementer has told the product owner so.

question: is-the-62x-pin-off-anywhere-else
  evidence: 62× and 63× cold, pinned against unpinned, replicated to 1.6% on two stages. M63 §4 phase B introduced the §5.9 pin among levers it describes as ones "we do not use", so everything before this milestone asked UNPINNED — M62 §R23's cost split (colourable 0.02-2.8 s, refusing 10-15 s, one refusing ask killed at 17 minutes), its nine 1-minimal descents at 500-900 s each, its 4.4 CPU-hour eight-seed portfolio, and its round-1 solver comparison (CaDiCaL 1.5.3 at 73.5 s against 1.9.5 at 87.9 s over a 14-ask trace). And FS-32 §R3 measured a DIFFERENT symmetry-breaking encoding, value precedence, as FLAT — so "symmetry breaking" is not one lever and that flat reading does not transfer to this one.
  expected: the pin is a phase C stage detail, and M62's cost numbers stand as recorded
  AMENDED 2026-09-11, before the settling run, by the implementer's grep: **the M62-era paths were never unpinned — they pin the CENTRE.** `parts_stage.Stage.cnf` pins the §5.9 rainbow triangle (3 clauses); `typem.cnf_for`/`side_cnf`/`patterns` pin the centre only (1 clause) and are what `m62_run`, `m62_descent`, `growsearch`, `m62_subtypes` and `five_dial` use; `mkstate.py` pins a triangle and the centre; `symstate.py` the centre. So my 62× is triangle against NOTHING, since `Stage(pin=False)` emits no unit clause, and the quantity that transfers is triangle against CENTRE. Checked independently here: a proper 4-colouring has 24 palette permutations, a rainbow triangle kills all 24, a centre pin leaves the 6 that permute the other three colours, so the symmetry ratio is 24/4 = **6×**, and the residual ~10× of my number is search guidance, which is the part with no reason to transfer to another arena. **The claim "M62's costs sit on a 60×-inflated baseline" is withdrawn at that size; the live claim is ~6× plus whatever guidance transfers.**
  A DERIVED BOUND, which the amendment suggests and which bounds the lever for D, F and G: **the rainbow triangle is MAXIMAL among clique pins in this problem.** Four points of the plane are never pairwise unit-distant (ledger row 58, `not_forces_of_unit_drawing`), so there is no K4 to pin and no further palette symmetry a clique can break. Everything left is placement — his §5.9 says *"The choice of Q significantly affects the speed"* — and problem-structure assignments such as his five-vertex trick for √3 triples (parts:678-684). So nobody should hunt for a bigger pin, and the residual 10× is precisely the arena-specific half.
  ask: on an M62-era object, does the rainbow triangle beat the CENTRE pin, and by how much against the 6x that palette symmetry alone predicts?
  if it transfers: every cost number M62 recorded sits on a 60x-inflated baseline, its parallelism trade-offs were priced against that baseline, and F and G must not inherit those prices — while §R23's sampling argument that a descent cannot reach the record is untouched, since that rests on the spread of a distribution and not on its clock
  if it does not: the 62x is specific to this stage shape — a frozen companion and a small deletable slack — which is itself worth knowing before D and G price anything on it
  answered by: run — a grep for the CNF builders, then one pinned/unpinned pair on an M62-era object such as the 757 closure or Heule-510
  cost: minutes, after the verdicts
  hunch: amended with the card — between 5x and 15x on an M62-era object: 6x from palette symmetry, which must transfer, times a guidance factor that may not
  falsifier: triangle against centre on an M62-era object below 3x, or at the 60x the original framing would have predicted
  rank: 19

hunch: P-C4.0-joint-ask-costs-stay-under-a-second
  claim: on the joint stage the ask costs rise above the frozen-companion regime (0.006 s colourable, 0.02-0.11 s refusing) but stay under one second, at 60%
  basis: prior
  falsifier: a joint-stage refusing population averaging under half a second, or above one second
  registered: 2026-09-11
  status: killed (by: the implementer's in-run measurement, 2026-09-11 — the joint stage's refusing population averages 0.27 s over 322 asks and its colourable population 0.029 s over 1,231, so the low half of the falsifier fired; the isolated C4.0 figures, 0.170 and 1.758 s on a fresh oracle, are 6x higher, and the mechanism is the incremental solver keeping its learned clauses. What the miss cost: card 11's six-hour forecast for C4a, wrong in the over-cautious direction, and answered before it could change a decision, since C4a was already running)

hunch: the-printed-375-column-is-the-M6B-run
  claim: Table 2's 375 "M6A&B" range column is the M6B run's own ranges rather than the union of the M6A and M6B runs, so the M6B level set's ranges match the printed column exactly, including (2,0,6,4) at 0-4 and (10,0,2,4) at 8-12, while our M6A level set's tail sits outside it
  basis: derived
  falsifier: the M6B run's ranges differ from the printed column, or they contain the tail profiles
  registered: 2026-09-11
  status: killed (by: the implementer's complete M6B level, 2026-09-11 — (2,0,6,4) reads 2-6 against his printed 0-4, so a member reaches 6 and both halves of the falsifier fire; the printed column is narrower than both complete levels in the same two cells, so it is neither run's. What the miss cost: nothing was built on it; and the replacement reading is stronger, since completeness plus count equality refutes the early-stop explanation outright — card 17)

## Handover — what the next Poros inherits

**Cards.** Nine written; eight adopted by the planner, card 3 answered by the product owner, card 5
answered as recommended. Fates are beside each card above, and in the phase's own record §7.

**Open, and in this order.** (i) Card 1's two runs — the joint reduction over A412 ∪ ρ·g(A166), in **two**
inequivalent relative frames (double cosets, planner's correction), which is the only item that can end
the milestone with the goal met; its answer decides whether phase D's loop is needed for the record at
all. (ii) C4.0, the joint stage's own ask costs, on which four remaining drops are conditional
(`P-C4.0`, my hunch at 60%). (iii) Card 8's run — whether his §5.10 indicators rank the orbits his own
move used. (iv) Three ledger hunches still open: the joint minimum at 509 (prior, ~35% on fewer), the
reserve condition (a pre-registered exact test passed, awaiting the engineer's re-derivation), and
whether 509 is still the record, which the prior-art gate settles.

**The process lesson, the planner's, worth carrying to D.** Its gap audit was built by walking the plan's
promises, so it inherited the plan's blind spots; three of my nine cards found something the table
asserted without carrying (the S side already spent as the calibration, 8-4-2-1 absent entirely, and
§5.10's second role). The consequence it drew is not "ask the advisor more" but **audit the source, not
the plan** — and the matching one on my side is that all three came from reading his paper against a
question the plan had not asked, which is the cheapest reading available to whoever is not holding the
plan.

## Measurements

*Scripts in the scratch directory; each reads his `.vtx` files through `tools/parts_vtx.load_lattice`,
the base through `tools/parts_repro.Base(2.6)` and the order-24 group through
`tools/parts_faces.base_group_perms`, and writes only to stdout.*

### M1 — `path_containment.py`: is state 3's working graph A403 plus the named orbits? (21.9 s, one core)

| test | result over the 24 group elements |
|---|---|
| (a) `v403e2112` ⊆ g(`v451e2400`) — state 2's A inside state 1's A | **passes for 12 of 24** |
| (b) `v406e2082` ⊆ g(`v403e2112`) ∪ O | **fails for all 24; minimum leftover 6** |
| (c) `v412e2106` ⊆ g(`v403e2112`) ∪ O | **fails for all 24; minimum leftover 12** |
| (d) `v406e2082` ⊆ g(`v412e2106`) — rung-2 A inside rung-1 A | **passes for 12 of 24** (not the identity: stored frames differ, literal union 589) |
| (e) M6B: `v406e2076` ⊆ g(`v403e2106`) ∪ O | **fails for all 24; minimum leftover 6** |

O = the full base orbits (0,0,0,4) (size 6), (0,0,6,6) (size 12), (4,0,0,0) (size 6); |v403e2112 ∪ O| =
421. Orbit (4,0,0,0) is **already full (6 of 6) in v403e2112**, so "filling orbit (4, 0, 0, 0)"
(parts:810) adds no vertex to A403: it can only mean the minima now keep all six (Table 2: 4 at 375, 6
at 374). A406 and A412 hold 3 of (0,0,0,4) and 6 of (0,0,6,6), as Table 2's 374 column says.

**Reading.** (a) and (d) are what one working graph reduced at two rungs predicts. (b), (c), (e) kill my
claim that the recorded path's only expansion is the named one: under every frame, state 3's
accumulators carry 6 (A406) and 12 (A412) vertices that neither A403 nor the three named orbits supply.
The sentence at parts:808-810 under-describes state 3's working graph. Card 1's evidence line and card
3's said "one expansion, and it is named"; both are corrected below, and the planner was told.

### M2 — `leftover_orbits.py`: which orbits hold the unnamed vertices (22.2 s, one core)

Fills per file (orbit : count):

| file | (0,0,2,6) aux | (0,0,2,2) | (0,0,6,6) | (0,0,0,4) | (4,0,0,0) | the four varying orbits |
|---|---|---|---|---|---|---|
| `v451e2400` (state 1 A) | **12** | 6 | 6 | 0 | 6 | 12 each |
| `v403e2112` (state 2 A, M6A) | 6 | 6 | 0 | 0 | 6 | 12 each |
| `v403e2106` (375 A, M6B) | 6 | 6 | 0 | 0 | 6 | 12 each |
| `v406e2082` (state 3 A, M6A) | 6 | **12** | 6 | 3 | 6 | 12 each |
| `v406e2076` (374 rung 2, M6B) | 6 | **12** | 6 | 3 | 6 | 12 each |
| `v412e2106` (state 4 A) | **12** | **12** | 6 | 3 | 6 | 12 each |

- The 6 left over from A406 (both subtypes) are **exactly the other half of (0,0,2,2)**; the 12 left over
  from A412 are **the other halves of (0,0,2,2) and of (0,0,2,6)**. So A412 ⊆ g(A403) ∪ O ∪ (0,0,2,2) ∪
  (0,0,2,6) exactly, a 433-vertex set, and A412 carries both auxiliary halves (Table 3's caption: *"L-subgraph
  M6A or M6B, M = G374, A = G412"*).
- State 1's A451 also carries both auxiliary halves (12); state 2's A403 carries one (6). So the L451
  stage the record reduced had a full auxiliary orbit on the deletable side; its minima kept 6.
- Merging the two A403 files (M6A ∪ M6B) plus O gives 586 vertices and contains A406 but not A412
  (leftover 3). Too generous to explain anything; dropped.

**Reading, as a construction for the engineer to check.** A406 ⊆ g(A412) (M1 d), and A412 is by
definition the union of state 4's minima. So, if his enumerations were complete, reducing v412e2106
itself at rung 1 returns state 4's level exactly, and state 3's level is its invariant part under an
order-2 subgroup of the stage group (M64 §R10's free rung lattice). **States 3–4 then replay as one
reduction of his own A412, with no expansion step.** The expansion he actually made from A403 is the
two half-fills plus the two named additions, and his sentence names a no-op in place of the fills.

### M3 — `expansion_rule.py`: does his stated rule pick out the move his files imply? (65 s, one core)

Base 4,513 points, 38,730 exact unit edges (`typem.unit_edges_fast`). From v403e2112 (M6A):

- **Partially filled orbits: 16.** Four of size 12 — (0,0,2,2), (0,0,2,6), (10,0,0,2), (14,0,0,2), each
  6/12 — and twelve of size 24, each 12/24; none of size 6. The move filled (0,0,2,2) and (0,0,2,6) and
  left the other two at 6 (M1's leftovers lie only in the first two).
- **Reserve condition** (an absent vertex with at least 4 unit neighbours in A403, parts:517-521): 49 of
  the 210 orbits not full (50 for v403e2106), near his *"about 40 are included in R"* (parts:534),
  though on a different disk. By decreasing maximum degree: 1 (8,0,0,4) 10; 2 (12,2,2,0) 9; 3 (4,0,4,4) 8;
  4 (12,2,6,0) 8; 5 (10,0,8,2) 7; **6 (0,0,0,4) 6 and 7 (0,0,6,6) 6, the named additions**; 8 (10,0,0,2)
  6; …; **33 (0,0,2,2) and 34 (0,0,2,6), degree 4, the unnamed fills**.
- Of ranks 1–5: Table 2 shows (8,0,0,4), (4,0,4,4) and (12,2,6,0) at 6 in Heule's 529 L (393 column)
  and reduced away or varying later on his path; (12,2,2,0) is half-filled and stable; (10,0,8,2) is in
  no column of Table 2.
- From M6B's v403e2106 the auxiliary orbit's absent half ranks 7th (degree 6), not 34th.
- (0,0,0,4) has exactly 3 of its 6 absent vertices at degree 4 or more, and his minima keep 3 of that
  orbit (Table 2); whether they are the same three is not checked.

**Reading.** His stated rule, read literally, does not select his recorded move from A403. The
small-partial-orbit priority offers four fills and the move took the two of lowest degree; the degree
order puts the named additions sixth and seventh, behind three orbits his path had carried and reduced,
one stable half-filled orbit, and one orbit his tables never show. A candidate reconstruction, in the
hypothetical mood — *exclude orbits the path already discarded, prefer orbits of 6 or 12 vertices, rank by
degree* — makes the named additions first and second, and still does not say which two of the four
partial orbits get filled. **So scoring a frozen rule on whether it ranks his move first is a test with at
least a six-way tie on the fills and an unstated tabu on the additions; one recorded move cannot
discriminate rules, and card 3's rule branch is rewritten to score by outcome.**
