#!/usr/bin/env python3
"""FS114-P stage 1 (standing rule 5): every quotation in the planner brief `data/fs114/briefs/P114-planner.md`, in
`data/fs114/briefs/STANDING-RULES.md`, and every quotation the plan and the claim list use, checked verbatim against its source.
Whitespace, typographic quotes and backticks normalised; bold markers `**` and italic `*` removed.  Exit 1 if any is MISSING.
--self-test: one word altered in the first quotation must turn it MISSING while its faithful twin is FOUND (a plant that fires for
its own reason: the altered word, nothing else differs)."""
import re, sys, pathlib
R = pathlib.Path('/home/kooshi/source/lean-dir')
STUB = 'plans/STUB-global-step.md'
NIGHT = 'plans/POROS-2026-09-27-night-aim.md'
INV = 'plans/FS112-close-inventory.md'
Q = [
 # --- the brief: Kooshi's words ---
 ("My goal is to fully solve, and then verify in Lean, HN. Then we publish.", 'CLAUDE.md'),
 ("When round 3 finishes, let's close this milestone, and point two milestones at the two gaps, so we can focus on them specifically. They seem to require more research and careful exploration, and may be more complicated than they appear.", INV),
 ("Even decompressed, this is a bit beyond me, […]. I'll defer to a Poros agent.", INV),
 # --- the brief: the question ---
 ("can a six-map with unit arcs have a vertex of four colours or a repeated colour within 3 of every point?", STUB),
 ("Choosing the form is the milestone's first decision.", STUB),
 ("Is the unit-arc NO local — an explicit radius past which no valid fragment survives around a four-colour vertex — or visible only to a count over the whole plane, as Euler's formula and discharging give?", NIGHT),
 ("an explicit radius R with a derived exclusion of every valid fragment on the disc of radius R about a four-colour vertex", NIGHT),
 ("that the plane cannot be 6-tlled", 'data/fs112/fs112-pa/extracts.md'),
 ("that the plane cannot be 6-tlled [sic] with a non-Siamese tiling", INV),
 ("search for a finite graph is out.", 'CLAUDE.md'),
 # --- the brief's claims about sources (the name ruling; the form's grade; the night advisor's section 6) ---
 ("FS-114's one name: \"the unit-arc question\"", INV),
 ("with \"the global step\" kept as the name of its central statement", INV),
 ("A local exclusion about **one** four-colour vertex would be the whole NO, with no ray step and no density", NIGHT),
 ("hunch: global — G17's top-rung pattern, and the strip forces any obstruction to read two dimensions", NIGHT),
 # --- the standing rules ---
 ("From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you will surprise yourself.", 'CLAUDE.md'),
 ("to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time", 'CLAUDE.md'),
 ("A proven theorem about why its impossible is also valid. All novel knowledge is a success", 'CLAUDE.md'),
 ("It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress.", 'plans/CONSOLIDATION-2026-09-27.md'),
]
def norm(s):
    s = s.replace('**', '').replace('“', '"').replace('”', '"').replace('’', "'").replace('‘', "'").replace('`', '').replace('*', '')
    return re.sub(r'\s+', ' ', s).strip()
_cache = {}
def text(src):
    if src not in _cache:
        _cache[src] = norm((R/src).read_text())
    return _cache[src]
def run(qs):
    bad = 0
    for q, src in qs:
        ok = norm(q) in text(src)
        print(('FOUND  ' if ok else 'MISSING'), src, '|', q[:100])
        bad += (not ok)
    return bad
if __name__ == '__main__':
    extra = []
    if len(sys.argv) > 2 and sys.argv[1] == '--file':      # further quotations, one per line: "<source>\t<quotation>"
        for line in (R/sys.argv[2]).read_text().splitlines():
            if line.strip() and not line.startswith('#'):
                src, q = line.split('\t', 1); extra.append((q, src))
    if '--self-test' in sys.argv:
        q, src = Q[3]
        planted = [(q.replace('within 3', 'within 2'), src), (q, src)]
        b = run(planted)
        ok = (b == 1)
        print('self-test', 'PASS' if ok else 'FAIL'); sys.exit(0 if ok else 1)
    b = run(Q + extra); print('quotations:', len(Q + extra), 'missing:', b); sys.exit(1 if b else 0)
