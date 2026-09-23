# FS-71 — the owner's blind controls (NOT in the plan; NOT in any brief)

Each is a defect, an owed check, or a misfiled grade that a complete audit of the batch's own sources surfaces without being
told. Score each batch: found / missed. A missed control is a completeness defect of the batch's enumeration (G21); the
successor (or the owner at the close) fixes it, and the miss is recorded in the plan §R.

| id | batch | the control | where it is visible to a reader of the batch's sources |
|---|---|---|---|
| C3 | 2 (M37–M52) | row 44's `Instances/OneTwo` module "two docstrings cite does not exist" — a proof address that does not resolve | LEDGER row 44; grep `OneTwo` in Proofs/ finds only the docstrings |
| C7 | 2 | M43's fine-tail "does not factor" claim was WITHDRAWN (G28 demotion record); the batch must file M43's virtual-edge count as M45's measurement and nothing from M43 as a theorem | G28; M43/M45 plans |
| C-spare | 2 | row 45's "spare-colour lemma ((k−1)-colourable ⟹ no pair compulsion at k)" is a hand lemma consumed by FS70-T3 and G40 — it should be filed with a kernel decision (is it kernel anywhere? `Absorb.lean`'s `extends_of_repaint` is close) | LEDGER row 45; FS70-derivation T3 |
| C8 | 3 (M53–M61) | `plans/FIELD-WALL-THEOREM.md` Prop. 6.4 is CORRECTED by row 63 (G38): the batch must file it as superseded/defective, not as a theorem | G38's sentence "correcting `plans/FIELD-WALL-THEOREM.md` Prop. 6.4" |
| C10 | 3 | M56's lemma L7 ("1/p ∈ Σ₀ iff no conjugation-fixed prime above p") is a CONJECTURE in M56, proved by GPT Astra (G55), prior art `[Fischer1990b]` Thms 1, 3, 4 for the multiquadratic odd-unramified and quadratic cases; and several of M56 L1–L6 are Fischer1990b's — the batch must re-attribute | G55; BIBLIOGRAPHY `[Fischer1990b]` row; row 57 |
| C9 | 3 | G31: "forcing at χ allows ≤ 2 critical vertices, and this 1-sum has 3" — the ≤ 2 is row 48 (kernel); the "1-sum has 3 critical vertices" is a computed fact — file the derived corollary (no forced pair at five on the 1581) under M54 with row 48 as its source, not as a measurement | G31, row 48 |
| C4 | 4 (M62–M64) | row 65 (iii): the free-circle theorem's hypothesis "has never been met by any object built" — G30 #5 (a theorem over an uninhabited domain in practice); the batch must file the free-circle theorem with that caveat | LEDGER row 65 (iii); `plans/M63-phaseH3-*` |
| C-G7 | 4 | G7's "the only rational cosine putting the spindle distance at integer n" — a theorem in `plans/M63-phaseH2-the-family.md` §3; prior art `[Polymath16wikiMain]` (the family) — the batch must file the uniqueness claim with its proof checked (is "only" proved or asserted?) | G7; row 64 |
| C2 | 5 (FS-24–FS-38) | row 63: "the multiquadratic iff is unchecked against `[AxenovichEtAl2014]` and `[Johnson2006]`" — an owed prior-art check on the two-colour iff; the batch must run it (held? `[Johnson2006]` is marked unread in row 73) | LEDGER row 63 |
| C14 | 5 | FS38-derivation D2-A: balance and gap-freedom are Blokhuis–Brouwer–Haemers 2007 Prop. 2.3 (`[AbiadEtAl2025]`); "the periodicity ours" — the completed entry must carry the split | row 67; G54 |
| C15 | 6 (FS-50–FS-66) | row 70's "[proof] … every odd-degree real field is 2-colourable" is `[Moorhouse2010]` §7.1 (bibliography row says so) — the batch must attribute it | BIBLIOGRAPHY `[Moorhouse2010]` row; row 70; G56 |
| C16 | 6 | G61(2): "the 3-adic plane … stays rigid tensored with the residue planes at 7 and 11" is MEASURED and was "leaned on as if proved" (FS-67's stub) — must be filed as measured with FS-67 as the open theorem, never as a theorem | G61; FS-67 stub; row 72 |
| C5 | 6 | row 74: "`[ZanardoZannier1991]` Thm 3 … was not re-read for this" — an owed reading behind a pointer; file as owed, not as prior art confirmed | row 74 |
| C6 | 6 | G58: "Bibliography keys owed" (`[GarciaMarcoKnauer]` arXiv:2303.06262 cited in G58 with no BIBLIOGRAPHY entry) — `bib_audit.py` may or may not catch a key inside CLAUDE.md; the batch touching FS-53 should add the entry | G58 |
| C12 | 6 | G64's demotion: S ⟺ W was claimed, only S ⟹ W holds; the batch files the derived S ⟹ W (given the bridge) and the exact form, with the demotion, from `data/fs62/` and CLAUDE.md | G64 |

Batch 1 (M17–M36): no planted control beyond the seed — the density is low; score on completeness of rows 12–33's [tools]
clauses and on whether the quadrature law (row 27) and the stacking law (row 29) are filed as derivations with their proofs
located (or "not on disk").

Found at the gate by the owner (not a control; already corrected): G35's quaternion identification.
