#!/usr/bin/env python3
"""FS131-T4: the experiment — what Lean v4.32.0 does with one name declared by two modules.

The scratch package is `data/fs131/t4/exp/` (its own Lake package on the repository's toolchain, core Lean only, nothing under
`Proofs/`). This tool writes it from the scenario table below, builds its leaf modules, elaborates every consumer, and writes what
Lean printed: one file per consumer under `data/fs131/t4/exp-out/`, and the table `data/fs131/t4/experiment-table.md`.

A scenario `Sn` is two sibling modules `T4Exp.Sn.A` and `T4Exp.Sn.B` (neither imports the other; both import `T4Exp.Base`), each
declaring the probed name in namespace `T4.Sn`, and these consumers:

  OnlyA, OnlyB        import one sibling                — the partners: what each copy prints when it stands alone
  TopAB, TopBA        import both, in each order        — declare `down`, a theorem that uses the name, and print its axioms
  UseA, UseB          import one sibling, declare `useA` / `useB` using the name (built as modules: they are imported below)
  UseA_B, B_UseA      import UseA and B, in each order  — print the axioms of `useA`, compiled against A's copy alone
  UseB_A, A_UseB      import UseB and A, in each order  — the same for `useB`
  UpAB, UpBA          import one sibling and write the other's declarations in the file itself — "one module upstream of the
                      other"; `#t4locals` then prints what the file did declare

Every consumer imports `T4Exp.Probe` first, whose `#t4probe` prints, from the environment's own data: every module whose compiled
data declares the name (in import order, with its kind and the constants its value uses — each clean copy's proof is a marker
theorem named for its module, so a copy is identified by what it uses); which copy the environment holds; the module the
environment attributes the name to (`Environment.getModuleIdxFor?`); the axioms `collectAxioms` reports for the name (what
`#print axioms` prints); and the axioms of the value the environment actually holds (collected through the constants it uses).

Usage:  python3 tools/fs131_t4_experiment.py            write the package, run everything, write the outputs and the table
        python3 tools/fs131_t4_experiment.py --check    re-run and compare with the committed outputs and table (exit 1 on a difference)
        python3 tools/fs131_t4_experiment.py --plant    the control of the tool's own checks: two faults planted in the probe, each
                                                        in a scratch copy of the package (S1 and S2 only), each watched to be
                                                        caught by the check written for it; exit 0 iff both are
Run it under the slot (`scripts/slot.py --mem 4 --cpus 4 -- python3 tools/fs131_t4_experiment.py`): about a minute.

The tool's own checks (it exits 1 if any fails; each is printed):
  * the leaf modules build; a consumer expected to elaborate does, one expected to fail does, with the expected text;
  * the instrument's partners: `OnlyA` and `OnlyB` each report exactly one declaring module, that module's copy held, and the two
    axiom readings equal — so a disagreement between them in a `Top` row comes from the pair and not from the probe;
  * in the `sorry` scenario the probe's "axioms of the held value" contains `sorryAx` exactly when the held copy is the `sorry` one.
"""
import pathlib
import re
import shutil
import subprocess
import sys

REPO = pathlib.Path(__file__).resolve().parent.parent
T4 = REPO / "data/fs131/t4"
PKG = T4 / "exp"
OUT = T4 / "exp-out"
TABLE = T4 / "experiment-table.md"

STMT = "2 + 2 = 4"


def clean(m, stmt=STMT, proof="rfl"):
    return f"theorem mark{m} : {stmt} := {proof}\ntheorem dup : {stmt} := mark{m}\n"


