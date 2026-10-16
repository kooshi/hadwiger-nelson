#!/usr/bin/env python3
"""fs131_kpa1_quotes -- checks every quotation of a brief against the file its source line names (FS131-KPA1, stage 1).

A quotation is a run of lines beginning '> ' closed by a line '> — source: <path>[ § <section>]'. The quoted text, with
its line breaks folded to single spaces, must occur in the named file with its line breaks folded the same way. Exit 0
when every quotation is found, 1 otherwise; each quotation's verdict is printed.

  python3 tools/fs131_kpa1_quotes.py BRIEF [--root DIR] [--plant]

--plant changes one character of the first quotation before the search and must make the check fail (exit 1): the
check's negative control.
"""
import argparse
import os
import sys


def fold(text):
    return ' '.join(part.strip() for part in text.splitlines())


def quotations(brief_text):
    out, cur = [], []
    for line in brief_text.splitlines():
        if line.startswith('> — source:'):
            out.append(('\n'.join(cur), line[len('> — source:'):].strip()))
            cur = []
        elif line.startswith('> '):
            cur.append(line[2:])
        elif line.strip() == '>':
            cur.append('')
        else:
            cur = []
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('brief')
    ap.add_argument('--root', default='.')
    ap.add_argument('--plant', action='store_true')
    a = ap.parse_args()
    qs = quotations(open(a.brief, encoding='utf-8').read())
    if not qs:
        print('ERROR: no quotation found in the brief')
        return 1
    bad = 0
    for i, (text, src) in enumerate(qs):
        path = src.split(' § ')[0].strip()
        q = fold(text)
        if a.plant and i == 0:
            q = q[:10] + ('X' if q[10] != 'X' else 'Y') + q[11:]
        full = os.path.join(a.root, path)
        if not os.path.exists(full):
            print(f'[{i}] MISSING SOURCE {path}')
            bad += 1
            continue
        hay = fold(open(full, encoding='utf-8').read())
        ok = q in hay
        print(f'[{i}] {"VERBATIM" if ok else "NOT FOUND"}  {len(q)} chars  source {src}')
        if not ok:
            bad += 1
    print(f'{len(qs)} quotations, {bad} not found')
    return 1 if bad else 0


if __name__ == '__main__':
    sys.exit(main())
