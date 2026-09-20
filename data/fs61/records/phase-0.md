# FS-61 phase 0 — the instrument: the phase record

*Plan: `plans/FS61-quadratic-census.md` §6 phase 0, §5 rule 16. Implementer: de Bruijn (Opus 5), 2026-09-19.
Machine for every number below: **the desktop, 16 physical cores / 32 threads, 128 GB**, idle except
where a row says otherwise. Timings are wall seconds unless a row says CPU seconds. Every command is pasteable from the
repository root after `source scripts/dev-env.sh`.*

**What phase 0 built.** `tools/fs61_census.py`, the census driver: a thin layer over the frozen FS-58 instrument that
enumerates a field's lattices, canonicalises them so that one lattice has one name however many class specs produce it,
asserts that every unit vector of a lattice is one of its generators, asks whether balls of those lattices are
3-colourable, and records all of it as JSONL that a re-run resumes from. Nothing in `tools/fs58_*.py` or `data/fs58/`
was edited (gate 0.8).

**Verdict:** *(written once every item has been run — see §The gate)*

---

## The gate

*(filled in as each item lands — see §Results below)*

## Plants and controls

*(filled in below)*

## Cost and machine

*(filled in below)*