# id, the brief's row, A's declarations, B's declarations, the probed name (in T4.<id>), the statement and term a consumer of A's
# copy / of B's copy / of the merged environment writes, and whether an environment importing both is expected to exist.
SCENARIOS = [
    dict(id="S1", row="(i) both clean", A=clean("A"), B=clean("B"), merge=True),
    dict(id="S2", row="(ii) A is `sorry`, B clean", A=f"theorem dup : {STMT} := sorry\n", B=clean("B"), merge=True),
    dict(id="S3", row="(iii) A rests on a declared `axiom`, B clean",
         A=f"axiom axA : {STMT}\ntheorem dup : {STMT} := axA\n", B=clean("B"), merge=True),
    dict(id="S4", row="(iv) A is an `axiom` of the name and type, B a theorem", A=f"axiom dup : {STMT}\n", B=clean("B"), merge=True),
    dict(id="S5", row="(v) the types differ", A=clean("A"), B=clean("B", f"{STMT} ∧ True", "⟨rfl, trivial⟩"),
         stmtB=f"{STMT} ∧ True", merge=False),
    dict(id="S6", row="both are `axiom`s of the name and type", A=f"axiom dup : {STMT}\n", B=f"axiom dup : {STMT}\n", merge=True),
    dict(id="S7", row="A is by `native_decide`, B clean", A=f"theorem dup : {STMT} := by native_decide\n", B=clean("B"), merge=True),
    dict(id="S8", row="one type up to bound-variable names",
         A="theorem markA : ∀ n : Nat, n + 0 = n := fun _ => rfl\ntheorem dup (n : Nat) : n + 0 = n := markA n\n",
         B="theorem markB : ∀ m : Nat, m + 0 = m := fun _ => rfl\ntheorem dup (m : Nat) : m + 0 = m := markB m\n",
         stmt="∀ k : Nat, k + 0 = k", merge=True),
    dict(id="S9", row="a `Prop`-valued instance under its generated name",
         A="instance : Nonempty Tok := ⟨.a⟩\n", B="instance : Nonempty Tok := ⟨.b⟩\n",
         name="instNonemptyTok", stmt="Nonempty Tok", use="inferInstance", merge=True, up_elab=True),
    dict(id="S10", row="a data-valued instance under its generated name, one body",
         A="instance : Inhabited Tok := ⟨.a⟩\n", B="instance : Inhabited Tok := ⟨.a⟩\n",
         name="instInhabitedTok", stmt="Inhabited Tok", use="inferInstance", kind="def", merge=False, up_elab=True),
    dict(id="S11", row="two `def`s of one name, type and body", A="def dup : Nat := 4\n", B="def dup : Nat := 4\n",
         stmt="Nat", use="dup", kind="def", merge=False),
    dict(id="S12", row="an equation lemma Lean generates on demand (`T4.fn.eq_1`), asked for in both",
         A="theorem askA : T4.fn 0 = 1 := T4.fn.eq_1\n", B="theorem askB : T4.fn 0 = 1 := T4.fn.eq_1\n",
         name="_root_.T4.fn.eq_1", stmt="T4.fn 0 = 1", use="T4.fn.eq_1", merge=True, up_elab=True),
]
for s in SCENARIOS:
    s.setdefault("name", "dup")
    s.setdefault("stmt", STMT)
    s.setdefault("stmtA", s["stmt"])
    s.setdefault("stmtB", s["stmt"])
    s.setdefault("use", "dup")
    s.setdefault("kind", "theorem")
    # Whether the "one module upstream" files are expected to elaborate: an anonymous instance declared over an imported one gets
    # a fresh generated name, and a generated equation lemma already imported is simply used — neither is a redeclaration.
    s.setdefault("up_elab", False)
    s["full"] = s["name"][len("_root_."):] if s["name"].startswith("_root_.") else f"T4.{s['id']}.{s['name']}"

BASE = """/-! FS131-T4's scratch package: what the scenarios share. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4

/-- A two-element type for the instance scenarios. -/
inductive Tok where
  | a
  | b

/-- A recursive function, so that Lean generates its equation lemmas on demand (`T4.fn.eq_1`). -/
def fn : Nat → Nat
  | 0 => 1
  | n + 1 => fn n

end T4
"""

