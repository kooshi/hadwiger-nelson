#!/usr/bin/env python3
"""CL3: classify raw_units.tsv into lines.tsv.  Usage: cl3_classify.py DIR | cl3_classify.py selftest [--plant]"""
import re, sys, os, csv, subprocess, collections
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# files that are not job records (instructions, plans, stubs) or whole-file noise
EXCL_FILES = re.compile(r'^(plans/STANDING-RULES\.md|plans/STUB-.*|plans/SESSION-HANDOFF-.*|plans/CRUNCH-.*-queue\.md|data/fs116/fs116-z2/CLAUDE\.md\.draft|data/fs86/comp-debruijn/SUCCESSOR-PREAMBLE\.md)$')
# mixed files: keep only these lines
KEEP_ONLY = {'plans/M3-exotic-colourings.md': {581,582,583,584,585,653}, 'plans/FS89-rational-band-rigidity.md': {898,900,902,904,905},
             'plans/PROTOCOL-crunch.md': {481, 494, 500}}
# (file, line) exclusions: absorbed non-log text, found by reading
EXCL_LINES = {('plans/POROS-2026-09-25-fs86-next.md', n) for n in (280,281,282,284)} | {('plans/FS84-S1-derivation.md', 157), ('plans/FS67-tight-products.md', 635), ('plans/FS91-S1D-character.md', 273)} | {('data/fs112/fs112-c/reconciliation.md', 401)}
AGG = re.compile(r'^(Across the (eleven|seven)|Planner \d|\(from the records|\(one per job|"?- — J27|"?- — J06|The close: none \(reading and reconciliation\)|[A-Z0-9]{1,3}: .* → )')
PLACE = re.compile(r'^[\*\(\[]*[-\s]*\(?(one line per move|filled as they occur|one line per move made by derivation)', re.I)
O_STRONG = re.compile(r"\bGAP\b|\bleft (open|as the|it open)\b|\bis left open|\bstall|\bdeferred\b|post-ban|after 2026-10-01|waits for 2026-10-01|proposed for after|not established|\bstated as open\b|\brecorded it open\b|\bnamed as a (step|debt)\b|\bleft it as a registered hunch|named for a derivation|open step|\bleave[s]? (the question )?open|the claim left", re.I)
O_WEAK = re.compile(r"\bnot (run|built|done|attempted|reached|tried|computed|enumerated|derived|searched)\b|\bdid not\b|\bnot yet\b|\bstopped\b|\bnot found\b|\bleft (open|as)\b", re.I)
O_RE = re.compile(O_STRONG.pattern + "|" + O_WEAK.pattern, re.I)
R_RE = re.compile(r"\binstead\b|\bderiv|\bproved?\b|\bproof\b|\bexcluded\b|\bexact(ly)?\b|\bchecked\b|\bby hand\b|\breplaced\b|\blemma\b|\bobstruction\b|→|\bby formula\b|\bformula\b|\bfixed (set|list)\b|\bcomplete\b|\bdone by\b|\bbuilt by hand\b|\bread the committed\b|\bwithout\b|\bcounted\b|\bargument\b|\bbound\b|\btheorem\b|\bexhausted\b|\bwas written\b|\breduction\b|\bidentity\b|\breplaces\b|\bcount\b|\bused\b", re.I)
N_RE = re.compile(r"^\W*(?:stage\s*\d+[a-z]?\s*[:.)-]*\s*|\(stage\s*\d+\)\s*|[A-Za-z0-9 ]{0,24}stage\s*\d+[^:]{0,12}:\s*)*(none|nothing|no search|no move|empty|no step|no finite)", re.I)
NOT_N = re.compile(r"one would have been|would have (searched|run|made|scanned|enumerated|asked)", re.I)

ID_CELL = re.compile(r'^(?:[A-Z]{0,3}\d+[a-z]?|#|—|-|stage \d+|[A-Z]\d+(?:[-–]\w+)?|J\d+\w*(?:, ?\w+)*|\d+(?:[a-z]|[–-]\d+)?)$', re.I)
def norm(t):
    body = re.sub(r'^\s*[-*+]\s+', '', t).strip()
    body = re.sub(r'^\*\*would[\s-]*have[\s-]*searched[^*]*\*\*:?\s*', '', body, flags=re.I)
    if body.startswith('|'):
        cells = [c.strip() for c in body.strip('|').split('|')]
        while len(cells) > 1 and ID_CELL.match(cells[0]): cells = cells[1:]
        body = ' | '.join(c for c in cells if c)
    return body.strip()

def is_count_row(t):
    b = re.sub(r'^\s*[-*+]\s+', '', t).strip()
    if not b.startswith('|'): return False
    c = [x.strip() for x in b.strip('|').split('|')]
    return len(c) >= 3 and re.fullmatch(r'\d+(, \d+)*', c[1]) is not None

N2 = re.compile(r"\bstages?\s*\d+[^:.]{0,12}[:.]\s*(none|nothing)|no step of this job needs a search|\brun(s)? no search|no search moves|^empty\b|^no finite", re.I)
def classify(t):
    body = norm(t)
    if (N_RE.match(body) or N2.search(body)) and not NOT_N.search(body) and not O_STRONG.search(body):
        return 'N', False
    os_ = bool(O_STRONG.search(body)); ow = bool(O_WEAK.search(body)); r = bool(R_RE.search(body))
    if os_: return 'O', r
    if r: return 'R', False
    if ow: return 'O', False
    return 'U', False

