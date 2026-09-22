## Workflow — how we work through this project
We build **leaf-first up the dependency DAG, one milestone at a time**, and we live on the **green
manifold**: the file elaborates at the end of every working step, and `sorry` appears only at tracked
leaves.

1. **Architect** — the major modules and the overall shape → `ARCHITECTURE.md`.
2. **Plan** — master roadmap: milestones, the module/lemma DAG, leaf-first order → `ARCHITECTURE.md`
   § Roadmap (from M21 onward: `CLAUDE.md` § Frontier / paths forward). **The stub rule (set
   2026-08-09, Kooshi):** every future milestone on the roadmap is maintained as a *detailed*
   pre-subplan stub in `plans/` — full mission context in plain language, everything the deciding
   session knew (the observations, the registered expectations, the failure clauses, the named
   deliverables including visualizers where the milestone produces an explorable object, **and a provisional-bearings line
   naming the grokkings the minting session believes bear**, step 3g) — written
   so a fresh session with zero conversation memory can subplan it with all meaning intact.
   Sessions die and compaction loses nuance; the stubs are the roadmap's memory. A direction
   change that does not rewrite the affected stubs is not recorded; a demoted milestone keeps its
   stub with a banner saying why (deprecate, never delete).
3. **Reframe** — the milestone's opening, in two acts **in this order**, before a route is written: **3g, the knowledge
   audit** against the project's own theory (results, understanding, method — here the ledger, the grokkings and the method
   rules), whose product is the *recognition*: the milestone's question restated in the theory's terms, with what the theory
   predicts, supplies, forbids and what the milestone can falsify; then **3a, the prior-art gate** against the world's theory,
   which *depends on 3g* — the recognition sentence is the search query (G49), and prior art found without a frame is filed
   under "are we first?" and lost (the step-9 sweep exists for that failure). Their outputs are **§G** and **§PA** of the subplan,
   in that order, ahead of everything else; then step 3s. (Minted in this shape 2026-09-22, Kooshi: FS-70's routes were written
   from the literature's shapes by analogy because nothing had reframed the goal first. In a generic extraction of this workflow
   the two acts are *the knowledge audit* and *the prior-art gate*, together *the reframe*, and they precede the subplan.)

3g. **Grokking audit** (the knowledge audit) — *the first act of step 3: before the prior-art gate, before the subplan's routes, before any
   derivation.*
   Its output is a **§G section of the subplan**, ahead of §PA; a subplan without one is not a subplan. **Minted 2026-09-22
   (Kooshi)**, after FS-70's plan — three implementer phases, an exact theorem and a typed null — was found to have skipped
   four things `CLAUDE.md` already held, each surfaced only by Kooshi asking a question a grokking answers: G54's tight/slack
   classifier at the field's split prime (run in one minute, it says the 2-unit local plane is Hoffman-tight at four colours, so
   it forces pairs at depth — the very mechanism of every known four-forcer, row 67 — which is a *reason to expect forcing* the
   plan never had); G15/G16/G32's disjunctive pigeonhole form and the two-distance dial (a whole second route, with tools
   already built); G40/G14, which predicted the arena's null before it was run; and the lens shape the plan itself named first
   and no phase built. **Why the step exists, in Kooshi's words:** *the grokkings are perhaps the most important prior art we
   have; they are always in context with the intent that they will be used to advance the frontier, in a way that no other
   knowledge can; we are far enough into novel mathematics that you cannot rely on your priors any more.* An agent that reads
   `CLAUDE.md` and then plans from analogy with the literature has used the corpus as background; this step makes it the
   foundation. **The procedure, with the rigor of the modeling passes:**
   1. **Walk every entry, one line each, no batching, no skipping**: every grokking G1–G66 (and every one minted since), every
      ledger row's *mechanism* (rows 1–75), every `[method]` rule in `CLAUDE.md` § Grokkings and § Building. For each, one of
      three verdicts with its reason: **bears** — say what the entry says about *this* milestone's object, question, fabric or
      instruments, and which phase it changes; **silent** — say why; **falsifiable here** — the milestone can kill or confirm
      it, so register it as a prediction. A verdict without a reason is not a verdict.
   2. **Extract each *bears* into an instruction to a phase**: the shape it dictates (a lens, a core, a ball law), the screen it
      supplies (a residue, a classifier, an additive family), the theorem it makes free (a null predicted before it is run), the
      control it names (a known positive one field over), the route it adds or kills. Write it where the implementer will act
      on it — in the phase table — not only in §G.
   3. **The test of the audit:** its output must *change the plan* — a route added, removed or re-ordered, a screen run before
      a solver, a prediction registered — or the plan says explicitly that nothing in the corpus bears, which is itself a
      claim the owner pushes back on. An audit that changed nothing has measured its own reading, not the corpus (G21).
   4. **Fresh, every milestone, never from memory** — like the modeling skills of step 5: a compaction summary, a previous
      milestone's §G, or "I know the grokkings" is not the audit. The planner runs it with `CLAUDE.md` open; the owner scores
      §G line by line before accepting the plan, and a skipped entry is a plan defect.
   5. **At the close (step 9), re-read §G against what happened**: which extractions paid, which entry should have been used
      and was not — each miss is a new instance recorded under this step, and the grokking that was missed gets one line
      saying which milestone it would have aimed.
   6. **Two lighter touches at the milestone's edges.** *At minting* (step 2, the close that writes a stub): the stub carries a
      **provisional bearings** line — the grokkings the minting session believes bear — so that *choosing* the milestone uses the
      knowledge too; it is provisional and the audit at the opening replaces it (FS-70's stub named G48, G55, G57, G7, G62, G31
      and missed G54, G16, G32, G40, G60). *At the close* (step 9): every newly minted grokking names the **open stubs it bears
      on**, and those stubs' provisional lines are updated in the same commit — the knowledge reaches the milestones it aims
      before they open.

