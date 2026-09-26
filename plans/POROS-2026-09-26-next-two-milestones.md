# Poros, crunch job J50 — the next two milestones (2026-09-26)

*Advisor record. Brief: `data/crunch-2026-09-25/briefs/J50-poros-next-two-milestones.md`, with
`data/crunch-2026-09-25/briefs/STANDING-RULES.md` as part of it. Kooshi decides; this record recommends.*

## Stage 0 — expectation, written before the close reading — SAVED

**Conditions of this reading (the honest part).** Before writing this I had read: the Poros identity and its two companion skills
(the procedures, not every paragraph); the standing rules; `CLAUDE.md` from disk at its Frontier items 24–28, G77–G79 and § Paths
forward (the summary table of the ranked stubs, lines 271–342). So the table was *seen* before this expectation, as a summary. Not yet
read: `plans/FRONTIER-STUBS.md`, the FS-100 stub, the queue's §8, the handoff's §6–§7, the latest reports, the two earlier advisor
records, the J43 page. The expectation below is therefore drawn from the Frontier summary and the constraints, and is scored in
Stage 3 against what the close reading finds.

**Expected pair, before the reading.**

1. **FS-100, the missing lemma MR, as a reading-room-plus-derivation milestone.** Reason: it is the one item where one statement
   ("every `U`-invariant `E`-null measure on `R̂` is a multiple of Haar") reportedly decides three things at once — five at ℚ(√47),
   row 88 ⟺ T-B1 over the type-(B) fields, five at ℚ(√167) — and it is ban-legal (derivation and reading). My prior about MR itself:
   it has the shape of a Furstenberg/Rudolph ×p×q measure-rigidity statement, which in its measure form is **open** in general
   (known with positive entropy: Rudolph, Johnson; higher rank: Einsiedler–Katok–Lindenstrauss). So I expect the milestone's most
   probable honest output to be a *classification of MR's difficulty* — "MR follows from [a named theorem] here because the extra
   structure supplies entropy / a second direction", or "MR implies Furstenberg's ×2×3 measure conjecture, so it is as hard as that"
   — either of which is a result (a no-go counts). Odds of MR proved outright in four hours: low (≤ 0.15).
2. **A kernel milestone in the other slot** — the kernel lane's top item (FS-75 re-aimed: S1 and no mixing in the kernel; or FS-87's
   dB9 V1). Reason: kernel work is valued where a result is finite or algebraic, it needs no blind verifier (the kernel is one), it
   uses one agent slot continuously, and M2 showed the lane lands. Odds of a kernel theorem landing in four hours: medium-high.

**Expected shape:** in parallel, one slot each — the derivation milestone alternating planner → derivation → blind verifier →
close, the kernel milestone planner → implementer → close — with one shared front-page pass at the end. Two full milestones in
series at cap two would not fit four hours.

**Expected stale items in the brief's candidate list:** FS-82 is closed (the Frontier says it closed with FS-91), so it is not a
candidate; FS-75's "T4 for the family" was re-aimed at FS-91's close to "S1 and no mixing". Checked in Stage 1.

**Hunches registered here** (scored at the end of this record):

```markdown
hunch: mr-is-open-measure-rigidity
  claim: MR(F) as FS-100 states it is at least as hard as a known open measure-rigidity problem (Furstenberg ×2×3 type), unless the
    stub's hypotheses (the E-null condition, the U-invariance) supply the entropy or rank that the known theorems need
  basis: prior
  falsifier: the stub or its stage-2 record shows MR reduced to a published theorem whose hypotheses are met here
  registered: 2026-09-26
  status: open

hunch: fs98-not-four-hours
  claim: FS-98's T-B1 (isolation across an ultrametric front) will not land in four hours; it stalled at one named step with two minds
  basis: read (CLAUDE.md § Paths forward row 8: "both stopped at one named step by two minds (row 111)")
  falsifier: the stub names a new input since row 111 that closes the step
  registered: 2026-09-26
  status: open
```

## Stage 1 — the quotation check and the evidence inventory — SAVED

### 1.1 The brief's statements against their sources (standing rule 5)

