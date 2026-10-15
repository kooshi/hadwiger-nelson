#!/usr/bin/env python3
"""FS131-LCH1: resolve the merge of main (bd3bd9541) into fs131-wlc, hunk by hunk, per the brief:
keep both sides, except where main deleted what the chain still lists (the transfer, a theorem on main since FS131-LP1)
and the OneAvoidingDensity row (main's version wins whole). Each decision is printed."""
import re, sys

def hunks(text):
    """Split into [('ctx', lines) | ('hunk', ours, theirs)]."""
    out, ours, theirs, mode = [], [], [], None
    for ln in text.split('\n'):
        if ln.startswith('<<<<<<< '):
            mode, ours, theirs = 'ours', [], []
        elif ln == '=======' and mode == 'ours':
            mode = 'theirs'
        elif ln.startswith('>>>>>>> ') and mode == 'theirs':
            out.append(('hunk', ours, theirs)); mode = None
        elif mode == 'ours': ours.append(ln)
        elif mode == 'theirs': theirs.append(ln)
        else: out.append(('ctx', [ln]))
    assert mode is None
    return out

def resolve(path, policy):
    parts = hunks(open(path, encoding='utf-8').read())
    res, k = [], 0
    for p in parts:
        if p[0] == 'ctx': res.extend(p[1]); continue
        k += 1
        lines, why = policy(k, p[1], p[2])
        print(f'{path} hunk {k}: ours {len(p[1])} lines, theirs {len(p[2])}, kept {len(lines)} — {why}')
        res.extend(lines)
    open(path, 'w', encoding='utf-8').write('\n'.join(res))
    assert '<<<<<<<' not in '\n'.join(res)

def both(k, o, t): return o + t, 'both sides, ours first'

def arch(k, o, t):
    if k == 1:
        assert o[0].startswith('| `Plane/OneAvoidingDensity`') and len(o) == 1
        return t, "main's (OneAvoidingDensity: main's version wins whole; the density bound's rows)"
    if k == 4:
        rows = [l for l in o if l.startswith('| `Rigidity.positive_entropy_rigidity`')]
        assert len(rows) == 1 and any(l.startswith('| `Outside.OAI158.proper_to_borel_weak`') for l in o)
        sent = [l for l in t if l.startswith('Two at present.')]
        assert len(sent) == 1
        s = sent[0].replace('Two at present. The third, `Outside.OAI158.proper_to_borel_weak`',
                            'Three at present. A fourth, `Outside.OAI158.proper_to_borel_weak`', 1)
        assert s != sent[0]
        return rows + [''] + [s], ("the chain's positive_entropy_rigidity row; main's sentence, its count three "
                                   "(the transfer's row dropped: a theorem on main since FS131-LP1)")
    return both(k, o, t)

def axioms(k, o, t):
    text = ('declares three imports at present: wave 10\'s `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207, FS131-K10c), with\n'
            'the records below; FS-132\'s `Outside.OAI158.no_proper_five_coloring` (`[OAIMath2026]` family 158, FS132-I1), with six\n'
            '(one of them FS-124\'s radius clause, `Plane/RadiusOutside`); and, on the five-colour chain\'s line, FS-131\'s\n'
            '`Rigidity.positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]` Thm 1.3, FS131-KN3; declared to the audit at the\n'
            'chain\'s join, FS131-IJN1). Its first, wave 2\'s `falconer_lemma2_nonempty`, is a theorem since FS131-IF1 (FS131-L10B\'s\n'
            'join), and FS-132\'s second, `Outside.OAI158.proper_to_borel_weak`, since the port of its proof (FS-131, FS131-IPD1): its\n'
            'twelve records are under CLEAN.')
    return text.split('\n'), "joined prose: main's two imports and the chain's third; the transfer a theorem (main)"

def ledger(k, o, t):
    keep = [l for l in o if not l.startswith('RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak ')]
    dropped = len(o) - len(keep)
    assert dropped == 12 and t == []
    return keep, f"the chain's RESTS rows on positive_entropy_rigidity; {dropped} RESTS rows on the transfer dropped (main's)"

resolve('Proofs.lean', both)
resolve('ARCHITECTURE.md', arch)
resolve('scripts/Axioms.lean', axioms)
resolve('scripts/assumptions-ledger.txt', ledger)
