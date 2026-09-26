#!/usr/bin/env python3
"""J25 stage 5: the queue's banner, §2's final statuses, J48's and J49's rows, and §8 (from j25/section8.md).
Every anchor asserted at its expected count before anything is written.  Usage: apply_queue.py [--plant]"""
import sys, pathlib
ROOT = pathlib.Path('/home/kooshi/source/lean-dir')
Q = 'plans/CRUNCH-2026-09-25-queue.md'
S8 = (ROOT / 'data/crunch-2026-09-25/j25/section8.md').read_text(encoding='utf-8')
E = []
def rep(old, new, n=1): E.append((old, new, n))
rep("# The crunch queue — 16 hours at 4–5 agents (planned 2026-09-25)\n",
    "# The crunch queue — 16 hours at 4–5 agents (planned 2026-09-25)\n\n"
    "> **CLOSED 2026-09-26** by front-page job J25: every §2 status is final, §5 is scored and §8 carries the close — the jobs run, the\n"
    "> milestones, and what the crunch hands to 2026-10-01 (§8.4).\n")
rep("| every unfolded report folded | nothing | recurring | ready |",
    "| every unfolded report folded | nothing | recurring | DONE (last fold through J47; J48's and J49's front-page items applied by J25) |")
rep("| ≥ 15,000 bytes freed with the audit green, or 350k (commit what passed) | — | P3 | ready |",
    "| ≥ 15,000 bytes freed with the audit green, or 350k (commit what passed) | — | P3 | not run (Kooshi raised the ceiling to 325,000 until the crunch ends, 6460c11e) |")
rep("re-aimed at the band-1/6 exit lemma | P1 | DONE |",
    "re-aimed at the band-1/6 exit lemma | P1 | DONE (its report: stage 3b saved, stage 4 left to a successor at the owner's direction) |")
rep("| J24 or J25 | P2 | wait |",
    "| J24 or J25 | P2 | DONE (as J23a/J23a2, J23b, J23c; J41 and J42 for row 88 and FS-67) |")
rep("| J24; the last J23 | 2 | 330 | the same | — | P2 | wait |",
    "| J24; the last J23 | 2 | 330 | the same | — | P2 | DONE |")
rep("a verdict per claim; divergence table | none | P3 | DONE |",
    "a verdict per claim; divergence table | none | P3 | DONE (report at stage 4; stage 5 committed after it, 9262898f) |")
rep("| post-ban (from 2026-10-01) | wait |",
    "| post-ban (from 2026-10-01) | post-ban — FS-84's S4 (§8.4) |")
rep("four stages saved: design, data+checker, build, publish | none | P2 | wait |",
    "four stages saved: design, data+checker, build, publish | none | P2 | READY — the bookend, launched after J25 |")
rep("| a verdict per claim saved | none | P2 | wait |\n",
    "| a verdict per claim saved | none | P2 | DONE — run as J48 |\n"
    "| J48 | Opus | blind check (FS-100 stage 1) | FS-100 | BC-1–BC-8, the FS100-BC row's list | brief data/crunch-2026-09-25/briefs/J48-FS100-stage1-blind-check.md | `plans/FS100-BC-verification.md` | J47 | — | — | a verdict per claim saved | none | P2 | DONE |\n"
    "| J49 | Opus | exact check (FS-100 stage 2, KT-1) | FS-100 | `[AmbrusEtAl2023]`'s H4 and H5 in ball arithmetic | brief data/crunch-2026-09-25/briefs/J49-KT1-ambrus-ball-arithmetic.md | `plans/FS100-KT1-ambrus-ball.md` | J47 | — | — | certified, inconclusive or violated, saved | none | P2 | DONE (certified) |\n")
rep("*Written by J25: the jobs run and their harness totals; §5 scored; the milestones closed; what the queue hands to 2026-10-01.*",
    S8.rstrip('\n'))

def main():
    edits = list(E)
    if '--plant' in sys.argv:
        edits.append(('an anchor no file holds (J25 plant)', 'x', 1))
    t = (ROOT / Q).read_text(encoding='utf-8')
    for old, new, n in edits:
        c = t.count(old)
        if c != n:
            print(f'FAIL: anchor found {c} times, expected {n}: {old[:90]!r}'); sys.exit(1)
        t = t.replace(old, new)
    (ROOT / Q).write_text(t, encoding='utf-8'); print('wrote', Q, len(t.encode()), 'bytes'); print('RESULT: PASS')
if __name__ == '__main__':
    main()
