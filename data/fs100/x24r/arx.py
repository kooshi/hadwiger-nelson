#!/usr/bin/env python3
"""X24R helper: print arXiv Atom entries (id, title, authors, abstract) from a saved API response."""
import re, sys
s = open(sys.argv[1]).read()
n = int(sys.argv[2]) if len(sys.argv) > 2 else 2000
for e in s.split('<entry>')[1:]:
    t = re.search(r'<title>(.*?)</title>', e, re.S).group(1)
    a = re.search(r'<summary>(.*?)</summary>', e, re.S).group(1)
    i = re.search(r'<id>(.*?)</id>', e).group(1)
    au = re.findall(r'<name>(.*?)</name>', e)
    print('=====', i, ' '.join(t.split())); print('AUTH', ', '.join(au)); print(' '.join(a.split())[:n])