PROBE = r"""import Lean
/-! FS131-T4's probe: what the environment holds for a name, read from the environment's own data.
Written by `tools/fs131_t4_experiment.py`. -/
open Lean Elab Command

namespace T4Exp

/-- The kind of a constant, as the kernel holds it. -/
def kindOf : ConstantInfo → String
  | .axiomInfo _ => "axiom" | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .opaqueInfo _ => "opaque"
  | .quotInfo _ => "quot" | .inductInfo _ => "inductive" | .ctorInfo _ => "constructor" | .recInfo _ => "recursor"

/-- The value of a constant that has one. -/
def valueOf? : ConstantInfo → Option Expr
  | .thmInfo v => some v.value | .defnInfo v => some v.value | .opaqueInfo v => some v.value | _ => none

/-- The constants a copy's value uses, sorted (an axiom: none). -/
def usesOf (ci : ConstantInfo) : Array Name :=
  ((valueOf? ci).map (·.getUsedConstants)).getD #[] |>.qsort Name.lt

/-- Two constants are one copy: same kind, type and value. -/
def sameCopy (a b : ConstantInfo) : Bool :=
  kindOf a == kindOf b && a.type == b.type && valueOf? a == valueOf? b

/-- Every (module, constant) whose compiled data declares `n`, in import order. -/
def copies (env : Environment) (n : Name) : Array (Name × ConstantInfo) := Id.run do
  let mut out := #[]
  for m in env.header.moduleNames, d in env.header.moduleData do
    for cn in d.constNames, ci in d.constants do
      if cn == n then out := out.push (m, ci)
  return out

/-- `#t4probe n`: one `PROBE` line per fact about `n`. A name no module declares is an error, never an empty report. -/
elab "#t4probe " id:ident : command => do
  let env ← getEnv
  let n := id.getId
  let cs := copies env n
  if cs.isEmpty then throwError "#t4probe: no imported module declares {n}"
  let some held := env.find? n | throwError "#t4probe: the environment holds no {n}"
  -- Strings, never `m!`: a formatted message wraps a long list across lines, and these lines are parsed.
  let show_ (xs : Array Name) : String := "[" ++ ", ".intercalate (xs.toList.map toString) ++ "]"
  for (m, ci) in cs do
    logInfo s!"PROBE {n} DECLARED-BY {m} kind={kindOf ci} uses={show_ (usesOf ci)}"
  let from_ := cs.filter (fun p => sameCopy p.2 held) |>.map (·.1)
  logInfo s!"PROBE {n} ENV-HOLDS kind={kindOf held} uses={show_ (usesOf held)} copy-of={show_ from_}"
  match (env.getModuleIdxFor? n).bind fun i => env.header.moduleNames[i.toNat]? with
  | some m => logInfo s!"PROBE {n} ATTRIBUTED-TO {m}"
  | none => logInfo s!"PROBE {n} ATTRIBUTED-TO none"
  let printed ← collectAxioms n
  logInfo s!"PROBE {n} AXIOMS-PRINTED {show_ (printed.qsort Name.lt)}"
  let mut real : NameSet := {}
  if held.isAxiom then real := real.insert n
  for c in usesOf held do
    for a in (← collectAxioms c) do real := real.insert a
  logInfo s!"PROBE {n} AXIOMS-OF-HELD-VALUE {show_ (real.toArray.qsort Name.lt)}"

/-- `#t4locals`: the constants the file itself has declared so far, on one `LOCALS` line. -/
elab "#t4locals" : command => do
  let env ← getEnv
  let ns := env.constants.map₂.toList.map (·.1) |>.toArray.qsort (fun a b => a.toString < b.toString)
  logInfo s!"LOCALS [{", ".intercalate (ns.toList.map toString)}]"

end T4Exp
"""


