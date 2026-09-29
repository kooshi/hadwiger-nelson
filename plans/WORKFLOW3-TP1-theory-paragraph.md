# TP1 — the theory in one paragraph: checked clause by clause, and its replacement drafted

*Ephodos, 2026-09-28. Brief: `data/workflow3/briefs/TP1-theory-paragraph.md` (with `plans/STANDING-RULES.md`). A drafting job for the
front page; not blind, no fences. This record is the job's only working file; `CLAUDE.md` is not edited here (Keryx files the draft).*

## Theorems this phase proved

None. This job checks a summary paragraph against its sources and drafts its replacement; it derives nothing new.

## Would have searched here

Nothing. The job reads text and greps it; no move of it is a search for a finite witness.

## Stage 1 — SAVED: the readback

Each quotation in the brief, checked against its source by a script (whitespace normalised; `CLAUDE.md` read from disk, not from the
launch snapshot):

| quotation in the brief | source | result |
|---|---|---|
| Kooshi: "Let's say 80kB for CLAUDE.md, and 200kB for grokkings. Also, in CLAUDE, we still call grokkings "the working theory of the 5th colour". That feels a bit out of date. Make sure that the "theory in one paragraph" is also valid." | `plans/WORKFLOW-AUDIT-2026-09-28.md` § 9 (line 128) | verbatim |
| the paragraph, "**The theory in one paragraph.** The 4/5 wall is arithmetic. … the field's number is the plane's (G81)." | `CLAUDE.md` § Grokkings — the working theory of Hadwiger–Nelson (disk, line 396) | verbatim; 13 lines |
| "`CLAUDE.md` is at 68,853 of its 80,000-byte budget" | `wc -c CLAUDE.md` | 68853 — matches |

No mismatch. One note on the brief's framing, not a mismatch: the section heading on disk is already renamed ("Grokkings — the working
theory of Hadwiger–Nelson", commit `42c67943`), so of Kooshi's two points only the paragraph is left, which is this job.

**The claims I hold, restated beside the quotations.** (1) A table, one row per clause of the quoted paragraph: the clause, its source
read by body (a `GN` in `.claude/skills/grokkings/SKILL.md` or a row of `LEDGER.md`), and a verdict — holds, stale (superseded, by
what), false (what shows it), unsupported. (2) A replacement, at most about 3,000 bytes, every clause sourced inline and graded where
it rests on less than the kernel, claiming nothing past its sources. (3) A resolution check that every cited `GN` and row exists, with
the command and its output. (4) The report in the standing rules' form.

## Stage 2 — SAVED: the clause-by-clause check

Sources read by body: the grokkings in `.claude/skills/grokkings/SKILL.md` (preloaded; G1, G2, G4, G8, G11–G16, G31, G34, G35, G38,
G43, G48, G54–G57, G59, G60, G70, G80–G86 read for this table), the rows of `LEDGER.md` extracted by number (52, 55, 57, 59, 60, 66,
67, 68, 87, 89, 99, 120, 123, 128–141, each printed in full), and `CLAUDE.md` from disk (§ The aim, § Frontier). Verdicts: *holds*,
*stale* (true when written, since superseded), *false*, *unsupported* (no source). A clause that holds but drops a grade or widens a
scope says so.

