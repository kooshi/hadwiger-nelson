#!/usr/bin/env python3
"""CL3: extract "would have searched here" log units from plans/ and data/.
Usage: cl3_extract.py extract OUTDIR   |   cl3_extract.py selftest [--plant]
A unit = one bullet / numbered item / paragraph of a log section (continuation lines joined).
"""
import re, sys, os, subprocess, json, csv, tempfile
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
P = re.compile(r'would[\s\-]*have[\s\-]*searched', re.I)
HEAD = re.compile(r'^(#{1,6})\s')
BUL = re.compile(r'^(\s*)([-*+]|\d+[.)]|\([a-z0-9]+\))\s+')
LABEL = re.compile(r'^\s*(?:[-*+]\s+)?[\*_(\[]*[^:\n]{0,60}?[\*_)\]]*[:.]?')

def units_from(lines):
    """split a block of lines into units; drop units that are only a label."""
    out = []; cur = None
    for no, t in lines:
        if not t.strip():
            if cur: out.append(cur); cur = None
            continue
        if t.lstrip().startswith('|'):
            if cur: out.append(cur); cur = None
            cells = [c.strip() for c in t.strip().strip('|').split('|')]
            if all(re.fullmatch(r':?-{2,}:?', c) or not c for c in cells): continue
            if re.search(r'what (I|you|was)( did| done)? ?(instead)?', t, re.I) and re.search(r'instead', t, re.I) and re.search(r'move', t, re.I): continue
            out.append([no, '- ' + t.strip()]); continue
        if BUL.match(t) and not (cur and t.startswith(' ') and not BUL.match(t)):
            if cur: out.append(cur)
            cur = [no, t.rstrip()]
        else:
            if cur: cur[1] += ' ' + t.strip()
            else: cur = [no, t.rstrip()]
    if cur: out.append(cur)
    res = []
    for no, t in out:
        body = BUL.sub('', t, 1).strip()
        core = re.sub(r'[\*_`:\s.()\-]', '', body)
        if P.search(body) and len(re.sub(P, '', body)) < 40 and body.rstrip('*_ ').endswith((':', ':**', '**')) and len(body) < 90:
            continue  # bare label
        if not core: continue
        res.append((no, t))
    return res

def extract_text(text):
    L = text.split('\n')
    fence = False; marks = []
    inf = []
    for i, t in enumerate(L):
        if t.strip().startswith('```'): fence = not fence
        inf.append(fence)
    sections = []   # (kind, startline, [(no, text)])
    covered = set()
    i = 0
    while i < len(L):
        t = L[i]
        if inf[i]: i += 1; continue
        m = HEAD.match(t)
        if m and P.search(t):
            lvl = len(m.group(1)); j = i + 1; blk = []
            while j < len(L):
                m2 = HEAD.match(L[j])
                if m2 and not inf[j] and len(m2.group(1)) <= lvl: break
                blk.append((j + 1, L[j])); j += 1
            sections.append(('H', i + 1, t, units_from(blk)))
            covered.update(range(i, j)); i = j; continue
        if not m and P.search(t) and not t.lstrip().startswith('|'):
            # label form: phrase occurs in the label before the first colon (or at line start)
            mb = re.search(r'[\*_]{1,2}[^*_]*?would[\s\-]*have[\s\-]*searched[^*_]*[\*_]{1,2}[:.]?', t, re.I)
            pre = t.split(':')[0] if ':' in t else t
            if (mb or (P.search(pre) and len(pre) < 90 and re.sub(r'^[\s\-*+_(\["“]*(\d+(\.\d+)*[.)]?\s+)?(the |my |a |our )?', '', t, flags=re.I).lower().startswith('would'))) and i not in covered:
                if mb: rest = t[mb.end():]
                else: rest = t.split(':', 1)[1] if ':' in t else ''
                rest = re.sub(r'^[\*_\s]+', '', rest)
                blk = []
                if rest.strip(): blk.append((i + 1, '- ' + rest))
                j = i + 1
                if rest.strip():
                    while j < len(L) and L[j].strip() and not HEAD.match(L[j]) and not P.search(L[j]):
                        blk.append((j + 1, L[j])); j += 1
                else:
                    while j < len(L) and not HEAD.match(L[j]) and not (L[j].strip() and not L[j].startswith((' ', '\t', '-', '*')) and not BUL.match(L[j])):
                        blk.append((j + 1, L[j])); j += 1
                sections.append(('L', i + 1, t, units_from(blk)))
                covered.update(range(i, j)); i = j; continue
        i += 1
    INL = re.compile(r'(?:^|[.)"]\s+)[\*_]*would[\s\-]*have[\s\-]*searched(?:[\s\-]*here)?(?:[\s\-]*log)?[\*_]*[:.]\s*(.*)', re.I)
    other = []
    for i in range(len(L)):
        if P.search(L[i]) and i not in covered and not inf[i]:
            m = INL.search(L[i])
            if m and not L[i].lstrip().startswith('|') and m.group(1).strip():
                tx = m.group(1).strip()
                if not tx.endswith(('.', ')')) and i + 1 < len(L) and L[i + 1].strip(): tx += ' ' + L[i + 1].strip()
                sections.append(('I', i + 1, L[i], [(i + 1, '- ' + tx)]))
            else:
                other.append((i + 1, L[i]))
    return sections, other

