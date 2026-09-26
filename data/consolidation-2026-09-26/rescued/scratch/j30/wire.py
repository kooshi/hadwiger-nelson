#!/usr/bin/env python3
"""J30 stage 4: append address-only pointer blocks to stubs and milestone plans; insert one-line correction-owed banners at anchors."""
import os, re, sys
R = "/home/kooshi/source/lean-dir"; os.chdir(R)
IDX = "`plans/CRUNCH-2026-09-25-INDEX.md`"
HEAD = "## Where the 2026-09-25 work on this lives"
INTRO = (f"*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is "
         f"{IDX}; a blind verifier does not open it.*")
REP = "data/crunch-2026-09-25/reports/"
def block(lines):
    return "\n\n" + HEAD + "\n\n" + INTRO + "\n\n" + "\n".join("- " + l for l in lines) + "\n"
BLOCKS = {
 "plans/STUB-plane-bridge.md": [
  "`plans/M2-kernel-lane.md` — the kernel lane's plan (crunch milestone M2), §2.3 and §4.1 on this stub",
  "`plans/M2-S2K-route-c.md` — job J15's record: route C in the kernel; module `Proofs/HadwigerNelson/Transcendental.lean`",
  "`plans/M2-S1D-bridge.md` — job J17's record: the bridge's hand step",
  "`data/crunch-2026-09-25/briefs/J17K-M2-bridge-kernel.md` — the brief of the queued kernel job on the bridge",
  f"`{REP}J04.md`, `J15.md`, `J17.md` — the job reports",
  "`plans/M2-close-inventory.md` rows 1, 12–15, 29–34 — items for this stub, including a correction owed to it (row 13)"],
 "plans/STUB-chain-theorem.md": [
  "`plans/M2-kernel-lane.md` — the kernel lane's plan (M2)",
  "`plans/M2-S1K-chain.md` — job J14's record: this stub's theorem and instances in the kernel",
  "`Proofs/HadwigerNelson/Chain.lean`, `Proofs/HadwigerNelson/Instances/SqrtTwoThree.lean`, `Proofs/HadwigerNelson/Instances/SevenConditional.lean` — the modules",
  f"`{REP}J14.md` — the job report",
  "`plans/M2-close-inventory.md` rows 18–28, 35 — items for this stub, including its re-aim (row 35)"],
 "plans/STUB-unit-vector-ring-kernel.md": [
  "`plans/M2-kernel-lane.md` §2.2 — the kernel lane's plan on this stub; scratch skeleton `data/m2/j04/K3PrimeInversion.lean`",
  "`plans/M2-S3K-unit-ring.md` — job J16's record (in progress at this writing); module `Proofs/HadwigerNelson/UnitRing.lean`",
  "`plans/FS91-S1D-character.md` §2.3–§2.4 — job J07's record: the unit-vector ring's completions (Lemma C, C′)",
  "`plans/FS91-S0FV-three-colours-blind.md` §2.2 — job J09's record: its localisation lemma J2",
  "`plans/FS91-S1V-character.md` §3.2 — job J10's record: the blind re-derivation",
  "`plans/FS91-close-inventory.md` rows 13, 73, 79 — items for this stub, including its re-aim (row 79)"],
 "plans/STUB-biquadratic-table.md": [
  "`plans/FS91-S0F-three-colours.md` §2.7, §3.1 — job J02's record: three colours over every real number field",
  "`plans/FS91-S0FV-three-colours-blind.md` §2.5, §3.5 — job J09's record: the blind derivation beside it",
  f"`{REP}J02.md`, `J09.md` — the job reports",
  "`plans/FS91-close-inventory.md` rows 7, 12, 117 — items for this stub (row 117: its re-aim)"],
 "plans/STUB-four-colours-167.md": [
  "`plans/FS91-S1D-six.md` stages 3–5 — job J08's record: character colourings at ℚ(√167) and the window members",
  "`plans/FS91-S1V-six.md` — job J11's record: its blind verification",
  "`plans/FS91-S1D-character.md` §4.4 and `plans/FS91-S1V-character.md` §2.3 — jobs J07 and J10 on C-167",
  "`plans/M3-S1D-windows-five.md` — job J21's record: measurable windows over ℚ(√167) at five colours",
  f"`{REP}J08.md`, `J11.md`, `J21.md` — the job reports",
  "`plans/FS91-close-inventory.md` rows 81–85, 106–110 and `plans/M3-close-inventory.md` rows 16–26 — items for this stub (row 85 of the first: its re-aim)"],
 "plans/STUB-adelic-window-colouring.md": [
  "`plans/M3-exotic-colourings.md` — crunch milestone M3's plan (question 2 is this stub at five colours)",
  "`plans/M3-S1D-windows-five.md` — job J21's record",
  "`data/crunch-2026-09-25/briefs/J22-M3-windows-five-verifier.md` — the queued blind verifier's brief (record `plans/M3-S1V-windows-five.md` when it runs)",
  "`plans/FS91-S1D-six.md` \"Proposed edits\" — job J08's re-aim of this stub",
  f"`{REP}J06.md`, `J08.md`, `J21.md` — the job reports",
  "`plans/M3-close-inventory.md` rows 5, 16–26 and `plans/FS91-close-inventory.md` row 85 — items for this stub (row 23 of the first: a stub to mint)"],
 "plans/STUB-tight-product-colourings.md": [
  "`plans/M3-S1D-windows-five.md` §3.2 and §3.6 — job J21's record: products of a measured graph with compact Cayley factors",
  "`plans/M3-close-inventory.md` rows 16, 21, 22 — the related items"],
 "plans/STUB-three-colour-criterion-kernel.md": [
  "`plans/FS91-S0F-three-colours.md` §4.5 — job J02's record, its re-aim of this stub",
  "`plans/FS91-S0FV-three-colours-blind.md` §3.5 — job J09's record, its re-aim of this stub",
  f"`{REP}J02.md`, `J09.md` — the job reports",
  "`plans/FS91-close-inventory.md` rows 11, 117 — the re-aims"],
 "plans/STUB-four-colour-inheritance.md": [
  "`plans/M3-exotic-colourings.md` — crunch milestone M3's plan (question 1 is this stub in rank one)",
  "`plans/M3-S1A-rank-one.md` — job J18's record",
  "`plans/M3-S1B-rank-one.md` — job J19's record (in progress at this writing)",
  "`data/crunch-2026-09-25/briefs/J20-M3-rank-one-verifier.md` — the queued blind verifier's brief",
  f"`{REP}J06.md`, `J18.md` — the job reports",
  "`plans/M3-close-inventory.md` rows 5, 8–15 — items for this stub (row 14: its re-aim)"],
 "plans/STUB-three-colours-residue-degree-three.md": [
  "`plans/FS91-S0F-three-colours.md` §3.2, §4.5 — job J02's record: this stub's field; tool `tools/crunch_j02_field.py`",
  "`plans/FS91-S0FV-three-colours-blind.md` §2.5, §3.3 — job J09's record: the blind derivation",
  f"`{REP}J02.md`, `J09.md` — the job reports",
  "`plans/FS91-close-inventory.md` rows 7, 8, 15, 117 — items for this stub, including a banner owed and a correction owed to its text (rows 8, 15)"],
 "plans/STUB-layer-method-five-colours.md": [
  "`plans/FS91-S0V-band-to-nine.md` — job J01's record: band rigidity from four and five colours upward",
  "`plans/FS91-S0V2-SWm-second-reading.md` — job J03a's record: the second blind reading",
  "`plans/FS91-character-local-global.md` §S — crunch milestone M1's plan",
  "`plans/FS91-close-inventory.md` rows 1–6, 59–70 — the related items"],
 "plans/STUB-five-colours-47.md": [
  "`plans/FS91-S1D-character.md` §4.4 — job J07's record: C-47 through the character local–global route",
  "`plans/FS91-S1V-character.md` §2.3 (V4) — job J10's record: the blind re-derivation",
  "`plans/FS91-close-inventory.md` rows 75, 92 — the related items"],
 "plans/STUB-dyadic-rigidity-triangle-free.md": [
  "`plans/FS91-S1D-character.md` §4.4 and `plans/FS91-S1V-character.md` §2.3 (V4) — jobs J07 and J10 on HD1",
  "`plans/FS91-S0FV-three-colours-blind.md` §2.2, `plans/FS91-S1D-character.md` §2.4, `plans/FS91-S1V-character.md` §3.2 — on FS86-B1-LR's scope",
  "`plans/M3-S1D-windows-five.md` §2.5, §4.6 — job J21's record, on FS86-CL1",
  "`plans/FS91-close-inventory.md` rows 13, 75, 78, 87, 92 and `plans/M3-close-inventory.md` row 18 — the related items"],
 "plans/STUB-de-grey-chain-kernel.md": [
  "`plans/M2-kernel-lane.md` §3 — the kernel lane's plan: the stripe lemma's skeleton and price; scratch `data/m2/j04/K3Stripe.lean`",
  "`plans/M2-S3K-unit-ring.md` — job J16's record (in progress at this writing; the stripe lemma is its second half)",
  "`plans/M2-close-inventory.md` rows 4, 10 — the related items"],
 "plans/STUB-isometric-measure-rigidity.md": [
  "`plans/FS91-character-local-global.md` — crunch milestone M1's plan (FS-91)",
  "`plans/FS91-S0V-band-to-nine.md` — job J01's record: the blind verification of FS-89's PA-B2 and PA-B3",
  "`plans/FS91-S0V2-SWm-second-reading.md` — job J03a's record",
  "`plans/FS91-S1D-character.md` §4.4 and `plans/FS91-S1V-character.md` — jobs J07 and J10 on FS89-CL2 to CL5",
  "`plans/FS91-close-inventory.md` rows 1–6, 18, 59–70, 75, 78, 92 — the related items, including corrections owed to `plans/FS89-derivation.md` (rows 61, 69, 78)"],
 "plans/STUB-band-rigidity-six.md": [
  "`plans/FS91-character-local-global.md` — crunch milestone M1's plan: this stub, opened",
  "`plans/FS91-S0V-band-to-nine.md` (J01), `plans/FS91-S0V2-SWm-second-reading.md` (J03a), `plans/FS91-S0F-three-colours.md` (J02), `plans/FS91-S0FV-three-colours-blind.md` (J09) — stage 0's records",
  "`plans/FS91-S1D-character.md` (J07), `plans/FS91-S1V-character.md` (J10), `plans/FS91-S1D-six.md` (J08), `plans/FS91-S1V-six.md` (J11) — stage 1's records",
  "`plans/FS91-S1D-one-prime.md` (J12, in progress at this writing) and `plans/FS91-S1V-one-prime.md` (J13, queued) — one prime",
  f"`{REP}` — the job reports; `data/fs91/` — their data",
  "`plans/FS91-close-inventory.md` — the milestone's close inventory"],
}
PLAN_BLOCKS = {
 "plans/FS91-character-local-global.md": [
  "the jobs' records: `plans/FS91-S0V-band-to-nine.md` (J01), `plans/FS91-S0F-three-colours.md` (J02), `plans/FS91-S0V2-SWm-second-reading.md` (J03a), `plans/FS91-S1D-character.md` (J07), `plans/FS91-S1D-six.md` (J08), `plans/FS91-S0FV-three-colours-blind.md` (J09), `plans/FS91-S1V-character.md` (J10), `plans/FS91-S1V-six.md` (J11); `plans/FS91-S1D-one-prime.md` (J12, in progress) and `plans/FS91-S1V-one-prime.md` (J13, queued)",
  "tools `tools/crunch_j01_*`, `tools/crunch_j02_*`, `tools/crunch_j03a_*`, `tools/crunch_j07_*`, `tools/crunch_j08_*`, `tools/crunch_j09_*`, `tools/crunch_j10_*`, `tools/crunch_j11_*`; data `data/fs91/j01/` to `data/fs91/j11/`",
  f"reports `{REP}J01.md` … `J11.md`; close inventory `plans/FS91-close-inventory.md`"],
 "plans/M2-kernel-lane.md": [
  "the jobs' records: `plans/M2-S1K-chain.md` (J14), `plans/M2-S2K-route-c.md` (J15), `plans/M2-S1D-bridge.md` (J17), `plans/M2-S3K-unit-ring.md` (J16, in progress)",
  "modules: `Proofs/HadwigerNelson/Chain.lean`, `Proofs/HadwigerNelson/Instances/SqrtTwoThree.lean`, `Proofs/HadwigerNelson/Instances/SevenConditional.lean`, `Proofs/HadwigerNelson/Transcendental.lean`; audit lines in `scripts/Axioms.lean` (sections FS-45 and FS-39 route C)",
  f"data `data/m2/j14/`, `data/m2/j15/`, `data/m2/j17/`; reports `{REP}J14.md`, `J15.md`, `J17.md`; close inventory `plans/M2-close-inventory.md`"],
 "plans/M3-exotic-colourings.md": [
  "the jobs' records: `plans/M3-S1A-rank-one.md` (J18), `plans/M3-S1D-windows-five.md` (J21), `plans/M3-S1B-rank-one.md` (J19, in progress); the verifiers' records `plans/M3-S1V-rank-one.md` (J20) and `plans/M3-S1V-windows-five.md` (J22) when they run",
  "tools `tools/crunch_j18_*`, `tools/crunch_j21_*`; data `data/m3/j18/`, `data/m3/j21/`",
  f"reports `{REP}J06.md`, `J18.md`, `J21.md`; close inventory `plans/M3-close-inventory.md`"],
 "plans/FS89-rational-band-rigidity.md": [
  "`plans/FS91-S0V-band-to-nine.md` — job J01's record: the blind verification of this milestone's PA-B2 and PA-B3",
  "`plans/FS91-S0V2-SWm-second-reading.md` — job J03a's record: the second reading, and the Notation's archimedean part",
  "`plans/FS91-S1D-character.md` §4.4 and `plans/FS91-S1V-character.md` — jobs J07 and J10 on FS89-CL2 to CL5",
  "`plans/FS91-S1D-six.md` stage 6 — job J08's record: the band-1/6 and band-1/5 lists for `Q`",
  "`plans/FS91-close-inventory.md` rows 1–6, 18, 59–70, 75, 78, 85, 92 — the related items, including corrections owed to `plans/FS89-derivation.md`"],
 "plans/FS86-dyadic-rigidity.md": [
  "`plans/FS91-S1D-character.md` §2.4, §4.4 and `plans/FS91-S1V-character.md` §2.3, §3.2 — jobs J07 and J10 on HD1 and on FS86-B1-LR's scope",
  "`plans/FS91-S0FV-three-colours-blind.md` §2.2 — job J09's record, on FS86-B1-LR's scope",
  "`plans/M3-S1D-windows-five.md` §2.5, §4.6 — job J21's record, on FS86-CL1",
  "`plans/M3-S1A-rank-one.md` §2.1 — job J18's record, on FS86-dB-H in rank one",
  "`plans/FS91-close-inventory.md` rows 13, 78, 87 and `plans/M3-close-inventory.md` rows 10, 18 — the related items"],
 "plans/FS81-quadratic-four-colours.md": [
  "`plans/FS91-S0F-three-colours.md` — job J02's record: three colours over every real number field, from FS81-T3 and T4",
  "`plans/FS91-S0FV-three-colours-blind.md` §2.5 — job J09's record, on FS81-T6's open item",
  "`plans/FS91-close-inventory.md` rows 7, 12, 15 — the related items"],
 "plans/FS79-invariant-question.md": [
  "`plans/M3-S1A-rank-one.md` — job J18's record: FS-76 in rank one, from FS73-T30 and FS79-T34 to T36",
  "`plans/M3-exotic-colourings.md` §IQ.1 — crunch milestone M3's plan",
  "`plans/M3-close-inventory.md` rows 1, 8–15 — the related items"],
}
def cb(src, rows, inv):
    return f"> **Correction owed (2026-09-25 crunch):** see {src}; carried in `{inv}` {rows}. Not applied here; the close rewrites this entry."
