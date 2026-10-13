#!/usr/bin/env python3
"""FS131-KN1 working tool: quote derivation entries' header sentences verbatim by address.
usage: quote.py <file>:<id-prefix> ...   prints '<file>:<line>  <text up to the grade bracket or N chars>'"""
import sys, re
N = 620
for arg in sys.argv[1:]:
    f, pid = arg.rsplit(':', 1)
    hit = False
    for i, l in enumerate(open(f).read().splitlines(), 1):
        if l.startswith('**' + pid + ' ') or l.startswith('**' + pid + '.') or l.startswith('**' + pid + ' —'):
            body = l[2:]
            cut = body.find(' [hand')
            for g in (' [tools', ' [cert', ' [kernel', ' [derived'):
                c = body.find(g)
                if c != -1 and (cut == -1 or c < cut): cut = c
            text = body if cut == -1 else body[:cut]
            grade = '' if cut == -1 else body[cut:cut + 160].split(']')[0] + ']'
            print(f'{f}:{i}  {text[:N]}{" …" if len(text) > N else ""}  ||{grade}\n')
            hit = True
    if not hit:
        print(f'{arg}  NO ENTRY FOUND\n')
