## Workflow — how we work through this project
We build **leaf-first up the dependency DAG, one milestone at a time**, and we live on the **green
manifold**: the file elaborates at the end of every working step, and `sorry` appears only at tracked
leaves.

1. **Architect** — the major modules and the overall shape → `ARCHITECTURE.md`.
2. **Plan** — master roadmap: milestones, the module/lemma DAG, leaf-first order → `ARCHITECTURE.md`
   § Roadmap.
3. **Subplan** — one milestone at a time, working up the DAG. Deep-dive its requirements and
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
8. **Quality gate** — the full gate from DEBRUIJN's `<the_loop>` / `<commands>`: `lake build` green ·
   zero `sorry` (`grep -rn --include="*.lean" "sorry"`) · `#print axioms` clean on the public
   surface · linters silent (`lake lint`) · spec examples passing.
9. **Commit** — and in the same closing commit, **update `CLAUDE.md` § Frontier** (the
   state-of-the-art summary, the novel-results ledger, the ranked paths forward). A
   milestone whose close does not update the Frontier is not closed (rule set 2026-08-04).
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
