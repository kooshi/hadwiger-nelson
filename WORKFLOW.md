## Workflow 2.0 — how we work through this project

We build **leaf-first up the dependency DAG, one milestone at a time**, and we live on the **green manifold**: the file
elaborates at the end of every working step, and `sorry` appears only at tracked leaves.

### Why we work this way — the reframe

A project past the known frontier has three tiers of knowledge, and it accumulates all three at every close: **results** —
what the kernel checked or an independent checker certified (the ledger); **understanding** — the mechanisms behind the
results and the readings that name their killing tests (the grokkings); **method** — the instruments, their failure modes and
the rules that keep a measurement honest. Together they are the project's *theory*. Two facts about it govern everything below.

**First: past the frontier, priors are worthless and the theory is the only map.** The literature's constructions, the
solver's defaults, an agent's sense of what usually works — each is a prior formed where the ground was known. Where the
project stands, the only knowledge that bears on the next milestone is what the project itself has established, and it is
held in context precisely so that it is *used*: to say what a milestone's goal *is* in the theory's terms, what the theory
already predicts about it (a free theorem; a null that need not be run), what instruments it supplies (a screen, a
classifier, a control with a known answer), what it forbids, and what the milestone could falsify. A plan built from an
analogy with the literature while the theory sat unread has used the project's own knowledge as background. That is the
failure this version exists to prevent: FS-70's plan — three implementer phases, an exact theorem, a typed null — was built
by transposing a published construction, and the theory held four things that bore on it (a classifier that says where
forcing exists in that field; a second route with tools already built; a prediction of a null before it was run; the shape
the plan itself named first), every one surfaced only when Kooshi asked a question a grokking answers.

**Second: knowledge is the world's as well as ours, and ours supplies the vocabulary to find theirs.** A prior-art search
in coined vocabulary finds nothing; one made with the object named in its discipline's terms finds what was published
decades earlier — and that naming is what the re-grokking produces. So the world's knowledge is searched *after* our own
has reframed the goal, and what the search finds about *what the object is* flows back into the theory at the close.

