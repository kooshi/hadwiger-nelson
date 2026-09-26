#!/usr/bin/env python3
"""F1 helper: for a commit C, list the sentences of C^:CLAUDE.md that C removed, scored by how much of each
survives (5-word shingles) in (a) today's CLAUDE.md, (b) today's CLAUDE.md + LEDGER.md + plans/GROKKING-INSTANCES.md,
(c) (b) + every plans/*.md + data/**/*record*.md.  Read-only; prints candidates with low (a)."""
import subprocess, re, sys, glob, os, pickle
ROOT = '/home/kooshi/source/lean-dir'
os.chdir(ROOT)
def show(ref, path='CLAUDE.md'):
    r = subprocess.run(['git', 'show', f'{ref}:{path}'], capture_output=True)
    return r.stdout.decode('utf-8', 'replace') if r.returncode == 0 else ''
def norm_words(s):
    s = s.lower()
    s = re.sub(r'[*`_>\[\]()|]', ' ', s)
    return re.findall(r"[\w'’\-−≤≥⟹⟺∈∉/.,:;]+", s)
def clean(w): return w.strip('.,:;')
def shingles(ws, n=5):
    ws = [clean(w) for w in ws if clean(w)]
    return {' '.join(ws[i:i+n]) for i in range(max(0, len(ws)-n+1))} if len(ws) >= n else ({' '.join(ws)} if ws else set())
def blocks(text):
    """join hard-wrapped lines into blocks; yield (label, block)"""
    sec = ''; cur = []; lab = ''
    out = []
    def flush():
        if cur: out.append((lab, ' '.join(cur)))
    for line in text.split('\n'):
        st = line.strip()
        if not st:
            flush(); cur = []; continue
        if re.match(r'(#|\* |- |\| |\d+\. |> |```)', st):
            flush(); cur = []
            if st.startswith('#'): sec = st.lstrip('#').strip()[:40]
            m = re.match(r'\* \*\*(G\d+)', st)
            lab = (m.group(1) if m else sec)
            if st.startswith('#'): lab = sec
        cur.append(st)
    flush()
    return out
def sentences(text, labels=False):
    out = []
    for lab, para in blocks(text):
        parts = re.split(r'(?<=[.!?])\s+(?=[A-Z*(“"])|(?<=\.\*\*)\s+|(?<=\.\*)\s+|;\s+(?=\*\*)', para)
        for q in parts:
            q = q.strip()
            if len(q) > 25: out.append((lab, q) if labels else q)
    return out
CACHE = 'data/consolidation-2026-09-26/f1/corpus.pkl'
def corpus():
    if os.path.exists(CACHE): return pickle.load(open(CACHE, 'rb'))
    cm = open('CLAUDE.md').read()
    a = set().union(*[shingles(norm_words(p)) for _, p in blocks(cm)])
    b = set(a)
    for f in ['LEDGER.md', 'plans/GROKKING-INSTANCES.md']:
        for _, p in blocks(open(f).read()): b |= shingles(norm_words(p))
    c = set(b)
    files = glob.glob('plans/*.md') + glob.glob('data/**/*record*.md', recursive=True) + glob.glob('data/**/*.md', recursive=True)
    for f in set(files):
        try: t = open(f, errors='replace').read()
        except Exception: continue
        for _, p in blocks(t): c |= shingles(norm_words(p))
    pickle.dump((a, b, c), open(CACHE, 'wb'))
    return a, b, c
def main():
    c = sys.argv[1]; thr = float(sys.argv[2]) if len(sys.argv) > 2 else 0.5
    base = sys.argv[3] if len(sys.argv) > 3 else c + '^'
    old, new = show(base), show(c)
    newset = set(sentences(new)); newsh = set().union(*[shingles(norm_words(p)) for _, p in blocks(new)] or [set()])
    A, B, C = corpus()
    n = 0; tot = 0
    for lab, s in sentences(old, labels=True):
        if s in newset: continue
        sh = shingles(norm_words(s))
        if not sh: continue
        inC = len(sh & newsh) / len(sh)
        if inC >= 0.6: continue  # mostly survived this commit: not its removal
        sa, sb, sc = (len(sh & X) / len(sh) for X in (A, B, C))
        if sa < thr:
            n += 1; tot += len(s.encode())
            print(f'--- [{lab}] a={sa:.2f} b={sb:.2f} c={sc:.2f} inCommit={inC:.2f} ({len(s.encode())} B)\n{s}')
    print(f'=== {n} candidate sentences, {tot} bytes', file=sys.stderr)
main()
