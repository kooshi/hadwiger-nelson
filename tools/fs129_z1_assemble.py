#!/usr/bin/env python3
"""FS129-Z1: assemble plans/FS129-derivation.md from the eight FS-129 reader records.

Each entry block is copied by name from its reader's record, verbatim, with every "§ …" address in `argument:` and `converse:`
re-pointed to that record. The record job's changes are the OVERRIDES below (each listed in the output's prose under its entry) and
the prose under each entry. Controls whose `of:` names an included entry are copied verbatim (their commands run from plans/, as in
the readers' records).

  python3 tools/fs129_z1_assemble.py            write plans/FS129-derivation.md, then check it
  python3 tools/fs129_z1_assemble.py --check    check only: every statement in the output equals its source's, spacing aside,
                                                every source entry is present once, and no source statement is missing
  python3 tools/fs129_z1_assemble.py --check --fault   the same check with one statement altered in memory: must FAIL
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PLANS = ROOT / "plans"
OUT = PLANS / "FS129-derivation.md"
READERS = ["OA1", "OR1", "MA1", "MA2", "MR1", "SA1", "SR1", "SR2", "SR3"]
HEAD = re.compile(r"^(derivation|control): ([\w.-]+)\s*$")
FIELD = re.compile(r"^  ([a-z][a-z ]*?):\s?(.*)$")


def blocks(path):
    lines = path.read_text().split("\n")
    out, i = {}, 0
    while i < len(lines):
        m = HEAD.match(lines[i])
        if not m:
            i += 1
            continue
        j = i + 1
        while j < len(lines) and lines[j].strip() and lines[j][0] in " \t":
            j += 1
        out[(m.group(1), m.group(2))] = lines[i:j]
        i = j
    return out


def fields(block):
    """field -> joined value"""
    f, last = {}, None
    for ln in block[1:]:
        m = FIELD.match(ln)
        if m and not ln.startswith("    "):
            last = m.group(1)
            f[last] = m.group(2)
        elif last:
            f[last] += " " + ln.strip()
    return f


def norm(s):
    return re.sub(r"\s+", " ", s or "").strip()


def replace_field(block, name, new_lines):
    out, i, done = [block[0]], 1, False
    while i < len(block):
        m = FIELD.match(block[i])
        if m and not block[i].startswith("    ") and m.group(1) == name:
            out.extend(new_lines)
            i += 1
            while i < len(block) and block[i].startswith("    "):
                i += 1
            done = True
            continue
        out.append(block[i])
        i += 1
    assert done, (block[0], name)
    return out


def repoint(block, record):
    out = []
    for ln in block:
        m = re.match(r"^(  (?:argument|converse): )§ (.*)$", ln)
        out.append(f"{m.group(1)}{record} § {m.group(2)}" if m else ln)
    return out


def load_sources():
    src = {}
    for r in READERS:
        rec = f"FS129-{r}-audit.md"
        for (kind, name), b in blocks(PLANS / rec).items():
            src[(kind, name)] = (rec, b)
    return src


# ------------------------------------------------------------------ the record job's changes

def sup_handoff(by, why, original):
    return [f"  handoff: none — superseded by {by} (FS129-Z1, 2026-10-03; {why}), which de Bruijn formalizes once in its place; the",
            f"    reader's handoff, verbatim: \"{original}\""]


SUPERSEDED = {
    "FS129-OA1-NOLIN5": ("FS129-SA1-NOAFF-K with FS129-SA1-NOAFF-FIELDS", "SA1 § 6.3 item 1"),
    "FS129-MA1-NOAFF5": ("FS129-SA1-NOAFF-K", "SA1 § 6.3 item 1"),
    "FS129-MA1-FALC-T": ("FS129-SA1-FALC-FAN", "SA1 § 6.3 item 3"),
    "FS129-MA2-FALC-GAP4": ("FS129-SA1-FALC-FAN", "SA1 § 6.3 item 3"),
    "FS129-MA2-FALC-DICHO": ("FS129-SA1-FALC-DICHO-K", "SA1 § 6.3 item 4"),
    "FS129-OA1-FALC-11": ("FS129-SA1-FALC-RES", "SA1 § 6.3 item 5"),
    "FS129-MA1-FALC-19": ("FS129-SA1-FALC-RES", "SA1 § 6.3 item 5"),
    "FS129-OA1-FALC-RED": ("FS129-SA1-FALC-RED", "the same statement, argued in Falconer's p. 188 order: SA1 § 6.3 item 6, inventory items 67, 106"),
    "FS129-OR1-BENDFRAG": ("FS129-SR1-BENDANY", "SR1 § 6.2 item 5"),
    "FS129-OR1-BEND3": ("FS129-SR1-BENDANY with FS129-SR1-BENDLE3", "SR1 § 6.2 item 5"),
    "FS129-OA1-RINGWIND": ("FS129-SR1-RINGBAND", "SR1 § 6.2 item 8; neither crosses unless one of the family is formalized"),
    "FS129-OR1-QFREE": ("FS129-SR3-QFREE-NS", "the same statement with \"simple\" dropped: SR3 § 2.2, inventory items 125, 128"),
}


def override(name, block):
    f = fields(block)
    changes = []
    if name in SUPERSEDED:
        by, why = SUPERSEDED[name]
        block = replace_field(block, "handoff", sup_handoff(by, why, f["handoff"]))
        changes.append("`handoff:` marks the supersession and quotes the reader's handoff")
    if name == "FS129-MA2-FALC-HOSTS":
        block = replace_field(block, "handoff", [
            "  handoff: de Bruijn — clauses (ii)–(iv) as filed, over FS129-SA1-FALC-FAN (B) and FS129-SA1-FALC-DICHO-K in place of",
            "    FS129-MA2-FALC-GAP4 and -DICHO (SA1 § 6.3 item 5); clause (i) is superseded by FS129-SA1-FALC-RES (i) and is not formalized",
            f"    from this entry (FS129-Z1, 2026-10-03); the reader's handoff, verbatim: \"{f['handoff']}\""])
        changes.append("`handoff:` splits clause (i), superseded, from clauses (ii)–(iv), re-pointed")
    if name == "FS129-MR1-DOUBLETIP":
        text = "\n".join(block)
        new = re.sub(r"FS116-N2-STAR \(C\(y\) = A\(p\) ⊔ T_y ⊔ O_y at a change point, p of four\s+colours\); ", "", text)
        new = new.replace("FS116-RING-GERM, FS116-N2-STAR, FS116-V4-TWIST", "FS116-RING-GERM, FS116-V4-TWIST")
        new = new.replace("over FS116-Y4-FLANK, RING-GERM (i) and N2-STAR;", "over FS116-Y4-FLANK and RING-GERM (i);")
        assert new.count("N2-STAR") == text.count("N2-STAR") - 3, "DOUBLETIP: three N2-STAR mentions expected in uses only, grade, handoff"
        block = new.split("\n")
        changes.append("FS116-N2-STAR dropped from `uses only:`, `grade:` and `handoff:` (SR1 § 2.2: step 3 needs only non-Siamese and "
                       "FS116-V4-DICHOTOMY; inventory items 95, 100)")
    if name == "FS129-OA1-RINGWIND":
        block = replace_field(block, "prior art", [
            "  prior art: partly: in-house — FS110-N2-RING (the band) and FS110-Y3-GP (the count n₂), two minds each: W here is Y3-GP's invariant read",
            "    position by position, W = (6 − 2n₂)/3 (`plans/FS129-SR1-audit.md` § Stage 3, group 7; inventory item 100); and G71 (Chandgotia's height",
            "    functions for three-colourings) and row 132's index of density traces, both \"fail only at a swap\"; the ring-hexagon form outside the",
            "    house not searched (owed)"])
        changes.append("`prior art:` names the in-house prior forms FS110-N2-RING and FS110-Y3-GP (inventory item 100)")
    if name == "FS129-SR2-QFCASE":
        block = replace_field(block, "uses only", [
            "  uses only: FS129-SR3-QFREE-NS (S1-QF's class — non-Siamese, valid, six colours, radius 2 > 1, a degree-4 vertex of four colours, a ring",
            "    carrying no (Q) arc — lies inside its class; no simplicity is read); that radius 2 is above 1; FS-116's \"valid fragment\", six-coloured unless",
            "    \"k-coloured\" is written"])
        block = replace_field(block, "grade", ["  grade: derived from: FS129-SR3-QFREE-NS"])
        block = replace_field(block, "handoff", [
            "  handoff: de Bruijn — formalize FS129-SR3-QFREE-NS (over FS129-SR3-EMPTY-NS, on FS116-V6's route, and FS129-SR1-BENDANY) and read S1-QF as its",
            "    case; S1-QF's own route (LENS, EXIT, CLUSTER) is then a second route"])
        changes.append("`uses only:`, `grade:` and `handoff:` cite FS129-SR3-QFREE-NS in place of FS129-OR1-QFREE, and the step \"so the fragment is "
                       "simple at p\" is withdrawn (SR3 § 2.3; inventory items 125, 130)")
    return block, changes


# ------------------------------------------------------------------ order and prose

ORDER = [
    ("A", "## 1. Lane A — the slack residue plane and the Falconer fan, merged (pass 3's forms first)"),
    "FS129-SA1-PLACE-HOM", "FS129-SA1-NOAFF-K", "FS129-SA1-NOAFF-FIELDS", "FS129-SA1-FALC-FAN", "FS129-SA1-FALC-DICHO-K",
    "FS129-SA1-FALC-RES", "FS129-SA1-FALC-RED", "FS129-MA2-FALC-HOSTS",
    ("A", "## 2. Lane A — the other entries"),
    "FS129-OA1-NOPERLAW", "FS129-SA1-SQRT3-LOCAL",
    ("A", "## 3. Lane A — superseded forms (kept, marked)"),
    "FS129-OA1-NOLIN5", "FS129-MA1-NOAFF5", "FS129-MA1-FALC-T", "FS129-MA2-FALC-GAP4", "FS129-MA2-FALC-DICHO", "FS129-OA1-FALC-11",
    "FS129-MA1-FALC-19", "FS129-OA1-FALC-RED",
    ("R", "## 4. Lane R — the bends on a fragment and the (Q)-free ring"),
    "FS129-OR1-WHOLE", "FS129-SR1-BENDANY", "FS129-SR1-BENDLE3", "FS129-OR1-QFREE-CLASS", "FS129-SR3-EMPTY-NS", "FS129-SR3-QFREE-NS",
    "FS129-SR2-QFCASE", "FS129-MR1-DOUBLETIP", "FS129-SR3-OUTERADJ", "FS129-SR1-TWOCIRC",
    ("R", "## 5. Lane R — the other entries"),
    "FS129-SR3-E2ONE", "FS129-SR1-SIXQ", "FS129-SR1-RINGBAND", "FS129-OR1-LOCALDENSE", "FS129-OR1-DISCF-NS", "FS129-OR1-TOP5", "FS129-SR2-CLOSURE",
    "FS129-SR2-HULLSET", "FS129-SR2-SUPK", "FS129-SR2-DISC1TS", "FS129-SR2-YESLIM-EQ", "FS129-SR2-TOUCHW",
    ("R", "## 6. Lane R — superseded forms (kept, marked)"),
    "FS129-OR1-QFREE", "FS129-OR1-BENDFRAG", "FS129-OR1-BEND3", "FS129-OA1-RINGWIND",
]

PROSE = {
"FS129-SA1-PLACE-HOM": "Rests on it: FS129-SA1-NOAFF-FIELDS and FS129-SA1-FALC-RES, and every field statement of the family, which the kernel "
"proves through this one homomorphism (SA1 § 6.3 item 2). It is G63's place t ↦ 0 composed with row 52's residue map; it carries FALC-11, FALC-19 and "
"NOAFF5's field readings to F(t₁, …, t_n) (inventory item 88).",
"FS129-SA1-NOAFF-K": "Rests on it: FS129-SA1-NOAFF-FIELDS. It is the merged form of four statements (SA1 § 6.3 item 1): FS129-OA1-NOLIN5 (its "
"k = 5 case over a residue-𝔽₁₁ prime, read with the simplex embedding — φ_v = c_v·f(·) coordinatewise, and φ_v constant forces c_v = 0 because the "
"simplex's vertices are distinct, then w = 0), FS129-MA1-NOAFF5 (its slack clause at k = 5, φ_v = ⟨a_v, f(·)⟩, and the edge vectors span ℝ⁴), MA2's "
"k = 4 note (`plans/FS129-MA2-audit.md` § 2.3) and the in-house prior form FS84-S1e (ii) (k = 4, filed by this job in `plans/FS84-S1-derivation.md`). "
"Row 66's `Slack.forces_iff_of_hom` (kernel) is its two-vertex case. What it bears on: FS-104 route (c) — G75's linear-annihilator format finds "
"nothing on a field with a slack residue target (pass 1's cross-era hit, inventory item 39).",
"FS129-SA1-NOAFF-FIELDS": "Rests on it: nothing derived in FS-129. It is the field reading FS-104 route (c)'s null uses (J12, `plans/FS129-OA1-audit.md` "
"§ 2.2): over ℚ(√11)(t₁, …, t_n) at four colours, and over every field with a usable 𝔽₁₁ or 𝔽₁₉ prime at five, no linear identity in the colours "
"holds on any finite configuration.",
"FS129-SA1-FALC-FAN": "Rests on it: FS129-SA1-FALC-DICHO-K, FS129-SA1-FALC-RES, and FS129-MA2-FALC-HOSTS clauses (ii)–(iv) as re-pointed. It is "
"the merged form of FS129-MA1-FALC-T (clause (1) is (A); (2) is (B)'s first clause at k = 5; (3) is (B)'s second clause read on a three-colouring, "
"whose unused fourth colour is absent everywhere) and FS129-MA2-FALC-GAP4 ((B)'s second clause at k = 5). Stated at every k ≥ 3, it is inhabited at "
"k = 4 by the unit rhombus (control FS129-SA1-FAN4).",
"FS129-SA1-FALC-DICHO-K": "Rests on it: FS129-SA1-FALC-RES clause (i) (χ(H) ≥ 4 at k = 5). Its k = 5 case is FS129-MA2-FALC-DICHO, superseded. "
"G9's measured reading (\"compulsions one rung below the top\") and this are one mechanism (inventory item 88).",
"FS129-SA1-FALC-RES": "Rests on it: nothing derived in FS-129; it bears on FS-104 routes (0) and (b) (J13), as the list of fields that could host a "
"five-colour Falconer fan and where its tip must sit. It supersedes FS129-OA1-FALC-11 and FS129-MA1-FALC-19 (clause (ii) at n = 0: V = 𝒪_{F,𝔭}, φ "
"the reduction, so φ(t − a) = 0 is t ≡ a mod 𝔭; a prime of residue field 𝔽₁₁ or 𝔽₁₉ is usable) and FS129-MA2-FALC-HOSTS clause (i) (clause (i) here, "
"sharpened: χ(F²) ≥ 4 already excludes a usable 𝔽₃ prime, by row 52, and a dyadic place ramified in F(i), by G35). The excluded case φ(t − a) = 0 is "
"the Searcher's queue rows 1 and 4; the dyadic U_Q targets, row 5.",
"FS129-SA1-FALC-RED": "Rests on it: FS-104 route (b)'s reduction — one Falconer fan at five colours, with the angle condition, would give "
"χ_m(ℝ²) ≥ 6 for the everywhere-proper measurable chromatic number; the family's lemmas above are the constraints such a fan must meet. It carries "
"FS129-OA1-FALC-RED's statement verbatim with the argument reordered as `[Falconer1981]` p. 188 (MA1 checked Lemmas 1–4 against the page images, "
"`plans/FS129-MA1-audit.md` § 2.1; inventory item 67): Lemma 1 chooses the rigid motion, and is never read as \"for every e ∈ E, almost every rotation "
"about e\". The kernel formalizes OA1's statement from this argument, importing Lemma 1 in the paper's form only.",
"FS129-MA2-FALC-HOSTS": "**Superseded in part**: clause (i) by FS129-SA1-FALC-RES (i), which is sharper; clauses (ii)–(iv) stand, over FS129-SA1-FALC-FAN "
"(B) and FS129-SA1-FALC-DICHO-K (their k = 5 cases are this entry's cited GAP4 and DICHO). Rests on it: inventory item 87's bearing line — clause "
"(iv) ties FS-104 route (b) to row 88 (one fan over ℚ(√59), ℚ(√83) or ℚ(√131) would settle row 88's periodicity question); for FS129-Z2's stub line.",
"FS129-OA1-NOPERLAW": "Rests on it: nothing (its handoff is none); a relay-result for FS-104 route (b). Its arithmetic analogue is G55's forced "
"ideal (row 111).",
"FS129-SA1-SQRT3-LOCAL": "Rests on it: nothing in FS-129. It supersedes TC1-SQRT3-DYADIC (the case √3 ∈ F), a conditional seed of the Lean order "
"(inventory item 13); it crosses only with G56's dyadic exclusion, if that is formalized.",
"FS129-OA1-NOLIN5": "**Superseded** by FS129-SA1-NOAFF-K with FS129-SA1-NOAFF-FIELDS: its statement is NOAFF-FIELDS at k = 5 over a residue-𝔽₁₁ "
"prime, read with the simplex embedding (FS129-SA1-NOAFF-K's prose gives the one-line passage). Kept as derived; nothing rests on it that does not "
"rest on the merged form.",
"FS129-MA1-NOAFF5": "**Superseded** by FS129-SA1-NOAFF-K (its slack clause at k = 5 with φ_v = ⟨a_v, f(·)⟩). Its not-claimed line's field reading "
"is FS129-SA1-NOAFF-FIELDS. Its control FS129-MA1-NOAFF5-DIM remains NOAFF-K's model at k = 5.",
"FS129-MA1-FALC-T": "**Superseded** by FS129-SA1-FALC-FAN, which states it at every k ≥ 3 (its clauses (1)–(3) are FAN's (A) and (B) at k = 5).",
"FS129-MA2-FALC-GAP4": "**Superseded** by FS129-SA1-FALC-FAN ((B)'s second clause at k = 5).",
"FS129-MA2-FALC-DICHO": "**Superseded** by FS129-SA1-FALC-DICHO-K (its case k = 5).",
"FS129-OA1-FALC-11": "**Superseded** by FS129-SA1-FALC-RES clause (ii) at the residue field 𝔽₁₁ and n = 0. Its orbit fact (control "
"FS129-OA1-FALC-11-W) is RES's control FS129-SA1-ORBIT11.",
"FS129-MA1-FALC-19": "**Superseded** by FS129-SA1-FALC-RES clause (ii) at the residue field 𝔽₁₉ and n = 0. Its orbit fact is RES's control "
"FS129-SA1-ORBIT19.",
"FS129-OA1-FALC-RED": "**Superseded** by FS129-SA1-FALC-RED: the same statement, verbatim, with the argument in Falconer's p. 188 order. This "
"entry's `uses only:` states Lemma 1 as \"a.e. rotation of a countable configuration about a point of a null set E meets E only there\", which is not "
"the paper's form (`plans/FS129-MA1-audit.md` § 2.2: the lemma chooses the motion, so the point of E the apex lands on cannot be fixed first); the "
"statement stands and no grade moves (inventory item 67). Formalize from FS129-SA1-FALC-RED's argument only.",
"FS129-OR1-WHOLE": "Rests on it: FS129-SR1-BENDANY, and through it FS129-SR1-BENDLE3, FS129-OR1-QFREE-CLASS, FS129-OR1-QFREE and FS129-SR2-QFCASE; "
"also the superseded FS129-OR1-BENDFRAG and -BEND3. It settles the records that disagreed on what FS-112's bends leave on a ring (`plans/FS116-close-inventory.md` "
"items 136, 145; `plans/FS129-SR1-audit.md` § 2.3): side 1 holds for this whole-tile restriction of radius at most √3, not for the round one it names "
"(control fs129-or1-cut). Its identity |x − e|² = (|x|² + |x − 2e|²)/2 − 1 (|e| = 1) was checked by sympy at the coordinator's receipt (inventory "
"item 54).",
"FS129-SR1-BENDANY": "Rests on it: FS129-SR1-BENDLE3; and FS129-OR1-QFREE-CLASS, which was written over FS129-OR1-BENDFRAG and reads the same from this "
"form — at k = 6 and a vertex p of at least four colours, an arc of Γ on ω(p) both of whose side colours are carried at p is a (Q) arc by definition, so "
"F″'s ring arcs are F's (Q) arcs, and its tiles at p are F's. Two notes go to de Bruijn with it (`plans/FS129-SR1-audit.md` § 2.1, the attack on QFREE's "
"chain, a checking reading that did not succeed): follow N2's route at the end vertices (NB2's reads a contact tile's shape, which a fragment of radius "
"below 2 does not promise), and prove the connectedness step by quasi-components.",
"FS129-SR1-BENDLE3": "Rests on it: nothing derived; it derives inventory item 82's \"generalization, not derived\" (below √3 the bends free the ring of "
"any point of at most three colours). **Record-job note (2026-10-03):** FS129-OR1-BEND3, which this replaces with BENDANY, also concludes that the new "
"fragment's tiles include every tile of F meeting B(q, min(r, √3)) other than the ring arcs' side tiles, changed only inside thin lenses; this "
"statement does not say so, though its fragment is BENDANY's F″, whose statement does. No hypothesis is dropped; the Lean statement should conclude "
"with BENDANY's tile clause, or that clause of BEND3 is lost.",
"FS129-OR1-QFREE-CLASS": "Rests on it: FS129-OR1-QFREE; and any later Γ-free exclusion in one of the four classes becomes a (Q)-free one at once. Its "
"input FS129-OR1-BENDFRAG is superseded by FS129-SR1-BENDANY, which carries the same step (BENDANY's prose).",
"FS129-OR1-QFREE": "**Superseded** by FS129-SR3-QFREE-NS, the same statement with \"simple\" dropped, on FS116-V6's route (SR3 § 2.2); its "
"not-claimed \"the Siamese or non-simple classes\" narrows to the Siamese class (inventory item 130). Rests on it, as filed: FS-123's question 1, answered yes (J1, inventory item 54); `CLAUDE.md` item 31's open case \"(Q)-free "
"rings with (R2) arcs\", closed in the non-Siamese simple class (inventory item 57, for FS129-Z2 to score); in OR1's § J3, NO-SAT's case 2 (SAT-QFREE) "
"and case 1's G3, closed in the non-Siamese simple class; FS116-Y4-EMPTY's not-claimed line, whose erratum this job files. Pass 3's attack on its two "
"named steps did not succeed (`plans/FS129-SR1-audit.md` § 2.1; a checking reading, not a second mind). Whether a blind second mind runs is Kooshi's "
"call (inventory item 56); the default files it derived, one mind.",
"FS129-SR2-QFCASE": "Rests on it: nothing. **Corrected by the record job (2026-10-03; inventory items 124, 125, 130):** the argument "
"(`plans/FS129-SR2-audit.md` § 3.2.2) showed a fragment of FS116-S1-QF's class simple at p, glossing FS-116's \"simple\" as \"one sector per tile at "
"p\"; `data/fs116/claims.md` § 0 defines simple for the whole fragment, and S1-QF does not assume it, so the statement's \"a case of "
"FS129-OR1-QFREE\" does not hold as worded (QFREE is stated for simple fragments). This job raised it; FS129-SR3 resolved it (`plans/FS129-SR3-audit.md` "
"§ 2.3): S1-QF's class lies inside FS129-SR3-QFREE-NS's, which drops \"simple\", so the conclusion stands with the gloss idle. Read the statement as "
"\"… is a case of FS129-SR3-QFREE-NS\"; the statement above is SR2's, left verbatim. Inventory item 117's correction to `plans/FS129-OR1-audit.md` § J3 "
"(S1-QF has no non-simple remainder) stands. As SR2 filed them: `uses only:` began \"FS129-OR1-QFREE; that a degree-4 vertex of four colours with "
"four edges has four sectors, one tile each, so the fragment is simple at p;\", `grade:` read \"derived from: FS129-OR1-QFREE\", and the handoff "
"\"formalize QFREE (over FS116-Y4-EMPTY) and read S1-QF as its case\".",
"FS129-MR1-DOUBLETIP": "Rests on it: FS116-V6-HUG, its Γ-free instance (a ring with no arc of Γ has every germ off (Q) arcs; `plans/FS129-SR1-audit.md` "
"§ Stage 3, group 1), so the kernel proves this form once and V6-HUG from it; and FS-124's ring types, which it prunes in case 5 and at hubs and kind-T "
"semi-hubs in case 1 (inventory item 82; FS129-Z2's stub line). It does not reach SEMI-PAR3. **Changed by the record job** (inventory items 95, 100): "
"FS116-N2-STAR is dropped from `uses only:`, `grade:` and `handoff:` — pass 3's attack (`plans/FS129-SR1-audit.md` § 2.2, a checking reading that did "
"not succeed) found that step 3 needs only non-Siamese and FS116-V4-DICHOTOMY. As MR1 filed them: `uses only:` held \"FS116-N2-STAR (C(y) = A(p) ⊔ T_y "
"⊔ O_y at a change point, p of four colours)\" between FLANK and V4-TWIST; `grade:` read \"derived from: FS116-Y4-FLANK, FS116-RING-GERM, FS116-N2-STAR, "
"FS116-V4-TWIST, FS116-V4-DICHOTOMY\"; the handoff read \"over FS116-Y4-FLANK, RING-GERM (i) and N2-STAR\". **Caution for the Lean list (FS129-SR3, `plans/FS129-SR3-audit.md` § Stage 2 — SAVED: item (d)):** SR1 § 6.2 "
"item 2, \"DOUBLETIP in place of V6-HUG\", would lose FS129-SR3-EMPTY-NS, because this entry's step 3 uses one cone per tile at the hubs; "
"FS116-V6-HUG's own colour step is kept for the Γ-free ring.",
"FS129-SR3-EMPTY-NS": "Rests on it: FS129-SR3-QFREE-NS, and through it FS129-SR2-QFCASE. It replaces FS116-Y4-EMPTY in the Lean order on "
"FS116-V6's route (V6-HUG's own colour step through V6-GERM, V6-COUNT's last step on sectors), never through FS129-MR1-DOUBLETIP's cone step, which "
"reads simplicity at the hubs (`plans/FS129-SR3-audit.md` § 2.3; inventory items 126, 131). FS116-Y4's own route does use simplicity. Prior art partly "
"in-house: FS116-V6 had left the non-simple class undecided.",
"FS129-SR3-QFREE-NS": "Rests on it: FS129-SR2-QFCASE (S1-QF is its case, no simplicity step); FS-123's question 3, whose non-simple half is closed "
"for (Q)-free rings, the Siamese half left; FS116-C114-LOCAL-F's Γ-free line and FS116-Y4-EMPTY's not-claimed line, which narrow to the Siamese class "
"(inventory items 125, 130; FS129-Z2's stub lines). It supersedes FS129-OR1-QFREE, and FS129-SR1-BENDANY carries the bend step as it does for QFREE "
"(BENDANY's prose). The argument address is OR1's, as SR3 filed it: the class-to-class passage, read at the non-Siamese class.",
"FS129-SR3-OUTERADJ": "Rests on it: FS-124's ring types, which it prunes beside FS129-MR1-DOUBLETIP (DOUBLETIP's outer twin; inventory item 133, "
"FS129-Z2's stub line). It widens FS116-V6-ADJ (two change points 60° apart, each with its outer germ off the shared arc free of (Q) arcs, never share "
"a single outer colour; non-Siamese, no simplicity) and carries V6-ADJ's argument as its last step, so V6-ADJ is formalized class-free or not at "
"all (its handoff). It rests on FS129-SR1-TWOCIRC's identity, through V6-ADJ's step.",
"FS129-SR3-E2ONE": "Rests on it: FS114-Y5-PINALL's exception, which narrows to \"E1, or E2 at two or more blades\", and FS114-Y5-PIN120's; FS114-Y6-E2RED's "
"not-claimed line (S6 is empty); FS114-K1's case list, which drops S6 and the wrap's E2RED site (inventory items 127, 130). This job files the "
"errata under FS114-Y5-PINALL and FS114-Y6-E2RED (`plans/FS114-derivation.md`); the stub lines are FS129-Z2's (item 133).",
"FS129-SR1-TWOCIRC": "Rests on it: the identity steps of FS114-Y5-PXKILL, FS116-V6-HUG, FS116-V6-ADJ and FS116-Y4-FLANK (each keeps its own pinning of "
"two tiles), and through FLANK FS129-MR1-DOUBLETIP. It is Kooshi's \"where else can we use that identity?\" (`plans/FS116-close-inventory.md` item 142) "
"answered: one law found three times, unnamed (inventory item 75).",
"FS129-SR1-SIXQ": "Rests on it: nothing derived in FS-129; with FS116-N2-FIVERING it replaces FS112-SIX in the Lean order (SR1 § 6.2 item 3); "
"FS116-N2-SIXRING stays as its non-Siamese strengthening.",
"FS129-SR1-RINGBAND": "Rests on it: nothing (its handoff is none); it is the one lemma under FS110-N2-RING, FS110-Y3-GP and FS129-OA1-RINGWIND, "
"formalized in their place should any be. **Record-job note (2026-10-03):** RINGWIND's last clauses — W has period 60°, its jumps over one period sum "
"to zero, and a hexagon position that is the only one with two change points 60° apart carries no jump — are not restated here; they follow at once "
"from h's definition (h(θ + 60°) is the same cyclic sum over one hexagon) with (iii). No hypothesis is dropped; a Lean statement replacing RINGWIND "
"should carry them.",
"FS129-OR1-LOCALDENSE": "Rests on it: FS129-OR1-DISCF-NS. Its input FS112-DISC1 is now a case of FS106-TS-T (FS129-SR2-DISC1TS). The class may be "
"empty (no fragment on a disc of radius 3 is held); then it is vacuous, and it constrains exactly the YES side's objects (FS116-O1-YESLIM).",
"FS129-OR1-DISCF-NS": "Rests on it: nothing derived; with C114-LOCAL-F in the non-Siamese simple class (FS-124, open) it gives DISC-F there at "
"radius R + 3 (J19, half closed). Inventory item 59 notes the consequence for `plans/FS116-local-exclusion.md` § 3.6 (outside this job's files).",
"FS129-OR1-TOP5": "Rests on it: nothing derived; it is the map step at five (J10) stated as the answer restated once REG-J′₅ is granted — a carrier "
"for it is FS129-P1's ranking call (inventory item 26).",
"FS129-SR2-CLOSURE": "Rests on it: the three places it is proved — FS106-DIAM (iii), FS111-V0-CLOSE, FS116-V5-NE1's first clause — which the kernel "
"proves once, as FS111-M2-INT's corollary for open sets (SR2 § 4.3 item 9).",
"FS129-SR2-HULLSET": "Rests on it: FS111-C-HULL as its case, and through C-HULL its consumers FS111-M-PINCH, -M-HULL2, -M2-FIX, -M-COVER-SC, -M-HALF, "
"which then need no colouring, tightness or normal form for this step (SR2 § 2.1 row 24; § 4.3 item 10). It is the true top of the lane-R root chain "
"that the false edge from the refuted FS111-C-HULL-SO had displaced (inventory items 77, 99).",
"FS129-SR2-SUPK": "Rests on it: FS106-EQ's every-k form, whose clause (e) rests on FS106-SUP and was stated at every k while SUP was stated at six; "
"this job files the erratum under FS106-EQ. FS106-EQ's (c) ⟺ (d) is SUPK read at the value 1.",
"FS129-SR2-DISC1TS": "Rests on it: FS112-DISC1's consumers — FS112-N2-DENSE, FS112-N3-DENSE3 and FS129-OR1-LOCALDENSE — which read it as FS106-TS-T's "
"corollary (SR2 § 4.3 item 12).",
"FS129-SR2-YESLIM-EQ": "Rests on it: FS116-O1-YESLIM's first clause, which becomes a two-line corollary of FS106-EQ's (c) ⟹ (a) (SR2 § 4.3 item 18); "
"the YES side's reading (valid fragments on discs of every radius give χ_m⁰(ℝ²) ≤ k) through it.",
"FS129-SR2-TOUCHW": "Rests on it: FS116-N2-RECIP, which uses FS116-N1-TOUCH and reads the wider form (SR2 § 4.3 item 20). The idle hypothesis was found "
"by FS116-V3 § 3.1; this entry states the wider form so that it is formalized once.",
"FS129-OR1-BENDFRAG": "**Superseded** by FS129-SR1-BENDANY (its case at k = 6 and a vertex of at least four colours; BENDANY's prose). FS129-OR1-QFREE-CLASS "
"was written over this entry and reads the same step from BENDANY.",
"FS129-OR1-BEND3": "**Superseded** by FS129-SR1-BENDANY with FS129-SR1-BENDLE3. Its tile clause is BENDANY's, not BENDLE3's (BENDLE3's note).",
"FS129-OA1-RINGWIND": "**Superseded** by FS129-SR1-RINGBAND ((i) with (iii); its periodicity clauses follow from h's definition, RINGBAND's note). "
"**Changed by the record job** (inventory item 100): `prior art:` names the in-house prior forms; as OA1 filed it, it read \"partly: G71 (Chandgotia's "
"height functions for three-colourings) and row 132's index of density traces, both \\\"fail only at a swap\\\"; the ring-hexagon form not searched (owed)\".",
}

HEADER = """# FS-129 — the cross-application audit: the derivation file

