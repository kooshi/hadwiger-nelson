#!/usr/bin/env python3
"""FS131-L10B: the ruled tidies have exactly the ruled shape (the brief's item 3).

  tools/fs131_l10b_tidyshape.py [--self-test] <ref>

<ref> is the commit before the tidies (the second merge's tip). Checked, in the working tree against <ref>, over every
`.lean` file under `Proofs/` that differs from <ref>:

 (a) FILES    the Lean files that differ are exactly `Arith/{MajorityVote, StandingFive, NormOneTarget, SpectralInputs,
              FloorPlanes, Floor128, ProductFactor}`;
 (b) CODE     with every comment and docstring blanked (`/- … -/` nested, `-- …`), the lines removed and the lines added
              are exactly the lists REMOVED and ADDED below — the majority vote's statement, the four proof lines that
              read the dropped hypotheses or derived countability, the spec example's signature and call, and the one
              instance line; and, ruled mid-job after the lint reported it, the one line of `ProductFactor` that states
              `fibre_mem_factorSets`, which loses the unread instance binder `[MeasurableSingletonClass Ω₁]` and nothing
              else; no other code line of any file changed;
 (c) SHAPE    the majority vote's statement after the tidy is the statement at <ref> with exactly ` (hG : Measurable G)`
              and ` (hc : ∀ x, Measurable (c x))` deleted and `[Finite K]` replaced by `[Countable K]` (whitespace
              collapsed) — nothing else of it moved;
 (d) INSTANCE the instance line is <ref>'s with the one word `local ` deleted.

Exit 0 iff all hold. --self-test also plants, on scratch copies of the working tree's files: a proof line changed in
another file (CODE); a hypothesis of another theorem dropped (CODE); the majority vote's conclusion changed (SHAPE, CODE);
a file outside the list touched in a comment only (FILES). Each must fail with its word, beside the faithful run.
"""
import importlib.util
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location('ks', os.path.join(HERE, 'fs131_l10b_kernelsig.py'))
ks = importlib.util.module_from_spec(spec)
spec.loader.exec_module(ks)

A = 'Proofs/HadwigerNelson/Arith/'
FILES = sorted(A + f + '.lean' for f in ['MajorityVote', 'StandingFive', 'NormOneTarget', 'SpectralInputs', 'FloorPlanes', 'Floor128', 'ProductFactor'])
REMOVED = {
    A + 'MajorityVote.lean': [
        "[Infinite I] [Finite K] [MeasurableSpace K] [MeasurableSingletonClass K] (G : Ω → K) (hG : Measurable G)",
        "(c : I → Ω → K) (hc : ∀ x, Measurable (c x)) (E : I → Set Ω) (hE : ∀ x, MeasurableSet (E x)) {p : ℝ}",
        "have _hG := hG",
        "have _hc := hc",
        "haveI : Countable K := Finite.to_countable",
        "example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ] (G : Ω → Bool) (hG : Measurable G) :",
        "ae_eq_measurable_of_majority G hG (fun _ : ℕ => G) (fun _ => hG) (fun _ => ∅) (fun _ => MeasurableSet.empty)",
    ],
    A + 'StandingFive.lean': ["local instance instNumberFieldStanding : NumberField standingField := numberField_standingField"],
    A + 'ProductFactor.lean': ["theorem fibre_mem_factorSets [MeasurableSingletonClass Ω₁] [IsProbabilityMeasure μ₁] [IsProbabilityMeasure μ₂]"],
}
ADDED = {
    A + 'MajorityVote.lean': [
        "[Infinite I] [Countable K] [MeasurableSpace K] [MeasurableSingletonClass K] (G : Ω → K)",
        "(c : I → Ω → K) (E : I → Set Ω) (hE : ∀ x, MeasurableSet (E x)) {p : ℝ}",
        "example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ] (G : Ω → Bool) :",
        "ae_eq_measurable_of_majority G (fun _ : ℕ => G) (fun _ => ∅) (fun _ => MeasurableSet.empty)",
    ],
    A + 'StandingFive.lean': ["instance instNumberFieldStanding : NumberField standingField := numberField_standingField"],
    A + 'ProductFactor.lean': ["theorem fibre_mem_factorSets [IsProbabilityMeasure μ₁] [IsProbabilityMeasure μ₂]"],
}


def show(ref, path):
    r = subprocess.run(['git', 'show', f'{ref}:{path}'], capture_output=True, text=True)
    return r.stdout if r.returncode == 0 else ''


def code_lines(text):
    return [' '.join(l.split()) for l in ks.strip_comments(text).split('\n') if l.strip()]


def multidiff(a, b):
    import collections
    ca, cb = collections.Counter(a), collections.Counter(b)
    return sorted((ca - cb).elements()), sorted((cb - ca).elements())


def statement(text, name='theorem ae_eq_measurable_of_majority'):
    i = text.index(name)
    return ' '.join(text[i:text.index(' := by', i)].split())