def selftest(plant):
    cases = [('- none.', 'N'), ('- Stage 1: none (reading).', 'N'), ('- a scan; instead derived X.', 'R'),
             ('- a scan; did not; the stage derived Y.', 'R'), ('- a scan; instead derived Y, claim left GAP.', 'O'), ('- a finder; did not.', 'O'), ('- would have searched it; unclear words.', 'U'),
             ('- none; one would have been a float check, done by hand', 'R')]
    bad = 0
    for t, want in cases:
        got = classify(t)[0]
        if plant and want == 'N': got = 'R'   # planted fault: N lines misread
        if got != want: bad += 1; print('MISMATCH', t, want, got)
    print('SELFTEST FAIL' if bad else 'SELFTEST PASS'); return 1 if bad else 0

def blame_dates(path):
    r = subprocess.run(['git', '-C', ROOT, 'blame', '--line-porcelain', '--', path], capture_output=True, text=True)
    d = {}; line = None; cur = None
    import datetime
    for l in r.stdout.split('\n'):
        m = re.match(r'^[0-9a-f]{40} \d+ (\d+)', l)
        if m: line = int(m.group(1)); continue
        if l.startswith('committer-time '):
            d[line] = (datetime.datetime.fromtimestamp(int(l.split()[1])).strftime('%Y-%m-%d'), int(l.split()[1]))
    return d

NONBAN = re.compile(r'budget|time box|outside the brief|not held|not my job|fetching|fetch', re.I)
def jobinfo(f):
    b = os.path.basename(f)[:-3] if f.endswith('.md') else os.path.basename(f)
    d = f.split('/')
    m = re.match(r'(FS\d+|M\d+[A-Z]?|PA|BASE|POROS|CRUNCH|PROTOCOL|RERANK)', b)
    ms = m.group(1) if m else (d[1] if f.startswith('data/') else b)
    if f.startswith('data/'): ms = d[1] + '/' + os.path.basename(f)
    low = b.lower()
    if f.startswith('plans/POROS-') or 'poros' in low: kind = 'Poros'
    elif 'verification' in low or '-v-' in low or re.search(r'-(v\d|vb|nb\d?|yb\d?|cv|cd|ce|vm\d)-', low) or low.endswith(('-v','-blind')): kind = 'verifier'
    elif low.endswith('-proof') or 'derivation' in low: kind = 'proof'
    elif 'construction' in low: kind = 'construction'
    elif 'reading' in low or 'walk' in low or 'opening' in low or 'reframe' in low: kind = 'opening'
    else: kind = 'other'
    return b, ms, kind

def main(d):
    raw = list(csv.DictReader(open(os.path.join(d, 'raw_units.tsv')), delimiter='\t'))
    OV = {}
    for r_ in csv.DictReader(open(os.path.join(d, 'overrides.tsv')), delimiter='\t', quoting=csv.QUOTE_NONE):
        OV[(r_['file'], int(r_['line']))] = (r_['class'], r_['reason'])
    cache = {}; rows = []; dropped = collections.Counter(); agg = []
    for r in raw:
        f = r['file']; ln = int(r['line'])
        if EXCL_FILES.match(f): dropped['file:' + f] += 1; continue
        t = r['text']; body = re.sub(r'^\s*[-*+]\s+|^\s*"?', '', t)
        if PLACE.match(body.lstrip('-* ')) or re.match(r'^[-\s]*\(one line per', t): dropped['placeholder'] += 1; continue
        if f in KEEP_ONLY and ln not in KEEP_ONLY[f]: dropped['mixed-drop:' + f] += 1; continue
        if (f, ln) in EXCL_LINES: dropped['noise:' + f] += 1; continue
        if AGG.match(body) or is_count_row(t) or re.match(r'^\d+ lines across', body) or (f == 'plans/FS67-PA-close.md' and 150 <= ln <= 190): 
            if f == 'plans/FS67-PA-close.md' and ln != 193 and not AGG.match(body) and not is_count_row(t): dropped['noise:FS67-PA'] += 1; continue
            agg.append(r); continue
        if f not in cache: cache[f] = blame_dates(f)
        wd, we = cache[f].get(ln, ('', 0))
        cls, alsoR = classify(t)
        if (f, ln) in OV:
            c0 = OV[(f, ln)][0]
            if c0 == 'drop': dropped['override-drop'] += 1; continue
            cls = c0; alsoR = False
        job, ms, kind = jobinfo(f)
        rows.append([f, ln, job, r['first_commit'], wd, 'AFTER' if wd > '2026-10-01' else '', t, cls, 'also-R' if alsoR else '', ('nonban?' if cls == 'O' and NONBAN.search(t) else ''), we])
    with open(os.path.join(d, 'lines.tsv'), 'w') as fh:
        w = csv.writer(fh, delimiter='\t', lineterminator='\n')
        w.writerow(['file', 'line', 'job', 'job_date', 'written', 'after_1001', 'text', 'class', 'mixed', 'cause_flag', 'written_epoch'])
        for x in rows: w.writerow(x)
    with open(os.path.join(d, 'aggregates.tsv'), 'w') as fh:
        for r in agg: fh.write('\t'.join([r['file'], r['line'], r['text']]) + '\n')
    print(len(rows), 'lines;', len(agg), 'aggregates;', dict(dropped))
    print(collections.Counter(x[7] for x in rows))

if __name__ == '__main__':
    if sys.argv[1] == 'selftest': sys.exit(selftest('--plant' in sys.argv))
    main(sys.argv[1])
