#!/usr/bin/env python3
"""Splice proved chunks from a scratch file into CoverExamples (FS131-I2n; I2m's helper extended).

usage: i2n-splice.py SCRATCH PLAN.json
PLAN: {"insert_before": [[module_decl_name, [scratch_chunk_names...]], ...],
       "bodies": [[module_decl_name, scratch_chunk_name], ...],      # replaces a `sorry` body
       "rebodies": [[module_decl_name, scratch_chunk_name], ...]}    # replaces a full proof body (statement kept)
A chunk runs from a line starting with '/--' to just before the next such line (or an 'end ' line).
"""
import json, re, sys
MOD = '/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2/Proofs/HadwigerNelson/Plane/CoverExamples.lean'

def chunks(text):
    lines = text.split('\n')
    starts = [i for i, l in enumerate(lines) if l.startswith('/--')]
    out = {}
    for k, st in enumerate(starts):
        en = starts[k + 1] if k + 1 < len(starts) else next(i for i in range(st, len(lines)) if lines[i].startswith('end '))
        body = '\n'.join(lines[st:en]).rstrip('\n') + '\n'
        m = re.search(r'^(?:private )?(?:theorem|lemma|def|noncomputable def|abbrev|structure|inductive|instance)\s+(\S+)', body, re.M)
        name = m.group(1) if m else f'_anon{k}'
        assert name not in out, name
        out[name] = body
    return out

def split_at_by(chunk):
    i = chunk.index(':= by\n')
    return chunk[:i + len(':= by\n')], chunk[i + len(':= by\n'):]

def main():
    scratch = open(sys.argv[1]).read()
    plan = json.load(open(sys.argv[2]))
    ch = chunks(scratch)
    mod = open(MOD).read()
    for leaf, body_name in plan.get('bodies', []):
        old = chunks(mod)[leaf]
        assert old.rstrip().endswith('sorry'), leaf
        new = old[:old.rindex('  sorry')] + split_at_by(ch[body_name])[1].rstrip('\n') + '\n'
        assert mod.count(old) == 1, leaf
        mod = mod.replace(old, new)
    for leaf, body_name in plan.get('rebodies', []):
        old = chunks(mod)[leaf]
        head, _ = split_at_by(old)
        # keep trailing non-proof lines of the old chunk? none expected: the chunk ends at the next docstring
        new = head + split_at_by(ch[body_name])[1].rstrip('\n') + '\n'
        assert mod.count(old) == 1, leaf
        mod = mod.replace(old, new + ('\n' if old.endswith('\n\n') else ''))
    for leaf, names in plan.get('insert_before', []):
        anchor = chunks(mod)[leaf]
        assert mod.count(anchor) == 1, leaf
        ins = ''.join(ch[n] + '\n' for n in names)
        mod = mod.replace(anchor, ins + anchor)
    open(MOD, 'w').write(mod)
    print('ok')

main()