3a. **Prior-art gate** — *before any derivation, and before the modeling passes.* Thirty minutes, and its
   output is a **§PA section of the subplan**; a subplan without one is not a subplan. Minted 2026-09-08
   (`CLAUDE.md` § Grokkings G49) after a check found that four consecutive milestones had reconstructed the
   contents of a 2010 draft that was one web search away, and that a paper systematizing one of their kernel
   theorems had been sitting unread in our own bibliography. Eight questions — the last four each added after a miss:
   1. **Name the object in the vocabulary of the discipline it belongs to, and search THAT.** G46 already
      demands the recognition step for *deriving*; the sentence it produces is the search query. "The finite
      planes are Cayley graphs of an abelian group" → search *Cayley graph chromatic number abelian group*.
      **Never search in this project's coined vocabulary** — "field wall", "finite-plane bound", "5-sealed"
      appear in no paper, and a private vocabulary is a perfect filter against finding out you are not first.
   2. **Search under at least two disciplines' names for the same object.** Kooshi's ladder of disciplines
      (under G30) already names which two rooms a given wall sits between; use it as the search plan. The
      2026-09-08 miss happened precisely because the object was in two literatures that do not cite each other.
   3. **Search for the QUESTION, not only the method** — "has anyone computed χ of the plane over this field?"
      A stated open problem you are about to answer is worth knowing *before* the milestone.
   4. **Look outside arXiv** — personal pages, unpublished drafts, theses, and the pre-2000 journal literature.
   5. **Walk the citation graph of the paper that POSED the question, not only of the one that proved the nearest
      result** — added 2026-09-09, after a check walked the four citations of the paper with the nearest theorem
      and never touched the forty-seven of the paper that asked the question. Anyone answering a question cites
      whoever asked it.
   6. **Open every citing work whose title is in the neighbourhood; never characterise one from its abstract** —
      the same check dismissed a paper held on our own shelf as "a new proof of `χ(ℝ²) ≥ 5`", which its abstract
      says and its conclusion contradicts. An abstract is not a reading (G50).
   7. **Cross-check citation lists in two databases** — OpenAlex and Semantic Scholar disagreed by a factor of
      four on the same paper, and the missing three were the informative ones.
   8. **Pull the COMPLETE author listing of everyone who posed or worked the question, and search abstracts in THEIR
      vocabulary, in a reviews database** — added 2026-09-19, after FS-61's gate found `[Fischer1994]` (Congressus
      Numerantium 104), whose author's summary states this project's Theorem B thirty-two years before we proved it.
      Every earlier gate missed it, for three reasons items 1–7 do not reach: it is in neither OpenAlex nor Semantic
      Scholar and nothing cites it, so **no citation walk can arrive at it** — pre-2000 conference proceedings mostly
      exist in no citation graph at all; its title, *A planar geometric graph of chromatic number four*, carries none
      of the question's words and reads in a listing as a planar-graphs paper; and we had read one paper by its author,
      ordered a second by interlibrary loan, and never once listed what else he wrote. Either of two queries finds it in
      seconds: his author listing (27 entries, exactly three on the subject), and his own 1990 vocabulary run against
      abstracts — `ti:"chromatic number" & ab:"additive" & ab:"coloring" & py:1985-2000` returns that one paper.
      **The zbMATH Open API is an excellent additional source and belongs in every gate — for DISCOVERY, not only for
      looking up a paper already known** (the only way it had been used here):
      `https://api.zbmath.org/v1/document/_search?search_string=…&results_per_page=100` (URL-encode the query;
      `curl -G --data-urlencode` does it). Fields, each verified 2026-09-19: `au:"Last, First"`, `ti:"…"`, `ab:"…"` (the
      review or summary text), `py:1985-2000`, `cc:05C15` (MSC class), `so:"Congr. Numerantium"` (source),
      `an:0836.05030` (a Zbl number); join with `&` and `|`. The JSON carries the full review text and, under
      `editorial_contributions`, whether it is a reviewer's review or an author's `summary` — **record which, because an
      author's summary is a claim, never a reading** (G50). The zbMATH *web pages* refuse scripted fetches (HTTP 403); the
      API does not. It indexes reviews, not citations, so it complements items 5–7 and replaces none of them; a negative
      from it measures the query's words, like any other (G21).
   Record the result in §PA either way: a negative ("searched X, Y, Z under these names; nothing") is a finding
   about where the unworked ground is. **Sell this as AIMING the milestone, not as protecting novelty**, or it
   gets skipped: it hands over free theorems and it finds the open questions the work is answering. Anything
   found goes into `BIBLIOGRAPHY.md` the same day, per the bibliography rule.
