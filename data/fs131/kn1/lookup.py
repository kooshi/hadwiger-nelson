#!/usr/bin/env python3
"""FS131-KN1 working tool. For each ledger row in a range, list the backticked names the row cites that
are audited records in the last gate's axiom receipt, with the receipt's section (CLEAN / IMPORTED /
PURCHASED), every axiom beyond the standard three, and every assumption the assumptions ledger says the
record TAKES. Names the row cites that look like Lean identifiers and match no audited record and no
declaration in Proofs/ are printed as NOT-FOUND (a ledger row citing a theorem the library does not hold).

usage: lookup.py <first-row> <last-row> [--names n1,n2,...]
Reads: LEDGER.md, data/fs124/l2/gate/receipt-axioms-final.log, scripts/assumptions-ledger.txt, Proofs/**.lean
Control: `lookup.py --self-test` plants a name absent from the library and a record on an import, and
checks the first reads NOT-FOUND and the second reads IMPORTED with its axiom.
"""
import re, sys, glob, os
STD = {'propext', 'Classical.choice', 'Quot.sound'}

def receipt(path='data/fs124/l2/gate/receipt-axioms-final.log'):
    out, sec = {}, None
    txt = open(path).read()
    pos = 0
    for m in re.finditer(r"^=== (\w[\w-]*) ===$|^'([^']+)' (depends on axioms: \[([^\]]*)\]|does not depend on any axioms)", txt, re.M):
        if m.group(1):
            sec = m.group(1); continue
        name = m.group(2)
        ax = [a.strip() for a in (m.group(4) or '').replace('\n', ' ').split(',') if a.strip()]
        out[name] = (sec, [a for a in ax if a not in STD], bool(m.group(4) is None))
    return out

def takes(path='scripts/assumptions-ledger.txt'):
    t = {}
    for l in open(path):
        p = l.split()
        if len(p) == 3 and p[0] in ('TAKES', 'RESTS', 'MENTIONS'):
            t.setdefault(p[2], []).append((p[0], p[1].replace('HadwigerNelson.', '')))
    return t

def decls():
    d = {}
    for f in glob.glob('Proofs/**/*.lean', recursive=True):
        for i, l in enumerate(open(f, errors='replace'), 1):
            m = re.match(r'\s*(?:@\[[^\]]*\]\s*)?(?:private |protected |noncomputable |scoped )*(theorem|lemma|def|abbrev|structure|instance|axiom|inductive|class)\s+([^\s:({\[]+)', l)
            if m:
                d.setdefault(m.group(2).split('.')[-1], []).append((f.replace('Proofs/HadwigerNelson/', ''), i, m.group(1), m.group(2)))
    return d

def rows():
    r = {}
    for i, l in enumerate(open('LEDGER.md').read().splitlines(), 1):
        m = re.match(r'\| (\d+) \| ', l)
        if m and 43 <= i <= 213:
            r[int(m.group(1))] = l
    return r

def match(name, rec):
    """audited records whose full name ends with the cited name (on a component boundary)"""
    return [k for k in rec if k == name or k.endswith('.' + name)]

def report(names, rec, tk, dc, label):
    print(f'== {label}')
    seen = set()
    for n in names:
        if n in seen: continue
        seen.add(n)
        ms = match(n, rec)
        if ms:
            for k in ms:
                sec, extra, free = rec[k]
                ax = 'no axioms' if free else ('std3' if not extra else 'std3 + ' + ', '.join(e.replace('HadwigerNelson.', '') for e in extra))
                tt = '; '.join(f'{a} {b}' for a, b in tk.get(k, []))
                print(f'  {k.replace("HadwigerNelson.", "")}  [{sec}; {ax}]' + (f'  <<{tt}>>' if tt else ''))
        else:
            last = n.split('.')[-1]
            if last in dc:
                f, i, kind, full = dc[last][0]
                print(f'  {n}  [declared, not an audited record: {kind} at {f}:{i}' + (f' (+{len(dc[last])-1} more)' if len(dc[last]) > 1 else '') + ']')
            elif re.fullmatch(r'[A-Za-z][A-Za-z0-9]*(?:[_.][A-Za-z0-9₀-₉′]+)+', n) and not n.endswith(('.py', '.md', '.lean', '.json', '.txt', '.gp', '.log', '.csv')) and '_' in n:
                print(f'  {n}  [NOT-FOUND]')

if __name__ == '__main__':
    rec, tk, dc = receipt(), takes(), decls()
    if sys.argv[1] == '--self-test':
        import io, contextlib
        b = io.StringIO()
        with contextlib.redirect_stdout(b):
            report(['no_such_theorem_kn1', 'five_le_chromaticNumber_weil', 'chromaticNumber_seamPlane'], rec, tk, dc, 'self-test')
        s = b.getvalue(); print(s)
        ok = 'no_such_theorem_kn1  [NOT-FOUND]' in s and 'five_le_chromaticNumber_weil  [IMPORTED; std3 + StandingFive.kloosterman_bound]' in s and 'chromaticNumber_seamPlane  [CLEAN; std3]' in s
        print('SELF-TEST', 'PASS' if ok else 'FAIL'); sys.exit(0 if ok else 1)
    if sys.argv[1] == '--names':
        report(sys.argv[2].split(','), rec, tk, dc, 'names'); sys.exit(0)
    a, b = int(sys.argv[1]), int(sys.argv[2])
    R = rows()
    for n in range(a, b + 1):
        if n in R:
            names = re.findall(r'`([^`]+)`', R[n])
            names = [x.strip() for x in names if re.fullmatch(r'[A-Za-z][\w.′₀-₉]*', x.strip())]
            report(names, rec, tk, dc, f'row {n}')
