#!/usr/bin/env python3
"""FS131-PV1: privacy check over a commit range.
usage: check.py RANGE SCRATCH GUARD_CMD...   (guard command is given as the remaining args; files are appended)
Writes file versions and messages under SCRATCH, runs the guard in batches, prints counts.
Refusals are reported as (commit, path, line) only; guard's raw output stays in SCRATCH."""
import subprocess, sys, os, re, collections, json

rng, scratch, *guard = sys.argv[1:]
repo = os.getcwd()
FNAME = re.compile(r'(^|/)(\.env|auth\.json|id_[^/]*|[^/]*\.pem|[^/]*\.key|[^/]*\.jsonl)$')

def git(*a, text=True):
    r = subprocess.run(['git', *a], capture_output=True, text=text)
    if r.returncode != 0:
        sys.exit('git failed: %s rc=%d' % (a, r.returncode))
    return r.stdout

commits = git('rev-list', '--reverse', rng).split()
os.makedirs(scratch, exist_ok=True)
fdir = os.path.join(scratch, 'files'); mdir = os.path.join(scratch, 'msgs')
os.makedirs(fdir, exist_ok=True); os.makedirs(mdir, exist_ok=True)

idents = collections.Counter(); nontext = []; large = []; names = []; skipped = []
fmap = {}   # scratch file -> (commit, path)
n = 0
LIM = 10 * 1024 * 1024
for c in commits:
    a = git('log', '-1', '--format=%an <%ae>%x00%cn <%ce>', c).strip().split('\0')
    idents['author: ' + a[0]] += 1; idents['committer: ' + a[1]] += 1
    mp = os.path.join(mdir, c + '.msg')
    with open(mp, 'w') as f: f.write(git('log', '-1', '--format=%B', c))
    fmap[mp] = (c, '<commit message>')
    out = subprocess.run(['git', 'diff-tree', '--no-commit-id', '-r', '-z', '-m', '--root',
                          '--diff-filter=AM', '--raw', '--no-abbrev', c], capture_output=True)
    if out.returncode != 0: sys.exit('diff-tree failed ' + c)
    toks = out.stdout.split(b'\0'); i = 0; seen = set()
    while i + 1 < len(toks):
        meta = toks[i].decode(); path = toks[i + 1].decode('utf-8', 'surrogateescape'); i += 2
        mode, sha = meta.split()[1], meta.split()[3]
        if (path, sha) in seen: continue
        seen.add((path, sha))
        if FNAME.search(path) or 'chats-bak' in path.split('/'):
            names.append((c, path)); continue          # never opened
        if mode == '160000':
            skipped.append((c, path, 'submodule')); continue
        blob = subprocess.run(['git', 'cat-file', 'blob', sha], capture_output=True).stdout
        if len(blob) > LIM: large.append((c, path, len(blob)))
        if b'\0' in blob[:8192] or b'\0' in blob:
            nontext.append((c, path, len(blob), 'binary(NUL)')); continue
        try: blob.decode('utf-8')
        except UnicodeDecodeError:
            nontext.append((c, path, len(blob), 'not utf-8')); continue
        n += 1
        sp = os.path.join(fdir, 'f%06d' % n)
        with open(sp, 'wb') as f: f.write(blob)
        fmap[sp] = (c, path)

files = sorted(fmap)
refusals = []; summaries = []
for k in range(0, len(files), 400):
    batch = files[k:k + 400]
    r = subprocess.run(guard + batch, capture_output=True, text=True)
    with open(os.path.join(scratch, 'guard-%03d.out' % (k // 400)), 'w') as f:
        f.write(r.stdout + '\n--stderr--\n' + r.stderr + '\nrc=%d\n' % r.returncode)
    m = re.search(r'guard: (\d+) files, (\d+) refusals', r.stdout)
    summaries.append((len(batch), int(m.group(1)) if m else None, int(m.group(2)) if m else None, r.returncode))
    for line in r.stdout.splitlines():
        for sp in batch:
            if sp in line:
                ln = re.search(re.escape(sp) + r':(\d+)', line)
                refusals.append((fmap[sp][0], fmap[sp][1], ln.group(1) if ln else '?'))
                break

print('range', rng, 'commits', len(commits))
print('text file versions passed', n, 'messages passed', len(commits))
print('non-text', len(nontext), 'skipped', len(skipped), 'large(>10MB)', len(large), 'name matches', len(names))
print('guard batches (sent, reported files, refusals, rc):', summaries)
print('guard total refusals:', sum(s[2] or 0 for s in summaries), 'parsed refusal lines:', len(refusals))
print('identities:'); [print('  ', v, k) for k, v in sorted(idents.items())]
json.dump({'nontext': nontext, 'skipped': skipped, 'large': large, 'names': names, 'refusals': refusals,
           'summaries': summaries, 'idents': idents}, open(os.path.join(scratch, 'result.json'), 'w'), indent=1)
for t in nontext: print('NONTEXT', t[0][:9], t[1], t[2], t[3])
for t in skipped: print('SKIPPED', t[0][:9], t[1], t[2])
for t in large: print('LARGE', t[0][:9], t[1], t[2])
for t in names: print('NAME', t[0][:9], t[1])
for t in refusals: print('REFUSAL', t[0][:9], t[1], 'line', t[2])
