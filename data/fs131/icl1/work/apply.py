import sys
# apply literal replacement pairs from a python file of `reps` to a target file; refuse any pair whose source is absent
target, spec = sys.argv[1], sys.argv[2]
ns = {}
exec(open(spec).read(), ns)
s = open(target).read()
for a, b in ns['reps']:
    if a not in s:
        sys.exit(f"ABSENT: {a[:80]!r}")
    s = s.replace(a, b)
open(target, 'w').write(s)
print(f"applied {len(ns['reps'])} replacements")
