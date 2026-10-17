# Brief FS131-PAS3 — read Kubicki, Lehel and Morayne (2002) in full against rational four-space at four colours, and settle its prior-art wording

*Written 2026-10-17 00:55 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-PAS3
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity; this job is the prior-art gate (§PA) on one paper and one result, with no derivation of its own
  role: the reader of one 2002 paper that may already hold this project's result on four-colourings of `ℚ⁴` (C7) or its structure clause (A3), deciding between the two drafted forms of C7's prior-art wording, or a third
  launch: now, in a worktree of your own cut from `main`; beside you two Lean implementers in other worktrees — one of them proving C7 and A3 — neither of which writes a file you write
  mission: § Why this job
  statements: § What to read against
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if the paper proves C7's answer itself (the forbidden distances), and when the record is done; the report goes to `data/fs131/reports/FS131-PAS3.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `plans/FS131-PAS3-kubicki-lehel-morayne.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/filing2`, on its branch `fs131-pas3` (cut from `main` at `1253d345c`; no Lean build): `plans/FS131-PAS3-kubicki-lehel-morayne.md`; your scripts and notes under `data/fs131/pas3/`; `data/fs131/reports/FS131-PAS3.md`. `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md` and `LEDGER.md` lines are drafted in your record, each naming its slot, never edited. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 120k by the harness's count, as guidance; hand back before about 200k

Hello. Yesterday's prior-art search found that a 2002 paper's withheld summary says "every 4-coloring of Q^4 is rigid",
and held the public wording of this project's result on rational four-space until someone read it. Kooshi saved the
paper this morning. It is nine pages: read all of it.

## Why this job

The finding and my ruling:

