# FS116-O1 readback: every quotation in the brief, searched verbatim (whitespace-normalised) in its source.
import re,sys
def norm(s): return re.sub(r'\s+',' ',s.replace('\n> ',' ').replace('\n',' ')).strip()
Q=[("CLAUDE.md","My goal is to fully solve, and then verify in Lean, HN. Then we publish."),
("plans/STUB-local-exclusion.md","**Is there a radius `R` — one `R` for every complexity, Siamese pairs allowed — such that no valid fragment exists on the closed disc of radius `R` about a vertex of at least four colours?**"),
("plans/STUB-local-exclusion.md","**In every valid fragment with any number `k ≥ 4` of colours, what does the unit circle about each vertex of at least four colours carry — its (Q) arcs, its change points, and the vertices of at least four colours it places at distance 1 — and which of these ring types can recur at every such vertex a ring places?**"),
("plans/STUB-local-exclusion.md","a check at the §IQ, under an hour"),
("plans/STUB-local-exclusion.md","an hour to one round"),
("plans/STUB-local-exclusion.md","to be told the answer"),
("plans/FS114-derivation.md","each with four tactic edges (`n = 0`, charge −2)"),
("plans/FS114-derivation.md","the strip's midline vertices as deficient vertices"),
("plans/FS114-N-proof.md","midline vertices `n = 4` (four straight edges)"),
("data/fs114/claims.md","tactic edge"),
("plans/FS114-N-proof.md","a **tactic edge** is an edge of the map"),
]
bad=0
for f,q in Q:
    t=norm(open(f).read()); ok=norm(q) in t
    print(("FOUND    " if ok else "NOTFOUND ")+f+" :: "+q[:70]); bad+= not ok
# plant: one word changed must not be found
pl=norm("My goal is to fully solve, and then verify in Lean, HN. Then we publish it.")
print("PLANT", "FIRES (not found)" if pl not in norm(open("CLAUDE.md").read()) else "DEAD")
for f,pat in [("plans/FS114-derivation.md","four tactic edges (`n = 0`"),("plans/FS114-derivation.md","deficient vertices"),("plans/FS114-N-proof.md","`n = 4` (four straight edges)")]:
    for i,l in enumerate(open(f),1):
        if pat in l: print("LINE",f,i)
