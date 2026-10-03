"""Fill {{Q:<file>|<heading>|<bullet id>}} placeholders in a brief template with the bullet quoted whole, as a blockquote with its source line."""
import re, sys
def bullet(path, heading, bid):
    s = open(path).read()
    i = s.index('\n## ' + heading) if ('\n## ' + heading) in s else s.index('\n### ' + heading)
    j = s.find('\n## ', i + 5)
    sec = s[i:j if j > 0 else len(s)]
    k = sec.index('- **' + bid + '**')
    rest = sec[k:]
    m = re.search(r'\n(?=- \*\*|\n)', rest[2:])
    item = rest[: (m.start() + 2) if m else len(rest)].rstrip('\n')
    out = ['> ' + l for l in item.split('\n')]
    out.append('> — source: ' + path + ' § ' + heading)
    return '\n'.join(out)
t = open(sys.argv[1]).read()
t = re.sub(r'\{\{Q:([^|]+)\|([^|]+)\|([^}]+)\}\}', lambda m: bullet(m.group(1), m.group(2), m.group(3)), t)
open(sys.argv[2], 'w').write(t)
