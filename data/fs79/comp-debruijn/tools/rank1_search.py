import sys, time
from rank1_phases import analyse
found = []
for D0 in ([1, 5, 7, 10], [3, 5, 9, 10], [3, 7, 9, 10], [5, 7, 9, 10]):
    for d in range(11, int(sys.argv[1]) + 1):
        D = sorted(set(D0) | {d})
        t = time.time()
        r = analyse(D)
        allrigid = r['cyclic'] > 0 and r['rigid'] == r['cyclic']
        if allrigid and r['walls'] > 0:
            found.append(D); print('FOUND', D, r['states'], r['cyclic'], r['walls'], flush=True)
        elif r['cyclic'] > 0 and r['rigid'] == r['cyclic']:
            print('allrigid-nowall', D, r['cyclic'])
    print('done', D0, flush=True)
print('found', found)
