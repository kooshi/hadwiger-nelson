"""Render a GitHub-flavoured Markdown file to HTML close to GitHub's README view, with its math.

Math is lifted out before Markdown runs (as GitHub does: `$…$` inline, ```math blocks) and handed to MathJax 3; the page
uses github-markdown-css. Usage: python3 render.py IN.md OUT.html. A local approximation of GitHub's renderer, not it.
"""
import html, re, sys
import markdown

src = open(sys.argv[1], encoding='utf-8').read()
store = []

def keep(tex, display):
    store.append(('\\[' + tex + '\\]') if display else ('\\(' + tex + '\\)'))
    return f'@@MATH{len(store) - 1}@@'

# display blocks first
src = re.sub(r'```math\n(.*?)\n```', lambda m: '\n<div class="mathblock">' + keep(m.group(1), True) + '</div>\n', src, flags=re.S)
# protect code spans and fenced code so their dollars stay literal
code = []
def keepcode(m):
    code.append(m.group(0)); return f'@@CODE{len(code) - 1}@@'
src = re.sub(r'```.*?```', keepcode, src, flags=re.S)
src = re.sub(r'`[^`\n]+`', keepcode, src)
# inline math: $…$ with no space just inside the dollars
src = re.sub(r'(?<![\\$])\$(?!\s)([^$\n]+?)(?<!\s)\$(?!\$)', lambda m: keep(m.group(1).replace('\\|', '|'), False), src)
for i, c in enumerate(code):
    src = src.replace(f'@@CODE{i}@@', c)
body = markdown.markdown(src, extensions=['tables', 'fenced_code', 'sane_lists'])
for i, m in enumerate(store):
    body = body.replace(f'@@MATH{i}@@', html.escape(m, quote=False))
page = f'''<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.5.1/github-markdown-light.min.css">
<style>body{{margin:0;background:#fff}} .markdown-body{{box-sizing:border-box;max-width:1012px;margin:0 auto;padding:16px}}
.markdown-body table{{display:block;width:max-content;max-width:100%;overflow:auto}} .mathblock{{overflow-x:auto;margin:0 0 16px}}</style>
<script>window.MathJax={{tex:{{inlineMath:[['\\\\(','\\\\)']],displayMath:[['\\\\[','\\\\]']]}},svg:{{fontCache:'global'}}}};</script>
<script src="https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-svg.js"></script>
</head><body><article class="markdown-body">{body}</article></body></html>'''
open(sys.argv[2], 'w', encoding='utf-8').write(page)
print('math segments:', len(store))