Hence **the reframe**: every milestone opens with two acts, in this order, before a single route is written — the
**re-grokking** (our theory, entry by entry, read from inside the new question) and the **prior-art gate** (the world's, in
the recognition's words) — and their outputs stand at the head of the subplan. The first act is named for what it is: not an
audit, which is an instruction to check, but re-grokking, an instruction to think (G67); and the theory is written to be
reasoned from — each grokking ends with what it makes you do and what would kill it. The reframe is carried out with the rigor of the
modeling passes: fresh every milestone, never from memory or a summary, walked in full, scored line by line. And the loop
closes at every close: results to the ledger, understanding to the grokkings, each miss to the re-grokking's instances, and every
new grokking forward to the open stubs it bears on. It is the foundation of every milestone; to omit it risks all future
advancement (Kooshi, 2026-09-22).

### The steps

1. **Architect** — the major modules and the overall shape → `ARCHITECTURE.md`.

2. **Plan** — master roadmap: milestones, the module/lemma DAG, leaf-first order → `ARCHITECTURE.md` § Roadmap (from
   M21 onward: `CLAUDE.md` § Frontier / paths forward). **The stub rule (Kooshi, 2026-08-09):** every future milestone on the
   roadmap is maintained as a *detailed* pre-subplan stub in `plans/` — full mission context in plain language, everything the
   deciding session knew (the observations, the registered expectations, the failure clauses, the named deliverables
   including visualizers where the milestone produces an explorable object), **and a provisional-bearings line naming the
   grokkings the minting session believes bear** (step 3.1) — written so a fresh session with zero conversation memory can
   subplan it with all meaning intact. Sessions die and compaction loses nuance; the stubs are the roadmap's memory. A
   direction change that does not rewrite the affected stubs is not recorded; a demoted milestone keeps its stub with a banner
   saying why (deprecate, never delete).

3. **Reframe** — the milestone's opening: two acts, in this order, before a route is written, and for a derivation milestone a
   third (3.3). Their outputs are **§G**, **§PA** and, for a derivation milestone, **§IQ** of the subplan, in that order, ahead of
   everything else. A subplan without them is not a subplan.

   **3.1 Re-grokking** — the project's own theory read from inside the new question: every grokking, every row's
   *mechanism* in `LEDGER.md`, every method rule. Its product is the *recognition*: the milestone's question restated in the theory's terms, with what the
   theory predicts, supplies, forbids, and what the milestone can falsify. (Minted 2026-09-22, Kooshi; the instance is FS-70,
   above — G54's tight/slack classifier at the field's split prime, run in a minute, says the local plane forces pairs at
   depth, the mechanism of every known four-forcer and a reason to expect forcing the plan never had; G15/G16/G32's
   pigeonhole form and two-distance dial were a second route with tools built; G40/G14 predicted the arena's null; the lens
   shape was the plan's own first shape and no phase built it.) The procedure:
   1. **Walk every entry, one line each, no batching, no skipping** — every grokking, every row's mechanism in `LEDGER.md`, every
      `[method]` rule in `CLAUDE.md` § Grokkings and § Building — both files open. For each, one of three verdicts with its reason: **bears** —
      what the entry says about *this* milestone's object, question, fabric or instruments, and which phase it changes;
      **silent** — why; **falsifiable here** — the milestone can kill or confirm it, so register it as a prediction. A verdict
      without a reason is not a verdict.
   2. **Extract each *bears* into an instruction to a phase**: the shape it dictates, the screen it supplies, the theorem it
      makes free (a null predicted before it is run), the control it names (a known positive, perhaps one field over), the
      route it adds or kills. Write it where the implementer acts on it — in the phase table — not only in §G.
   3. **The test of the re-grokking: its output must change the plan** — a route added, removed or re-ordered, a screen run before
      a solver, a prediction registered — or the plan says explicitly that nothing in the corpus bears, which is itself a claim
      the owner pushes back on. A re-grokking that changed nothing has measured its own reading, not the corpus (G21).
   4. **Fresh, every milestone, never from memory** — like the modeling skills of step 6: a compaction summary, a previous
      milestone's §G, or "I know the grokkings" is not the re-grokking. The planner runs it with `CLAUDE.md` and `LEDGER.md` open; the owner scores
      §G line by line before accepting the plan; a skipped entry is a plan defect.
   5. **Two lighter touches at the milestone's edges.** *At minting* (step 2): the stub's provisional-bearings line, so that
      *choosing* the milestone uses the knowledge too — provisional, replaced by the re-grokking at the opening (FS-70's stub named
      G48, G55, G57, G7, G62, G31 and missed G54, G16, G32, G40, G60). *At the close* (step 9): the §G re-read and the forward
      propagation of every new grokking to the open stubs it bears on.

   **3.2 The prior-art gate** — against the world's theory, searched in the recognition's words. Thirty minutes to a morning;
   its output is **§PA**. (Minted 2026-09-08, `CLAUDE.md` G49, after a check found that four consecutive milestones had
   reconstructed the contents of a 2010 draft that was one web search away, and that a paper systematizing one of their
   kernel theorems had been sitting unread in our own bibliography.) Eight questions, the last four each added after a miss:
   1. **Name the object in the vocabulary of the discipline it belongs to, and search THAT.** The re-grokking's recognition
      sentence is the query: "the finite planes are Cayley graphs of an abelian group" → search *Cayley graph chromatic
      number abelian group*. **Never search in this project's coined vocabulary** — "field wall", "finite-plane bound",
      "5-sealed" appear in no paper, and a private vocabulary is a perfect filter against finding out you are not first.
   2. **Search under at least two disciplines' names for the same object.** Kooshi's ladder of disciplines (G30) names which
      two rooms a given wall sits between; use it as the search plan. The 2026-09-08 miss happened precisely because the
      object was in two literatures that do not cite each other.
   3. **Search for the QUESTION, not only the method** — "has anyone computed χ of the plane over this field?" A stated open
      problem you are about to answer is worth knowing *before* the milestone.
   4. **Look outside arXiv** — personal pages, unpublished drafts, theses, and the pre-2000 journal literature.
   5. **Walk the citation graph of the paper that POSED the question, not only of the one that proved the nearest result**
      — added 2026-09-09, after a check walked the four citations of the paper with the nearest theorem and never touched
      the forty-seven of the paper that asked the question. Anyone answering a question cites whoever asked it.
   6. **Open every citing work whose title is in the neighbourhood; never characterise one from its abstract** — the same
      check dismissed a paper held on our own shelf as "a new proof of `χ(ℝ²) ≥ 5`", which its abstract says and its
      conclusion contradicts. An abstract is not a reading (G50).
   7. **Cross-check citation lists in two databases** — OpenAlex and Semantic Scholar disagreed by a factor of four on the
      same paper, and the missing three were the informative ones.
   8. **Pull the COMPLETE author listing of everyone who posed or worked the question, and search abstracts in THEIR
      vocabulary, in a reviews database** — added 2026-09-19, after FS-61's gate found `[Fischer1994]` (Congressus
      Numerantium 104), which proves this project's Theorem B's value thirty-two years before we proved it (read and verified
      2026-09-22). Every
      earlier gate missed it, for three reasons items 1–7 do not reach: it is in neither OpenAlex nor Semantic Scholar and
      nothing cites it, so **no citation walk can arrive at it** — pre-2000 conference proceedings mostly exist in no
      citation graph at all; its title, *A planar geometric graph of chromatic number four*, carries none of the question's
      words and reads in a listing as a planar-graphs paper; and we had read one paper by its author, ordered a second by
      interlibrary loan, and never once listed what else he wrote. Either of two queries finds it in seconds: his author
      listing (27 entries, exactly three on the subject), and his own 1990 vocabulary run against abstracts —
      `ti:"chromatic number" & ab:"additive" & ab:"coloring" & py:1985-2000` returns that one paper. **The zbMATH Open API
      belongs in every gate — for DISCOVERY, not only for looking up a paper already known**:
      `https://api.zbmath.org/v1/document/_search?search_string=…&results_per_page=100` (URL-encode the query;
      `curl -G --data-urlencode` does it). Fields, each verified 2026-09-19: `au:"Last, First"`, `ti:"…"`, `ab:"…"` (the
      review or summary text), `py:1985-2000`, `cc:05C15` (MSC class), `so:"Congr. Numerantium"` (source), `an:0836.05030` (a
      Zbl number); join with `&` and `|`. The JSON carries the full review text and, under `editorial_contributions`,
      whether it is a reviewer's review or an author's `summary` — **record which, because an author's summary is a claim,
      never a reading** (G50). The zbMATH *web pages* refuse scripted fetches (HTTP 403); the API does not. It indexes
      reviews, not citations, so it complements items 5–7 and replaces none of them; a negative from it measures the query's
      words, like any other (G21).

   Record the result in §PA either way: a negative ("searched X, Y, Z under these names; nothing") is a finding about where
   the unworked ground is. **Sell the gate as AIMING the milestone, not as protecting novelty**, or it gets skipped: it hands
   over free theorems and it finds the open questions the work is answering. Anything found goes into `BIBLIOGRAPHY.md` the
   same day, per the bibliography rule. **A new instrument minted mid-milestone gets its own gate before it is relied on**
   (FS-70's Kempe screen was minted without one).

   **3.3 The invariant question** — for every **derivation milestone**, meaning one whose deliverable is a theorem or a
   derivation rather than an object, a measurement, a kernel port or an audit. When unsure, run it. Its output is **§IQ**.
   (Minted 2026-09-23, Kooshi; `CLAUDE.md` G72. The instance: FS-73 asked whether every colouring looks like a periodic one,
   with the arithmetic removed and search forbidden. That forced the height function whose slope decided χ(ℚ(√167)²) ≥ 4, a
   bound two direct attacks on ℚ(√167) had not reached.) Five items, each written out:
   1. **The existence form**: the milestone's question as it is usually asked. Is there an object, a colouring, a forcer?
   2. **The structural form**: *a question that cannot be answered without an invariant every solution carries.*
      - It is about **every** solution, not one.
      - It is posed in the most general class where it still makes sense, with the arithmetic stripped when it can be.
      - §PA's naming (3.2 item 1) is where the invariant usually comes from: the home discipline's standard handle on an
        arbitrary solution.
   3. **The invariant it forces**: named if the discipline has one. Otherwise write "none known", and then finding it is the
      milestone.
   4. **Its route**: derivation only. A search may check a derived claim; it never answers the structural form.
   5. **The open instances it would decide**: listed, so that a new exact decision procedure is aimed at them the day it lands.

   The owner scores §IQ with §G. A structural form that is the existence form reworded has not done 3.3.

4. **Subplan** — only now the routes, the skeleton, the measurements and the phases, each aimed by §G and §PA. Deep-dive
   the milestone's requirements and *strictly specify its shape*: write the **skeleton** — every signature and full theorem
   statement, `sorry` at every leaf — so the *specification* elaborates before any proof effort is spent. Validate the spec
   right there, where a wrong statement is cheap: `#eval` the definitions, keep a sanity `example` per definition, and
   exhibit one concrete model of the hypotheses before trusting anything that assumes them. **Where cost decides the shape,
   measure before specifying, not after.** At this project's scale a representation choice is routinely a 3–5× difference,
   and it is invisible until measured: M04's vertex table and its squared-distance definition each turned out that way, and
   because both were settled with numbers in the subplan, implementation overturned nothing. A shape chosen from plausibility
   and then benchmarked is a shape you will rewrite. Refine scope here: if a milestone is bigger than it looked, push the
   excess to a later milestone — and whenever we carry scope forward, drop a stub in `plans/` capturing the carry-forward
   notes. Every phase names its budget, its stop rule, its checkpoint path and resume command, and what a kill redoes.

5. **Commit** the subplan (skeleton included), **together with the milestone's close inventory**, and move directly to modeling
   without pausing.

   **The close inventory** (`plans/FSnn-close-inventory.md`; Kooshi, 2026-09-23) is opened at this commit and written to **the
   moment an item comes up**, never at the end. The rule: **nothing the close will need lives only in the coordinator's context, or
   in a scratch directory.**
   - **One line per item, with its source address.** The items are:
     - a result, or a theorem proved outside the kernel;
     - a correction owed to `CLAUDE.md`, `LEDGER.md`, a plan or a record;
     - a prediction registered or scored;
     - an owner ruling, or an owner error;
     - an agent's slip;
     - a tool defect;
     - a prior-art debt;
     - a stub to mint or re-aim;
     - a file that must move out of `/tmp` into the repository.
   - **The coordinator is its only writer until the close.** Agents send their items to the coordinator, who logs them the same
     turn. Agent ids and anything the competitors must not read (held items) stay out of it.
   - **The close (step 9) is worked from it.** The close planner ticks each item "done" or "declined, with the reason", reads
     every number from the item's source rather than from the inventory, and adds anything it finds missing.
   - **Why:** at FS-73's close the material was spread across a pre-compaction handoff, the coordinator's scratch notes and ten
     records. It survived only because an inventory was written at the end, from memory. Written as it happens, a compaction or a
     crash costs nothing. `plans/FS73-close-inventory.md` is the template.

6. **Modeling passes** — reforge the subplan through the de Bruijn modeling skills before implementing. Each skill is a
   fresh **Skill**-tool invocation scoped to the current milestone — *always* freshly invoked, *never* worked from memory,
   and *never* counted as loaded just because its text already sits in context. A skill carried forward by a compaction
   summary, or shown in a "for context only, do not re-execute" reminder, is *not* a fresh load: its stated arguments name an
   earlier milestone, and, framed as passive reference, it gets read rather than run as a live procedure, which measurably
   blunts the pass. Invoke fresh regardless of what is already in context. Which passes to run:
   - **`debruijn-domain-modeling`** — *drive to the beautiful model* — find the true shape of the types and the statements
     — **always**.
   - **`debruijn-obligation-modeling`** — *drive to the statement from which the proof derives* — decompose the proofs;
     design the inductions, the recursion, and the termination measures — if the milestone proves anything nontrivial (an
     induction, a recursive definition, a termination obligation, any claim over all cases).
   - **`debruijn-experience-modeling`** — *drive until the tool disappears* — design the surface others consume — if the
     milestone ever crosses a consumer boundary: a lemma API, a simp set, notation, error or tactic output ("Try this:"),
     docstrings, config, or a macro/elab diagnostic.
   Order by where the milestone's center of gravity sits: run **experience first** when the consumer surface *is the
   purpose* of the milestone (experience → domain → obligation), and **last** otherwise (domain → obligation → experience).
   Apply each pass to the subplan and **commit** its changes before moving to the next.

7. **Implement** the milestone against its subplan — burn the skeleton's `sorry`s down via the loop: select one obligation
   (the goal state is the machine's own prioritization), **query** the environment before inhabiting, then close it or split
   it into finitely many strictly-smaller, named `have`/lemma children. Replacing one `sorry` with smaller ones is the only
   legal move. **Every phase record carries a heading "Theorems this phase proved"** (Kooshi, 2026-09-22) — each theorem
   stated in one line with its grade and where its proof lives, hand, derived and tools-grade alike; the close reads that
   heading, never the prose, when it fills the derivation file.

8. **Quality gate** — the full gate from DEBRUIJN's `<the_loop>` / `<commands>`, plus **`./scripts/vacuity.sh` green** (no
   new theorem quantifying over a provably empty domain, and no new carrier without a proved inhabitant — `CLAUDE.md` § The
   gate has the rationale and the baseline rule): the build green · zero `sorry` (`grep -rn --include="*.lean" "sorry"`) ·
   `#print axioms` clean on the public surface · linters silent (`lake lint`) · spec examples passing.

9. **Close**, worked item by item from the close inventory (step 5), which the close planner ticks. One closing commit also
   **updates `CLAUDE.md` § Frontier and `LEDGER.md`** (the state-of-the-art summary, the novel-results ledger's new row, the ranked
   paths forward); a milestone whose close does not update the Frontier is not closed (rule set 2026-08-04). In the same close:
   - **Re-rank the frontier set** (`plans/FRONTIER-STUBS.md`; Kooshi, 2026-09-06): add every candidate the milestone surfaced
     as a stub file, re-rank the table with each row's bearing on χ ≥ 6 stated honestly, demote with a banner, never delete;
     § Paths forward mirrors the top of the table. Both files hold current state only: rewrite the affected text in place —
     no dated amendments, correction trails or superseded rankings — and leave the history to git and the milestone's plan.
   - **Re-read §G against what happened, and propagate forward** (step 3.1): which extractions paid, which entry should have
     borne and was not used — each miss a new instance under 3.1, and the entry that was missed re-written in the form G67
     asks for — and, for every grokking minted at this close, the open
     stubs it bears on, their provisional-bearings lines updated in the same commit. For a derivation milestone, re-read §IQ
     too, and record whether the result came through the structural question or from elsewhere. That count is G72's killing test.
   - **Sweep §PA for recognitions that belong in the Grokkings** (2026-09-17). The conjecture sweep below catches claims
     the milestone *made*; this catches identifications it *found while checking whether it was first*. M63 phase H3's
     prior-art appendix derived, verified symbolically and correctly recorded that this project's whole rotation family is the
     Σ = n coincidence-rotation family of an imaginary quadratic order — the construction grammar of every witness we hold,
     in the vocabulary of a discipline with classification theorems — and then closed, leaving it in §PA.4 where nothing
     reads it; it surfaced five days later only because Kooshi asked whether any of this looked like Moiré patterns. **A
     prior-art appendix is written to answer "are we first?" and is filed under that question, so anything it learns about
     what the object IS gets filed there too and is lost.** Read §PA back asking only *what did this teach us about our own
     object?* and promote each answer to a grokking or a stub.
   - **Sweep the milestone's own plan for unpursued conjectures** (Kooshi, 2026-09-14): grep it for "conjecture" and "not
     claimed", and for each hit either mint a stub or record an explicit decline.
   - **Sweep the milestone's phases for theorems and file them** (Kooshi, 2026-09-22): every theorem the milestone stated and
     proved outside the kernel — hand, derived, tools — goes into `plans/FSnn-derivation.md` (statement, grade, the proof's
     address, what rests on it, and a kernel decision: kernel / stub / declined with the reason) and gets one line in
     `LEDGER.md` § B; the ledger row points at the derivation file. The intermediate theorems are the understanding's raw
     material and were being lost in the rows' compression (FS-70 had nine before anyone counted; FS-38 and FS-66 had filed
     theirs by name, unprompted, and nothing made the next milestone do the same). M56's modeling pass wrote "Conjecture, NOT
     claimed: 1/p ∈ Σ₀(F²) iff no conjugation-fixed prime of F(i) lies above p" inside a lemma paragraph on 2026-09-06, no
     stub was ever minted, and an outside advisor proved it eight days later — the stub rule fires on candidates a milestone
     *surfaces*, and a conjecture buried under a heading about something else is not surfaced.

10. **Report what landed** — in the house format of **§ "How to report to the user"**: the milestone's name and purpose,
    the shape that actually shipped, every decision implementation forced or overturned (in its four parts, with the
    confidence you now hold after seeing it run), and what to work on next. Anything the milestone left open goes in the
    report as a ranked item with its default, not as a sentence in a paragraph.

11. **Reframe and subplan the next milestone** (steps 3–4), and repeat.

Do not run ahead: finish and commit a milestone's quality gate before reframing the next.

> **Metaprogramming** (macros, elaborators, custom tactics, `Syntax`/`Expr`, `MetaM`/`TermElabM`/`TacticM`, notation,
> deriving handlers, delaborators, linters) is governed by the **`debruijn-meta`** companion skill — load it (freshly, under
> the same rule as step 6) for any milestone that writes code that writes code.

## How to report to the user

**Structure over prose, always.** Reports and decision requests are read by someone with decision fatigue; a paragraph that
buries a choice inside it costs more than one that never got written. This governs every response that **reports work** or
**asks the user something**. A direct question still gets a direct answer — do not table-ify "where did you put X".

Six properties, in order of how much they matter:

1. **Plain English, and assume zero prior context — for the entire project, not just this session.** The reader has never
   seen this repository, does not know what language it is written in, is not holding anything from the last message, and
   does not know what any milestone number refers to. Write for exactly that reader in every report, including mid-session
   ones where it feels redundant. Rules, all of them hard:
   - **No identifier is ever the noun.** Say "the check that every listed edge really is exactly one unit long", not
     `Geometry.edgeLength_eq_one`. A path, type, theorem, or function name may follow the plain-English name in parentheses
     as an address — it may never stand in for it.
   - **No shorthand and no back-references.** Never "the fix we discussed", "M03's second ask", "as noted above", "the same
     issue as before". Restate the thing in full, every time, however often.
   - **Expand on first use, every response.** Every milestone number, issue number, abbreviation, and piece of project
     vocabulary gets a one-clause gloss the first time it appears — "milestone M03, the bridge that turns 'this graph cannot
     be coloured with four colours' into a question a SAT solver can answer and a certificate the proof checker can
     re-verify".
   - **Describe it in the product's terms, not the implementation's** — what someone reading the finished theorem, or using
     the thing, would notice is different, before any word about how it was built.
   - **The test:** if a sentence only lands for someone with the repository open, the previous message in mind, or a
     working knowledge of Lean, it is not finished. Rewrite it.
2. **Every decision is stated explicitly, in four parts.** This binds *all* decisions — the ones you are handing to the
   user and the ones you settled yourself. A decision never appears as a bare statement of what will happen. The four parts,
   in order:
   - **The choice** — one line, in the plain English of property 1.
   - **At least one alternative** — one you actually weighed, named concretely, with what it would have bought you. "Do
     nothing" counts only when doing nothing was genuinely live.
   - **Why this one won** — measured against that named alternative specifically, not praise of the winner in the abstract.
   - **Confidence — high, medium, or low — and for anything below high, the one fact that would change it.** "Medium — if
     the coordinates ever need a fifth square root, this shape gets redone."

   If you cannot name an alternative, you did not make a decision, you took a default: say so in those words rather than
   dressing it up as one.
3. **State the default — "if you do nothing, X happens."** The single most useful line. It lets the user skip an item
   without it becoming a dropped thread, and it is what makes the difference between a list I can act on and a list I have to
   hold.
4. **Rank by urgency, and say which rank each item is.** *Must decide before work starts* / *decide when convenient* /
   *already settled, skip* / *know but do not decide*. Put the counts in the headings so the user knows the size of the ask
   before reading it.
5. **List what you already settled.** Explicitly, as its own section, so the user does not have to audit for what they
   might have missed. This section exists to be skipped — that is its whole job. Its entries are still decisions, so they
   still carry all four parts of property 2; a table with *choice · alternative · why · confidence* columns keeps each one to
   a row.
6. **Tables and short lists, not paragraphs.** One or two lines per item. Options in a table with a column for the case for
   each.

**Surface a decision only when it is genuinely theirs** — a real product or scope fork, not an implementation detail. If
you can settle it from the code, the standard, or a sensible default: settle it, put it in the *already settled* section as a
four-part row, and move on. Every item on the decision list spends attention that the real forks need.

**Recommend, always.** Every decision the user is asked to make carries your recommendation and your confidence in it. "Here
are three options" without a lean is the question handed back.
