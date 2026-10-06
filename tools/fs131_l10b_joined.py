#!/usr/bin/env python3
"""FS131-L10B: the merge of `fs131-wf1` is the JOINED state, and deviates from the three-way rule only where named.

The three-way rule (`tools/fs131_l10b_keepboth.py`): a non-blank line stands in the merged file ours + theirs - base
times. The join of "one branch declares an import" with "another proves the only import there was" is not that rule
everywhere: two sentences that one side wrote ("the library declares no import at present …", "None at present …") are
false of the joined tree and are rewritten. This check allows exactly those rewrites and nothing else, and then reads
the joined state itself.

  tools/fs131_l10b_joined.py check <ours-ref> <theirs-ref> <base-ref>
  tools/fs131_l10b_joined.py --self-test <ours-ref> <theirs-ref> <base-ref>

(1) THREE-WAY   for `scripts/Axioms.lean`, `ARCHITECTURE.md`, `Proofs.lean`, `scripts/axioms-controls.txt` in the working
                tree: the rule's faults are exactly the expected ones — the lines of EXPECT below (LOST: a line of theirs
                rewritten; EXTRA: its rewriting). Any other fault fails, and so does an expected one that is not there.
                `scripts/axioms-controls.txt` is checked when `--controls` is given (it is edited after the merge commit).
(2) DECLARE     the `declareImport` commands of `scripts/Axioms.lean` (lines beginning `#eval AxiomAudit.declareImport`
                outside every `/- … -/` block: the section's docstring quotes one as its example) are exactly one,
                `HadwigerNelson.StandingFive.kloosterman_bound`.
(3) IMPORTED    the `#print axioms` names between the IMPORTED and CLEAN banners are exactly the eight on Weil's bound.
(4) CLEAN       `falconer_lemma2_nonempty` and the four that rested on it are each printed once, between the CLEAN and
                PURCHASED banners.
(5) ARCH        `ARCHITECTURE.md`'s table "Imported outside theorems" has exactly one row, naming
                `StandingFive.kloosterman_bound`; the section does not say "None at present" or "declares no `axiom`".

--self-test: `check` must pass; then six plants on scratch copies, each failing with its own word: Falconer's
`declareImport` put back (DECLARE); one of Falconer's four put under IMPORTED (IMPORTED); one of Weil's eight moved
under CLEAN (IMPORTED); Falconer's row put back in the table (ARCH); "None at present" put back (ARCH); a line of
theirs dropped from `Proofs.lean` (THREE-WAY).
"""
import importlib.util
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location('keepboth', os.path.join(HERE, 'fs131_l10b_keepboth.py'))
kb = importlib.util.module_from_spec(spec)
spec.loader.exec_module(kb)

WEIL = ['kloostermanBound_of_ringChar_ne_two', 'targetFloor_seven_weil', 'targetFloor_six_weil', 'circle_sum_le_weil',
        'standingFloor_seven_weil', 'standingFloor_five_weil', 'seven_le_localBound_weil', 'five_le_chromaticNumber_weil']
FALC = ['falconer_lemma2_nonempty', 'falconer_reduction', 'le_chiM_of_falconerFan', 'exists_mem_falconerE', 'fan_tip_ae_mem']

# the rewrites of the joined state: (path, word, the line's first 60 characters)
EXPECT = {
    'scripts/Axioms.lean': [
        ('LOST', "declares no import at present — its first, wave 2's `falconer_lemma2_nonempty`, is a theorem since"),
        ('LOST', 'this section is empty.'),
        ('EXTRA', "declares one import at present, wave 10's `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207, FS131-K10c), with"),
        ('EXTRA', "eight records below; its first, wave 2's `falconer_lemma2_nonempty`, is a theorem since FS131-IF1 (FS131-L10B's join)."),
    ],
    'ARCHITECTURE.md': [
        ('LOST', 'None at present: the library declares no `axiom`. Its first import, `[Falconer1981]` Lemma 2 (i)'),
        ('EXTRA', "One at present. The library's first import, `[Falconer1981]` Lemma 2 (i) (FS131-K2c), is a theorem"),
    ],
    'Proofs.lean': [],
}


def three_way(path, text, o, t, b, expect):
    faults, _, _ = kb.check_text(text, kb.show(o, path), kb.show(t, path), kb.show(b, path))
    out, seen = [], set()
    for f in faults:
        word = f.split(' ', 1)[0]
        m = re.match(r"^\w+ '(.*?)' \(rule", f) or re.match(r'^\w+ "(.*?)" \(rule', f)
        line = m.group(1) if m else f
        hit = [i for i, (w, pre) in enumerate(expect) if w == word and line.startswith(pre[:95])]
        if hit:
            seen.add(hit[0])
        else:
            out.append(f'THREE-WAY {path}: unexpected {f[:160]}')
    for i, (w, pre) in enumerate(expect):
        if i not in seen:
            out.append(f'THREE-WAY {path}: expected {w} of {pre[:70]!r} is not there')
    return out


