#!/usr/bin/env python3
"""FS131-LCH1 — the names the chain's lines declare that main's library also declares, from the kernel's side.

Reads three dumps in the `@@ <KIND> <name> [flags]` format under `## MODULE <m>` headers
(data/fs131/lch1/lean/StatementDump.lean; FS131-ICM3's dumper for M13's line):
  CHAIN — the chain tree's compiled library (fs131-wm15 at 77d9d27ce), every Proofs.* module;
  MAIN  — main's gated build (fs131-w10g), every Proofs.* module;
  M13   — FS131-ICM3's last dump on fs131-wcm3 (its modules only).
The chain's lines' modules are those of CHAIN and M13 that MAIN does not hold, plus the add/add module
(Plane/OneAvoidingDensity) and the M13 modules MAIN holds under another text (none: MAIN holds no Rigidity module).
A COLLISION is a name declared in a chain-line module and in a MAIN module of another name. For the add/add module,
names in the chain's copy that main's copy lacks are listed as DROPPED (their readers break) and the reverse as ADDED.
Usage: fs131_lch1_collisions.py CHAIN MAIN M13 [--plant]
--plant adds one fake constant to MAIN under a chain-line name in another module and one to the chain's add/add copy,
and requires both reported (exit 0 only then)."""
import sys

def read(path):
    mods, cur = {}, None
    op = open(path, encoding='utf-8', errors='replace')
    for ln in op:
        if ln.startswith('## MODULE '):
            cur = ln.split()[2]; mods.setdefault(cur, {})
        elif ln.startswith('@@ '):
            p = ln.split()
            mods[cur][p[2]] = p[1]
    return mods

def main():
    chain, mainl, m13 = read(sys.argv[1]), read(sys.argv[2]), read(sys.argv[3])
    plant = '--plant' in sys.argv
    ADD = 'Proofs.HadwigerNelson.Plane.OneAvoidingDensity'
    lines = {m: c for m, c in chain.items() if m not in mainl}
    for m, c in m13.items():
        if m not in mainl:
            lines.setdefault(m, {}).update(c)
    if plant:
        some = next(iter(lines['Proofs.HadwigerNelson.Rigidity.ChainHeadline']))
        mainl.setdefault('Proofs.HadwigerNelson.PLANTED', {})[some] = 'THM'
        chain[ADD]['HadwigerNelson.Plane.PLANTED_dropped'] = 'THM'
    where = {}
    for m, c in mainl.items():
        for n in c:
            where.setdefault(n, []).append(m)
    out, ncol = [], 0
    for m in sorted(lines):
        for n, k in lines[m].items():
            for mm in where.get(n, []):
                if mm != m:
                    ncol += 1
                    out.append(f'COLLISION {k} {n} :: chain-line {m} :: main {mm} ({mainl[mm][n]})')
    for n, k in chain[ADD].items():
        for mm in where.get(n, []):
            if mm != ADD:
                ncol += 1
                out.append(f'COLLISION {k} {n} :: chain-line {ADD} (its copy) :: main {mm} ({mainl[mm][n]})')
    dropped = sorted(n for n in chain[ADD] if n not in mainl.get(ADD, {}))
    added = sorted(n for n in mainl.get(ADD, {}) if n not in chain[ADD])
    nlines = sum(len(c) for c in lines.values())
    nmain = sum(len(c) for c in mainl.values())
    print(f'FS131-LCH1 collisions: the chain lines\' {len(lines)} modules ({nlines} constants) and the add/add copy '
          f'({len(chain[ADD])}) against main\'s {len(mainl)} modules ({nmain} constants): {ncol} collision(s)')
    for l in out: print(l)
    for n in dropped: print(f'DROPPED (in the chain\'s copy of {ADD}, not in main\'s) {chain[ADD][n]} {n}')
    for n in added: print(f'ADDED (in main\'s copy, not in the chain\'s) {mainl[ADD][n]} {n}')
    if plant:
        okc = any('PLANTED' in l for l in out)
        okd = 'HadwigerNelson.Plane.PLANTED_dropped' in dropped
        print(f'PLANT: collision reported={okc}, dropped reported={okd}')
        return 0 if okc and okd else 1
    return 0

sys.exit(main())