def files():
    """path (relative to the package) -> text, for every file of the package."""
    f = {
        "lean-toolchain": (REPO / "lean-toolchain").read_text(),
        "lakefile.toml": 'name = "t4exp"\ndefaultTargets = []\n\n[[lean_lib]]\nname = "T4Exp"\n',
        "T4Exp/Base.lean": BASE,
        "T4Exp/Probe.lean": PROBE,
    }
    for s in SCENARIOS:
        d, ns, full = f"T4Exp/{s['id']}", f"T4.{s['id']}", s["full"]
        hdr = f"/-! FS131-T4 scenario {s['id']}: {s['row']}. Written by `tools/fs131_t4_experiment.py`. -/\n"

        def mod(imports, body, probe=True):
            imp = "".join(f"import {i}\n" for i in (["T4Exp.Probe"] if probe else []) + imports)
            return imp + hdr + body

        def inns(text):
            return f"namespace {ns}\nopen T4\n{text}end {ns}\n"

        def use(nm, stmt):
            return f"theorem {nm} : {stmt} := {s['use']}\n" if s["kind"] == "theorem" else f"def {nm} : {stmt} := {s['use']}\n"

        A, B = f"T4Exp.{s['id']}.A", f"T4Exp.{s['id']}.B"
        UA, UB = f"T4Exp.{s['id']}.UseA", f"T4Exp.{s['id']}.UseB"
        f[f"{d}/A.lean"] = mod(["T4Exp.Base"], inns(s["A"]), probe=False)
        f[f"{d}/B.lean"] = mod(["T4Exp.Base"], inns(s["B"]), probe=False)
        f[f"{d}/UseA.lean"] = mod([A], inns(use("useA", s["stmtA"])), probe=False)
        f[f"{d}/UseB.lean"] = mod([B], inns(use("useB", s["stmtB"])), probe=False)
        probe = f"#t4probe {full}\n"
        f[f"{d}/OnlyA.lean"] = mod([A], probe + inns(use("down", s["stmtA"])) + f"#print axioms {ns}.down\n")
        f[f"{d}/OnlyB.lean"] = mod([B], probe + inns(use("down", s["stmtB"])) + f"#print axioms {ns}.down\n")
        f[f"{d}/TopAB.lean"] = mod([A, B], probe + inns(use("down", s["stmt"])) + f"#print axioms {ns}.down\n")
        f[f"{d}/TopBA.lean"] = mod([B, A], probe + inns(use("down", s["stmt"])) + f"#print axioms {ns}.down\n")
        f[f"{d}/UseA_B.lean"] = mod([UA, B], probe + f"#print axioms {ns}.useA\n")
        f[f"{d}/B_UseA.lean"] = mod([B, UA], probe + f"#print axioms {ns}.useA\n")
        f[f"{d}/UseB_A.lean"] = mod([UB, A], probe + f"#print axioms {ns}.useB\n")
        f[f"{d}/A_UseB.lean"] = mod([A, UB], probe + f"#print axioms {ns}.useB\n")
        f[f"{d}/UpAB.lean"] = mod([A], inns(s["B"]) + probe + "#t4locals\n")
        f[f"{d}/UpBA.lean"] = mod([B], inns(s["A"]) + probe + "#t4locals\n")
    return f


LEAVES = ["Base", "Probe"]
CONSUMERS = ["OnlyA", "OnlyB", "TopAB", "TopBA", "UseA_B", "B_UseA", "UseB_A", "A_UseB", "UpAB", "UpBA"]


