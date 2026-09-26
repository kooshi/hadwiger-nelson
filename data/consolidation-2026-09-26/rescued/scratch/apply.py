#!/usr/bin/env python3
"""J55: apply FS-100's drafts (J53b) then FS-75's (J54), with the owner's rulings, to CLAUDE.md / LEDGER.md /
plans/FRONTIER-STUBS.md. Every anchor must occur exactly once at the moment it is applied.

    python3 apply.py --out DIR [--files CLAUDE.md,LEDGER.md,...]   # write results to DIR (dry run)
    python3 apply.py --inplace --files LEDGER.md                    # write in place (only the named files)
"""
import importlib.util
import re
import sys
from pathlib import Path

ROOT = Path("/home/kooshi/source/lean-dir")


def load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


fs75 = load("fs75drafts", ROOT / "data/fs75/j54/front_page_drafts.py")  # imports J53's as fs75.fs100
fs100 = fs75.fs100
assert Path(fs100.__file__).resolve() == (ROOT / "data/fs100/j53/front_page_drafts.py").resolve(), fs100.__file__


def override(drafts, name, old=None, new=None):
    out, hit = [], 0
    for n, o, w in drafts:
        if n == name:
            hit += 1
            out.append((n, old if old is not None else o, new if new is not None else w))
        else:
            out.append((n, o, w))
    assert hit == 1, name
    return out


# --- FS-75's drafts, adjusted by the owner's rulings and the brief ---------------------------------------------------
F75_CLAUDE = override(
    fs75.CLAUDE, "Last updated — FS-75's close (after FS-100's clause)",
    new="(`plans/FS100-three-field-lemma.md` §R-close), and FS-75's minimal instance (row 119) — **Paid (kernel)** "
        "(`plans/FS75-kernel-167.md` §R-close).")  # brief item 4: one sentence of current state
F75_LEDGER = override(
    fs75.LEDGER, "the claim list — Ours (the owner's call; stage 5's decision 5b)",
    new="on its solenoid (row 118); the winding form of the three-colour criterion's ⟹ as a `Θ₃` certificate's semantics, "
        "and the certificate's kernel checker (row 119; as far as the gate reached; its ingredients are in print);")  # owner note 2

# --- the owner's ruling on --dupes (a): item 27 orients and points, never retells row 116's mechanism -----------------
FS100_CLAUDE = override(
    fs100.CLAUDE, "item 27 — Kronecker windows at four colours (row 116)",
    new="over ℚ(√167) lives at nine places; nothing touches `χ_µ(ℝ²)`. **Kronecker windows at four colours** (row 116; "
        "FS-100): the selection onto `T + A` is false as stated; at ℚ(√47) its `E`-form is the five-clause's pure-point layer, "
        "open at one density step.")

# --- the owner's ruling on --dupes (b): a § B line keeps what it must carry, and the row keeps the full sentence ------
B_SHORTEN = [
    ("FS100-X1",
     "is FALSE: over ℚ, `Θ = (τ + ψ_w, τ + ψ_w̄)` at 5 with `W = 2⌊2t₁⌋ + ⌊2t₂⌋`; every field",
     "is FALSE: parity times the cross at the two primes above 5, over ℚ (row 116's `Θ` and `W`); every field"),
    ("FS100-EQ",
     "X proved for `Θ ∈ Eⁿ` and `n = 1`, open for `n ≥ 2` off `E`",
     "X proved in rank one and inside `Eⁿ`; open off `E` from rank two"),
    ("FS100-R",
     "KS-sat_E ⟺ density of `Φ(N)` for off-`E` families on neighbourhoods of 1 in `U`; stopped at",
     "KS-sat_E ⟺ row 116's density statement for off-`E` families; stopped at"),
    ("FS100-T2",
     "no finitely generated `Γ ⊂ U_F` acts irreducibly on the solenoid `R̂` (`R/ℤ[Γ]` infinite), so EL's Thm 1.2 never applies",
     "`R/ℤ[Γ]` is infinite for every finitely generated `Γ ⊂ U_F`, so none acts irreducibly on `R̂` and EL's Thm 1.2 never applies"),
    ("FS75-W",
     "carries an additive `W` on the relation lattice with `Σ_j min(r_j, 2r_j) ≤ 3W(r)`; no averaging",
     "carries a winding (row 119's additive `W` and its inequality); no averaging"),
]

