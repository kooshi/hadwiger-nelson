"""FS132-F1 filing helpers: whitespace-tolerant, exactly-once replacement; draft extraction by script."""
import re, sys

def ws(s):
    return re.sub(r'\s+', ' ', s.strip())

def rx(s):
    return r'\s+'.join(re.escape(t) for t in s.split())

def find_once(text, old, label):
    ms = list(re.finditer(rx(old), text))
    assert len(ms) == 1, f'{label}: {len(ms)} matches for {old[:70]!r}'
    return ms[0]

def replace_once(text, old, new, label, log=None):
    m = find_once(text, old, label)
    if log is not None:
        log.append(f'{label}: 1 match, replaced ({len(m.group(0))} -> {len(new)} chars)')
    return text[:m.start()] + new + text[m.end():]

def insert_after(text, anchor, add, label, log=None):
    m = find_once(text, anchor, label)
    if log is not None:
        log.append(f'{label}: 1 anchor, inserted {len(add)} chars after')
    return text[:m.end()] + add + text[m.end():]

def replace_span(text, start, end, new, label, log=None):
    ms = find_once(text, start, label + ' [start]')
    me = re.search(rx(end), text[ms.start():])
    assert me, f'{label}: end not found {end[:60]!r}'
    # end must be the first occurrence after start; assert no other start between
    s0, e0 = ms.start(), ms.start() + me.end()
    if log is not None:
        log.append(f'{label}: span of {e0 - s0} chars replaced by {len(new)}')
    return text[:s0] + new + text[e0:]

def lines_of(path):
    return open(path, encoding='utf-8').read().split('\n')

def quotes(unit):
    return re.findall(r'"(.*?)"', unit, re.S)

def one_line(s):
    return ws(s)