| # | clause (verbatim) | source, read by body | verdict |
|---|---|---|---|
| 1 | "The 4/5 wall is arithmetic." | G1 [kernel]; G35 [kernel over subrings; field level gated — row 57's gap, which G64 calls the kernel's, not the mathematics'] | **holds** |
| 2 | "A unit-distance graph over K is 4-colourable by a residue colouring at the prime above 2" | row 57 (Theorem B, "residue maps onto 𝔽₄ at the two primes above 2"); row 89 ("one of K's two dyadic places"); G70 (`R/2R ≅ 𝔽₄ × 𝔽₄`, "the two primes above 2") | **holds**, one word off: K(i) has **two** conjugation-fixed primes above 2, so "a prime above 2", not "the prime" |
| 3 | "so a 5-forcer is K-fabric — a small vocabulary of seam shells about rotation centres, organized by the half-spindle group — plus a spindle whose radicand breaks the 2-adic wall" | G4 [measured] ("Every known 5-forcer stands on one inventory"); G2, G8 [measured]; G1 (the wall, a necessity) | **stale** as a statement about 5-forcers: it describes the held witnesses at [measured] grade. Superseded by G11 (Moser-free five-chromatic graphs, [external]), G55 (the chain replaces the spindle: eight chained 8/3 forcers over K(√7), [hand]) and rows 121, 123 (five over ℚ(√47), ℚ(√3,√5) and every `L = 5` field, fields without √11 and, at ℚ(√47), without √3 — no 5-forcer there is K-fabric; G57: no field whose local bound could be 6 holds a Moser spindle). The wall's necessity (G1, G35) still holds |
| 4 | "its forcing is a regional pigeonhole on the fabric composed with kills that must leave K, invisible at the pair level." | G15 [measured constructive half; universality a reading]; G16, G34 (the last kill leaves K, by Theorem B); G13, G31 (pair meters cannot see it) | **holds** for the finite forcers held, at G15's grade, which the clause drops (it reads as a law). The field-level five (row 123) has no finite forcer, and row 129 recasts it as a one-class density bound |
| 5 | "Past five colours the linear arithmetic goes blind and the finite residue planes take over" | G38 ("gives 2, 3 or 4 colours and then nothing below 7"; "above four use the finite planes"); G43 (the plane at 11: "non-linear, 5"); row 52 | **holds**, off by one in its wording: by G38 linear colourings are blind from five up, i.e. *past four*; the residue planes take over at five |
| 6 | "a field is 5-sealed when a usable small prime's plane is 5-colourable" | `CLAUDE.md` § Notation ("Sealed at k"); G43 | **holds** ("small" is informal; the definition also admits the target at a prime above 2) |
| 7 | "the sealing plane carries no pair compulsion of its own" | row 60 [kernel] (`Forces ↔ x = y` on every k-colourable prime plane `p ≡ 3 (mod 4)`; the virtual-edge half only at 11); row 66 [kernel] (Γ₁₁ slack and pairwise fusable; Γ₁₉ the forces half) | **holds** for prime planes; at 19 only the forced-pair half is proved |
| 8 | "and a spindle over a forced pair removes exactly the prime that sealed its fabric." | G48 [kernel] ("the forcer deletes exactly the local bound it beats") | **holds** (vacuous at five, as clause 9 says) |
| 9 | "That mechanism now has no instance: the sealing plane at 11 has a fan gap, and a gap at level one frees every pair above it (row 66)" | row 66 [kernel] (`not_forces_of_fanGap`; Γ₁₁'s gapped table); G13; G48 | **holds** |
| 10 | "so over every 5-sealed field the five-colour compulsion structure at arity 2 is trivial — forced pairs are single vertices, virtual edges unit edges" | row 66 ("over every 5-sealed multiquadratic field ⊇ K — each has 11 usable of residue degree one"; for every graph with a homomorphism into Γ₁₁; "Not claimed: the field-level hand step … (row 57's gap)") | **holds within row 66's scope; the clause widens it.** Row 66 claims both halves for fields sealed by Γ₁₁ (named: every 5-sealed multiquadratic F ⊇ K); at a field sealed at five by Γ₁₉ alone the virtual-edge half is **unsupported** (rows 60, 66 prove it only at 11) |
| 11 | "and a residue plane forces pairs only where it is Hoffman-tight or pulls back from a tight quotient (row 87)" | G54 (tight ⟹ gap-free [derived]; gap ⟹ free [kernel]; the middle case observed, row 87; "Killing test … of the reading that the middle case comes from a tight quotient") | **holds at [reading] grade**, which the clause drops: the "only" (every gap-free slack plane pulls back from a tight quotient) is G54's reading with its killing test |
| 12 | "which at five colours no sealing plane does (G54;" | G54 ("no plane that seals a field at five does (each has a gap, row 66)"); row 66 (gaps at 11 and 19, kernel) | **holds** |
| 13 | "at 2 with four colours the plane is tight and the tower forces from level 5, row 67)." | row 67 [kernel at levels 4–5; hand for tightness at every level] | **holds** |
| 14 | "So a 6-forcer's every compulsion lives in a 6-open field (G48), where the residue method is silent;" | G48 [kernel] (same sentence); row 66 ("Not claimed: … anything at arity ≥ 3"); G31 ("Open: arity 3") | **holds at arity 2** — "every compulsion" drops the arity the sentence's source is scoped to (G48 drops it too; the paragraph's clause 10 carries it) |
| 15 | "what it can still name is a 5-colourable, 5-tight quotient of such a plane (FS-42)," | G54 ("the only residue route left … (FS-42, a reading with its falsifier)") | **holds at [reading] grade**, grade dropped; low bearing now (FS-42 is rank 29, "none beyond FS-49's"; a finite witness for six is out as a route, § Publication) |
| 16 | "or the first digit at 83 (FS-40)." | G48 ("de Grey's field … is 7 outright (FS-40, closed with FS-50)"); row 68 [exact-rational] ("Six colours refused at 83 … FS-40 closes on the refusal side", χ(Γ₈₃) ≥ 7 on the checker's word); G56, G59 | **stale.** FS-40 is closed: Γ₈₃ is not six-colourable (row 68), so 83 can name nothing toward six; "the first digit" (a finite plane exactly six-chromatic) now lives only in the window `q ∈ {23, 27, 31, 43, 47}` and U₆₄, none decided (G56, G59). The coordinator's observation is confirmed |
| 17 | "Through five the residue reading is exact: χ(F²) = L(F) whenever L(F) ≤ 5, over every real number field (row 123, [hand], through MR)" | row 123 [hand + tools exact; MR row 120's grade]; row 99 [hand] (`L ≤ 4`, no MR) | **holds**; MR is needed only at `L = 5` |
| 18 | "— the lower half by measure rigidity for the unit-vector group (G80), with no forcer;" | G80; rows 120, 123 ("With MR (row 120) that gives five; below five it is row 99"; "Not claimed: an explicit five-chromatic graph") | **holds at `L = 5`**; below five the lower half is row 99's slope argument (G74), not MR. Missing beside it: row 129 — the five is a one-class fractional bound rounded, and that route never gives six |
| 19 | "and where every stable place mixes, the field's number is the plane's (G81)." | G81 [hand, two blind minds]; row 128 ("given MR … for every totally real number field `F` whose stable places are all 6-thick") | **holds in substance; scope and grade dropped**: it is stated for *totally real* fields whose stable places all mix *at six colours* (6-thick), and *given MR*; unqualified it reads wider and unconditional |
| — | the paragraph as a whole: "a fair statement of what the project understands now" (the brief's test) | § The aim links 1–6; rows 128–141; G81–G86 | **stale.** It stops at the collapse's first sentence and says nothing of the density cap (row 129), the stability question (row 131), the regular half (row 132), the bounded-complexity map question and its four-colour vertex (rows 133–138), the two routes (row 139) or contact regularity (rows 140–141) — the whole of the direction the project now follows. Its first two thirds are the five- and six-forcer design theory, which the aim retired as a route |

**Summary.** No clause is false. One is stale in the sense the brief names (16, FS-40), one is stale as a universal (3, the shape of a
5-forcer), four drop a grade or widen a scope (4, 11, 15 their [measured]/[reading] grade; 10 and 19 their scope; 19 also "given
MR"), two carry a one-word slip (2 "the prime", 5 "past five"), and the paragraph as a whole describes the project as of FS-103, not
now. The framing of the job is right: the paragraph needs rewriting, not patching, because what it omits is the theory's present half.