# --- J55's own edits (brief items 3, 4; the row-range pointer) ------------------------------------------------------
J55_CLAUDE = [
    ("Open milestones — FS-100's in-ban round closed (brief item 4)",
     "FS-75's minimal instance (row 119; `plans/FS75-derivation.md`; the stub re-aimed); row 88's question",
     "FS-75's minimal instance, `χ(ℚ(√167)²) ≥ 4` in the kernel (row 119; `plans/FS75-derivation.md`; the stub re-aimed); "
     "FS-100's in-ban round (rows 116–118; `plans/FS100-derivation.md`; stage 4 re-aimed as 4′, which leads its next slot; "
     "the stub re-aimed); row 88's question"),
    ("The ledger pointer — rows 1–119",
     "**Rows 1–115 live in `LEDGER.md`**",
     "**Rows 1–119 live in `LEDGER.md`**"),
]

ESCAPE_ROWS = ("| 75 |", "| 76 |", "| 78 |", "| 80 |", "| 85 |", "| 86 |", "| FS66-L1 |", "| M3-J22-T8 |")


def escape_code_pipes(line):
    parts = line.split("`")
    for i in range(1, len(parts), 2):  # odd pieces are inside code spans
        parts[i] = re.sub(r"(?<!\\)\|", r"\\|", parts[i])
    return "`".join(parts)


def apply(text, drafts, label):
    for name, old, new in drafts:
        n = text.count(old)
        if n != 1:
            raise SystemExit(f"FAIL [{label}] {name}: anchor found {n}x")
        text = text.replace(old, new, 1)
        print(f"  ok [{label}] {len(new.encode()) - len(old.encode()):+6d} B  {name}")
    return text


def do_claude(text):
    text = apply(text, FS100_CLAUDE, "FS-100")
    text = apply(text, F75_CLAUDE, "FS-75")
    text = apply(text, J55_CLAUDE, "J55")
    return text


def do_ledger(text):
    text = apply(text, fs100.LEDGER, "FS-100")
    text = apply(text, F75_LEDGER, "FS-75")
    lines = text.split("\n")
    hits = 0
    for i, l in enumerate(lines):
        if l.startswith(ESCAPE_ROWS):
            new = escape_code_pipes(l)
            if new != l:
                hits += 1
                print(f"  ok [J55] escaped {new.count(chr(92) + '|') - l.count(chr(92) + '|')} pipe(s) in {l[:14]!r}")
            lines[i] = new
    assert hits == 8, hits
    text = "\n".join(lines)
    b100 = (ROOT / "data/fs100/j53/ledger-b-draft.md").read_text(encoding="utf-8").strip()
    b75 = (ROOT / "data/fs75/j54/ledger-b-draft.md").read_text(encoding="utf-8").strip()
    block = b100 + "\n" + b75
    for cid, old, new in B_SHORTEN:
        line = next(l for l in block.split("\n") if l.startswith(f"| {cid} |"))
        assert line.count(old) == 1, cid
        block = block.replace(line, line.replace(old, new, 1), 1)
        print(f"  ok [owner (b)] {len(new.encode()) - len(old.encode()):+6d} B  § B {cid} shortened")
    text = text.rstrip("\n") + "\n" + block + "\n"
    print(f"  ok [FS-100+FS-75] appended {len(b100.splitlines())} + {len(b75.splitlines())} § B lines")
    return text


def do_stubs(text):
    return apply(text, fs75.STUBS, "FS-75")


DO = {"CLAUDE.md": do_claude, "LEDGER.md": do_ledger, "plans/FRONTIER-STUBS.md": do_stubs}

if __name__ == "__main__":
    args = sys.argv[1:]
    files = args[args.index("--files") + 1].split(",") if "--files" in args else list(DO)
    inplace = "--inplace" in args
    out = Path(args[args.index("--out") + 1]) if "--out" in args else None
    assert inplace != (out is not None)
    for f in files:
        src = (ROOT / f).read_text(encoding="utf-8")
        res = DO[f](src)
        dst = (ROOT / f) if inplace else out / Path(f).name
        dst.write_text(res, encoding="utf-8")
        print(f"{f}: {len(src.encode()):,} -> {len(res.encode()):,} bytes ({len(res.encode()) - len(src.encode()):+,}) -> {dst}")