*Filed 2026-10-03 by FS129-Z1, the record job's first part (`data/fs129/briefs/FS129-Z1-record.md`; its record `plans/FS129-Z1-record.md`).
This file is FS-129's theorem record: every statement the audit's readers derived, as an entry in the deriver's grammar, gated by
`python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS129-derivation.md`. It is assembled by `tools/fs129_z1_assemble.py` from
the readers' records: each block is the reader's, verbatim, with its `§` addresses pointed into the reader's record; the record job's changes
are named in the prose under the entry they touch. FS129-SR3's four entries are included (the brief's amendment of 2026-10-03).*

## What FS-129 is

Kooshi asked for "an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others,
interweaving and strengthening what we have, and potentially finding new paths" (`plans/STUB-cross-application-audit.md` § The request). The
plan (`plans/FS129-cross-application-audit.md`) runs it as one index (`data/fs129/index/`, FS129-IX1) and three passes, never pairwise, in two
lanes split by milestone number — **lane A**, the arithmetic era (through FS-103), and **lane R**, the regularity-wall era (FS-104 on):

| pass | question | lane A | lane R |
|---|---|---|---|
| 1, open steps ("finding new paths") | which held result closes, shortens or reduces each step of Poros's demand list (`data/fs129/demand-judged.md`) | `plans/FS129-OA1-audit.md` | `plans/FS129-OR1-audit.md` |
| 2, mechanisms ("interweaving") | where each grokking's mechanism bears and was not applied | `plans/FS129-MA1-audit.md`, `plans/FS129-MA2-audit.md` | `plans/FS129-MR1-audit.md` |
| 3, merges and strengthening | statements that are one; hypotheses that weaken; records that disagree; the vacuity sort; the Lean order | `plans/FS129-SA1-audit.md` | `plans/FS129-SR1-audit.md`, `plans/FS129-SR2-audit.md`, `plans/FS129-SR3-audit.md` |

