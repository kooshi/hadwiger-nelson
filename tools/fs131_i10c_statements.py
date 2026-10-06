#!/usr/bin/env python3
"""FS131-I10C: the statement check. Every declaration of the base commit's file must appear verbatim in the working tree.

usage: fs131_i10c_statements.py <base-commit> <file> [<file> ...]      (exit 0 iff every base declaration is unchanged)
       fs131_i10c_statements.py --self-test <base-commit> <file>       (plants two faults in a copy and must see both)

A declaration is the text from its docstring (if any) to the next declaration: a `theorem`/`lemma` is compared up to its first
` :=` (its statement), anything else (`def`, `abbrev`, `structure`, `instance`, `example`, a `/-! … -/` block, `namespace`, `open`,
`import`) whole. The check is substring containment in the working file, so new declarations may be added anywhere.
"""
import re, subprocess, sys

START = re.compile(r'^(?:@\[[^\]]*\]\s*)?(?:private |protected )?(?:noncomputable )?(theorem|lemma|def|abbrev|structure|instance|example|inductive|class)\b')

def chunks(text):
    lines = text.split('\n')
    out, i, n = [], 0, len(lines)
    while i < n:
        line = lines[i]
        if line.startswith('/-!'):
            j = i
            while '-/' not in lines[j]: j += 1
            out.append(('doc', '\n'.join(lines[i:j + 1]))); i = j + 1; continue
        if line.startswith('/--'):
            j = i
            while '-/' not in lines[j]: j += 1
            k = j + 1
            if k < n and START.match(lines[k]):
                kind = START.match(lines[k]).group(1)
                e = k + 1
                while e < n and lines[e].strip() != '' and not lines[e].startswith('/-') and not START.match(lines[e]): e += 1
                out.append((kind, '\n'.join(lines[i:e]))); i = e; continue
            out.append(('doc', '\n'.join(lines[i:j + 1]))); i = j + 1; continue
        m = START.match(line)
        if m:
            e = i + 1
            while e < n and lines[e].strip() != '' and not lines[e].startswith('/-') and not START.match(lines[e]): e += 1
            out.append((m.group(1), '\n'.join(lines[i:e]))); i = e; continue
        if line.startswith(('import ', 'namespace ', 'open ', 'end ')):
            out.append(('line', line))
        i += 1
    return out

def statement(kind, text):
    if kind in ('theorem', 'lemma'):
        p = text.find(' :=')
        return text if p < 0 else text[:p + 3]
    return text

def check(base_text, work_text):
    missing = []
    cs = chunks(base_text)
    for kind, text in cs:
        st = statement(kind, text)
        if st not in work_text: missing.append((kind, st))
    return len(cs), missing

def git_show(commit, path):
    return subprocess.run(['git', 'show', f'{commit}:{path}'], check=True, capture_output=True, text=True).stdout

def main():
    args = sys.argv[1:]
    if args and args[0] == '--self-test':
        commit, path = args[1], args[2]
        base = git_show(commit, path); work = open(path).read()
        n, missing = check(base, work)
        ok = (n > 0 and not missing)
        # fault 1: one character of a theorem's statement changed
        f1 = work.replace('347 ≤ Nat.card (𝓞 standingField ⧸ w)', '346 ≤ Nat.card (𝓞 standingField ⧸ w)', 1)
        _, m1 = check(base, f1)
        # fault 2: one line of a definition dropped
        f2 = work.replace("  TargetFloor n 128 ∧ ∀ Q : ℕ, Q % 4 = 3 → 347 ≤ Q → TargetFloor n Q\n", '', 1)
        _, m2 = check(base, f2)
        fired = (f1 != work and len(m1) >= 1 and f2 != work and len(m2) >= 1)
        print(f'self-test: clean={ok} ({n} base declarations), fault 1 flagged {len(m1)}, fault 2 flagged {len(m2)}:',
              'PASS' if ok and fired else 'FAIL')
        return 0 if ok and fired else 1
    commit, paths = args[0], args[1:]
    bad = 0
    for path in paths:
        n, missing = check(git_show(commit, path), open(path).read())
        print(f'{path}: {n} base declarations, {len(missing)} changed or missing')
        for kind, st in missing:
            bad += 1
            print(f'  CHANGED [{kind}]: {st[:200]!r}')
    print('STATEMENTS:', 'PASS' if bad == 0 else 'FAIL')
    return 0 if bad == 0 else 1

if __name__ == '__main__':
    sys.exit(main())
