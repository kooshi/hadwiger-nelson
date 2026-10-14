#!/usr/bin/env python3
"""FS131-LCH1 — no stored statement and no definition changed at the chain's landing but the ruled ones, from the
kernel's side. Reads the indexes `data/fs131/lch1/split_dump.py` writes (module, kind, name, flags, type hash, value
hash, data hash per constant; hashes are Lean's `Expr.hash`, which reads no binder name):
  CHAIN-BEFORE — the chain tree before any edit was compiled (fs131-wm15 at 77d9d27ce);
  MAIN-BEFORE  — main's gated build (fs131-w10g);
  M13          — FS131-ICM4's last dump on fs131-wcm4 (data/fs131/icm4/statements-after2.txt; full text; its four
                 modules' constants: CircleCos, ClassRatio, BinaryField, DyadicCerts);
  AFTER        — the joined tree after the build being checked.
Expected: a constant of a module main holds is as in MAIN-BEFORE; of a chain-line module, as in CHAIN-BEFORE (M13's
two modules: as in M13). The ruled changes (the brief's § The integrations, the amendments), each checked as stated:
  DELETED   — absent after: the names listed below (and the internal constants generated under them).
  PUBLIC    — `_private.<mod>.0.<name>` before, `<name>` after, same kind, module, type and value hash, where the hash of
              a type that names another of the same list's private names is compared through ReAdd's print (below).
  DROPPED   — the stored type after, with the dropped binders put back by the kernel's own term surgery
              (data/fs131/lch1/lean/ReAdd.lean, its hashes in readd.txt), hashes equal to the type before.
  NEW       — present after, absent before: the listed names (and internal constants generated under them).
  MOVED     — `Plane.mOne`, `Plane.mOne_le_one`: the chain's copies gone, main's the one (as in MAIN-BEFORE).
  REPLACED  — `Plane/OneAvoidingDensity`: main's copy whole (every constant as in MAIN-BEFORE).
Everything else: present, same kind, same module, same type hash, same value hash (a definition), or the difference is
reported as CHANGED and the check fails, unless listed in an INSTANCE file (constants whose stored type moved by an
instance only, each with its kernel check; `--instance <file>`).
Usage: fs131_lch1_statements.py CHAIN-BEFORE.tsv MAIN-BEFORE.tsv M13.txt AFTER.tsv READD.txt [--instance F] [--plant]
--plant plants five faults in memory (a changed type, a changed value, a missing constant, an unruled new constant, a
wrong re-added hash) and requires each reported by name and nothing else new."""
import sys

NS = 'HadwigerNelson.'
DELETED = {NS + n for n in [
    'Rigidity.zeroEntropyCarried_of_numberField',
    'SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five_of_chain']}
DELETED_PRIVATE = {  # (module, user name) of private constants deleted
    ('Proofs.HadwigerNelson.Rigidity.SqrtClassFive', NS + 'Rigidity.ratioAtMost_two_notMem_link'),
    ('Proofs.HadwigerNelson.Rigidity.SqrtClassFive', NS + 'Rigidity.exists_I_integer'),
} | {('Proofs.HadwigerNelson.Rigidity.InvariantMeasure', NS + 'Rigidity.' + n) for n in [
    'avgMeasure', 'avgMeasure_apply', 'isProbabilityMeasure_avgMeasure', 'avgMeasure_map', 'integral_avgMeasure',
    'map_eq_of_tendsto', 'map_eq_of_tendsto_of_eventually', 'measure_compl_eq_zero_of_tendsto',
    'isClosed_setOf_of_tendsto', 'exists_fixed_of_average', 'exists_common_fixed']}
HELPERS = ['avgMeasure', 'avgMeasure_apply', 'isProbabilityMeasure_avgMeasure', 'avgMeasure_map', 'integral_avgMeasure',
           'map_eq_of_tendsto', 'map_eq_of_tendsto_of_eventually', 'measure_compl_eq_zero_of_tendsto',
           'isClosed_setOf_of_tendsto', 'exists_fixed_of_average', 'exists_common_fixed']
PUBLIC = {('Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw', NS + 'OneClass.' + n) for n in HELPERS} | {
    ('Proofs.HadwigerNelson.Arith.UpperHalf', NS + 'UpperHalf.exists_I_integer')}
