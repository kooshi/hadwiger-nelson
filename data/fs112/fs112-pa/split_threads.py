"""Reading aid for job FS112-PA (not an exact check): split the held Polymath16 text
(~/source/library/notes/polymath16-threads-1-18-text.txt, one line per thread) into numbered
comments "[TT.n] author | date". Usage: python3 split_threads.py OUTDIR 06 07 08 09 16
The locators in extracts.md are "[TT.n]" from this split plus a unique verbatim phrase; the phrase
is the authoritative locator (grep it in the held file). Importable: comments(thread) -> list of
(author, date, body) with whitespace collapsed."""
import os, re, sys, textwrap
SRC = os.path.expanduser('~/source/library/notes/polymath16-threads-1-18-text.txt')
PAT = re.compile(r'(?:Reply |Comments |^)?([A-Z][\w.\- ]{0,40}?|"?\w[\w.\-]{0,30}"?) says: ((?:January|February|March|April|May|June|July|August|September|October|November|December) \d+, 20\d\d at \d+:\d+ [ap]m) ')

def threads():
    text, cur = {}, None
    for line in open(SRC):
        m = re.match(r'^########## pm/(\d+)\.txt', line)
        if m: cur = m.group(1); text[cur] = ''; continue
        if cur: text[cur] += line
    return text

def comments(t, text=None):
    s = (text or threads())[t]; ms = list(PAT.finditer(s)); out = [('OP', '', ' '.join(s[:ms[0].start()].split()))]
    for i, m in enumerate(ms):
        end = ms[i+1].start() if i+1 < len(ms) else len(s)
        body = ' '.join(re.sub(r'\s*Reply\s*$', '', s[m.end():end]).split())
        a = re.split(r'Reply |[.?!] ', m.group(1).strip())[-1].strip()
        out.append((a, m.group(2), body))
    return out

if __name__ == '__main__':
    out_dir, ts = sys.argv[1], sys.argv[2:]
    text = threads()
    for t in ts:
        cs = comments(t, text)
        with open(os.path.join(out_dir, f'c{t}.txt'), 'w') as out:
            out.write(f'=== thread {t}: {len(cs)-1} comments\n[OP] ' + textwrap.fill(cs[0][2], 160) + '\n\n')
            for i, (a, d, b) in enumerate(cs[1:], 1):
                out.write(f'[{t}.{i}] {a} | {d}\n' + textwrap.fill(b, 160) + '\n\n')
        print(t, len(cs) - 1)
