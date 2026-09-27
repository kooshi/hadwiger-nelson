"""Reading aid for job FS112-PA (not an exact check): split the held Polymath16 text
(~/source/library/notes/polymath16-threads-1-18-text.txt, one line per thread) into numbered
comments "[TT.n] author | date". Usage: python3 split_threads.py OUTDIR 06 07 08 09 16
The locators in extracts.md are "[TT.n]" from this split plus a unique verbatim phrase; the phrase
is the authoritative locator (grep it in the held file)."""
import os, re, sys, textwrap
SRC = os.path.expanduser('~/source/library/notes/polymath16-threads-1-18-text.txt')
out_dir, threads = sys.argv[1], sys.argv[2:]
text, cur = {}, None
for line in open(SRC):
    m = re.match(r'^########## pm/(\d+)\.txt', line)
    if m: cur = m.group(1); text[cur] = ''; continue
    if cur: text[cur] += line
pat = re.compile(r'(?:Reply |Comments |^)?([A-Z][\w.\- ]{0,40}?|"?\w[\w.\-]{0,30}"?) says: ((?:January|February|March|April|May|June|July|August|September|October|November|December) \d+, 20\d\d at \d+:\d+ [ap]m) ')
for t in threads:
    s = text[t]; ms = list(pat.finditer(s))
    with open(os.path.join(out_dir, f'c{t}.txt'), 'w') as out:
        out.write(f'=== thread {t}: {len(ms)} comments\n[OP] ' + textwrap.fill(s[:ms[0].start()], 160) + '\n\n')
        for i, m in enumerate(ms):
            end = ms[i+1].start() if i+1 < len(ms) else len(s)
            body = re.sub(r'\s*Reply\s*$', '', s[m.end():end])
            a = re.split(r'Reply |[.?!] ', m.group(1).strip())[-1].strip()
            out.write(f'[{t}.{i+1}] {a} | {m.group(2)}\n' + textwrap.fill(body, 160) + '\n\n')
    print(t, len(ms))