def run(ref, cur, changed, quiet=False):
    """cur: {path: text} for the working tree; changed: the list of Lean paths that differ from ref."""
    faults = []
    if sorted(changed) != FILES:
        faults.append(f'FILES: differ from {ref[:8]}: unexpected {sorted(set(changed) - set(FILES))}, missing {sorted(set(FILES) - set(changed))}')
    for p in sorted(set(changed) | set(FILES)):
        rem, add = multidiff(code_lines(show(ref, p)), code_lines(cur[p]))
        if rem != sorted(REMOVED.get(p, [])) or add != sorted(ADDED.get(p, [])):
            ur = [l for l in rem if l not in REMOVED.get(p, [])]
            ua = [l for l in add if l not in ADDED.get(p, [])]
            mr = [l for l in REMOVED.get(p, []) if l not in rem]
            ma = [l for l in ADDED.get(p, []) if l not in add]
            faults.append(f'CODE {p}: unexpected removed {ur[:3]}, unexpected added {ua[:3]}, expected-but-absent {(mr + ma)[:3]}')
    mv = A + 'MajorityVote.lean'
    try:
        want = statement(show(ref, mv)).replace(' (hG : Measurable G)', '').replace(' (hc : ∀ x, Measurable (c x))', '') \
            .replace('[Finite K]', '[Countable K]')
        got = statement(cur[mv])
        if want != got or statement(show(ref, mv)).count('[Finite K]') != 1:
            faults.append('SHAPE: the majority vote\'s statement is not the old one with the two binders deleted and the class replaced')
    except ValueError:
        faults.append('SHAPE: the majority vote\'s statement was not found')
    sf = A + 'StandingFive.lean'
    old_l = [l for l in show(ref, sf).split('\n') if 'instNumberFieldStanding' in l and 'instance' in l]
    new_l = [l for l in cur[sf].split('\n') if 'instNumberFieldStanding' in l and 'instance' in l]
    if len(old_l) != 1 or len(new_l) != 1 or old_l[0] != 'local ' + new_l[0]:
        faults.append('INSTANCE: the instance line is not the old one with `local ` deleted')
    if not quiet:
        for f in faults:
            print('  ' + f)
        n_rem = sum(len(v) for v in REMOVED.values())
        n_add = sum(len(v) for v in ADDED.values())
        print(f'Lean files differing from {ref[:8]}: {len(changed)}; code lines removed {n_rem}, added {n_add}, in {len(REMOVED)} files; '
              f'the other {len(changed) - len(REMOVED)} differ in comments and docstrings only')
        print('tidy shape: PASS' if not faults else f'tidy shape: FAIL ({len(faults)} fault(s))')
    return faults


def main(argv):
    st = '--self-test' in argv
    args = [a for a in argv if a != '--self-test']
    if len(args) != 1:
        print(__doc__)
        return 2
    ref = args[0]
    changed = [p for p in subprocess.run(['git', 'diff', '--name-only', ref, '--', 'Proofs', 'Proofs.lean'],
                                         capture_output=True, text=True).stdout.split('\n') if p.endswith('.lean')]
    paths = sorted(set(changed) | set(FILES) | {A + 'NegCircleModel.lean', A + 'GapSeven.lean'})
    cur = {p: open(p, encoding='utf-8').read() for p in paths}
    faults = run(ref, cur, changed)
    if not st:
        return 1 if faults else 0
    ok = not faults
    pf, mv, gs = A + 'NegCircleModel.lean', A + 'MajorityVote.lean', A + 'GapSeven.lean'
    plants = [
        ('CODE', 'a code line added in another file',
         {pf: cur[pf].replace('\nend ', '\ntheorem zz_planted : True := trivial\n\nend ', 1)}, changed + [pf]),
        ('CODE', 'a hypothesis of another theorem dropped',
         {A + 'NormOneTarget.lean': cur[A + 'NormOneTarget.lean'].replace(' (hσ : ∀ x, σ (σ x) = x)', '', 1)}, changed),
        ('SHAPE', 'the majority vote\'s conclusion changed',
         {mv: cur[mv].replace('g ∧ G =ᵐ[μ] g := by', 'g ∧ g =ᵐ[μ] G := by', 1)}, changed),
        ('FILES', 'a file outside the list touched in a comment only',
         {gs: cur[gs] + '\n-- planted\n'}, changed + [gs]),
    ]
    for word, what, repl, ch in plants:
        tx = dict(cur)
        tx.update(repl)
        if all(tx[p] == cur[p] for p in repl):
            print(f'plant ({what}): COULD NOT BE PLANTED')
            ok = False
            continue
        fs = run(ref, tx, ch, quiet=True)
        fired = any(f.startswith(word) for f in fs)
        print(f'plant ({what}): {"fired (" + word + ")" if fired else "DID NOT FIRE"}')
        ok = ok and fired
    print('self-test: PASS' if ok else 'self-test: FAIL')
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