def selftest(plant):
    doc = ("# T\n\n## Would-have-searched-here log\n\n- Stage 1: none.\n- Stage 2: (a) a\n  cont b.\n"
           "- Stage 3: c.\n\n## Next\n\n**Would have searched here (stage 4):** d\ncont\n\ntext\n\n- **Would have searched here:**\n  6. x\n  7. y\n")
    if plant: doc = doc.replace('- Stage 3: c.\n', '')
    secs, other = extract_text(doc)
    n = sum(len(s[3]) for s in secs)
    print('units found', n, 'expected 6'); 
    if n != 6: print('SELFTEST FAIL'); return 1
    print('SELFTEST PASS'); return 0

def git_date(path):
    r = subprocess.run(['git', '-C', ROOT, 'log', '--diff-filter=A', '--format=%ad', '--date=short', '--', path], capture_output=True, text=True)
    ds = [x for x in r.stdout.split() if x]
    return ds[-1] if ds else ''

def main(out):
    files = [l.strip() for l in subprocess.run(
        "grep -rIli 'would.have.searched' plans data", shell=True, cwd=ROOT, capture_output=True, text=True).stdout.split('\n') if l.strip()]
    rows = []; others = []; nosec = []
    for f in sorted(files):
        if '/briefs/' in f or not f.endswith(('.md', '.txt', '.draft')):
            nosec.append((f, 'excluded: brief or non-md')); continue
        text = open(os.path.join(ROOT, f), errors='replace').read()
        secs, other = extract_text(text)
        gd = git_date(f)
        hd = ''
        m = re.search(r'20\d\d-\d\d-\d\d', '\n'.join(text.split('\n')[:15]))
        if m: hd = m.group(0)
        if not secs: nosec.append((f, 'no section')) 
        for kind, ln, head, us in secs:
            for no, t in us:
                rows.append([f, no, kind, gd, hd, head.strip()[:80], t.strip()])
        for no, t in other:
            others.append([f, no, gd, hd, t.strip()])
    MANUAL = [('plans/CRUNCH-2026-09-26-x2x3-INDEX.md', 244, 'Would-have-searched-here log for the whole job: empty.'),
              ('plans/FS111-M3-finiteness.md', 376, '(would-have-searched: a fall colouring of HC_K\'s complement by `k − 1` classes).')]
    for f, ln, tx in MANUAL:
        line = open(os.path.join(ROOT, f)).read().split('\n')[ln - 1]
        assert tx.split(':')[0][:20].lower() in line.lower() or tx[:20] in line, (f, ln)
        rows.append([f, ln, 'M', git_date(f), '', 'manual', '- ' + tx])
    os.makedirs(out, exist_ok=True)
    with open(os.path.join(out, 'raw_units.tsv'), 'w') as fh:
        w = csv.writer(fh, delimiter='\t', lineterminator='\n')
        w.writerow(['file', 'line', 'kind', 'first_commit', 'header_date', 'section_head', 'text'])
        for r in rows: w.writerow([x.replace('\t', ' ').replace('\n', ' ') for x in map(str, r)])
    with open(os.path.join(out, 'other_mentions.tsv'), 'w') as fh:
        w = csv.writer(fh, delimiter='\t', lineterminator='\n')
        w.writerow(['file', 'line', 'first_commit', 'header_date', 'text'])
        for r in others: w.writerow([x.replace('\t', ' ').replace('\n', ' ') for x in map(str, r)])
    with open(os.path.join(out, 'nosection.txt'), 'w') as fh:
        for f, why in nosec: fh.write(f + '\t' + why + '\n')
    print(len(files), 'files;', len(rows), 'units;', len(others), 'other mentions;', len(nosec), 'files without unit/excluded')

if __name__ == '__main__':
    if sys.argv[1] == 'selftest': sys.exit(selftest('--plant' in sys.argv))
    main(sys.argv[2])
