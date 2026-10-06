#!/usr/bin/env python3
"""FS131-M7: `ArcBend.of_away`'s hypothesis `hM` IS `bend_away_part`'s conclusion (inventory ruling 448 (b)).

Reads, from the working tree,
  * `Plane/ValidMap/BendStep.lean`: the text of `bend_away_part` between `∃ (M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ), ` and ` := by`;
  * `Plane/ValidMap/ArcStep.lean`: the text of `ArcBend.of_away` between `(hM : ` and `) :\n    ArcBend F M h K P θ₁ θ₂ c c' c ε := by`;
folds whitespace runs on both, and requires them equal, token for token (the same bound names: `M`, `h`, `K`, `P`, `θ₁`, `θ₂`, `c`,
`F` are the two theorems' binders of the same names). Exit 0 only when equal; on a difference it prints the first differing clause of
the conjunction.

  python3 tools/fs131_m7_away_clause.py              # the check
  python3 tools/fs131_m7_away_clause.py --self-test  # three plants on ArcStep's text, each must fail; the unplanted run must pass
"""
import re
import sys

D = 'Proofs/HadwigerNelson/Plane/ValidMap/'


def fold(s):
    return re.sub(r'\s+', ' ', s).strip()


def conclusion(bendstep):
    m = re.search(r'^theorem bend_away_part\b.*?∃ \(M : ArcMap k\) \(h : ℂ ≃ₜ ℂ\) \(K : Set ℂ\), (.*?) := by\n', bendstep, re.S | re.M)
    if not m:
        raise SystemExit('NOT FOUND: bend_away_part\'s conclusion in BendStep.lean')
    return fold(m.group(1))


def hypothesis(arcstep):
    m = re.search(r'^theorem ArcBend\.of_away\b.*?\(hM : (.*?)\) :\n    ArcBend F M h K P θ₁ θ₂ c c\' c ε := by\n', arcstep, re.S | re.M)
    if not m:
        raise SystemExit('NOT FOUND: ArcBend.of_away\'s hypothesis hM in ArcStep.lean')
    return fold(m.group(1))


def clauses(s):
    """Split a right-nested conjunction at its depth-0 `∧`."""
    out, depth, cur = [], 0, []
    for tok in s.split(' '):
        depth += sum(tok.count(ch) for ch in '([{') - sum(tok.count(ch) for ch in ')]}')
        if tok == '∧' and depth == 0:
            out.append(' '.join(cur))
            cur = []
        else:
            cur.append(tok)
    out.append(' '.join(cur))
    return out


def check(bendstep, arcstep):
    a, b = conclusion(bendstep), hypothesis(arcstep)
    ca, cb = clauses(a), clauses(b)
    if a == b:
        return True, f'EQUAL: {len(ca)} clauses, {len(a)} characters after folding'
    for i, (x, y) in enumerate(zip(ca, cb)):
        if x != y:
            return False, f'DIFFER at clause {i + 1} of {len(ca)}/{len(cb)}:\n  bend_away_part: {x}\n  of_away hM:     {y}'
    return False, f'DIFFER in the number of clauses: {len(ca)} against {len(cb)}'


def main():
    bs, ar = open(D + 'BendStep.lean').read(), open(D + 'ArcStep.lean').read()
    ok, msg = check(bs, ar)
    if '--self-test' not in sys.argv:
        print(msg)
        print('RESULT:', 'PASS' if ok else 'FAIL')
        sys.exit(0 if ok else 1)
    print('unplanted:', 'PASS' if ok else 'FAIL', '—', msg.split('\n')[0])
    m = re.search(r'^theorem ArcBend\.of_away\b.*?:= by\n', ar, re.S | re.M)
    head = m.group(0)
    plants = {
        'the last clause in its old form (the interval of r2Contacts)':
            ('P + 2 * e θ ∈ closure (F.region c))) :', '∃ a b, a < b ∧ θ ∈ Icc a b ∧ Icc a b ⊆ F.r2Contacts P θ₁ θ₂ c)) :'),
        'the horn clause as an iff':
            ('(∀ x j, F.HasHornCount x j → ∃ j\' ≤ j, M.HasHornCount x j\')', '(∀ x j, M.HasHornCount x j ↔ F.HasHornCount x j)'),
        'a clause dropped (IsCompact K)': ('IsCompact K ∧ ', ''),
    }
    allfired = ok
    for name, (old, new) in plants.items():
        if old not in head:
            raise SystemExit(f'PLANT TARGET ABSENT in ArcBend.of_away: {old!r}')
        ok2, msg2 = check(bs, ar.replace(head, head.replace(old, new, 1), 1))
        print(f'plant — {name}: {"FIRED" if not ok2 else "DID NOT FIRE"}  {msg2.splitlines()[0]}')
        allfired = allfired and not ok2
    print('SELF-TEST:', 'every plant fired, the unplanted run passed' if allfired else 'FAILED')
    sys.exit(0 if allfired else 1)


if __name__ == '__main__':
    main()