Each reader's report is `data/fs129/reports/<job>.md`; the inventory is `plans/FS129-close-inventory.md`.

**Grades.** Every entry here is derived, one mind, as its reader filed it (plan § 7: a composition is "derived, one mind" until its Lean module
passes); none was raised. Pass 3's attacks on the two one-mind results that move the ranking's top (FS129-OR1-QFREE's chain, FS129-MR1-DOUBLETIP)
were checking readings and did not succeed (`plans/FS129-SR1-audit.md` §§ 2.1–2.2).

**Prior art.** Kept as each reader measured it. Most entries are "owed"; several say "owed to FS129-Z1" or "for FS129-Z1": the record job did not
run those searches (its brief keeps each line as measured), so each such debt is open and held for the coordinator.

**Supersession.** Pass 3's merged forms stand first; each form they replace is kept below, its statement verbatim, its `handoff:` reading
"none — superseded by …" with the reader's handoff quoted. The kernel formalizes each merged form once:

| merged form (formalize) | in place of |
|---|---|
| FS129-SA1-NOAFF-K, with FS129-SA1-NOAFF-FIELDS | FS129-OA1-NOLIN5, FS129-MA1-NOAFF5 (and MA2's k = 4 note; FS84-S1e (ii)) |
| FS129-SA1-FALC-FAN | FS129-MA1-FALC-T, FS129-MA2-FALC-GAP4 |
| FS129-SA1-FALC-DICHO-K | FS129-MA2-FALC-DICHO |
| FS129-SA1-FALC-RES | FS129-OA1-FALC-11, FS129-MA1-FALC-19, FS129-MA2-FALC-HOSTS clause (i) |
| FS129-SA1-FALC-RED's argument for the shared statement | FS129-OA1-FALC-RED's argument |
| FS129-SR1-BENDANY, with FS129-SR1-BENDLE3 | FS129-OR1-BENDFRAG, FS129-OR1-BEND3 |
| FS129-SR1-RINGBAND (if any of the family is formalized) | FS129-OA1-RINGWIND (and FS110-N2-RING, FS110-Y3-GP) |
| FS129-SR3-QFREE-NS, over FS129-SR3-EMPTY-NS (FS116-V6's route) | FS129-OR1-QFREE (and FS116-Y4-EMPTY; FS116-S1-QF read as its case) |

Pass 3's entries that replace earlier milestones' statements (FS129-SR1-TWOCIRC, -SIXQ; FS129-SR2-CLOSURE, -HULLSET, -SUPK, -DISC1TS, -YESLIM-EQ,
-QFCASE, -TOUCHW; FS129-SR3-OUTERADJ, -E2ONE; FS129-SA1-SQRT3-LOCAL) say so in their own handoffs; the full lists for the Lean backlog are SA1 § 6.3, SR1 § 6.2, SR2 § 4.3 and SR3 § 5.1.

**Record-job notes** (each under its entry): FS129-SR2-QFCASE read FS-116's "simple" at p only — raised by this job and resolved by
FS129-SR3 (its FS129-SR3-QFREE-NS drops "simple" from QFREE; `plans/FS129-SR3-audit.md` § Stage 2), so QFCASE stands, its fields citing QFREE-NS; FS129-MR1-DOUBLETIP carries
SR3's caution that it cannot replace FS116-V6-HUG without losing FS129-SR3-EMPTY-NS; FS129-SR1-BENDLE3 omits FS129-OR1-BEND3's tile
clause, which FS129-SR1-BENDANY carries; FS129-SR1-RINGBAND does not restate FS129-OA1-RINGWIND's periodicity clauses. No hypothesis a source needed
is dropped by a merged form. Corrections made inside entries: FS129-MR1-DOUBLETIP's `uses only:` (without FS116-N2-STAR) and FS129-OA1-RINGWIND's
prior art (inventory item 100); FS129-SR2-QFCASE's `uses only:`, `grade:` and `handoff:` (QFREE-NS; items 125, 130); FALC-RED's argument by
supersession (items 67, 106).
"""


def assemble():
    src = load_sources()
    controls_of = {}
    for (kind, name), (rec, b) in src.items():
        if kind == "control":
            of = fields(b).get("of", "").split(" — ")[0].strip()
            controls_of.setdefault(of, []).append(name)
    out = [HEADER]
    for item in ORDER:
        if isinstance(item, tuple):
            out.append("\n" + item[1] + "\n")
            continue
        rec, b = src[("derivation", item)]
        b = repoint(b, rec)
        b, changes = override(item, b)
        out.append("\n".join(b) + "\n")
        for cname in sorted(controls_of.get(item, [])):
            crec, cb = src[("control", cname)]
            out.append("\n".join(cb) + "\n")
        prose = PROSE[item]
        if changes:
            prose += " *Fields this job changed:* " + "; ".join(changes) + "."
        out.append(prose + "\n")
    OUT.write_text("\n".join(out))
    return src


def check(fault=False):
    src = load_sources()
    mine = blocks(OUT)
    bad = 0
    wanted = {n for (k, n) in src if k == "derivation"}
    have = {n for (k, n) in mine if k == "derivation"}
    for n in sorted(wanted - have):
        print(f"MISSING {n}"); bad += 1
    for n in sorted(have - wanted):
        print(f"EXTRA {n}"); bad += 1
    for n in sorted(wanted & have):
        s_src = norm(fields(src[("derivation", n)][1]).get("statement"))
        s_mine = norm(fields(mine[("derivation", n)]).get("statement"))
        if fault and n == "FS129-OR1-QFREE":
            s_mine = s_mine.replace("non-Siamese simple", "non-Siamese")
        if s_src != s_mine:
            print(f"STATEMENT DIFFERS {n}"); bad += 1
    for n in sorted(SUPERSEDED):
        if "superseded by" not in fields(mine[("derivation", n)]).get("handoff", ""):
            print(f"NOT MARKED {n}"); bad += 1
    print(f"z1 assemble check: {len(have)} entries, {bad} problems" + (" (fault planted)" if fault else ""))
    return bad


if __name__ == "__main__":
    args = sys.argv[1:]
    if "--check" not in args:
        assemble()
    sys.exit(1 if check(fault="--fault" in args) else 0)
