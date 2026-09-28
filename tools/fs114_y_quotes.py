#!/usr/bin/env python3
"""FS114-Y stage 1 (standing rule 5): every quotation in my brief `data/fs114/briefs/Y114-construction.md` and in
`data/fs114/briefs/STANDING-RULES.md`, and every quotation my record uses, checked verbatim against the source it names.

Normalisation, applied to quotation and source alike: typographic quotes to straight ones, backticks, bold `**` and italic `*` removed,
blockquote markers at line starts removed, a line-break hyphen ("correspond-\\ning") joined, all whitespace runs to one space.
Exit 1 if any quotation is MISSING.

--self-test: the first quotation with one word altered must read MISSING while its faithful twin reads FOUND (the plant fires for its
own reason: the altered word, nothing else differs); and a faithful quotation checked against the wrong file must read MISSING.
Run: python3 tools/fs114_y_quotes.py [--self-test]
"""
import pathlib
import re
import sys

R = pathlib.Path('/home/kooshi/source/lean-dir')
HOME = pathlib.Path.home()
CLAIMS = 'data/fs114/claims.md'
GROUP = str(HOME / 'source/library/hadwiger-nelson-problem-group/threads/Z50mmulkXCQ.txt')
SIM = str(HOME / 'source/library/hadwiger-nelson-problem-group/threads/J_Tw1_hUxQI.txt')
SVTXT = str(pathlib.Path('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs114-y/sv.txt'))

Q = [
    # --- the brief: Kooshi's words ---
    ("My goal is to fully solve, and then verify in Lean, HN. Then we publish.", 'CLAUDE.md'),
    ("Let's see some ambition. I know we can do it.", 'CLAUDE.md'),
    ("search for a finite graph is out. It would be huge, not feasible.", 'CLAUDE.md'),
    # --- the brief: the question ---
    ("Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if "
     "trichromatic vertices of degree greater than 3 are allowed?", CLAIMS),
    ("Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if "
     "trichromatic vertices of degree greater than 3 are allowed?", SVTXT),
    # --- the standing rules ---
    ("From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you "
     "will surprise yourself.", 'CLAUDE.md'),
    ("to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time", 'CLAUDE.md'),
    ("A proven theorem about why its impossible is also valid. All novel knowledge is a success", 'CLAUDE.md'),
    ("It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress.",
     'plans/CONSOLIDATION-2026-09-27.md'),
    # --- the claim list's statements my record works (quoted from the claim list, then from their own sources) ---
    ("Every closed disc of radius 3 of every valid map holds a vertex of at least four colours or a vertex with a repeated colour.",
     'plans/FS112-derivation.md'),
    ("In a valid map, every close complementary cubic trichromatic partner of a cubic trichromatic vertex `u` is the fourth corner "
     "`w_i + w_j − u` of a unit rhombus on two of `u`'s leaving centres, so `u` has at most three such partners.", 'plans/FS112-derivation.md'),
    ("on the disk's pentagon skeleton, can the trivalent `B_k` (two unit-arc boundaries, centres `A_k`, `A_{k+1}`) be given a third unit-arc "
     "boundary whose completions are exactly their complementary partners (`B_0`'s current partners `Z^R_0`, `Z^L_1` are not completions)?",
     'plans/STUB-global-step.md'),
    ("And the disk's blue and orange routes to a fourth colour at `C_0`, never analysed (Y3 §4.4 (ii)).", 'plans/STUB-global-step.md'),
    ("Every valid map has a valid modification by W-MERGE and whole-arc bends, creating no unit arc, in which every unit arc is (Q) or (R2); "
     "the procedure terminates with no stubs.", 'plans/FS112-derivation.md'),
    ("The centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour.", 'plans/FS112-derivation.md'),
    ("A vertex with five colours has unit arcs centred at it of total length at least 180°; with six, its whole unit circle lies in `Γ`, "
     "every arc of kind both.", 'plans/FS112-derivation.md'),
    # --- the Google group (Sirgedas), as the claim list quotes them ---
    ("Degree 6 isn't possible with only 6 colors.", GROUP),
    ("1 quad \"emits\" 4 curved edges. This is 2n edges (80% of all edges).", GROUP),
    ("Then, a 6-colored 5-regular graph that covers the plane can be partitioned into red blocks", GROUP),
    ("Also this graph can't have pentagons.", GROUP),
    ("Similarly the metagraph can't have a quadrilateral. (Well, I'm pretty certain, but the proof below is a bit sloppy(?)).", GROUP),
    ("So, the red metagraph must have only triangles.", GROUP),
    ("Allowing a degree-4 vertex can prevent curved edges adjacent to that vertex, but I think it creates another quad/pentagon.", SIM),
    ("So, a valid tiling can't have an enclosed vertex with 3 neighbors.", SIM),
    ("so 200% of the edges are curved, so a 5-coloring is impossible.", SIM),
    ("Note that the emitted curved edges must all be unique (the curve lies on a unit radius circle centered on the emitting vertex).", GROUP),
    ("Cover rule: For a degree-5 6-colored graph, every vertex must \"cover\" each color. (e.g. each vertex must either be red or have a red "
     "neighbor). Proof: otherwise there's a duplicate color among those 6 vertices.", GROUP),
    ("The 5 rigid EDs have length 1, but then the \"pentagon\" will have at least one \"edge\" with length > 1.", GROUP),
]


def norm(s):
    s = re.sub(r'(?m)^\s*>\s?', '', s)
    s = re.sub(r'(\w)-\s*\n\s*(\w)', r'\1\2', s)
    for a, b in (('“', '"'), ('”', '"'), ('’', "'"), ('‘', "'"), ('`', ''), ('**', ''), ('*', '')):
        s = s.replace(a, b)
    return re.sub(r'\s+', ' ', s).strip()


_cache = {}


def text(path):
    p = pathlib.Path(path)
    if not p.is_absolute():
        p = R / p
    if p not in _cache:
        _cache[p] = norm(p.read_text(errors='replace'))
    return _cache[p]


def check(q, src):
    return norm(q) in text(src)


def main():
    if '--self-test' in sys.argv:
        q, src = Q[0]
        faithful = check(q, src)
        planted = check(q.replace('fully', 'truly'), src)
        wrongfile = check(q, 'data/fs114/briefs/STANDING-RULES.md')
        ok = faithful and not planted and not wrongfile
        print(f"self-test: faithful FOUND={faithful}; planted word MISSING={not planted}; wrong source MISSING={not wrongfile}")
        print('SELF-TEST', 'PASS' if ok else 'FAIL')
        sys.exit(0 if ok else 1)
    bad = 0
    for q, src in Q:
        ok = check(q, src)
        bad += not ok
        print(f"{'FOUND  ' if ok else 'MISSING'} {pathlib.Path(src).name:45s} {q[:90]}")
    print(f"{len(Q) - bad} of {len(Q)} FOUND")
    sys.exit(1 if bad else 0)


if __name__ == '__main__':
    main()