DROPPED = {NS + n for n in [
    'Rigidity.min_localBound_five_le_chromaticNumber',
    'Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound',
    'SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five',
    'SqrtClassValues.chromaticNumber_planeOver_sqrt143_eq_five',
    'SqrtClassValues.chromaticNumber_planeOver_sqrt311_eq_five',
    'SqrtClassValues.chromaticNumber_planeOver_sqrt335_eq_five',
    'SqrtClassValues.chromaticNumber_planeOver_sqrt3_sqrt5_eq_five',
    'SqrtClassValues.five_le_chromaticNumber_planeOver_sqrt167']}
NEW = {NS + 'Plane.mOne_le_0_2470': 'Proofs.HadwigerNelson.Plane.MOneBound',
       NS + 'Plane.mOne_lt_one_quarter': 'Proofs.HadwigerNelson.Plane.MOneBound'}
OAD = 'Proofs.HadwigerNelson.Plane.OneAvoidingDensity'
M13MODS = {'Proofs.HadwigerNelson.Arith.CircleCos', 'Proofs.HadwigerNelson.Rigidity.ClassRatio',
           'Proofs.HadwigerNelson.Arith.BinaryField', 'Proofs.HadwigerNelson.Arith.DyadicCerts'}
# the p = 19 line's modules (fs131-wc17): merged whole, edited by no one here; their constants are counted, not compared
INCOMING = 'Proofs.HadwigerNelson.Arith.FibreCert'

def read_idx(path):
    d = {}
    for ln in open(path, encoding='utf-8'):
        if ln.startswith('#'): continue
        m, k, n, fl, th, vh, dh = ln.rstrip('\n').split('\t')
        d[n] = dict(mod=m, kind=k, flags=fl, th=th, vh=vh, dh=dh)
    return d

def read_full(path, mods):
    d, mod, cur = {}, None, None
    for ln in open(path, encoding='utf-8', errors='replace'):
        if ln.startswith('## MODULE '): mod = ln.split()[2]; continue
        if mod not in mods: continue
        if ln.startswith('@@ '):
            p = ln.rstrip('\n').split(' '); cur = p[2]
            d[cur] = dict(mod=mod, kind=p[1], flags=' '.join(p[3:]), th='', vh='', dh='')
        elif ln.startswith('TYPE ') and cur: d[cur]['th'] = ln.split(' ', 2)[1]
        elif ln.startswith('VALUE ') and cur: d[cur]['vh'] = ln.split(' ', 2)[1].strip()
        elif ln.startswith('DATA ') and cur: d[cur]['dh'] = ln.split(' ', 2)[1].strip()
    return d

def internal_under(n, roots):
    return any(n.startswith(r + '.') or n.startswith('_private') and r in n for r in roots)

def priv(mod, user):
    return f'_private.{mod}.0.{user}'

