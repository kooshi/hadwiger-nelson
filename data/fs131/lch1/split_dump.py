#!/usr/bin/env python3
"""FS131-LCH1: split a dump of data/fs131/lch1/lean/StatementDump.lean into what is committed:
<out>.index.tsv — one row per constant: module, kind, name, flags, type hash, value hash, data hash (every module);
<out>.full.txt — every line of the FULL-mode modules (stored types, values, data as text).
Usage: split_dump.py <dump.txt> <out-prefix>"""
import sys
src, pre = sys.argv[1], sys.argv[2]
idx = open(pre + '.index.tsv', 'w', encoding='utf-8'); full = open(pre + '.full.txt', 'w', encoding='utf-8')
mod, mode, row, n, nfull = None, None, None, 0, 0
def flush():
    global row, n
    if row: idx.write('\t'.join(row) + '\n'); n += 1
    row = None
for ln in open(src, encoding='utf-8', errors='replace'):
    if ln.startswith('## MODULE '):
        flush(); p = ln.split(); mod, mode = p[2], p[4].split('=')[1]
        if mode == 'FULL': full.write(ln)
        continue
    if ln.startswith('## END'):
        flush(); full.write(ln); idx.write('#' + ln); continue
    if mode == 'FULL': full.write(ln)
    if ln.startswith('@@ '):
        flush(); p = ln.rstrip('\n').split(' ')
        row = [mod, p[1], p[2], ' '.join(p[3:]), '', '', '']
        if mode == 'FULL': nfull += 1
    elif ln.startswith('TYPE '): row[4] = ln.split(' ', 2)[1]
    elif ln.startswith('VALUE '): row[5] = ln.split(' ', 2)[1].strip()
    elif ln.startswith('DATA '): row[6] = ln.split(' ', 2)[1].strip()
flush()
print(f'{src}: {n} constants indexed, {nfull} in FULL modules')
