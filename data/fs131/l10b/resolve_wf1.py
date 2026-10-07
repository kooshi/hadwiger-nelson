#!/usr/bin/env python3
"""FS131-L10B: the merge of `fs131-wf1` (Falconer's lemma proved) into the line that declares Weil's bound — the two
conflict hunks resolved to the JOINED state, which is neither side's (the brief's step 2 (ii)), and the two sentences
that merged by themselves and are false of the joined tree rewritten. Every edit is an exact replacement that must
match once. Run in the worktree with the merge in progress, before `git add`.

  scripts/Axioms.lean   hunk: Falconer's `declareImport` and its four IMPORTED records go (theirs deleted them; they are
                        under CLEAN, where theirs entered them); Weil's `declareImport` and its eight records stay (ours).
                        prose: theirs' "The library declares no import at present … so this section is empty" becomes
                        the joined state: one import, Weil's; Falconer's a theorem.
  ARCHITECTURE.md       hunk: Falconer's row goes, Weil's row stays; theirs' "None at present: the library declares no
                        `axiom`…" becomes a line of current state that says the first import is now a theorem.
"""
import re, sys

def once(text, old, new, what):
    n = text.count(old)
    if n != 1:
        sys.exit(f"REFUSED: {what}: matched {n} times, not once")
    return text.replace(old, new)

def hunk(text, what):
    m = re.search(r'<<<<<<< HEAD\n(.*?)\|\|\|\|\|\|\| [0-9a-f]+\n(.*?)=======\n(.*?)>>>>>>> [0-9a-f]+\n', text, re.S)
    if not m or len(re.findall(r'^<<<<<<< ', text, re.M)) != 1:
        sys.exit(f"REFUSED: {what}: not exactly one diff3 hunk")
    return m

# --- scripts/Axioms.lean
p = 'scripts/Axioms.lean'
t = open(p, encoding='utf-8').read()
m = hunk(t, p)
ours, base, theirs = m.group(1), m.group(2), m.group(3)
if theirs.strip() != '':
    sys.exit("REFUSED: scripts/Axioms.lean: theirs' side of the hunk is not empty")
if not ours.startswith(base):
    sys.exit("REFUSED: scripts/Axioms.lean: ours is not the base followed by additions")
t = t[:m.start()] + ours[len(base):] + t[m.end():]
t = once(t,
 "not (`undeclared-library-axiom`, from `libraryAxioms`, the file's last command). The library\n"
 "declares no import at present — its first, wave 2's `falconer_lemma2_nonempty`, is a theorem since FS131-IF1 — so\n"
 "this section is empty.\n",
 "not (`undeclared-library-axiom`, from `libraryAxioms`, the file's last command). The library\n"
 "declares one import at present, wave 10's `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207, FS131-K10c), with\n"
 "eight records below; its first, wave 2's `falconer_lemma2_nonempty`, is a theorem since FS131-IF1 (FS131-L10B's join).\n",
 "the IMPORTED banner's sentence of current state")
open(p, 'w', encoding='utf-8').write(t)

# --- ARCHITECTURE.md
p = 'ARCHITECTURE.md'
t = open(p, encoding='utf-8').read()
m = hunk(t, p)
ours, base, theirs = m.group(1), m.group(2), m.group(3)
if not ours.startswith(base) or base.count('\n') != 1 or '`Plane.falconer_lemma2_nonempty`' not in base:
    sys.exit("REFUSED: ARCHITECTURE.md: ours is not Falconer's row followed by additions")
weil = ours[len(base):]
if weil.count('\n') != 1 or not weil.startswith('| `StandingFive.kloosterman_bound`'):
    sys.exit("REFUSED: ARCHITECTURE.md: ours' addition is not Weil's one row")
none_line = ("\nNone at present: the library declares no `axiom`. Its first import, `[Falconer1981]` Lemma 2 (i) (FS131-K2c), "
             "is a theorem since FS131-IF1 — `falconer_lemma2_nonempty`, proved in `Plane/MetricalBoundary`.\n")
if theirs != none_line:
    sys.exit("REFUSED: ARCHITECTURE.md: theirs' side is not the one line expected")
joined_line = ("\nOne at present. The library's first import, `[Falconer1981]` Lemma 2 (i) (FS131-K2c), is a theorem since FS131-IF1 — "
               "`falconer_lemma2_nonempty`, proved in `Plane/MetricalBoundary` — and is no longer in this table.\n")
t = t[:m.start()] + weil + joined_line + t[m.end():]
open(p, 'w', encoding='utf-8').write(t)
print("resolved: scripts/Axioms.lean (1 hunk, 1 sentence), ARCHITECTURE.md (1 hunk)")