def sh(cmd, cwd):
    """(exit status, stdout and stderr together) — the status read directly, never through a pipe."""
    r = subprocess.run(cmd, cwd=cwd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    return r.returncode, r.stdout


def write_package():
    want = files()
    if PKG.exists():
        for p in sorted(PKG.rglob("*")):
            rel = p.relative_to(PKG).as_posix()
            if p.is_file() and not rel.startswith(".lake/") and rel != "lake-manifest.json" and rel not in want:
                p.unlink()
    for rel, text in want.items():
        p = PKG / rel
        p.parent.mkdir(parents=True, exist_ok=True)
        if not p.exists() or p.read_text() != text:
            p.write_text(text)
    return want


def scrub(text, lake=False):
    """An output with this machine's absolute paths made relative, so the committed files do not depend on where the tree stands.
    A Lake build's output also loses what varies between runs — the timings, the job counters and the order of its lines (it is
    kept as its sorted distinct lines): it is the cross-check, and `lake env lean`'s output is the record."""
    text = text.replace(str(PKG) + "/", "").replace(str(REPO) + "/", "")
    if lake:
        text = re.sub(r" \(\d+(?:\.\d+)?(?:ms|s)\)", "", text)
        text = re.sub(r"\[\d+/\d+\] ", "", text)
        text = "\n".join(sorted(set(ln for ln in text.split("\n") if ln.strip()))) + "\n"
    return text


def probe_lines(out, full):
    """kind -> text, for the PROBE lines of `full`; DECLARED-BY is a list."""
    res = {"DECLARED-BY": []}
    for ln in out.split("\n"):
        m = re.search(r"PROBE " + re.escape(full) + r" (\S+) (.*)$", ln)
        if not m:
            continue
        if m.group(1) == "DECLARED-BY":
            res["DECLARED-BY"].append(m.group(2))
        else:
            res[m.group(1)] = m.group(2)
    return res


def axioms_line(out):
    """The `#print axioms` line(s) of an output, joined (the list wraps across lines when long)."""
    m = re.search(r"'[^'\n]+' (depends on axioms: \[[^\]]*\]|does not depend on any axioms)", out)
    return re.sub(r"\s+", " ", m.group(1)) if m else None


def first_error(out):
    for ln in out.split("\n"):
        if "error" in ln:
            return re.sub(r"\s+", " ", ln).strip()
    return None


def short(mods):
    """`[T4Exp.S1.A, T4Exp.S1.B]` -> `A, B`."""
    return ", ".join(x.split(".")[-1] for x in re.findall(r"[\w.]+", mods)) if mods else "—"


# A fault planted in the probe, and the text of the check that must catch it.
PLANTS = {
    "the probe calls every declaring module's copy the held one":
        ("kindOf a == kindOf b && a.type == b.type && valueOf? a == valueOf? b", "true",
         "held copy and the held value's axioms disagree about `sorry`"),
    "the probe reports no axioms for the name, whatever `collectAxioms` returns":
        ("{show_ (printed.qsort Name.lt)}", "[]", "the partner's two axiom readings differ"),
}


def plant():
    """Each planted fault, in a scratch copy of the package with S1 and S2 only; the unplanted checks are the partner (`--check`)."""
    global PKG, PROBE, SCENARIOS
    keep = (PKG, PROBE, SCENARIOS)
    ok = True
    for what, (old, new, expect) in PLANTS.items():
        assert keep[1].count(old) == 1, f"the plant's anchor occurs {keep[1].count(old)} times in the probe, not once"
        PKG, PROBE, SCENARIOS = T4 / "exp-plant", keep[1].replace(old, new), [s for s in keep[2] if s["id"] in ("S1", "S2")]
        shutil.rmtree(PKG, ignore_errors=True)
        problems = run(write=False)
        fired = [q for q in problems if expect in q]
        other = [q for q in problems if expect not in q]
        print(f"PLANT ({what}): {'FIRED' if fired and not other else 'DID NOT BEHAVE'} — {len(fired)} problem(s) with the expected text"
              + (f", and {len(other)} unforeseen: {other}" if other else ""))
        ok = ok and bool(fired) and not other
        shutil.rmtree(PKG, ignore_errors=True)
    PKG, PROBE, SCENARIOS = keep
    sys.exit(0 if ok else 1)


def main():
    if "--plant" in sys.argv:
        plant()
    problems = run(write=True, check="--check" in sys.argv)
    for q in problems:
        print(f"PROBLEM: {q}")
    sys.exit(1 if problems else 0)


def run(write, check=False):
    """Write the package, run every consumer, apply the tool's checks; returns the problems. With `write`, also writes (or, with
    `check`, compares) the outputs and the table."""
    problems = []
    want = write_package()
    print(f"package: {PKG.relative_to(REPO)} ({len(want)} files)")
    shutil.rmtree(PKG / ".lake", ignore_errors=True)

    leaves = [f"T4Exp.{x}" for x in LEAVES] + [f"T4Exp.{s['id']}.{m}" for s in SCENARIOS for m in ("A", "B", "UseA", "UseB")]
    rc, out = sh(["lake", "build", *leaves], PKG)
    results = {"leaves.build": (rc, out)}
    print(f"leaf modules: lake build of {len(leaves)} modules: exit {rc}")
    if rc != 0:
        problems.append("the leaf modules did not build")
        print(out)

    rows = []
    for s in SCENARIOS:
        for c in CONSUMERS:
            rel = f"T4Exp/{s['id']}/{c}.lean"
            rc, out = sh(["lake", "env", "lean", rel], PKG)
            results[f"{s['id']}/{c}"] = (rc, out)
            pl = probe_lines(out, s["full"])
            rows.append((s, c, rc, out, pl))
        # the cross-check through Lake's own build of the two `Top` modules: the same verdict as `lake env lean`
        for c in ("TopAB", "TopBA"):
            rc, out = sh(["lake", "build", f"T4Exp.{s['id']}.{c}"], PKG)
            results[f"{s['id']}/{c}.lake-build"] = (rc, out)
            rc0 = results[f"{s['id']}/{c}"][0]
            if (rc == 0) != (rc0 == 0):
                problems.append(f"{s['id']}/{c}: `lake build` exit {rc} and `lake env lean` exit {rc0} disagree")
            elif rc == 0 and axioms_line(out) != axioms_line(results[f"{s['id']}/{c}"][1]):
                problems.append(f"{s['id']}/{c}: `lake build` and `lake env lean` print different axioms")

    # ---- the tool's own checks -------------------------------------------------------------------------------------------
    for s, c, rc, out, pl in rows:
        tag = f"{s['id']}/{c}"
        if c in ("OnlyA", "OnlyB"):
            me = c[-1]
            if rc != 0:
                problems.append(f"{tag}: the partner did not elaborate")
                continue
            decl = [d.split()[0].split(".")[-1] for d in pl["DECLARED-BY"]]
            if decl != [me]:
                problems.append(f"{tag}: the partner reports declaring modules {decl}, not [{me}]")
            if short(re.search(r"copy-of=(.*)$", pl.get("ENV-HOLDS", "")).group(1)) != me:
                problems.append(f"{tag}: the partner does not hold its own module's copy")
            if pl.get("AXIOMS-PRINTED") != pl.get("AXIOMS-OF-HELD-VALUE"):
                problems.append(f"{tag}: the partner's two axiom readings differ: {pl.get('AXIOMS-PRINTED')} / {pl.get('AXIOMS-OF-HELD-VALUE')}")
        elif c.startswith("Up"):
            if not s["up_elab"] and (rc == 0 or "has already been declared" not in out):
                problems.append(f"{tag}: a redeclaration over an imported copy was expected to fail with 'has already been declared', exit {rc}")
            if s["up_elab"] and rc != 0:
                problems.append(f"{tag}: expected to elaborate (no redeclaration: a fresh generated name, or a lemma already there), exit {rc}")
        else:
            if s["merge"] and rc != 0:
                problems.append(f"{tag}: expected to elaborate, exit {rc}: {first_error(out)}")
            if not s["merge"] and (rc == 0 or "environment already contains" not in out):
                problems.append(f"{tag}: expected the import to fail with 'environment already contains', exit {rc}")
        if s["id"] == "S2" and rc == 0 and "ENV-HOLDS" in pl:
            held_a = short(re.search(r"copy-of=(.*)$", pl["ENV-HOLDS"]).group(1)) == "A"
            if held_a != ("sorryAx" in pl.get("AXIOMS-OF-HELD-VALUE", "")):
                problems.append(f"{tag}: held copy and the held value's axioms disagree about `sorry`")

    if not rows:
        problems.append("no consumer was run")
    if not write:
        return problems

    # ---- the outputs and the table ---------------------------------------------------------------------------------------
    texts = {f"{k}.out": f"exit {rc}\n{scrub(out, lake=k.endswith('build'))}" for k, (rc, out) in results.items()}
    L = ["# FS131-T4 — the experiment's table: one name declared by two modules, Lean v4.32.0",
         "",
         "*Written by `tools/fs131_t4_experiment.py` from the outputs under `data/fs131/t4/exp-out/` (one file per row, `exit <status>`",
         "then everything Lean printed). The package is `data/fs131/t4/exp/`; each scenario's two siblings are `T4Exp.<S>.A` and",
         "`T4Exp.<S>.B`. Columns: **declared by** — the modules whose compiled data holds the name, in import order; **held** — the",
         "copy the environment's constant is (identified by the constants its value uses); **attributed** — the module",
         "`Environment.getModuleIdxFor?` gives; **printed for the name** — `collectAxioms` of the name, which is what `#print axioms`",
         "prints; **of the held value** — the axioms collected through the constants the held copy's value uses; **the consumer's",
         "print** — `#print axioms` of `down` (declared in the consumer itself, using the name) or of `useA` / `useB` (imported, each",
         "compiled against one sibling alone).*",
         ""]
    for s in SCENARIOS:
        L += [f"## {s['id']} — {s['row']}", "",
              f"`A`: `{s['A'].strip().splitlines()[-1]}`  ·  `B`: `{s['B'].strip().splitlines()[-1]}`  ·  the name: `{s['full']}`", "",
              "| consumer | imports, in order | exit | declared by | held | attributed | printed for the name | of the held value | the consumer's print |",
              "|---|---|---|---|---|---|---|---|---|"]
        imports = {"OnlyA": "A", "OnlyB": "B", "TopAB": "A, B", "TopBA": "B, A", "UseA_B": "UseA (← A), B", "B_UseA": "B, UseA (← A)",
                   "UseB_A": "UseB (← B), A", "A_UseB": "A, UseB (← B)", "UpAB": "A; then writes B's declarations",
                   "UpBA": "B; then writes A's declarations"}
        for s2, c, rc, out, pl in rows:
            if s2 is not s:
                continue
            if "ENV-HOLDS" in pl:
                decl = ", ".join(f"{d.split()[0].split('.')[-1]} ({d.split()[1][5:]})" for d in pl["DECLARED-BY"])
                m = re.search(r"kind=(\S+) .*copy-of=(.*)$", pl["ENV-HOLDS"])
                held = f"{short(m.group(2))} ({m.group(1)})"
                attr = short(pl.get("ATTRIBUTED-TO", ""))
                pr, hv = pl.get("AXIOMS-PRINTED", "?"), pl.get("AXIOMS-OF-HELD-VALUE", "?")
            else:
                decl = held = attr = pr = hv = "—"
            loc = re.search(r"LOCALS (\[.*\])", out)
            cp = axioms_line(out) or ("— " + (first_error(out) or "no error") + (f"; the file declared {loc.group(1)}" if loc else ""))
            who = {"OnlyA": "down", "OnlyB": "down", "TopAB": "down", "TopBA": "down", "UseA_B": "useA", "B_UseA": "useA",
                   "UseB_A": "useB", "A_UseB": "useB"}.get(c)
            cp = (f"`{who}`: " if who and axioms_line(out) else "") + cp
            L.append(f"| {c} | {imports[c]} | {rc} | {decl} | {held} | {attr} | {pr} | {hv} | {scrub(cp).replace('|', '¦')} |")
        L.append("")
    L += ["## The tool's own checks", ""]
    L += [f"- FAILED: {p}" for p in problems] or [
        "- all passed: the leaf modules built; every consumer expected to elaborate did, and every one expected to fail did — with",
        "  `environment already contains` for an import of two copies, and `has already been declared` for a redeclaration over an",
        "  imported copy; each `OnlyA` / `OnlyB` partner reports one declaring module, its own copy held, and equal axiom readings; in",
        "  S2 the held value's axioms hold `sorryAx` exactly when the held copy is the `sorry` one; `lake build` of each `Top` module",
        "  agrees with `lake env lean` (status, and the axioms printed)."]
    table = "\n".join(L) + "\n"

    if check:
        diffs = []
        for name, text in texts.items():
            p = OUT / name
            if not p.exists() or p.read_text() != text:
                diffs.append(str(p.relative_to(REPO)))
        if not TABLE.exists() or TABLE.read_text() != table:
            diffs.append(str(TABLE.relative_to(REPO)))
        for d in diffs:
            print(f"DIFFERS from the committed file: {d}")
        print(f"--check: {len(texts)} outputs and the table compared; {len(diffs)} differ")
        problems += [f"differs: {d}" for d in diffs]
    else:
        shutil.rmtree(OUT, ignore_errors=True)
        for name, text in texts.items():
            p = OUT / name
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text(text)
        TABLE.write_text(table)
        print(f"wrote {len(texts)} outputs under {OUT.relative_to(REPO)} and {TABLE.relative_to(REPO)}")

    print(f"consumers run: {len(rows)}; problems: {len(problems)}")
    return problems


if __name__ == "__main__":
    main()
