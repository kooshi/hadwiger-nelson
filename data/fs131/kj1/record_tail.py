#!/usr/bin/env python3
"""FS131-KJ1: assemble the record's last sections from two text files (kept so the record's edit is reproducible)."""
import sys
p = 'plans/FS131-KJ1-joining-module.md'
s = open(p).read()
old = '*(Filled stage by stage; each line is a theorem of the built tree with its grade and address, or says what is not yet built.)*'
assert s.count(old) == 1
s = s.replace(old, open(sys.argv[1]).read().rstrip('\n'))
s += '\n' + open(sys.argv[2]).read()
open(p, 'w').write(s)
print('record assembled')
