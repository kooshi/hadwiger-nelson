#!/usr/bin/env python3
"""FS131-IP1: splice proofs from a scratch file into a module, keeping the module's statements byte for byte.

Usage: fs131_ip_splice.py MODULE SCRATCH NAME [NAME ...]
For each NAME, the module's declaration `theorem NAME ... := by\n  sorry` (statement = everything from `theorem NAME` up to and including
`:= by`) gets the scratch declaration's proof body (the lines after the scratch's `:= by`, up to the next blank line followed by a top-level
item). The statement text in the module and in the scratch must be identical, else the tool refuses (exit 2) and names the declaration:
the check that no statement moves. --check-only compares statements and writes nothing.
"""
import re, sys

def decls(text):
    """Map name -> (start, stmt_end, end) offsets of each `theorem`/`lemma` declaration."""
    out = {}
    for m in re.finditer(r'^(?:protected |private )?(?:theorem|lemma) (\S+)', text, re.M):
        name = m.group(1)
        start = m.start()
        by = text.find(':= by\n', start)
        if by < 0:
            continue
        stmt_end = by + len(':= by\n')
        # body ends at the next line that starts a top-level item (non-indented, non-empty)
        nxt = re.compile(r'^\S', re.M).search(text, stmt_end)
        end = nxt.start() if nxt else len(text)
        out[name] = (start, stmt_end, end)
    return out

def norm(s):
    return ' '.join(s.split())

def main():
    args = sys.argv[1:]
    check_only = '--check-only' in args
    args = [a for a in args if a != '--check-only']
    mod_path, scr_path, names = args[0], args[1], args[2:]
    mod = open(mod_path).read()
    scr = open(scr_path).read()
    md, sd = decls(mod), decls(scr)
    bad = []
    for n in names:
        if n not in md or n not in sd:
            bad.append(f'{n}: missing in {"module" if n not in md else "scratch"}')
            continue
        ms, me = md[n][0], md[n][1]
        ss, se = sd[n][0], sd[n][1]
        if norm(mod[ms:me]) != norm(scr[ss:se]):
            bad.append(f'{n}: STATEMENT DIFFERS')
    if bad:
        print('REFUSED:\n  ' + '\n  '.join(bad))
        sys.exit(2)
    if check_only:
        print(f'OK: {len(names)} statements identical')
        return
    # splice from the end so offsets stay valid
    for n in sorted(names, key=lambda n: -md[n][0]):
        ms, me, mend = md[n]
        ss, se, send = sd[n]
        body = scr[se:send].rstrip('\n') + '\n\n'
        mod = mod[:me] + body + mod[mend:]
    open(mod_path, 'w').write(mod)
    print(f'spliced {len(names)}')

if __name__ == '__main__':
    main()