def main():
    a = [x for x in sys.argv[1:] if not x.startswith('--')]
    plant = '--plant' in sys.argv
    inst = set()
    if '--instance' in sys.argv:
        f = sys.argv[sys.argv.index('--instance') + 1]
        a.remove(f)
        inst = {l.split()[0] for l in open(f) if l.strip() and not l.startswith('#')}
    chain, mainb, m13, after = read_idx(a[0]), read_idx(a[1]), read_full(a[2], M13MODS), read_idx(a[3])
    readd = {}
    for l in open(a[4]):
        p = l.split()
        if p and p[0] == 'READD': readd[p[1]] = p[2]
    mainmods = {v['mod'] for v in mainb.values()}
    exp = {}
    for n, v in chain.items():
        if v['mod'] not in mainmods and v['mod'] not in M13MODS: exp[n] = v
    for n, v in m13.items(): exp[n] = v
    for n, v in mainb.items(): exp[n] = v          # main's modules, OneAvoidingDensity among them, win
    if plant:
        k1 = NS + 'Rigidity.mrPlus'; after[k1] = dict(after[k1], th='PLANTED')
        k2 = NS + 'Plane.mOne'; after[k2] = dict(after[k2], vh='PLANTED')
        k3 = NS + 'Rigidity.entropySplit'; after.pop(k3)
        after[NS + 'Rigidity.PLANTED_new'] = dict(mod='Proofs.HadwigerNelson.Rigidity.ChainHeadline', kind='THM',
                                                  flags='', th='1', vh='', dh='')
        readd[NS + 'SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five'] = 'PLANTED'
    reports, ok = [], {'same': 0, 'renamed': 0, 'deleted': 0, 'public': 0, 'dropped': 0, 'new': 0, 'instance': 0, 'incoming': 0}
    pub_after = {n for _, n in PUBLIC}
    pub_before = {priv(m, n): n for m, n in PUBLIC}
    del_priv = {priv(m, n) for m, n in DELETED_PRIVATE}
    deleted_roots = DELETED | del_priv
    chain_only_copies = {NS + 'Plane.mOne_le_one'}  # the chain's copy, in WindowDensity
    for n, e in sorted(exp.items()):
        if n in DELETED or n in del_priv or internal_under(n, deleted_roots):
            if n in after and not (n in pub_after):
                reports.append(f'NOT-DELETED {n}')
            else: ok['deleted'] += 1
            continue
        if n in pub_before:
            m = pub_before[n]; g = after.get(m)
            if not g: reports.append(f'PUBLIC-MISSING {m}'); continue
            if g['kind'] != e['kind'] or g['mod'] != e['mod']: reports.append(f'PUBLIC-KIND/MODULE {m}'); continue
            if g['th'] != e['th'] and readd.get(m) != e['th']:
                reports.append(f'PUBLIC-TYPE {m}: before {e["th"]}, after {g["th"]}, renamed-back {readd.get(m)}'); continue
            if e['vh'] and g['vh'] != e['vh'] and readd.get(m + ':value') != e['vh']:
                reports.append(f'PUBLIC-VALUE {m}'); continue
            ok['public'] += 1; continue
        g = after.get(n)
        if g is None:
            if internal_under(n, set(pub_before)): ok['public'] += 1; continue  # renamed with its parent
            reports.append(f'MISSING {n} ({e["mod"]})'); continue
        if g['kind'] != e['kind'] or g['mod'] != e['mod']:
            reports.append(f'KIND/MODULE {n}: {e["kind"]} {e["mod"]} -> {g["kind"]} {g["mod"]}'); continue
        if n in DROPPED:
            if readd.get(n) == e['th']: ok['dropped'] += 1
            else: reports.append(f'DROPPED-MISMATCH {n}: before {e["th"]}, re-added {readd.get(n)}')
            continue
        tsame = g['th'] == e['th']
        vsame = (not e['vh'] and not g['vh']) or g['vh'] == e['vh'] or (e['dh'] and g['dh'] == e['dh'])
        if tsame and vsame: ok['same'] += 1
        elif (tsame or readd.get(n) == e['th']) and (vsame or readd.get(n + ':value') == e['vh']):
            ok['renamed'] += 1  # the type names a helper made public: equal read back under the private name
        elif n in inst: ok['instance'] += 1
        else:
            reports.append(f'CHANGED {n} ({g["mod"]}): type {"same" if tsame else e["th"] + "->" + g["th"]}, '
                           f'value {"same" if vsame else "differs"}')
    for n, g in sorted(after.items()):
        if n in exp or n in pub_after: continue
        if n in NEW and NEW[n] == g['mod']: ok['new'] += 1; continue
        if g['mod'].startswith(INCOMING): ok['incoming'] += 1; continue
        if internal_under(n, set(NEW) | pub_after): ok['new'] += 1; continue
        reports.append(f'UNRULED-NEW {n} ({g["mod"]}, {g["kind"]})')
    # the chain's moved copies: gone from the chain's modules
    for n in chain_only_copies:
        if after.get(n, {}).get('mod') != 'Proofs.HadwigerNelson.Plane.OneClass.Defs':
            reports.append(f'MOVED-WRONG {n}')
    for n in DROPPED:
        if n not in readd: reports.append(f'DROPPED-UNCHECKED {n}')
    print(f'FS131-LCH1 statements: expected {len(exp)} constants; ' + ', '.join(f'{k} {v}' for k, v in ok.items()) +
          f'; reports {len(reports)}')
    for r in reports: print(r)
    if plant:
        want = ['Rigidity.mrPlus', 'Plane.mOne', 'Rigidity.entropySplit', 'Rigidity.PLANTED_new',
                'SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five']
        hit = [w for w in want if any((NS + w + ' ') in r + ' ' or (NS + w + ':') in r for r in reports)]
        print(f'PLANT: {len(hit)}/{len(want)} planted faults reported')
        return 0 if len(hit) == len(want) else 1
    return 0 if not reports else 1

sys.exit(main())
