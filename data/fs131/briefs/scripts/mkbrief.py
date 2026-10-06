import re,sys
ROOT="/home/kooshi/source/lean-dir/"
WT=ROOT+".claude/worktrees/"
INV="plans/FS131-close-inventory.md"
def line(path,prefix,contains=None):
    full=path if path.startswith("/") else ROOT+path
    ls=[l.rstrip("\n") for l in open(full)]
    c=[l for l in ls if l.startswith(prefix) and (contains is None or contains in l)]
    assert len(c)==1,(path,prefix,len(c))
    return c[0]
def Q(path,prefix,heading=None,contains=None):
    l=line(path,prefix,contains)
    return "> "+l+"\n> — source: "+path+((" "+heading) if heading else "")+"\n"
def item(n):
    return Q(INV,f"{n}. ")
KOOSHI='''> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)
'''
IDENT="de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)"
FENCE="none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)"
STAND="plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail"
BUDGET="about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage"
MACHINE='''## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
'''
NOSPAWN="You start no agents of your own (standing rule 1: delegation is one level\ndeep, because the coordinator can only review work it knows exists)."
