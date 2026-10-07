#!/usr/bin/env python3
"""FS132-L1: every draft's slot is the text that stands on the merged tree (standing rule 3: quote, never paraphrase).

The record's "Drafts for the front page" give, for each draft, the exact words of a file that the draft *replaces* or
*follows*. A draft written against words that are not there cannot be filed. This tool holds the list (file, words) —
copied from the record by hand, so the check is of the record against the files — and requires each to occur exactly
once in its file, whitespace-normalised, and to occur in the record itself (so the list and the record cannot drift).

  fs132_l1_slots.py [--root DIR]      exit 0 only if every slot occurs once in its file and is quoted in the record
  fs132_l1_slots.py --self-test       a changed word, a slot occurring twice (a too-short quotation) and a slot absent
                                      from the record must each be refused; the list as it stands must pass
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
RECORD = "plans/FS132-L1-landing.md"
SLOTS = [
    ("CLAUDE.md", "the current audit reads 6521 clean and 5 declared purchases, and 8 imported (and 20 axiom-free; 6,554 records at wave 8's first landing, FS131-L8A, 2026-10-06)"),
    ("CLAUDE.md", "The library declares one outside axiom, `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums, `[Weil1948]` p. 207, read against its page by two readers — and the eight imported records are the theorems that rest on it;"),
    ("CLAUDE.md", "`axioms=1 rests=8 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — one outside theorem declared as an axiom, with eight theorems resting on it;"),
    ("CLAUDE.md", "seven standing for outside theorems, twenty-three for hand results of ours and five for open questions — taken in 98 (hypothesis, statement) pairs by 51 statements (`scripts/assumptions-ledger.txt` lists each pair; FS131-LT5, 2026-10-06)."),
    ("CLAUDE.md", "`declarations=14807 refutations-skipped=215 sites=1446`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1403 unknown=2`."),
    ("CLAUDE.md", "The baseline's two entries, `hexShell_plane5` and `hexShell_plane6`, cannot be discharged: their inhabitant *is* Hadwiger–Nelson."),
    ("tools/claude_md_fact_audit.py", '(("6304", "5"), ("6521", "5"))'),
    ("CLAUDE.md", "kernel-checked in its own library, built and audited here (EXT-OAI1), read in full (EXT-OAI2), not in this library — so `χ(ℝ²) ∈ {6, 7}`. With no hypothesis it is one question about measurable colour classes, and both of its answers decide the problem (§ The aim)"),
    ("CLAUDE.md", "(family 158; kernel-checked in its own library on the standard three axioms, the cone built and audited here, EXT-OAI1; its manuscript read in full, EXT-OAI2). This repository's own kernel holds the classical interval, **5 ≤ χ(ℝ²) ≤ 7** (row 33), on the standard three axioms, its lower end through de Grey's graph (rung B)."),
    ("CLAUDE.md", "the least number of colours in a measurable colouring proper at almost every unit pair (`[OAIMath2026]` Thm 1.3 with row 130)"),
    ("CLAUDE.md", "**Since 2026-10-07 the frontier stands on `[OAIMath2026]` family 158**: `χ(ℝ²) ∈ {6, 7}` and `χ(ℝ²) = χ_m⁰(ℝ²)` with no hypothesis"),
    ("LEDGER.md", "*Outside this library, and audited here (`plans/EXT-OAI1-audit.md`): `[OAIMath2026]` family 158 proves in Lean, at v4.34.1 on the standard three axioms, that no map `ℂ → Fin 5` separates every unit pair, which in this row's form is `6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber` — with this row's upper end, `6 ≤ χ(ℝ²) ≤ 7` (`six_le_chromaticNumber_plane_of_no_proper_five`, drafted, conditional on their statement, added nowhere); the theorem this library holds unconditionally is still `5 ≤ χ(ℝ²) ≤ 7`.*"),
    ("LEDGER.md", "With no hypothesis (`[OAIMath2026]` Thm 1.3; `χ_m⁰ ≤ χ` kernel-checked there and audited here, EXT-OAI1): `χ(ℝ²) = χ_m⁰(ℝ²)`."),
    ("LEDGER.md", "At six, `χ_m⁰(ℝ²) ≥ 7` ⟺ `lim µ₆(ε) < 1`: `[SokolovVoronov2025]` §9's hypothesis, read uniformly in `ε`, is `χ_m⁰ = 7`, and a refutation needs no wild set — it is a sequence of periodic grid colourings with vanishing holes, the wildness only in the limit."),
    ("LEDGER.md", "**the six-target**: χ(ℝ²) ≥ k + 1 from k-colour virtual edges at √3 AND at 2, neither sufficing alone on the hex-shell host (`add_one_le_chromaticNumber_plane_of_forced_pairs`; the {1, 2} host needs one, G26)."),
    ("LEDGER.md", "and distance-set-generic, and over {1, 2} one √3 gadget suffices (`six_le_chromaticNumber_oneTwo_of_forced_sqrt3`);"),
    ("BIBLIOGRAPHY.md", "Nothing of ours rests on any family but 158."),
    ("plans/EXT-OAI1-audit.md", "- the import's two statements closed by the release's theorems (`ImportReadback.lean`);"),
    ("LEAN.md", "(`StandingFive.kloosterman_bound`, with `kloostermanBound_of_ringChar_ne_two` and `kloosterman_page_of_kloostermanBound`)"),
    ("LEAN.md", "A statement that concludes `False` is skipped as a refutation, so a marker on it is never read and proves nothing either way."),
    ("LEAN.md", "(`StandingFive.StandingFloor`, FS131-LT5)."),
]


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


def check(root, slots, record_text):
    bad, rows = 0, []
    rec = norm(re.sub(r"^\s*>\s?", "", record_text, flags=re.M))
    for path, words in slots:
        hay = norm((root / path).read_text(encoding="utf-8"))
        n = hay.count(norm(words))
        in_rec = norm(words) in rec
        ok = n == 1 and in_rec
        bad += not ok
        rows.append(f"{'ok ' if ok else 'BAD'} {path}: occurs {n} time(s); quoted in the record: {in_rec} — {norm(words)[:72]}…")
    return bad, rows


def main(argv):
    root = Path(argv[argv.index("--root") + 1]) if "--root" in argv else ROOT
    record_text = (root / RECORD).read_text(encoding="utf-8")
    bad, rows = check(root, SLOTS, record_text)
    if "--self-test" in argv:
        if bad:
            print(f"SELF-TEST NOT RUN: the list as it stands fails ({bad}); the partner must pass first")
            return 1
        plants = {
            "a changed word": [(SLOTS[0][0], SLOTS[0][1].replace("6521", "6522"))] + SLOTS[1:],
            "a slot that occurs more than once (too short to place a draft)": SLOTS + [("CLAUDE.md", "declared outside theorem")],
        }
        ok = True
        for name, planted in plants.items():
            b, _ = check(root, planted, record_text)
            print(f"plant '{name}': {'FIRED' if b else 'SILENT'}")
            ok = ok and b >= 1
        b, _ = check(root, SLOTS, record_text.replace("cannot be discharged", "can not be discharged"))
        print(f"plant 'a slot the record does not quote': {'FIRED' if b else 'SILENT'}")
        ok = ok and b >= 1
        print(f"SELF-TEST {'OK' if ok else 'FAILED'}: {len(SLOTS)} slots pass unplanted; 3 plants")
        return 0 if ok else 1
    for r in rows:
        print(r)
    print(f"slots: {len(SLOTS)}  bad: {bad}  root: {root}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