| brief says | source | verdict |
|---|---|---|
| Kooshi: "we have time and space for probably 2 more full milestones. Start a Poros agent to decide what those should be." | `plans/SESSION-HANDOFF-2026-09-25-crunch.md` §7: *"I'm going to compact, then we have time and space for probably 2 more full milestones. Start a Poros agent to decide what those should be."* | matches (the first clause omitted) |
| "**at most two agents at once** (Kooshi, to stay inside a usage window)" | handoff §7, "Update ~03:30 — the crunch is over": *"(Kooshi: the two-agent cap is removed; back to normal, generally no more than three agents at once)"* | **superseded after the brief was written** — the fit below is computed at three |
| FS-100 "stages 1–2 are done, and stages 0 and 3–6 are in-ban" | stub status block: "Left in-ban: stages 0, 3, 4 (Kronecker selection, after the crunch, per Kooshi), 5 and 6; P1 from 2026-10-01" | matches; "after the crunch" is now met (handoff §7: "the crunch is over") |
| FS-98 "(T-B1, isolation of the pullbacks)" | `CLAUDE.md` § Paths forward row 8: "re-aimed (J38's R1) to isolation across an ultrametric front (T-B1) alone" | **paraphrase**; the stub's words are "isolation across an ultrametric front" — the J52 brief does not carry FS-98, so nothing propagates |
| "FS-87's dB9 V1" | `plans/STUB-de-grey-chain-kernel.md` line 3: "**Next:** target 2, dB9's V1; then target 3, the checker for Parts's nine trees — price both from target 1's rate" | matches |
| "FS-75's T4 for the family" | `plans/STUB-three-colour-criterion-kernel.md` line 3: "**Re-aimed at FS-91's close.** The kernel target is S1 over every real number field … and no mixing"; the T4 re-aim is FS-81's, kept below it as a quoted block | **stale by one re-aim**; J52's brief quotes line 3 |
| "FS-82 (three colours at residue degree three, ℚ(α, √7))" | `CLAUDE.md` § Paths forward, open milestones: "with it FS-82 closed, `plans/STUB-three-colours-residue-degree-three.md`"; queue §8.2 E2c: J02: "Θ₃(ℚ(α,√7))=∅ and χ=L=4" | **stale: FS-82 is closed** (rows 98–102's milestone); not a candidate |
| "FS-67's remnant (DB-1 at three colours)" | `CLAUDE.md` § Paths forward row 11: "**Left:** three colours (3-colour the non-zero-winding part of `E_3(G)`)" | the substance matches; the label "DB-1" not checked against the stub |
| G72 and G79 exist, current | `CLAUDE.md` from disk, lines 1472–1474 (G77–G79) | matches |

Owner slips to log (two, both from the brief's age, neither the owner's error at writing time): the cap line and the FS-82 candidate.

### 1.2 Evidence inventory

- `plans/STUB-measure-rigidity-three-fields.md` §3, the gap — read against: MR is a ×p×q measure-rigidity statement, zero-entropy half open — surprised: no. The stub carries J36 F5's reading verbatim: "The zero-entropy half is open, as for ×2×3", and the positive-entropy half "should be algebraic by Einsiedler–Lindenstrauss-type measure rigidity (recalled, not read)". One mind, and the EL half never read.
- FS-100 §4, X-KS — read against: Kronecker selection priced near even — surprised: no; "medium-low (0.4) that it is true as stated", with a named control over ℚ(√11).
- FS-100 §6.3 stage 3 — read against: the four MR papers held — surprised: yes, mildly. "Rudolph 1990, A. Johnson 1992, Host 1995, Einsiedler–Lindenstrauss; none held". The one lemma three fields wait on has never had its nearest literature opened (G50's shape).
- `plans/CRUNCH-2026-09-25-queue.md` §8.2 — read against: blind-verified derivations under-priced — surprised: no; "21 met, 7 missed … Every miss is in one direction … The planner under-priced derivation work that had a blind verifier behind it."
- queue §8.4 — read against: FS-100 is the only in-ban work handed on — surprised: no; "In-ban work left … FS-100 stages 0, 3, 4, 5 and 6; J43".
- handoff §7 update ~03:30 — read against: cap two binding — surprised: **yes** (1.1). Also "The planners J51/J52 should launch after J05 lands (they read `CLAUDE.md`)" — J05 is compressing `CLAUDE.md` now.
- J43's facts (`data/viz/local-global-map/facts.json`, 829 theorems; counted by tag and grade, seconds) — read against: the exposed fields thin in the kernel — surprised: **yes, twice.** (a) Kernel-grade theorems tagged with the field: ℚ(√47) 2 of 18, ℚ(√167) 2 of 29, ℚ(√59) 0 of 24, ℚ(√83) 0 of 18, ℚ(√131) 0 of 17 — and of the two at ℚ(√47) and ℚ(√167), one is row 73, whose kernel theorem is `four_le_chromaticNumber_planeOver_eleven` (ℚ(√11)), the other row 75 (a tower fact). **No field-level lower bound at either exposed field is in the kernel.** (b) ℚ(√143), ℚ(√311), ℚ(√335), which `CLAUDE.md` § The mission names as exposed predictions of "exactly five", are tagged by **zero** theorems; FS-100 §5 item 5 says whether they sit in T-C(A)'s class is "not checked here". Also thin: `k = 6` 20 theorems, `k = 7` 13; places 47 (2), 31 (3), 27 (9), 43 (9).
- FS-75 stub, shape — read against: the three-colour criterion's ⟹ direction needs heavy analysis — surprised: **yes.** Only the relation form is used downstream ("if θ ∈ Θ₃ then x_j ∈ [1/3, 2/3] and r·x ∈ ℤ for every relation r … the certificate uses that direction alone"), and T41's 36 vectors refuse by "a 1,050-leaf certificate (5.7 KB …) and a half-page hand proof (four inequality cases)". My own sketch of the ⟹ direction in relation form (hypothetical, to be priced by the planner): the height lift has steps in `{1, 2}`; a step depends only on the image in `Λ`, so the winding `w(r) = H(x + r) − H(x)` is independent of `x`; box averages of the steps lie in `[1, 2]^m`, satisfy `Σ r_j L_N(e_j) = w(r) + O(|r|²/N)`, and Bolzano–Weierstrass in `[1, 2]^m` gives `x = L/3` exactly. No descent to `Λ`, no function-space compactness.
- FS-87 stub line 3 — read against: kernel price unknown — surprised: no; "447 lines with its controls, in 17 minutes against a 4–6 hour price".
- The two earlier advisor records (`plans/POROS-2026-09-25-fs86-next.md`, `plans/POROS-2026-09-24-next-direction.md`) — read against: their shape — **unread beyond their size** (budget; this record's shape follows the brief's items 1–4 instead). Standing finding, not a claim.
- The J43 page itself — **unread** (no browser; its facts file was read instead).

### 1.3 Would have searched here

- None. The one computation was a count over J43's committed facts file (seconds, exact, no search).

## Stage 2 — the candidates — SAVED

*Odds are mine, stated before any planner prices them; per queue §8.2 the crunch's planner under-priced blind-verified derivations
(seven misses, all toward success), so I shade derivation odds up by about 0.05–0.10 against the stubs' priors and leave kernel odds at
the rate the kernel lane showed (M2: four items landed; FS-87's target 1 in 17 minutes against a 4–6 hour price). "Fit" is at Kooshi's
current cap of three agents (§1.1); the cap-two fit is in Stage 3.*

| # | candidate | decides, at what grade | fit (4 h) | odds | bearing: χ ≥ 6 / the conjecture | its null teaches | ban |
|---|---|---|---|---|---|---|---|
| A | **FS-100 in-ban, one milestone**: stage 0 (the reframe) with stage 3 (the MR reading room) as its §PA; stage 4, Kronecker selection, derivation + blind verifier; the entropy question of stage 5 as §IQ's structural form | Kronecker selection TRUE (closes layer 1: FS-64's adelic windows at four colours over ℚ(√47)) or FALSE over ℚ(√11) ("the first control the gap has ever had"), at [hand, derivation + blind]; MR's status graded: the positive-entropy half in print or not, the zero-entropy half named | planner 45 min; derivation and verifier in parallel from a fixed claim list, ~2 h; close ~30 min | decided either way 0.45–0.50; TRUE 0.40 (stub's X-KS); MR's difficulty graded with a read citation 0.75 | none on six; **the conjecture's exposed five-clause** at ℚ(√47) and ℚ(√167) ≥ 5 wait on MR (stub §2–3) | a GAP at J37's named equidistribution step, and "MR is ×2×3-hard here" read, not recalled: the measure route to five at ℚ(√47) is then a reading room while that conjecture stands, and post-ban effort goes to P1's finite `H` | yes |
| A′ | FS-100 as **two** milestones (A, plus stage 6: EI-2 over ℚ(√11) where colourings exist, or stage 5's MR proper) | as A, plus EI-2 at ℚ(√11): the first test of an example invariant (G79) on a field whose colourings exist | fits at three only with no kernel lane | EI-2 at ℚ(√11) decided 0.30; MR proper 0.10 | as A | EI-2's GAP is SI's "⟸" again | yes |
| B | FS-98, T-B1 (the stub: "isolation across an ultrametric front") | T-B1 TRUE or FALSE; given MR, row 88 ⟺ T-B1 | a derivation + verifier fits | 0.15–0.20: "both stopped at one named step by two minds (row 111)" | none on six; row 88's other half, but only *given MR* — so a landed T-B1 still leaves row 88 on MR | the same named step, a third time | yes |
| C | **Kernel: FS-75's minimal instance** — `χ(ℚ(√167)²) ≥ 4` in the kernel: the three-colour criterion in relation form (leaf 1), T41's 36-vector certificate (1,050 leaves) or its four-case hand proof, the lattice in the plane by `decide`, composed | the first field-level lower bound at an exposed field in the kernel (J43's count: none today), plus a reusable kernel criterion for every `Θ₃` certificate (FS-60's 13 fields, ℚ(√47)'s 2,997-node tree) | planner 45 min; implementer ~2–2.5 h; close 30 min; no blind verifier needed | 0.50 for the whole composition; 0.80 for the checker and the embedding; leaf 1 is the unpriced risk (the stub: "the cost, **unpriced**") | none on six; moves the conjecture's widest-gap field's bound from a checker's word to the kernel's | leaf 1's price, measured — which tells FS-75's S1 target what it costs | yes (kernel; existing certificates) |
| D | Kernel: FS-87's targets 2–3 — dB9's V1, the checker for Parts's nine trees, then row 85 as a conditional theorem with (S″) named | row 85 (de Grey's lattice: all 9,120 four-colourings `8Λ`-periodic; Mixon's 2018 question) toward the kernel | fits; rate known from target 1 | 0.65 for targets 2–3; 0.35 for the conditional theorem | none; publication substrate (`CLOSED-QUESTIONS.md` §2.5) | a price for the trees' checker | yes |
| E | FS-82 | — | — | — | — | — | **closed** (§1.1): not a candidate |
| F | FS-67's remnant at three colours (`CLAUDE.md` row 11: "3-colour the non-zero-winding part of `E_3(G)`") | the product theorem completed at `k = 3` | a derivation + verifier fits | 0.40 (heights exist at three colours, G71) | none on six; none on the conjecture now that three colours are decided over every real field (row 99) | the winding part's colouring as a named step | yes |
| G | FS-92, character classification at `k ≥ 4` | every band `k`-character is one place's pullback plus an archimedean part, or a counterexample | fits | 0.40 | none; characters are already excluded as falsifiers at the exposed fields (rows 96, 101) | the (g3) step at `e ≥ 2` | yes |
| H | FS-99, the ℚ⁴ control ("is every four-colouring of `G(ℚ⁴)` the Benda–Perles pullback? Zaks 1989 first") | a control separating dyadic tightness from triangles | reading first, then a derivation | 0.30 | none; calibrates row 88 | — | yes |

**Folded into A rather than a milestone of its own:** J43's second surprise (§1.2 (b)) — whether ℚ(√143), ℚ(√311), ℚ(√335) sit in T-C(A)'s
class, i.e. whether FS-100's three-field lemma reaches the conjecture's other exposed five-clause fields. A few seconds of exact arithmetic
for the J51 planner's §IQ item 5, logged at the ban's edge.

**Checked and dropped as out of scope for four in-ban hours:** FS-42 (5-tight quotients: the one residue route to a five-forced pair, but
its instrument is a quotient enumeration, which the ban names); FS-59 and FS-84 (their in-ban remainder *is* FS-100's MR; the rest is
post-ban); FS-90 (Kooshi's grant, a search).

### Would have searched here

- None in this stage.