> 1075. **FS131-PAS2, mid-job: a possible 2002 source for C7 (logged 2026-10-17 00:25 UTC; by message).** G. Kubicki, J. Lehel, M. Morayne, *Patch colorings and rigid colorings of the rational n-space*, J. Combin. Theory Ser. B 84 (2002) 45–53, doi 10.1006/jctb.2001.2062, Zbl 1024.05030: zbMATH withholds the abstract but its search matches the phrases "Q^4 is rigid", "every 4-coloring of", "uniquely extend", "points at distance one get distinct colors"; if "rigid" means a four-colouring of a unit tetrahedron extends uniquely over its component, C7's structure theorem is essentially theirs and Johnson's question a corollary. Also in print: `[Johnson2010]`'s restatement (Ramsey Theory, Birkhäuser 2011, p. 169: "I think that the same answer holds for n = 4, but this has not been shown"); Bau–Johnson–Noble (Canad. Math. Bull. 2021) Thm 3.3, the quaternion-similarity step. **My receipts:** OpenAlex lists it bronze open access with no repository copy; my fetch (Playwright, system Chrome headless, a fresh empty context, no login, host allow-list) got ScienceDirect's error page and HTTP 403 on `/pdf`; one web search found no author copy (SZTAKI's eprint 2901 lists it without full text). **Ruling, four parts:** *Choice:* ask Kooshi for a browser save to `~/source/library/pdf/KubickiLehelMorayne2002-patch-rigid-colorings-rational-n-space-jctb-84-45-53.pdf`; FS131-PAS2 records C7's verdict as pending the paper and hands back without waiting; FS131-KFS1's job is unchanged (the kernel proof is wanted either way), and no public line words C7's novelty until the paper is read. *Alternative:* defeat the bot check, or hold the planner. *Why:* the paper-fetch rule (memory: the blocks are not worth defeating; Kooshi's browser save works), and a found attribution changes the credit, not the formalization. *Confidence:* high. Leads I passed to it, unread and labelled mine: arXiv:2602.17943 (matched by a search engine, title unknown); a University of Haifa record titled "On four-colourings of the rational four-space" (possibly `[Zaks1999]`). **Credited:** FS131-PAS2's probe of a withheld abstract through the search engine's phrase matches.
> — source: plans/FS131-close-inventory.md

The search's hand-back, with the two drafted forms:

> 1080. **FS131-PAS2 handed back DONE (logged 2026-10-17 00:36 UTC; about 549k by the harness's count — not to be resumed; record `plans/FS131-PAS2-prior-art.md`, report `data/fs131/reports/FS131-PAS2.md`; branch `fs131-pas2` merged).** **C7:** pending `[KubickiLehelMorayne2002]` — not found in print among everything read (124 logged queries); `[Johnson2010]` p. 169 poses it again in 2011 with C7's answer as a guess; `[BauJohnsonNoble2021]` Thm 3.3 is C7's similarity step (fetched and read); drafts in two forms, (A) not in print, (B) in print in part (§ 2.4). **C14:** not found in print (§ 4.3): the upper bound `[Fischer1994]`'s, the lower bound's graph and blow-up `[MatolcsiEtAl2025]`'s read inside the field, and at the Moser ring `sup χ_gf = 4` is `[Ducz2026]` Thm 3.1 with its p. 4 ring remark. **Off-brief:** row 129's plane clause is `[LiSu2026]`'s (filed and pushed, items 1077, 1079). **My receipt:** `[Ducz2026]`'s abstract ("We show that this bound is tight for graphs in the Moser lattice … The same colorings also extend to the entire Moser ring") and Theorem 3.1 read in the held PDF (`~/source/library/pdf/arXiv-2606.12325.pdf`), as the record quotes them. My two leads, checked by it: arXiv:2602.17943 is Istrate–Zara, no bearing; the Haifa record is `[Zaks1989]`. The key I wrote in item 1075 named the volume's year (2011), which is no key — the work is `[Johnson2010]` (the 2011 volume's chapter); corrected in place. **Ruling, four parts, on what is filed now:** *Choice:* a Clerk (FS131-FPA2) files § 4.4 items 1–3 (`CLOSED-QUESTIONS.md` § 1.6, row 71, the bibliography lines) and § 2.4 item 4 (C7's bibliography rows, the same in both forms), with item 1054's owed bibliography items, `[Neukirch1999]` and § C rows for the arXiv ids `tools/bib_audit.py` lists. *Held:* § 2.4 items 1–3 (C7's novelty in form A or B, and the period question of draft 2, whose attribution may move with the 2002 paper) until `[KubickiLehelMorayne2002]` is read; C14's novelty line until its module lands. *Alternative:* file C7's form (A) now and correct it later. *Why:* a public "not found in print" that a held lead may overturn is the error items 1076–1079 just corrected. *Confidence:* high. **Routed:** its generalization — every finite unit-distance graph over ℚ(√3, √11) has `χ_gf ≤ 4` ([derived], one mind, from FS56-T2 and Theorem B; record § 4.2), which carries `[Ducz2026]`'s ring bound to the field — goes into FS131-KFS1's implementer brief (the planner is near its line). **Owed (prior-art debts, title only, for the asking lane or a later search):** Didin–Voronov 2026 (dense colour classes); `[Davies2026]`'s conditional transfer giving `χ(ℝ³) ≥ 7`; `[Zaks1989]` (closed access; `[Johnson2010]` p. 174 names it as where the `ℚ⁴` key "might be found"); C133-CHIF in print (what separates `[LiSu2026]` from `[MatolcsiEtAl2025]` § 2's question). **Credited:** FS131-PAS2, for the Li–Su find, the phrase probes of a withheld summary with a nonsense and a visible-text control, and the two printed questions it answered in passing (held with C7). Running: FS131-KFS1 — 1 slot.
> — source: plans/FS131-close-inventory.md

## What to read against

- **The paper:** `/home/kooshi/source/library/pdf/KubickiLehelMorayne2002-patch-rigid-colorings-rational-n-space-jctb-84-45-53.pdf` (J. Combin. Theory Ser. B 84 (2002) 45–53; its abstract: "every 2-coloring of Q 2 or Q 3, and every
  4-coloring of Q 4 is rigid", where a rigid colouring is one that "uniquely extend[s] from any open subset of Q n").
- **C7 and its derivation:** `CLOSED-QUESTIONS.md` § 3's entry "Which distances can a four-colouring of `ℚ⁴` forbid beside
  1?" (the answer and the outline: the component of the origin, the residue map onto `𝔽₄`, Zaks's Lemma 1, the valuation
  law); the derivations LV-T3 (`data/consolidation-2026-09-27/lv/record.md`) and LX (`data/consolidation-2026-09-27/lx/record.md`).
- **A3, the structure clause** — every proper four-colouring of `ℚ⁴` is, on each component, the residue map up to a
  bijection of the colours — as the kernel planner states it: `/home/kooshi/source/lean-dir/.claude/worktrees/il5/plans/FS131-KFS1-four-space-plan.md` § 1.2 (item A3) and § 2.1 — the planner's record, on its branch in another
  worktree, read only (it reaches `main` with the landing); my ruling that the
  implementer states it:

> 1082. **FS131-KFS1 handed back DONE: both parts planned with skeletons (logged 2026-10-17 00:40 UTC; about 395k by the harness's count — not to be resumed for work; record `plans/FS131-KFS1-four-space-plan.md`, report `data/fs131/reports/FS131-KFS1.md`; branch `fs131-kfs1` at `0c47f7b02`, worktree `il5`).** Planned, one mind; nothing held. **Part A (C7):** four modules `Proofs/HadwigerNelson/RationalFour/{Basic,Order,Compulsion,Forbid}.lean`, about 1,190 lines on the standard three axioms with no import — `[Zaks1999]` Lemma 1, `[BendaPerles2000]` pp. 123–125 and `[Johnson1990]` Thm 3 formalized; heads `forall_coloring_eq_iff`, `forall_coloring_ne_iff`, `exists_coloring_eq_and_ne_iff` (the compulsion law), `exists_coloring_forbidding_iff` (Johnson's question, every `d > 0`), its `padicValRat` form, `coloring_forbids_of_odd`, and the read-back anchor `nonempty_iso_unitDistance`. **Part B (C14):** `Instances/SeamFractional.lean`, the three heads already proved from two leaves (`numberField_seamField`, `IndepLaw.density_le_quarter_seamField`), by an invariant random independent set (`Collapse.exists_indepLaw`, standard three) and `G27`'s certificate — no blow-up and no E–L; about 1,360 lines, a generator of about 350 and generated data whose kernel price is unmeasured. **My receipts:** the four commits exist; I read the stored heads `exists_coloring_forbidding_iff` ("a colouring forbidding `d` exists ⟺ `d²` is not rational, or `d² = p/q` with `p`, `q` odd") and `forall_coloring_eq_iff` ("forced equal ⟺ `x = y` or `v₂(|x − y|²) ≥ 1`") against `CLOSED-QUESTIONS.md` § 3's C7 — they say what C7 says; `sorry` counts 36 in Part A's four modules, 2 in Part B's. **Rulings, four parts, on its held decisions:** (1) *Choice:* Part A also states A3, the structure clause (every proper four-colouring is, on each component, the residue map up to a bijection), about 40 lines. *Alternative:* leave it out. *Why:* it is the theorem the 2002 paper may hold (item 1075), so the library should state it in the form a reader can compare, and its price is small. *Confidence:* high. (2) *Choice:* Part B's first leaf is a price probe — generate the data and check two atom chunks before the whole `G27` pipeline. *Alternative:* build in the plan's order. *Why:* the kernel price is the one unmeasured number (`LEAN.md`: re-price from the first two leaves). *Confidence:* high. (3) *Choice:* two implementers at once, on two branches, each removing the other part's skeleton in its first commit (nothing with a `sorry` reaches `main`); the landings serialize. *Alternative:* one implementer for both (about 2,550 lines — past one context). *Why:* the parts share no module. *Confidence:* high. **Routed:** FS131-PAS2's generalization (every finite unit-distance graph over ℚ(√3, √11) has `χ_gf ≤ 4`) to Part B's implementer as optional; its search request (a smaller certificate for `χ_gf(G27) ≥ 4`) to `plans/SEARCH-QUEUE.md` row 27; its question for the asking lane (a `ℚ⁸` analogue through the octonions; steps A3 and A5 use associativity) to the asking lane's next job. **Held:** its front-file drafts (a ledger row for C7, `CLOSED-QUESTIONS.md` lines, bibliography "rests on" fields) until the landings and `[KubickiLehelMorayne2002]`. **Credited:** the route for C14 with no blow-up and no E–L, and its own tool defect found and fixed with a control.
> — source: plans/FS131-close-inventory.md

- **The two drafted forms** of the wording: `plans/FS131-PAS2-prior-art.md` § 2.4, items 1–3.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their source; restate in your record C7, A3 and the two
   forms in your own words.
2. **The reading**: the whole paper, with every theorem and lemma about `ℚ⁴` (and any about general `ℚⁿ` that applies at
   `n = 4`) quoted with its page; how "rigid" is defined; and for each of C7's parts — the compulsion law (forced equal,
   forced different, free), A3, and the answer to Johnson's question — whether the paper states it, implies it in a few
   lines (say which lines), or neither. Mine its reference list, and note anything else in it that bears on this
   project's results (its patch-colouring theorem among them).
3. **The verdict and the drafts**: form (A), form (B) or a third form of `plans/FS131-PAS2-prior-art.md` § 2.4 items 1–3, brought to what you read,
   each naming its slot; its draft 2 (the periods question) re-worded if the paper bears on it; a `BIBLIOGRAPHY.md` status
   line for `[KubickiLehelMorayne2002]` ("read in full", with what it states); and a novelty line for the C7 module's
   landing, in the project's wording rule ("prior art: not found in print" only for what is not; never "first").
4. **The report**, in the standing rules' form.

## What is yours to decide

How far to follow the paper's references, and the verdict. If C7 or A3 is misstated against the paper, or the paper's
notion of rigidity is stronger or weaker than A3, say exactly how: that is the finding. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
