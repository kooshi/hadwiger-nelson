#!/usr/bin/env python3
"""FS131-L5: negative controls for a merge check on a merge where `tools/fs131_m7_merge_check.py --self-test` cannot run
(its third plant needs an import line of `Proofs.lean` that THEIRS added; the merge of `fs131-w5z` adds none, so the self-test
stops at "PLANT TARGET ABSENT" — the tool is another job's and is not edited).

Builds planted TREES from the staged merge (a scratch index file; no ref, no working-tree file and not the real index is
touched; the objects written are unreferenced) and runs the merge check on each with `--rev <tree>`:
  0. the staged merge itself                                             -> must PASS
  1. a Lean file THEIRS alone changed, replaced by OURS' blob             -> must FAIL naming it
  2. a Lean file OURS alone changed, replaced by THEIRS' blob             -> must FAIL naming it
  3. `scripts/Axioms.lean` with the last `#print axioms` record of THEIRS' additions dropped -> must FAIL naming it
  4. `scripts/Axioms.lean` with that record doubled                       -> must FAIL naming it
  5. with `--both FILE` (a file both sides changed): FILE set to OURS' blob, THEIRS' change dropped -> must FAIL naming it
Plants 3 and 4 need a record THEIRS added to `scripts/Axioms.lean`; on a merge where THEIRS added none they are reported as
not applicable (and `--both` is then required, so that a both-changed file is still planted on).
Usage: fs131_l5_merge_plants.py BASE OURS THEIRS THEIRS_ONLY_FILE OURS_ONLY_FILE [--both FILE]
Exit 0 iff 0 passes and every applicable plant fails naming the planted file.
"""
import os
import subprocess
import sys
import tempfile

CHECK = 'tools/fs131_m7_merge_check.py'
AX = 'scripts/Axioms.lean'


def git(*a, env=None, inp=None):
    return subprocess.run(['git', *a], capture_output=True, text=True, check=True, env=env, input=inp).stdout.strip()


def blob(rev, path):
    return git('rev-parse', f'{rev}:{path}')


def planted_tree(real_tree, path, new_blob):
    with tempfile.TemporaryDirectory() as d:
        env = dict(os.environ, GIT_INDEX_FILE=os.path.join(d, 'index'))
        git('read-tree', real_tree, env=env)
        git('update-index', '--cacheinfo', f'100644,{new_blob},{path}', env=env)
        return git('write-tree', env=env)


def run(base, ours, theirs, tree):
    r = subprocess.run([sys.executable, CHECK, base, ours, theirs, '--rev', tree], capture_output=True, text=True)
    return r.returncode, r.stdout + r.stderr


def main():
    base, ours, theirs, tfile, ofile = sys.argv[1:6]
    real = git('write-tree')
    ok = True
    rc, out = run(base, ours, theirs, real)
    print(f'0. the staged merge (tree {real[:10]}): exit {rc} -> {"PASS as it must" if rc == 0 else "DID NOT PASS"}')
    ok &= rc == 0
    assert blob(base, tfile) == blob(ours, tfile) != blob(theirs, tfile), 'not a THEIRS-only file'
    assert blob(base, ofile) == blob(theirs, ofile) != blob(ours, ofile), 'not an OURS-only file'
    merged_ax = git('cat-file', 'blob', f'{real}:{AX}') + '\n'
    theirs_ax = set(git('cat-file', 'blob', f'{theirs}:{AX}').split('\n'))
    ours_ax = set(git('cat-file', 'blob', f'{ours}:{AX}').split('\n'))
    added = [l for l in merged_ax.split('\n') if l.startswith('#print axioms ') and l in theirs_ax and l not in ours_ax]
    both = sys.argv[sys.argv.index('--both') + 1] if '--both' in sys.argv else None
    plants = [
        (f'1. {tfile} (THEIRS alone changed it) set to OURS\' blob', tfile, blob(ours, tfile)),
        (f'2. {ofile} (OURS alone changed it) set to THEIRS\' blob', ofile, blob(theirs, ofile)),
    ]
    if added:
        rec = added[-1]
        assert merged_ax.count(rec + '\n') == 1
        dropped = git('hash-object', '-w', '--stdin', inp=merged_ax.replace(rec + '\n', '', 1))
        doubled = git('hash-object', '-w', '--stdin', inp=merged_ax.replace(rec + '\n', rec + '\n' + rec + '\n', 1))
        plants += [(f'3. {AX} with the record `{rec}` dropped', AX, dropped), (f'4. {AX} with that record doubled', AX, doubled)]
    else:
        assert both, 'THEIRS added no record to scripts/Axioms.lean: give --both FILE'
        print(f'3, 4. not applicable: THEIRS added no record to {AX}')
    if both:
        assert len({blob(base, both), blob(ours, both), blob(theirs, both)}) == 3, 'not a file both sides changed'
        plants.append((f'5. {both} (both sides changed it) set to OURS\' blob', both, blob(ours, both)))
    for label, path, b in plants:
        rc, out = run(base, ours, theirs, planted_tree(real, path, b))
        fired = rc != 0 and path in out
        lines = [l for l in out.split('\n') if path in l][:2]
        print(f'{label}: exit {rc} -> {"FAILS naming it" if fired else "NOT CAUGHT"}')
        for l in lines:
            print('     ' + l[:220])
        ok &= fired
    print('PLANTS ' + ('OK: the unplanted merge passes and every plant fails naming its file' if ok else 'FAILED'))
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main())
