#!/usr/bin/env python3
"""CL3: for each O line, list later derivation entries whose opening text names an identifier the line names.
Usage: cl3_candidates.py DIR  |  cl3_candidates.py selftest [--plant]. Candidates only, not findings."""
import re, sys, os, csv, glob, subprocess, datetime
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STOP = {'GAP','SAT','MILP','PARI','LRAT','TRUE','FALSE','NOTE','LEDGER','CLAUDE','PROTECTED','CDCL','DONE','PLANT','MUST','NONE'}
ID = re.compile(r"\b[A-Z][A-Za-z0-9]*(?:[-–][A-Za-z0-9′']+)+\b|\b[A-Z]{2,}[0-9]+\b|\b[A-Z]{3,}\b")

def terms(text):
    ts = set()
    for m in ID.finditer(text):
        w = m.group(0)
        if w in STOP or len(w) < 3: continue
        if re.fullmatch(r'(FS|J|M|X|W|S|Y|N)\d+[A-Za-z]*', w): continue   # bare job ids name no object
        ts.add(w)
    for m in re.finditer(r'`([^`]{4,30})`', text):
        w = m.group(1).strip()
        if re.fullmatch(r"[A-Za-z][A-Za-z0-9_′'\-]{3,}", w): ts.add(w)
    for m in re.finditer(r"\b[A-Z][A-Za-z0-9\-]*[0-9][A-Za-z0-9\-]*['’]s ([a-z]{4,})", text):
        ts.add('-' + m.group(1).upper())   # 'HEX3's star' -> id component -STAR
    return ts

def blame(path):
    r = subprocess.run(['git', '-C', ROOT, 'blame', '--line-porcelain', '--', path], capture_output=True, text=True)
    d = {}; line = None
    for l in r.stdout.split('\n'):
        m = re.match(r'^[0-9a-f]{40} \d+ (\d+)', l)
        if m: line = int(m.group(1)); continue
        if l.startswith('committer-time '):
            d[line] = int(l.split()[1])
    return d

def entries(path):
    L = open(os.path.join(ROOT, path), errors='replace').read().split('\n')
    starts = []
    for i, t in enumerate(L):
        m = re.match(r'^derivation:\s*(\S+)', t) or re.match(r'^\*\*([A-Za-z0-9][^\s*]*)\s+[—–-]\s', t)
        if m: starts.append((i, m.group(1)))
    out = []
    for k, (i, eid) in enumerate(starts):
        j = starts[k + 1][0] if k + 1 < len(starts) else len(L)
        txt = ' '.join(L[i:min(j, i + 14)])[:1400]
        out.append((i + 1, eid, txt))
    return out

def find(lineterms, date, ents_by_file, blames):
    res = []
    for f, ents in ents_by_file.items():
        for ln, eid, txt in ents:
            if blames[f].get(ln, 0) <= date: continue
            hit = [t for t in lineterms if t in txt]
            if hit: res.append((eid, f, hit[0]))
    return res

def selftest(plant):
    ents = {'plans/X-derivation.md': [(5, 'X-ID1', 'derivation: X-ID1 statement: the star HEX3 has radius 2')]}
    bl = {'plans/X-derivation.md': {5: 200}}
    line_terms = terms('stage 4: colourings about HEX3\'s star toward radius 2')
    if plant: line_terms = terms('stage 4: colourings about the star')
    r = find(line_terms, 100, ents, bl)
    ok = bool(r)
    print('found', r); print('SELFTEST PASS' if ok else 'SELFTEST FAIL'); return 0 if ok else 1

def main(d):
    rows = list(csv.DictReader(open(os.path.join(d, 'lines.tsv')), delimiter='\t'))
    files = sorted(glob.glob(os.path.join(ROOT, 'plans/*derivation*.md')))
    files = [os.path.relpath(f, ROOT) for f in files]
    ents = {f: entries(f) for f in files}; ents = {f: e for f, e in ents.items() if e}
    bl = {f: blame(f) for f in ents}
    n = 0
    for r in rows:
        if r['class'] != 'O': r['candidates'] = ''; continue
        ts = terms(r['text'])
        hits = find(ts, int(r['written_epoch'] or 0), ents, bl)
        hits = [h for h in hits if not h[1].endswith(os.path.basename(r['file']).replace('-proof','-derivation'))]
        seen = []
        for h in hits:
            x = '%s, %s' % (h[0], h[1])
            if x not in seen: seen.append(x)
        r['candidates'] = ('a later entry names it: ' + '; '.join(seen[:12]) + (' (+%d more)' % (len(seen) - 12) if len(seen) > 12 else '')) if seen else ''
        n += bool(seen)
    cols = ['file', 'line', 'job', 'job_date', 'written', 'after_1001', 'text', 'class', 'mixed', 'cause_flag', 'written_epoch', 'candidates']
    with open(os.path.join(d, 'lines.tsv'), 'w') as fh:
        w = csv.writer(fh, delimiter='\t', lineterminator='\n'); w.writerow(cols)
        for r in rows: w.writerow([r.get(c, '') for c in cols])
    print('O lines with at least one candidate:', n)

if __name__ == '__main__':
    if sys.argv[1] == 'selftest': sys.exit(selftest('--plant' in sys.argv))
    main(sys.argv[1])
