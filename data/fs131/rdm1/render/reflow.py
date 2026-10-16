"""Reflow Markdown paragraphs and list items to a width, never breaking inside `$…$` math or a `code span`.

Tables, fenced blocks, headings and blank lines pass through. Usage: python3 reflow.py FILE WIDTH (rewrites FILE).
"""
import re, sys

path, width = sys.argv[1], int(sys.argv[2])
lines = open(path, encoding='utf-8').read().split('\n')
ATOM = re.compile(r'(?:`[^`]*`|\$(?!\s)[^$\n]*?(?<!\s)\$|\S)+')

def wrap(first_prefix, cont_prefix, text):
    atoms = ATOM.findall(text)
    out, cur, pre = [], '', first_prefix
    marker = re.compile(r'^([-+*>]|\d+[.)])$')  # a line may not begin with what Markdown reads as a list or quote marker
    for a in atoms:
        cand = (cur + ' ' + a) if cur else a
        if cur and len(pre) + len(cand) > width:
            if marker.match(a) and ' ' in cur:
                head, last = cur.rsplit(' ', 1)
                out.append(pre + head); cur, pre = last + ' ' + a, cont_prefix
            else:
                out.append(pre + cur); cur, pre = a, cont_prefix
        else:
            cur = cand
    if cur: out.append(pre + cur)
    return out

res, i, fence = [], 0, False
while i < len(lines):
    l = lines[i]
    if l.startswith('```'):
        fence = not fence; res.append(l); i += 1; continue
    if fence or not l.strip() or l.startswith('|') or l.startswith('#') or l.startswith('>'):
        res.append(l); i += 1; continue
    m = re.match(r'^(\s*)([-*] |\d+\. )?', l)
    indent, bullet = m.group(1), m.group(2) or ''
    first = indent + bullet
    cont = indent + (' ' * len(bullet))
    body = [l[len(first):].strip()]
    j = i + 1
    while j < len(lines):
        n = lines[j]
        if (not n.strip() or n.startswith('```') or n.startswith('|') or n.startswith('#') or n.startswith('>')
                or re.match(r'^\s*([-*] |\d+\. )', n)):
            break
        body.append(n.strip()); j += 1
    res.extend(wrap(first, cont, ' '.join(body)))
    i = j
open(path, 'w', encoding='utf-8').write('\n'.join(res))
