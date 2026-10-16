#!/usr/bin/env python3
"""D11, ROADMAP.md section 1: delete item 3 ("Row 128, the collapse.") and renumber items 4-6 to 3-5. Asserts each anchor once."""
from pathlib import Path
p=Path(__file__).resolve().parents[3]/'ROADMAP.md'; s=p.read_text()
i=s.index('3. **Row 128, the collapse.**'); assert s.count('3. **Row 128, the collapse.**')==1
j=s.index('4. **Theorems that take an open question as a hypothesis.**'); assert s.count('4. **Theorems that take an open question as a hypothesis.**')==1
print('deleting:\n'+s[i:j])
s=s[:i]+s[j:]
for a,b in [('4. **Theorems that take','3. **Theorems that take'),('5. **An outside theorem that a plane','4. **An outside theorem that a plane'),('6. **Every row 128–167 not graded wholly','5. **Every row 128–167 not graded wholly')]:
    assert s.count('\n'+a)==1,a; s=s.replace('\n'+a,'\n'+b)
p.write_text(s)
