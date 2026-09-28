#!/usr/bin/env python3
"""FS114-NB stage 1 (standing rule 5): every quotation my brief, my instance file and my record rely on, checked verbatim
against its source.  Input: a TSV file, one quotation per line, "<source path>\t<quotation>" (a path relative to the repository
or absolute; '#' lines are comments).  Normalisation, applied to source and quotation alike: markdown bold `**`, italic `*`
and backticks removed; typographic quotes and apostrophes made plain; a hyphen at a line's end joined to the next line's word
(OCR "correspond-\\ning"); all whitespace runs made one space.  Prints FOUND / MISSING per line; exit 1 if any is MISSING.
--self-test: the first quotation with one word altered must turn MISSING while its faithful twin stays FOUND, so the plant
fires for its own reason (the altered word) and not for the scaffolding."""
import pathlib
import re
import sys

REPO = pathlib.Path('/home/kooshi/source/lean-dir')


def norm(s: str) -> str:
    s = re.sub(r'(\w)-\s*\n\s*(\w)', r'\1\2', s)
    for a, b in (('**', ''), ('`', ''), ('*', ''), ('“', '"'), ('”', '"'), ('’', "'"), ('‘', "'")):
        s = s.replace(a, b)
    return re.sub(r'\s+', ' ', s).strip()


_cache: dict = {}


def text(src: str) -> str:
    if src not in _cache:
        p = pathlib.Path(src) if src.startswith('/') else REPO / src
        _cache[src] = norm(p.read_text(errors='replace'))
    return _cache[src]


def load(tsv: str):
    out = []
    for line in (REPO / tsv).read_text().splitlines():
        if line.strip() and not line.startswith('#'):
            src, q = line.split('\t', 1)
            out.append((src, q))
    return out


def run(qs) -> int:
    bad = 0
    for src, q in qs:
        ok = norm(q) in text(src)
        print(('FOUND  ' if ok else 'MISSING'), src, '|', q[:110])
        bad += (not ok)
    return bad


if __name__ == '__main__':
    qs = load(sys.argv[1] if len(sys.argv) > 1 and not sys.argv[1].startswith('--') else 'data/fs114/fs114-nb/quotes.tsv')
    if '--self-test' in sys.argv:
        src, q = qs[0]
        words = q.split()
        i = len(words) // 2
        altered = ' '.join(words[:i] + [words[i] + 'X'] + words[i + 1:])
        faithful_found = norm(q) in text(src)
        altered_found = norm(altered) in text(src)
        print('self-test: faithful', 'FOUND' if faithful_found else 'MISSING', '| altered', 'FOUND' if altered_found else 'MISSING')
        sys.exit(0 if (faithful_found and not altered_found) else 1)
    n_bad = run(qs)
    print(f'{len(qs) - n_bad} of {len(qs)} FOUND')
    sys.exit(1 if n_bad else 0)
