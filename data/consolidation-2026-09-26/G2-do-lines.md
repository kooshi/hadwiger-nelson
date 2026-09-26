# Draft *Do* lines for G21, G30 and G46 — for Kooshi's approval; nothing here is applied

*Job G2, 2026-09-26. Kooshi's "yes" to: "Draft 'what to do / what would kill it' lines for three principles that lack them: searches
measure their own method, measurement versus derivation, recognise the classical theory first" (G21, G30, G46). Form: G67's —
`*Do: <trigger> … Killing test: …*`, the trigger first and never a bare verb. These three are method rules, so the second half follows
the shape the other method entries use (G49, G50, G51, G67, G72, G79): the observation that would show the rule to be ceremony or
insufficient. Every clause is built from the entry's own body; the phrases built on are quoted under each draft. `CLAUDE.md` is read
from disk at `65dc5c13`.*

## G21 — A negative measures its enumeration

**Draft.**

> *Do: when a search, sweep or census returns a zero — or a count, a speedup, an elimination — ask first whether the acceptance test is the exact
> condition or only a sufficient one, and put the answer and the enumeration's bounds (its period cap, radius or generator image) into the
> headline sentence; before believing a new instrument's zero, point it at a known positive at the scale of the question; check the
> written artifact, not the in-memory list behind it; and audit a result you like at the rate you audit one you do not. Killing test:
> a zero reported with its enumeration in the headline that readers still took for a fact about the objects (the rule is not enough), or
> a run of milestones in which no headline scope ever changed a decision (the rule is ceremony).*

**Built on:** "When a sweep refuses, the first question is not "what does this say about the objects" but "is my acceptance test the
exact condition, or a sufficient one?""; "a verdict — negative, positive count, or speedup — is a statement about its enumeration and
conditioning, and both belong in the headline sentence"; "Point every new instrument at a known positive before believing its zero";
"assert on the written artifact, never on the list that produced it"; "Audit the results you like at the same rate as the ones you do
not"; "a periodic search measures its period cap"; "a control at the scale of the question".

**Why this shape.** The body holds a dozen instances and five rules; the *Do* keeps the four that apply at the moment a result comes
back, in the order they are needed. The killing test replaces "Falsifier: none needed" with the two ways a method rule fails, as G51's
and G72's do.

**Alternative wording.** *Do: when a result comes back from any search, write into its headline what the search could and could not
see — its acceptance test (exact or only sufficient), its bounds, and the known positive it was pointed at — and read it as a fact
about that enumeration until a derivation widens it. Killing test: a headline written this way that still misled its readers.*

**If applied:** the *Do* goes at the entry's end, after the pointer to §G21 of `plans/GROKKING-INSTANCES.md`; the sentence "Falsifier:
none needed — this is a methodological invariant, and it fails only by being ignored." would then be redundant with the killing test —
keep it, or replace it (your call; the draft assumes replace).

## G30 — Measurement generates; derivation kills

**Draft.**

> *Do: when a measurement suggests a law — a pattern, a zero, a count that looks general — record it as a candidate, never a
> conclusion, and buy the conclusion separately: derive it, or register a replication on fresh objects before running it; before
> spending days of compute on it, write it for an outside reader in its native vocabulary, and if it resists derivation, find the
> discipline where its statement lives and seek the theorem in it; prefer a dial to a search for a positive, and ask a calibrated bed
> first; write every escape clause to the prediction's standard, and check that a grokking's quantifier matches the measurement before
> applying it. Killing test: the one above — a reading bought by neither a test nor a derivation that survives, or derivations dying
> as often as readings (the sort: `plans/GROKKING-INSTANCES.md` §G30).*

**Built on:** "A measurement buys a candidate pattern; a conclusion is bought by a derivation or a pre-registered replication on fresh
objects"; "*Rule: before spending days of compute on a conjecture, write it for an outside reader in its native mathematical
vocabulary*"; "When a wall resists derivation, name the discipline its statement lives in and look for the theorem there"; "Prefer
measurements that turn a DIAL … over searches that hunt for a POSITIVE"; "prefer CALIBRATED test beds"; "Write the escape clause to the
same standard as the prediction"; "A prediction applying a grokking whose quantifier does not match the measurement".

**Why this shape.** G30's body is long and its rules are spread across a paragraph, seven failure modes and a ladder; the trigger
"when a measurement suggests a law" is the moment all of them apply, so the *Do* gathers them there. The killing test points at the
falsifier the entry now carries (stage 3 of this job) instead of restating it, so that `--dupes` stays at its baseline.

**Alternative wording.** *Do: when a measurement suggests a law, write the law down as a candidate and name what would buy it — the
derivation to attempt, or the replication to register on fresh objects — before any further compute; and if neither comes, write it
for an outsider in its home discipline's words. Killing test: the one above.*

**If applied:** the *Do* goes at the entry's end, after the *Falsifier* sentence; applied with the alternative, the failure modes and
the ladder still carry the rest.

## G46 — Recognize the classical theory first

**Draft.**

> *Do: when a new object or question appears — at a milestone's opening, or with a new prime, ring or construction — name it in the
> words of the theory it already belongs to and let that theory say possible, impossible or where before any search runs; use that
> recognition sentence as the prior-art query (G49); read the implementation's data layout as well as the plan's words for it; rank a
> stub that reduces to an exact finite computation and a named theorem above one that hunts for an object, and hold a stub
> with no recognition as a reading room; read a failed search as news about the search's genre. Killing test: a frontier milestone
> whose object search delivers what no recognition predicted — then the ranking is wrong for that genre.*

**Built on:** "Name the object in the vocabulary of the theory it already belongs to (Cayley graphs → character sums; frameworks →
rigidity) and let that theory decide the question's shape before any search"; "The recognition sentence is the prior-art query (G49)";
"read the construction's own data layout, not only the plan's vocabulary for it"; "When a plan and an implementation describe the same
object, the implementation is the one that cannot round off"; "a finite exact computation plus a named theorem beats an object search;
a stub with no recognition yet is a reading room"; "read a search's failure as information about the search's genre, not about the
objects"; the falsifier, "*a frontier milestone whose object search delivers what no recognition predicted — then the corollary's ranking
is wrong for that genre.*"

**Why this shape.** G46 already carries a falsifier; the *Do* reuses it as the killing test, so the entry gains a trigger and an
imperative without a new claim. "possible, impossible or where" is the pre-cut text's own list (`plans/GROKKING-INSTANCES.md` §G46:
"let that theory decide the question's shape — possible, impossible, where — before any search runs").

**Alternative wording.** *Do: when a new object appears, write one sentence naming it in its home discipline's vocabulary before any
search, and let that sentence set the plan's shape and the prior-art query. Killing test: the falsifier above.*

**If applied:** the *Do* replaces the entry's *Falsifier for the rule* sentence (the killing test carries it); the pointer to §G46 stays.
With the alternative, the falsifier sentence stays and the *Do* follows it.

## Notes for the approver

- All three drafts would add bytes to `CLAUDE.md` (291,894 at `65dc5c13`): about +780, +850 and +760 for the full drafts (less the
  sentence each replaces, where it replaces one), about +300 each for the alternatives; the budget is 300,000.
- Checked: the three drafts appended to `CLAUDE.md` add exactly one repeated run of ten words to `--dupes` — G46's killing test, which
  is its falsifier sentence; applied as proposed (replacing that sentence) they add none. The drafts paraphrase the body wherever they
  would otherwise repeat ten words; the "Built on" quotes live here only.
