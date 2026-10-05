#!/usr/bin/env python3
"""Splice proved chunks from a scratch file into CoverExamples.

usage: splice.py SCRATCH PLAN.json
PLAN: {"insert_before": [[module_leaf_name, [scratch_chunk_names...]], ...],
       "bodies": [[module_leaf_name, scratch_chunk_name], ...],
       "rename": {"old'": "new", ...}}
"""
import json, re, sys
MOD = '/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2/Proofs/HadwigerNelson/Plane/CoverExamples.lean'

def chunks(text):
    # chunk = from a line starting with '/--' to just before the next such line (or 'end ' line)
    lines = text.split('\n')
    starts = [i for i, l in enumerate(lines) if l.startswith('/--')]
    out = {}
    order = []
    for k, st in enumerate(starts):
        en = starts[k + 1] if k + 1 < len(starts) else next(i for i in range(st, len(lines)) if lines[i].startswith('end '))
        body = '\n'.join(lines[st:en]).rstrip('\n') + '\n'
        m = re.search(r'^(?:private )?(?:theorem|lemma|def|noncomputable def|abbrev|structure|inductive|instance)\s+(\S+)', body, re.M)
        name = m.group(1) if m else f'_anon{k}'
        out[name] = body
        order.append(name)
    return out, order

def proof_body(chunk):
    i = chunk.index(':= by\n')
    return chunk[i + len(':= by\n'):]

def main():
    scratch = open(sys.argv[1]).read()
    plan = json.load(open(sys.argv[2]))
    ch, _ = chunks(scratch)
    mod = open(MOD).read()
    ren = plan.get('rename', {})
    def fix(t):
        for a, b in ren.items():
            t = t.replace(a, b)
        return t
    for leaf, body_name in plan.get('bodies', []):
        mc, _ = chunks(mod)
        old = mc[leaf]
        assert old.rstrip().endswith('sorry'), leaf
        new = old[:old.rindex('  sorry')] + fix(proof_body(ch[body_name])).rstrip('\n') + '\n'
        assert mod.count(old) == 1, leaf
        mod = mod.replace(old, new)
    for leaf, names in plan.get('insert_before', []):
        mc, _ = chunks(mod)
        anchor = mc[leaf]
        assert mod.count(anchor) == 1, leaf
        ins = ''.join(fix(ch[n]) + '\n' for n in names)
        mod = mod.replace(anchor, ins + anchor)
    open(MOD, 'w').write(mod)
    print('ok')

main()
