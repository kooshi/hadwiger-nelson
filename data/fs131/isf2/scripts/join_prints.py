#!/usr/bin/env python3
"""FS131-ISF2: join each `#print axioms` result of an audit receipt onto one line (a print that wraps its axiom list
continues on lines that begin with a space until the closing bracket) and print them sorted. Usage: join_prints.py LOG"""
import re, sys
out, cur = [], None
for ln in open(sys.argv[1], encoding='utf-8'):
    ln = ln.rstrip('\n')
    if re.match(r"^'.*' (depends on axioms|does not depend)", ln):
        if cur is not None: out.append(cur)
        cur = ln
        if ln.endswith(']') or 'does not depend' in ln:
            out.append(cur); cur = None
    elif cur is not None:
        cur += ' ' + ln.strip()
        if ln.rstrip().endswith(']'):
            out.append(cur); cur = None
if cur is not None: out.append(cur)
for x in sorted(out): print(re.sub(r'\s+', ' ', x))
