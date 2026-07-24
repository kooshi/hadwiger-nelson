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
   anything that assumes them. Refine scope here: if a milestone is bigger than it looked, push the
   excess to a later milestone — and whenever we carry scope forward, drop a subplan **stub** in
   `plans/` capturing the carry-forward notes → `plans/<Mxx-milestone>.md`.
4. **Commit** the subplan (skeleton included).
5. **Domain-modeling pass** — find the true shape of the types and statements — *always* run it, and
   *always* by **freshly invoking** the `debruijn-domain-modeling` skill (via the Skill tool), scoped
   to the current milestone, before applying it. A fresh invocation every time: never work from
   memory, and never count the skill as loaded just because its text already sits in context. A skill
   carried forward by a compaction summary, or shown in a "for context only, do not re-execute"
   reminder, is *not* a fresh load; its stated arguments name an earlier milestone, and, framed as
   passive reference, it gets read rather than run as a live procedure, which measurably blunts the
   pass. Invoke it fresh regardless of what is already in context, apply it to the subplan, then
   **commit** the changes it produces.
6. **Obligation-modeling pass** — decompose the proofs; design the inductions, the recursion, and the
   termination measures — *if the milestone proves anything nontrivial* (an induction, a recursive
   definition, a termination obligation, any claim over all cases). Freshly invoke the
   `debruijn-obligation-modeling` skill (via the Skill tool), scoped to the current milestone, under
   the same fresh-invocation rule as step 5 (never from memory, and never from text the skill already
   occupies in context). Apply it, then **commit** the changes it produces.
7. **Experience-modeling pass** — design the surface others consume — *if the milestone touches a
   surface a user or agent reads*: a lemma API, a simp set, notation, error or tactic output ("Try
   this:"), docstrings, config, or a macro/elab diagnostic. Freshly invoke the
   `debruijn-experience-modeling` skill (via the Skill tool), scoped to the current milestone, under
   the same fresh-invocation rule as step 5 (never from memory, and never from text the skill already
   occupies in context). Apply it, then **commit** the changes it produces.
<disabled>
8. **Pause for user review** of the new and improved subplan before implementing.
</disabled>
9. **Implement** the milestone against its subplan — burn the skeleton's `sorry`s down via the loop:
   select one obligation (the goal state is the machine's own prioritization), **query** the
   environment before inhabiting, then close it or split it into finitely many strictly-smaller,
   named `have`/lemma children. Replacing one `sorry` with smaller ones is the only legal move.
10. **Quality gate** — the full gate from DEBRUIJN's `<the_loop>` / `<commands>`: `lake build` green ·
    zero `sorry` (`grep -rn --include="*.lean" "sorry"`) · `#print axioms` clean on the public
    surface · linters silent (`lake lint`) · spec examples passing.
11. **Commit.**
12. **Subplan the next milestone** and repeat.

Do not run ahead: finish and commit a milestone's quality gate before subplanning the next.

> **Metaprogramming** (macros, elaborators, custom tactics, `Syntax`/`Expr`, `MetaM`/`TermElabM`/
> `TacticM`, notation, deriving handlers, delaborators, linters) is governed by the **`debruijn-meta`**
> companion skill — load it (freshly, under the same rule as step 5) for any milestone that writes
> code that writes code.
