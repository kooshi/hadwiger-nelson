#!/usr/bin/env python3
"""CL3: counts from lines.tsv.  Usage: cl3_counts.py DIR"""
import sys, os, csv, collections, re
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cl3_classify import jobinfo
d = sys.argv[1]
rows = list(csv.DictReader(open(os.path.join(d, 'lines.tsv')), delimiter='\t'))
C = collections.Counter
def tab(key):
    t = collections.defaultdict(C)
    for r in rows: t[key(r)][r['class']] += 1
    return t
def show(title, t):
    print('###', title)
    print('| key | R | O | N | U | total |'); print('|---|---|---|---|---|---|')
    for k in sorted(t): c = t[k]; print('| %s | %d | %d | %d | %d | %d |' % (k, c['R'], c['O'], c['N'], c['U'], sum(c.values())))
print('TOTAL', dict(C(r['class'] for r in rows)), len(rows))
print('MIXED O (also names a result)', sum(1 for r in rows if r['class'] == 'O' and r['mixed']), 'of', sum(1 for r in rows if r['class'] == 'O'))
print('O flagged nonban?', sum(1 for r in rows if r['class'] == 'O' and r['cause_flag']))
print('AFTER 10-01', dict(C(r['class'] for r in rows if r['after_1001'])))
print('O with candidates', sum(1 for r in rows if r['class'] == 'O' and r['candidates']))
show('by milestone', tab(lambda r: jobinfo(r['file'])[1].split('/')[0] if r['file'].startswith('plans/') else 'data:' + r['file'].split('/')[1]))
show('by job kind', tab(lambda r: jobinfo(r['file'])[2]))
show('by job date', tab(lambda r: r['job_date']))
jobs = collections.defaultdict(C)
for r in rows: jobs[r['file']][r['class']] += 1
print('RECORDS with a log (units):', len(jobs), '; with >=1 O:', sum(1 for j in jobs.values() if j['O']), '; with all N:', sum(1 for j in jobs.values() if set(j) == {'N'}))
print('RECORDS-with-log by kind:', dict(C(jobinfo(f)[2] for f in jobs)), 'with O:', dict(C(jobinfo(f)[2] for f, j in jobs.items() if j['O'])))
