# FS-100 close inventory (opened by the product owner, 2026-09-26, with the plan; WORKFLOW 5 — the owner is its only writer until the close)

*Milestone: FS-100's in-ban stages (`plans/FS100-three-field-lemma.md`). Planner J51; derivation J51D and blind verifier J51V in parallel. One line per item with its source; the close planner ticks each done or declined with its reason and reads every number from the source.*

## Items

| # | kind | item | source | status |
|---|---|---|---|---|
| 1 | result | J51-T1: real quadratic ℚ(√d) is in T-C(A)'s class ⟺ d ≡ 47, 143, 167 (mod 168) ⟺ L ≥ 5; ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√167) in class [hand + tools exact, one mind; rests on J28D's class form, Lemma P, FS-66] | plan §1.4; tools/j51_tca_class.py (plant fired) | open |
| 2 | result | J51-T2: for every finitely generated Γ ⊂ U_F, ann(ℤ[Γ]) is a proper infinite closed invariant subgroup of R̂, so EL's Thm 1.2 never applies [hand, one mind] | plan §PA.3 | open |
| 3 | result | J51-T3: KS-sat ⟹ Kronecker selection, by fibre colour sets, no measure [hand, one mind, sketch; J51D/J51V check it as KS-2] | plan §PA.3 | open |
| 4 | result | the card answered: branch "first yes (EL2021 Thm 1.3, modulo PE-lim), second no/open" [reading, one mind] | plan §PA.3 | open |
| 5 | prior-art debt | EL2021 (arXiv 2101.11120v1) §§2–9 unread; copy at data/fs100/j51/el2021.pdf | plan §PA.2 | open |
| 6 | prior-art debt | EL2003 ERA-AMS: author summary only (AMS PDF bot-blocked) | plan §PA.2 | open |
| 7 | prior-art debt | Rudolph 1990, Johnson 1992, Host 1995: zbMATH reviews only | plan §PA.2 | open |
| 8 | prior-art debt | Z. Wang 2012 (non-hyperbolic) and Lindenstrauss–Wang 2012 (topological self-joinings): KS-3's nearest literature, unread | plan §PA.2 | open |
| 9 | prior-art debt | Bekka–Francini 2022 (characters of algebraic groups over number fields via solenoid rigidity): possibly the closest in print to MR; unread | plan §PA.2 | open |
| 10 | correction owed | stub §5 item 5 "not checked here" → J51-T1; stub §2.3/§7 "probably includes ℚ(√167) (not checked)" → checked, yes | plan §S proposed edits | open |
| 11 | correction owed | J43's facts file: ℚ(√143), ℚ(√311), ℚ(√335) untagged though in row 113's class form | plan §S proposed edits | open |
| 12 | correction owed | Kronecker selection's "closure of the image of Θ's (T + A)-part" is ill-defined as a subgroup of Tⁿ; read as the factor K/K₀ with K̂′ = {m : m·Θ ∈ T + A} | plan §S | open |
| 13 | prediction scored | J50's hunch mr-is-open-measure-rigidity: supported by a read citation (EL2021 Thm 1.2's dichotomy; total irreducibility fails here) | plan §PA.3 | open |
| 14 | prediction scored | J50's card: hunch "first yes, second no" — met, with the first yes conditional on PE-lim | plan §PA.3 | open |
| 15 | prediction registered | X-MR 0.7 true / 0.02 decided here (a belief, not scoreable in-ban) | plan §P | open |
| 16 | prediction registered | X-KS 0.50 TRUE / 0.15 FALSE / 0.35 GAP; P-sat 0.85; P-sat1 0.70; P-K0 0.75; P-EL 0.80; P-ent 0.05 | plan §P | open |
| 17 | prediction registered | X-R1's killing test written: a U-invariant E-null τ, weak* limit of Fin_S-carried measures, not Haar | plan §P | open |
| 18 | stub to mint or re-aim | PE-lim (from EL2021 Thm 1.3 at finitely generated Γ to U-invariance: positive entropy ⟹ Haar on R̂) — stage 5's derivation | plan §PA.3, §S | open |
| 19 | stub to mint or re-aim | FS-64: Kronecker selection + T-C(A) would close four-colour adelic windows over every class field, not only ℚ(√47) | plan §IQ item 5 | open |
| 20 | bears | G21: route-dependence audit; controls of the right shape (KS-5 added) | §G.1 | open |
| 21 | bears | G27: Galois-averaged τ allowed in MR | §G.1 | open |
| 22 | bears | G30, G46, G49, G50: the recognition (R̂ an EL solenoid, U by automorphisms; self-joinings) and the gate | §G.1 | open |
| 23 | bears | G35, G43, G44, G66: the class check's inputs | §G.1 | open |
| 24 | bears | G48, G64: targets as values of L; S and W apart | §G.1 | open |
| 25 | bears | G54, G55: no tight place → a count; R = O′ makes R̂ S-adic with S infinite | §G.1 | open |
| 26 | bears | G60: P1's finite H route (post-ban) | §G.1 | open |
| 27 | bears | G71, G72, G73, G79: §IQ — pair-level carrier, structural form, averaged certificates, the example invariant | §G.1 | open |
| 28 | bears | G74, G76, G77: Kronecker's rank one is band rigidity; Berend with the rotated plane set aside; C9 the control | §G.1 | open |
| 29 | bears | G51, G67: one derivation + one blind verifier; the terse form | §G.1 | open |
| 30 | owner ruling | §M (the two modeling skills) left by J51 is run by J51D at its stage 1, fresh with the Skill tool, before any derivation — accepted (WORKFLOW 6 needs it before implementing, and J51 was at its budget) | owner, launch of J51D (handoff §7) | open |
| 31 | owner ruling | KS-2 stays in J51V's fixed list — dropping it would hide nothing, since KS-3 states KS-sat itself, and J51-T3 (one mind, a sketch) is what the reduction rests on | owner, launch of J51V (handoff §7) | open |
| 32 | agent slip | J51 read LEDGER § A by row heads (~240 characters), with the consumed rows read deeper, not in full as briefed — declared; accepted for this milestone | plans/FS100-three-field-lemma.md §G.2; data/crunch-2026-09-25/reports/J51.md held item 3 | open |
| 33 | file to move | EL2021's PDF committed at data/fs100/j51/el2021.pdf (567 KB); the house copy belongs in ~/source/library/ with a BIBLIOGRAPHY.md entry and its per-section reading status | 47d0106f | open |
| 34 | owner error | J51V's fence 'the bodies of commits whose subjects start "J51"' and 'reports J51*.md' literally include J51V's own — clarified at launch: its own commits and report are excepted | data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md | open |