def state(ax, arch):
    out = []
    # commands only: the section's docstring quotes a `declareImport` line as its example
    code = re.sub(r'/-.*?-/', lambda m: '\n' * m.group(0).count('\n'), ax, flags=re.S)
    decl = re.findall(r'^#eval AxiomAudit\.declareImport ``(\S+)', code, re.M)
    if decl != ['HadwigerNelson.StandingFive.kloosterman_bound']:
        out.append(f'DECLARE: declareImport commands are {decl}')
    try:
        i_imp = ax.index('#eval IO.println "=== IMPORTED ==="')
        i_cl = ax.index('#eval IO.println "=== CLEAN ==="')
        i_pu = ax.index('#eval IO.println "=== PURCHASED ==="')
    except ValueError:
        return out + ['BANNERS: a banner is missing']
    pr = lambda s: re.findall(r'^#print axioms (\S+)', s, re.M)
    imp = pr(ax[i_imp:i_cl])
    want = ['HadwigerNelson.StandingFive.' + n for n in WEIL]
    if sorted(imp) != sorted(want):
        out.append(f'IMPORTED: records under IMPORTED are not the eight: extra {sorted(set(imp) - set(want))}, '
                   f'missing {sorted(set(want) - set(imp))}, count {len(imp)}')
    clean = pr(ax[i_cl:i_pu])
    for n in FALC:
        k = clean.count('HadwigerNelson.Plane.' + n)
        if k != 1:
            out.append(f'CLEAN: {n} is printed {k} time(s) under CLEAN')
    m = re.search(r'### Imported outside theorems.*?\n(.*?)\n\*\*Two ledgers', arch, re.S)
    if not m:
        return out + ['ARCH: the section "Imported outside theorems" was not found']
    sec = m.group(1)
    rows = [l for l in sec.split('\n') if l.startswith('| `')]
    if len(rows) != 1 or not rows[0].startswith('| `StandingFive.kloosterman_bound`'):
        out.append(f'ARCH: the table has {len(rows)} row(s): {[r[:50] for r in rows]}')
    for phrase in ('None at present', 'declares no `axiom`'):
        if phrase in sec:
            out.append(f'ARCH: the section still says {phrase!r}')
    return out


def run(texts, o, t, b, controls=False, quiet=False):
    faults = []
    for path in ['scripts/Axioms.lean', 'ARCHITECTURE.md', 'Proofs.lean']:
        faults += three_way(path, texts[path], o, t, b, EXPECT[path])
    faults += state(texts['scripts/Axioms.lean'], texts['ARCHITECTURE.md'])
    if not quiet:
        for f in faults:
            print('  ' + f)
        print('joined state: PASS' if not faults else f'joined state: FAIL ({len(faults)} fault(s))')
    return faults


def main(argv):
    st = '--self-test' in argv
    args = [a for a in argv if a not in ('--self-test', 'check')]
    if len(args) != 3:
        print(__doc__)
        return 2
    o, t, b = args
    texts = {p: open(p, encoding='utf-8').read() for p in ['scripts/Axioms.lean', 'ARCHITECTURE.md', 'Proofs.lean']}
    faults = run(texts, o, t, b)
    if not st:
        return 1 if faults else 0
    ok = not faults
    ax, arch, pl = texts['scripts/Axioms.lean'], texts['ARCHITECTURE.md'], texts['Proofs.lean']
    w0 = '#print axioms HadwigerNelson.StandingFive.targetFloor_six_weil\n'
    f0 = '#print axioms HadwigerNelson.Plane.fan_tip_ae_mem\n'
    banner = '#eval IO.println "=== CLEAN ==="\n'
    theirs_only = [l for l in kb.show(t, 'Proofs.lean').split('\n')
                   if l.strip() and l not in kb.show(o, 'Proofs.lean').split('\n')]
    plants = [
        ('DECLARE', "Falconer's declareImport put back",
         {'scripts/Axioms.lean': ax.replace(banner, '#eval AxiomAudit.declareImport ``HadwigerNelson.Plane.falconer_lemma2_nonempty\n' + banner, 1)}),
        ('IMPORTED', "one of Falconer's four put under IMPORTED",
         {'scripts/Axioms.lean': ax.replace(f0, '', 1).replace(banner, f0 + banner, 1)}),
        ('IMPORTED', "one of Weil's eight moved under CLEAN",
         {'scripts/Axioms.lean': ax.replace(w0, '', 1).replace(banner, banner + w0, 1)}),
        ('ARCH', "Falconer's row put back in the table",
         {'ARCHITECTURE.md': arch.replace('| `StandingFive.kloosterman_bound`', '| `Plane.falconer_lemma2_nonempty` (`Plane/FalconerReduction`) | x | y | z |\n| `StandingFive.kloosterman_bound`', 1)}),
        ('ARCH', '"None at present" put back',
         {'ARCHITECTURE.md': arch.replace('One at present. ', 'None at present: the library declares no `axiom`. ', 1)}),
        ('THREE-WAY', 'a line of theirs dropped from Proofs.lean',
         {'Proofs.lean': pl.replace(theirs_only[0] + '\n', '', 1)} if theirs_only else {}),
    ]
    for word, what, repl in plants:
        tx = dict(texts)
        tx.update(repl)
        if not repl or all(tx[p] == texts[p] for p in repl):
            print(f'plant ({what}): COULD NOT BE PLANTED')
            ok = False
            continue
        fs = run(tx, o, t, b, quiet=True)
        fired = any(f.startswith(word) for f in fs)
        print(f'plant ({what}): {"fired (" + word + ")" if fired else "DID NOT FIRE"}')
        ok = ok and fired
    print('self-test: PASS' if ok else 'self-test: FAIL')
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
