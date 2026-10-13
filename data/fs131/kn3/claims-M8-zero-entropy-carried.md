# Draft claim list M8-zero-entropy-carried — EF_F⁺: zero entropy is carried by `T + A` (the pigeonhole carried to the field)

*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: its own planner; likely three or four modules (the model; Lemma PF and heights; Lemma 3.1′; the pigeonhole and the wandering step).*

## The leaves it carries (quoted by script)

> NF2-LEAF-21: EF_F⁺ (D:162): the model of the dual as `𝔸_𝒮/D` (FS105:76, FS105-B-M1; X01D § 2.0, :113); Lemma PF, the product-formula gap (X01D:208; Mathlib has the product formula, `NumberField.prod_abs_eq_one`); an expanding place (X01D § 3.2, :214); Lemma 3.1′ (X01D:226); Lemma 3.2′ (a), the pigeonhole with the rational unit vectors as multipliers (X01D § 3.4, :246) over the height count (FS105:106, :110); two scales and one global point (X01D § 3.5–3.6); leaves (§ 3.7); wandering shells (§ 3.8, :301; FS105:86).
> — source: data/fs131/claims-NF2.md § The chain's leaves

> NF2-LEAF-18: Shannon–McMillan–Breiman, for EF_F⁺'s Lemma 3.1′ (X11K's node M2: "X-SMB"). Mathlib: none (searched "shannon", "mcmillan"). Whether Lemma 3.1′ needs the theorem or only the definition of entropy, I did not read.
> — source: data/fs131/claims-NF2.md § The chain's leaves

## Statements

1. `Rigidity.zeroEntropyCarried [NumberField F] (h : NoRamifiedStableDyadic F) : ZeroEntropyCarried F` — typed, `sorry`.
2. to type — the model of `Dual F` as `𝔸_𝒮/D` and, in it, `TA F` = the classes with a lift whose finite part is on the diagonal (FS105-B-M1; X01D § 2.0). **This is where the pigeonhole's reader gets its description of the one set `TA F`.** Needs `R = O′` (M9).
3. to type — Lemma 3.1′ (X01D l. 226): zero entropy gives few names. **Open classical input**: Shannon–McMillan–Breiman in its almost-everywhere, non-ergodic form — absent from Mathlib and from the release by name — unless Steps 4–5 run on convergence in mean along chosen scales (a question for the derive lane).

## Derivation addresses

EN1 § 8.1 row 12: FS100-EFP (`plans/FS100-derivation.md` l. 162); `plans/FS100-X01D-derivation.md` § 2.0 (l. 118), l. 208 (Lemma PF), §§ 3.2–3.8; `plans/FS100-X12B-derivation.md` §§ 2.1–2.2; `plans/FS105-derivation.md` ll. 76, 86, 106, 110; FS100-EFG (b) (`plans/FS100-derivation.md` l. 216)

## Imports

M1, M9, Mathlib's adeles and `NumberField.prod_abs_eq_one`

## Exports

`zeroEntropyCarried`

## Can run beside

new files; after M9 and M1's definitions (which are typed)

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. What I read: not read by me; the largest block of the chain that is entropy; size unknown.