BANNERS = [  # (file, anchor text that must occur exactly once at a line start, position 'before'|'after', banner)
 ("plans/FS89-derivation.md", "**Notation, fixed once**", "before",
  cb("`plans/FS91-S0V2-SWm-second-reading.md` §3.4, §3.7 and `plans/FS91-S1D-character.md` §4.4", "rows 61, 69, 78", "plans/FS91-close-inventory.md")),
 ("plans/FS89-derivation.md", "**FS89-CL2 —", "before",
  cb("`plans/FS91-S0V2-SWm-second-reading.md` §3.4 (J03a-9) and `plans/FS91-S1D-character.md` §4.4 (J07-14)", "rows 61, 69, 78", "plans/FS91-close-inventory.md")),
 ("plans/FS89-derivation.md", "**FS89-S0A-10 —", "before",
  cb("`plans/FS91-S1D-six.md` stage 6 (J08-11) and J08's \"Proposed edits\"", "row 85", "plans/FS91-close-inventory.md")),
 ("plans/FS86-derivation.md", "**FS86-B1-LR —", "before",
  cb("`plans/FS91-S1D-character.md` §2.4 (J07-4), `plans/FS91-S0FV-three-colours-blind.md` §2.2 (J2) and `plans/FS91-S1V-character.md` §3.2 (J10-T6)", "rows 13, 73, 78", "plans/FS91-close-inventory.md")),
 ("plans/FS86-derivation.md", "**FS86-CL1 —", "before",
  cb("`plans/M3-S1D-windows-five.md` §2.5, §4.6", "row 18", "plans/M3-close-inventory.md")),
 ("plans/FS81-derivation.md", "**T6 — §F.5", "before",
  cb("`plans/FS91-S0FV-three-colours-blind.md` §2.5 (J4-T6)", "row 15", "plans/FS91-close-inventory.md")),
 ("plans/FS91-S0F-three-colours.md", "### 2.10 Hypotheses used; finite degree; other subfields of ℝ", "after",
  cb("`plans/FS91-S0FV-three-colours-blind.md` §5 item 1", "row 113", "plans/FS91-close-inventory.md")),
 ("plans/FS91-S1D-six.md", "- **ℚ(√167).** *Unconditional (J08-7 + J08-3):*", "before",
  cb("`plans/FS91-S1V-six.md` stage 4 (the divergence table and its closing notes)", "row 109", "plans/FS91-close-inventory.md")),
 ("plans/FS91-S1D-character.md", "- **(g3) At `k ∈ {6, 7}`**", "before",
  cb("`plans/FS91-S1V-character.md` §3.1 item 19 and §4 row 10 (J10-T8)", "row 105", "plans/FS91-close-inventory.md")),
 ("plans/FS91-S1D-character.md", "### 3.1 CLG_k — TRUE for every real number field and every `k ≥ 2`, given `H_k`", "after",
  cb("`plans/FS91-S1V-character.md` §2.3 and §4 row 6", "row 89", "plans/FS91-close-inventory.md")),
 ("plans/FS91-character-local-global.md", "- **SIX-e (the fields).**", "before",
  cb("`plans/FS91-S1V-six.md` stages 3–4", "row 110", "plans/FS91-close-inventory.md")),
 ("plans/M2-kernel-lane.md", "### 2.1 §PA — the repository's own modules, read at their source", "after",
  cb("`plans/M2-S1K-chain.md` stages 1 and 3", "row 23", "plans/M2-close-inventory.md")),
 ("plans/M2-kernel-lane.md", "### 2.2 §PA — Mathlib and core, per statement", "after",
  cb("`plans/M2-S2K-route-c.md` §1.1", "row 32", "plans/M2-close-inventory.md")),
 ("plans/M2-kernel-lane.md", "### 2.3 §PA — the prior-art gate on the bridge (J17), time-boxed", "after",
  cb("`plans/M2-S1D-bridge.md` §1.1 (Q5–Q7)", "row 14", "plans/M2-close-inventory.md")),
 ("plans/M3-exotic-colourings.md", "### PA.1 Question 2 — measurable colourings, products, windows", "after",
  cb("`plans/M3-S1D-windows-five.md` §1.1 (Q7)", "row 19", "plans/M3-close-inventory.md")),
 ("plans/M3-exotic-colourings.md", "### S. The stages as jobs", "after",
  cb("`plans/M3-S1A-rank-one.md` §2.4", "row 9", "plans/M3-close-inventory.md")),
 ("plans/M3-exotic-colourings.md", "### M. The modeling passes", "after",
  cb("`plans/M3-S1A-rank-one.md` §2.1 and §2.4, and `plans/M3-S1D-windows-five.md` §3.6", "rows 9, 10, 20", "plans/M3-close-inventory.md")),
]
dry = "--dry" in sys.argv
touched = set()
for f, anchor, pos, text in BANNERS:
    L = open(f, encoding="utf-8").read().split("\n")
    hits = [i for i, l in enumerate(L) if l.startswith(anchor)]
    assert len(hits) == 1, (f, anchor, hits)
    i = hits[0]
    if any("Correction owed (2026-09-25 crunch)" in L[j] for j in range(max(0, i - 2), min(len(L), i + 3))): continue
    if pos == "before": L[i:i] = [text, ""]
    else: L[i + 1:i + 1] = ["", text]
    if not dry: open(f, "w", encoding="utf-8").write("\n".join(L))
    touched.add(f)
for f, lines in list(BLOCKS.items()) + list(PLAN_BLOCKS.items()):
    s = open(f, encoding="utf-8").read()
    assert os.path.exists(f)
    if HEAD in s: continue
    if not dry: open(f, "w", encoding="utf-8").write(s.rstrip("\n") + block(lines))
    touched.add(f)
print(len(touched)); print("\n".join(sorted(touched)))