3s. **The subplan proper** — only now the routes, the skeleton, the measurements and the phases, each aimed by §G
   and §PA. Deep-dive its requirements and
   *strictly specify its shape*: write the **skeleton** — every signature and full theorem statement,
   `sorry` at every leaf — so the *specification* elaborates before any proof effort is spent.
   Validate the spec right there, where a wrong statement is cheap: `#eval` the definitions, keep a
   sanity `example` per definition, and exhibit one concrete model of the hypotheses before trusting
   anything that assumes them.
   **Where cost decides the shape, measure before specifying, not after.** At this project's scale a
   representation choice is routinely a 3–5× difference, and it is invisible until measured: M04's
   vertex table and its squared-distance definition each turned out that way, and because both were
   settled with numbers in the subplan, implementation overturned nothing. A shape chosen from
   plausibility and then benchmarked is a shape you will rewrite. Refine scope here: if a milestone is bigger than it looked, push the
   excess to a later milestone — and whenever we carry scope forward, drop a subplan **stub** in
   `plans/` capturing the carry-forward notes → `plans/<Mxx-milestone>.md`.
4. **Commit** the subplan (skeleton included) and move directly to modeling without pausing.
5. **Modeling pass** — reforge the subplan through the de Bruijn modeling skills before implementing.
   Each skill is a fresh **Skill**-tool invocation scoped to the current milestone — *always* freshly
   invoked, *never* worked from memory, and *never* counted as loaded just because its text already
   sits in context. A skill carried forward by a compaction summary, or shown in a "for context only,
   do not re-execute" reminder, is *not* a fresh load: its stated arguments name an earlier milestone,
   and, framed as passive reference, it gets read rather than run as a live procedure, which measurably
   blunts the pass. Invoke fresh regardless of what is already in context. Which passes to run:
   - **`debruijn-domain-modeling`** — *drive to the beautiful model* — find the true shape of the
     types and the statements — **always**.
   - **`debruijn-obligation-modeling`** — *drive to the statement from which the proof derives* —
     decompose the proofs; design the inductions, the recursion, and the termination measures — if
     the milestone proves anything nontrivial (an induction, a recursive definition, a termination
     obligation, any claim over all cases).
   - **`debruijn-experience-modeling`** — *drive until the tool disappears* — design the surface
     others consume — if the milestone ever crosses a consumer boundary: a lemma API, a simp set,
     notation, error or tactic output ("Try this:"), docstrings, config, or a macro/elab diagnostic.
   Order by where the milestone's center of gravity sits: run **experience first** when the consumer
   surface *is the purpose* of the milestone (experience → domain → obligation), and **last** otherwise
   (domain → obligation → experience). Apply each pass to the subplan and **commit** its changes before
   moving to the next.
<disabled>
6. **Pause for user review** of the refined subplan before implementing. Report it in the house
   format — **§ "How to report to the user"**, which is binding here: structure over prose, plain
   English assuming zero knowledge of this project, every decision in its four parts (choice ·
   alternative · why · confidence), the default stated for every item, ranked by urgency, and what
   you already settled listed separately. Three parts:
   - **What it is for** — the milestone's name and purpose, in a line or two.
   - **The settled shape** — what the modeling passes converged on, as a short list.
   - **Decisions needed** — only genuine scope or product forks, each in the four-part shape plus
     what happens if the user says nothing. Surface none you can settle yourself; those go in the
     *already settled* table, in the same four parts.
</disabled>
7. **Implement** the milestone against its subplan — burn the skeleton's `sorry`s down via the loop:
   select one obligation (the goal state is the machine's own prioritization), **query** the
   environment before inhabiting, then close it or split it into finitely many strictly-smaller,
   named `have`/lemma children. Replacing one `sorry` with smaller ones is the only legal move.
8. **Quality gate** — the full gate from DEBRUIJN's `<the_loop>` / `<commands>`, plus
   **`./scripts/vacuity.sh` green** (no new theorem quantifying over a provably empty domain, and no
   new carrier without a proved inhabitant — `CLAUDE.md` § The gate has the rationale and the
   baseline rule): `lake build` green ·
   zero `sorry` (`grep -rn --include="*.lean" "sorry"`) · `#print axioms` clean on the public
   surface · linters silent (`lake lint`) · spec examples passing.
9. **Commit** — and in the same closing commit, **update `CLAUDE.md` § Frontier** (the
   state-of-the-art summary, the novel-results ledger, the ranked paths forward). A
   milestone whose close does not update the Frontier is not closed (rule set 2026-08-04).
   **And re-rank the frontier set** (`plans/FRONTIER-STUBS.md`, rule set 2026-09-06, Kooshi): add every
   candidate the milestone surfaced as a stub file, re-rank the table with each row's bearing on χ ≥ 6
   stated honestly, demote with a banner, never delete; § Paths forward mirrors the top of the table.
   Both files hold current state only: rewrite the affected text in place — no dated amendments,
   correction trails or superseded rankings — and leave the history to git and the milestone's plan.
   **And re-read the milestone's §G against what happened, and propagate forward** (2026-09-22, step 3g): which extractions
   paid, which entry should have borne and was not used — each a new instance under 3g — and, for every grokking minted at this
   close, the open stubs it bears on, their provisional-bearings lines updated in the same commit.
   **And sweep the milestone's §PA for recognitions that belong in the Grokkings** (2026-09-17). The
   conjecture sweep below catches claims the milestone *made*; this catches identifications it *found while
   checking whether it was first*. The rule exists because M63 phase H3's prior-art appendix derived, verified
   symbolically, and correctly recorded that this project's whole rotation family is the Σ = n coincidence-rotation
   family of an imaginary quadratic order — the construction grammar of every witness we hold, in the vocabulary of
   a discipline with classification theorems — and then closed, leaving it in §PA.4 where nothing reads it. It
   surfaced five days later only because Kooshi asked whether any of this looked like Moiré patterns. **A prior-art
   appendix is written to answer "are we first?" and is filed under that question, so anything it learns about
   what the object IS gets filed there too and is lost.** At every close, read the §PA back asking only: *what did
   this teach us about our own object?* — and promote each answer to a grokking or a stub.
   **And sweep the milestone's own plan for unpursued conjectures** (Kooshi, 2026-09-14): grep it for
   "conjecture" and "not claimed", and for each hit either mint a stub or record an explicit decline in
   the close. The rule exists because M56's modeling pass wrote "Conjecture, NOT claimed: 1/p ∈ Σ₀(F²)
   iff no conjugation-fixed prime of F(i) lies above p" inside a lemma paragraph on 2026-09-06, no stub was
   ever minted, and an outside advisor proved it eight days later — the stub rule fires on candidates a
   milestone *surfaces*, and a conjecture buried under a heading about something else is not surfaced.
10. **Report what landed** — in the house format of **§ "How to report to the user"**: the milestone's
    name and purpose, the shape that actually shipped, every decision implementation forced or
    overturned (in its four parts, with the confidence you now hold after seeing it run), and what to
    work on next. Anything the milestone left open goes in the report as a ranked item with its
    default, not as a sentence in a paragraph.
11. **Subplan the next milestone** and repeat.

Do not run ahead: finish and commit a milestone's quality gate before subplanning the next.

> **Metaprogramming** (macros, elaborators, custom tactics, `Syntax`/`Expr`, `MetaM`/`TermElabM`/
> `TacticM`, notation, deriving handlers, delaborators, linters) is governed by the **`debruijn-meta`**
> companion skill — load it (freshly, under the same rule as step 5) for any milestone that writes
> code that writes code.

## How to report to the user

**Structure over prose, always.** Reports and decision requests are read by someone with decision
fatigue; a paragraph that buries a choice inside it costs more than one that never got written. This
governs every response that **reports work** or **asks the user something**. A direct question still gets a
direct answer — do not table-ify "where did you put X".

Six properties, in order of how much they matter:

1. **Plain English, and assume zero prior context — for the entire project, not just this session.**
   The reader has never seen this repository, does not know what language it is written in, is not
   holding anything from the last message, and does not know what any milestone number refers to.
   Write for exactly that reader in every report, including mid-session ones where it feels
   redundant. Rules, all of them hard:
   - **No identifier is ever the noun.** Say "the check that every listed edge really is exactly one
     unit long", not `Geometry.edgeLength_eq_one`. A path, type, theorem, or function name may follow
     the plain-English name in parentheses as an address — it may never stand in for it.
   - **No shorthand and no back-references.** Never "the fix we discussed", "M03's second ask", "as
     noted above", "the same issue as before". Restate the thing in full, every time, however often.
   - **Expand on first use, every response.** Every milestone number, issue number, abbreviation, and
     piece of project vocabulary gets a one-clause gloss the first time it appears — "milestone M03,
     the bridge that turns 'this graph cannot be coloured with four colours' into a question a SAT
     solver can answer and a certificate the proof checker can re-verify".
   - **Describe it in the product's terms, not the implementation's** — what someone reading the
     finished theorem, or using the thing, would notice is different, before any word about how it
     was built.
   - **The test:** if a sentence only lands for someone with the repository open, the previous
     message in mind, or a working knowledge of Lean, it is not finished. Rewrite it.
2. **Every decision is stated explicitly, in four parts.** This binds *all* decisions — the ones you
   are handing to the user and the ones you settled yourself. A decision never appears as a bare
   statement of what will happen. The four parts, in order:
   - **The choice** — one line, in the plain English of property 1.
   - **At least one alternative** — one you actually weighed, named concretely, with what it would
     have bought you. "Do nothing" counts only when doing nothing was genuinely live.
   - **Why this one won** — measured against that named alternative specifically, not praise of the
     winner in the abstract.
   - **Confidence — high, medium, or low — and for anything below high, the one fact that would
     change it.** "Medium — if the coordinates ever need a fifth square root, this shape gets redone."

   If you cannot name an alternative, you did not make a decision, you took a default: say so in
   those words rather than dressing it up as one.
3. **State the default — "if you do nothing, X happens."** The single most useful line. It lets the user
   skip an item without it becoming a dropped thread, and it is what makes the difference between a
   list I can act on and a list I have to hold.
4. **Rank by urgency, and say which rank each item is.** *Must decide before work starts* / *decide
   when convenient* / *already settled, skip* / *know but do not decide*. Put the counts in the
   headings so the user knows the size of the ask before reading it.
5. **List what you already settled.** Explicitly, as its own section, so the user does not have to audit for
   what they might have missed. This section exists to be skipped — that is its whole job. Its
   entries are still decisions, so they still carry all four parts of property 2; a table with
   *choice · alternative · why · confidence* columns keeps each one to a row.
6. **Tables and short lists, not paragraphs.** One or two lines per item. Options in a table with a
   column for the case for each.

**Surface a decision only when it is genuinely theirs** — a real product or scope fork, not an
implementation detail. If you can settle it from the code, the standard, or a sensible default:
settle it, put it in the *already settled* section as a four-part row, and move on. Every item on the
decision list spends attention that the real forks need.

**Recommend, always.** Every decision the user is asked to make carries your recommendation and your
confidence in it. "Here are three options" without a lean is the question handed back.
