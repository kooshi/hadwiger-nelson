import Proofs.HadwigerNelson.Arith.NormOneTarget

/-!
# The floor at 128: `χ(U₁₂₈) ≥ 8`, by the ratio bound and an exact integer spectrum (FS-131 wave 10, second pass)

**Read aloud, against the informal claim.** G56's "`U₁₂₈`'s Hoffman floor is 8": `U₁₂₈ = Cay(𝔽_{2¹⁴}, μ₁₂₉)`, the level-one
target at an inert prime above 2 of norm 128. In characteristic 2 an additive character is `±1`-valued, so the 127
non-trivial eigenvalue classes are odd integers; computed exactly they are `−19, −15, …, 21`
(`tools/fs131_k10b_u128.py`, two routes), and the ratio bound gives `χ ≥ 1 + 129/19 > 7.78`. **No outside theorem.**

**The certificate** (kernel-checked here, each a `decide +kernel` on `Nat`): `𝔽₂[x]` is coded in `Nat` (bit `i` is the
coefficient of `xⁱ`), sums are `^^^`, multiplication by `x` is `<<< 1`.

* `P = x¹⁴ + x⁵ + x³ + x + 1` divides `x^(2¹⁴) + x` (`clmul_P_qBig`), and is coprime to `x⁴ + x` and to `x¹²⁸ + x`
  (`bezout4`, `bezout128`): Rabin's test, so `P` is irreducible — a root `g` of `P` exists in every field of `2¹⁴`
  elements, and `1, g, …, g¹³` is an `𝔽₂`-basis.
* `g` has order `16383 = 3·43·127` (`order_checks`: `g^5461, g^381, g^129 ≠ 1` in coordinates).
* one pass of the shift register `x ↦ x·g` over the 16,383 powers of `g`, the coordinate-0 bit of `gⁿ` counted into 127
  packed 8-bit counters by `n mod 127` (`counts`): every class has at most 74 ones (`counts_ok`), so every non-trivial
  character sum over `μ₁₂₉` is at least `129 − 2·74 = −19`.

**The leaf** is the bridge `charSum_128_ge`: from the certificate to the character sums of an abstract field of `2¹⁴`
elements (the plan: `plans/FS131-w10-kernel-plan.md` § 7.2). The floors are then compositions, proved here over it.

**Inhabitants.** `GaloisField 2 14` is a field of `128²` elements with the non-trivial involution `x ↦ x¹²⁸`, so
`TargetFloor n 128` does not quantify over an empty domain.
-/

namespace HadwigerNelson.Floor128

open Finset StandingFive

/-! ### The certificate -/

/-- Carry-less multiplication of `a` (read over `fuel` bits) by `b`: the product in `𝔽₂[x]` of the coded polynomials. -/
def clmul : Nat → Nat → Nat → Nat
  | 0, _, _ => 0
  | fuel + 1, a, b => (if a.testBit 0 then b else 0) ^^^ clmul fuel (a >>> 1) (b <<< 1)

-- BEGIN CERTIFICATE (generated: tools/fs131_k10b_gen128.py)
/-- The modulus `x¹⁴ + x⁵ + x³ + x + 1`, a primitive polynomial over `𝔽₂` (bits 14, 5, 3, 1, 0). -/
def P : Nat := 16427
/-- The quotient `(x^(2¹⁴) + x) / P` in `𝔽₂[x]`. -/
def qBig : Nat := 0x402b111e6076b7e26de19472453103ed9ba41538c65ecf333aaf3dbc72a559b8400b0496ef468cb99cd764b87c139b6c6d69c7325a3de054a3326a22ac9c0b149c2b0114a4312fffc0190f0a202d92a1db5f73d1c310fea48963f317bdca4511166514942e6337683ff9038da53d84688bb2dc682bf176dbdb2742ee3614a0339eee261e647406f38be6ff0c63ef1aaabff705061fe48e60b6cad14f410faa638721510d6b463cf0f2230c73e5deed27eaa8fe849ceb7c278691b427e6af2db6b6e2c1a5edf39fee8a5a1df5dc2c0251795daafbdea509999552fcfdf55c7a206db9b0c53f0566217d1f30fb26c2145051e1042ea34a5b1d599855838ba6d41d7d8f6c1d5d9ae4926da1bf635b51755a79c9f4acb41bfe30d73499a94a6307777331abab533429e024976fbceafcdde0d4f51056e241f3cfcf5f03e59ec636f4c888337e869db3f4d485240b3489a38e249f6adec930d33628b8ac646c0955efb2ec776739defd2d2eef66993113e75fe38d256ba6544b5fb3acf0325e3f51454535015c8a421253b878112a7d8b6eac4c7ce3f91387617a1c75264a47104eede7979bdc2407335a91a42d22e8b5ab1b1a5add88ef0ea2caa17b1cd96233c6ca91645011ca1530c33cecff3479c1f1ce97d7f0e62b79259bc42ba1570e82df29f42ce239c2f03a5b5d72894be3fd1136709c1b1e586c990909c9b487a5059e4660d6f448de11424670dc300f460cefbeeba45513d740af458d4d505de6d71c8943e69f32fa7e4ae753e45e1741afe9c934d187395eab0f122f8bf6f5c824770707476c7d630375c2204dac384a0f3e3dd04beffac2045a95a69c330eb2c0653c84c4cfcb5db2f478c15d8aee562a39a2cea3ca0d3f6558b8ec4f7d173599050e1a86adacb81c2d02fd3d242b21012cbe1fc49be839faea14b0395aa9be03c98c9d8beefa6e4023147c43bab93491ac2840cb79a5cde61761ba614604eadcc8685bc52b0d13770305f67d9b64680be4fe54eb1c191f00e46a0abc76a7e8a9a60c6fe8c99895feb8847486a5a9da3fe10c2bc16997138f64183fb9289cbb5df2df69df3dfc59b447d836bce6fb0ed2fefcadd48923d806a3aa33a6f408f5005c26066bd262a7989dfbdaa7b88873559783d382636749eaa0fbe6bf2772f17adc081568e78b96cb51b5274aeb54376c3d48126ba256fa4e55ab9b4c78e148026166116253f85300341dfdd94e219d778b56b6629787d13372814e81dedd38a66056a26ae2d1af29b407f327a2868db930931d39a6cc12dbeb380e269e32563a3366893bd7a0c7fe20ddf0de3157ceffec0b54b73a1f74d286cd92218d7d4f112e7f3a7f4a4b179ddfcd9e265e4f651893fd511d61827b68ef8ef4e89dbbf1b6a6e805e275ee3216112278e94d6042aa1fb4afb5ef32ba555bf93392e9f52c4e7dbb71e084d4c50f1a2ae9d539c6f28b4abb75e235c523087154cf0b2081d6d85a85ac587496af6d9da7fca1d35a11f20f1e2858c4dfc199f56c656ca511963336a8ee8e58ace43a2b692f5f83b3bcfaf619a74ce8bdae793996d35e13431ef82f33baf91f80b248367c9bc82c7265248b62ab9f4ec9f0ae050a1837bc4abf7753242324630f72111267a585c8645c1619271aca816e945652089d3ba7949a28e88db135f13ef5a81aee96570a806e38122b8947e42e231c792199753a475065fcf9f7ed6bc66ad2cee3e11c21052e0f0e229c8347dc340df71d09b980da73cdce078b169d7389e7a78490ecaf15ac9809a58dcd067fda17f1e6873d5c1a1ef428e088d3163d3023545752a4d942264e45a15f0be0fce5fafa1e747ec2b413fb52f4f8977fb62ebb45fd790d8b2e875d62838fa4650c9b8807637b44fdd549f2af5d82eb3409f5ac185f87b10deb101ecc32ce63b73e1dc5c360caf95faba356560a2c2a4193f156ce53a872d56de596c354d70486e582cb21817a9c23047687fd21293c54b338ae653481a6ec07536408357d6f04a6f00a4411ba216d15f4bcbedfb9a8ca99613232061be63f7150cdba3167d1b324a3724133b2fc7da37e46e080d6741efc2d82ab1f18ebcc6ee865dcec7f625bfd3123f8132b25039daff9c3f0961f24f353946a4a9767b988df11ee02095dead0cfbb69ef22b0911c612e3f116e542b612a3da07fb22c0a541b7e66f508594425a7dcb45bd521c954ef1ea80ee6e301749aa8beaf8df51c513173d9c672dd6887b50f5a01f8cb59b04569275ae19070f420e5eaf0da33e6df19eb602a91e40633f6d5ddacf8373c1c9d4b93c94ce0b8cc5af59805a25eff2c7667959a84acf430ef2eb7422e4b278293053600a846c8903cd8e2c9a08fd053e05ca65049eea24af75920198f5c0211524cb49ba812ebf474c68eb8c45f97bbc9ac880361ca551bd2228c89839bac105ae592c1e5c6e2818efcedff983db87014485e47607ab0315fcb9dcfc75a61c652c8e008853401f0ce3b938967f1a6ac2c427a6843ca8d694764780120b9ccf6b1e1847881769bf0365c8e40a3425e7f7a545b5577eb682ff3c7ca3d20299010cab974babd3620bdce47a0078313ff5045e97178dd509d9be43e29d83eb984d8c2dc2800e068bbad90a083d780d276afedcb85c0613e35d529cc36ccd2a6d81aaebd4614e0188ff04668d3966b121f94ba3d6002810eaacfc358d0d7b4cf8b76a3ea18b7ea6883b7be4be7ffa027969b70607eb2804e2d9aa4b97cbfdf15ecb318bbedbbb19db7f66594c20c5ff785503dd84e8dd90e0a8c69eb200180fa66454137b04d6c45792d9ea6086d59d87e9295c6a2aa9fe28d892fdfd591803a1b7663972b954af35b9108695b696f7492addc8c41fbcaad7ccfeb483a7b48fa067bd8a6e
/-- Bézout cofactor of `P` against `x⁴ + x`. -/
def a4 : Nat := 0xd
/-- Bézout cofactor of `x⁴ + x` against `P`. -/
def b4 : Nat := 0x3257
/-- Bézout cofactor of `P` against `x¹²⁸ + x`. -/
def a128 : Nat := 0x7d630375c2204dac384a0f3e3dd04bef
/-- Bézout cofactor of `x¹²⁸ + x` against `P`. -/
def b128 : Nat := 0x1f54
-- END CERTIFICATE

/-- Multiplication by `g` in the basis `1, g, …, g¹³`: a shift, and the reduction `g¹⁴ = g⁵ + g³ + g + 1` when bit 13 is
set. -/
def step (x : Nat) : Nat := if x.testBit 13 then (x <<< 1) ^^^ P else x <<< 1

/-- One pass of the shift register: from the state `x = gⁿ⁰` at index `i = n₀ mod 127`, over `fuel` steps, adding the
coordinate-0 bit of each power into the `i`-th packed 8-bit counter. Returns the last state and the counters. -/
def pass : Nat → Nat → Nat → Nat → Nat × Nat
  | 0, x, _, acc => (x, acc)
  | fuel + 1, x, i, acc => pass fuel (step x) (if i = 126 then 0 else i + 1) (acc + ((x &&& 1) <<< (8 * i)))

/-- The whole orbit: `g^16383` (which must be `1`) and the 127 counters `c_i = #{n ≡ i (mod 127) : (gⁿ)₀ = 1}`. -/
def counts : Nat × Nat := pass 16383 1 0 0

/-- The orbit closes, and every counter is at most `bound`. -/
def countsOk (bound : Nat) : Bool :=
  counts.1 == 1 && (List.range 127).all fun i => (counts.2 >>> (8 * i)) &&& 255 ≤ bound

/-- `P · qBig = x^(2¹⁴) + x`: `P` divides `x^(2¹⁴) − x`, so it splits in every field of `2¹⁴` elements. -/
theorem clmul_P_qBig : clmul 15 P qBig = 2 ^ 16384 ^^^ 2 := by decide +kernel

/-- `a4·P + b4·(x⁴ + x) = 1`: no root of `P` lies in `𝔽₄`. -/
theorem bezout4 : clmul 15 P a4 ^^^ clmul 14 b4 (2 ^ 4 ^^^ 2) = 1 := by decide +kernel

/-- `a128·P + b128·(x¹²⁸ + x) = 1`: no root of `P` lies in `𝔽₁₂₈`. -/
theorem bezout128 : clmul 15 P a128 ^^^ clmul 14 b128 (2 ^ 128 ^^^ 2) = 1 := by decide +kernel

/-- `g^(16383/r) ≠ 1` for `r = 3, 43, 127`, in coordinates: `g` generates the multiplicative group. -/
theorem order_checks : (pass 5461 1 0 0).1 ≠ 1 ∧ (pass 381 1 0 0).1 ≠ 1 ∧ (pass 129 1 0 0).1 ≠ 1 := by decide +kernel

/-- **The certified spectrum**: the orbit closes and every class has at most 74 ones — so every non-trivial character sum
is at least `129 − 2·74 = −19`. -/
theorem counts_ok : countsOk 74 = true := by decide +kernel

/-! ### The bridge (the leaf) and the floors -/

/-- **The character sums of `μ₁₂₉` in a field of `2¹⁴` elements are at least `−19`.** The bridge from the certificate:
`P` has a root `g` (`clmul_P_qBig`), the powers `1, …, g¹³` are a basis (`bezout4`, `bezout128`), `g` is a generator
(`order_checks`); `x ↦ (−1)^(x₀)` is a non-trivial additive character `ψ₀`, every non-trivial `ψ` is `ψ₀(a ·)`, `a = gⁱ`,
and `Σ_{u ∈ μ₁₂₉} ψ₀(gⁱ u) = Σ_{j < 129} ψ₀(g^(i + 127 j)) = 129 − 2·c_{i mod 127}` (`counts_ok`). -/
theorem charSum_128_ge {k : Type} [Field k] [Fintype k] [DecidableEq k] (hcard : Fintype.card k = 128 ^ 2)
    (ψ : AddChar k ℂ) (hψ : ψ ≠ 1) : -(19 : ℝ) ≤ (∑ u ∈ univ.filter (fun u : k => u ^ (128 + 1) = 1), ψ u).re := by
  sorry

/-- **`χ(U₁₂₈) ≥ 8`** — "U₁₂₈'s Hoffman floor is 8" (G56): `7·19 = 133 < 129 + 19`. -/
theorem targetFloor_eight_128 : TargetFloor 8 128 :=
  targetFloor_of_charSum 8 128 (m := 19) (by norm_num) (by norm_num)
    fun _ _ _ _ hcard ψ hψ => charSum_128_ge hcard ψ hψ

/-- **`χ(U₁₂₈) ≥ 7`**, the form `StandingFive.StandingFloor 7` reads. -/
theorem targetFloor_seven_128 : TargetFloor 7 128 := by
  intro k _ _ σ hσ hne hcard
  exact le_trans (by exact_mod_cast (by norm_num : (7 : ℕ) ≤ 8)) (targetFloor_eight_128 k σ hσ hne hcard)

/-! ## Spec -/

-- `clmul` is the product in `𝔽₂[x]`: `(x + 1)² = x² + 1`.
example : clmul 2 3 3 = 5 := by decide
-- `step` multiplies by `g`, and reduces `g¹⁴` to `g⁵ + g³ + g + 1` (the code 43).
example : step 1 = 2 := by decide
example : step (2 ^ 13) = 43 := by decide +kernel
-- the control of `counts_ok`: one lower and the check fails (some class has exactly 74 ones).
example : countsOk 73 = false := by decide +kernel
-- `pass` with no fuel returns its state and counters unchanged.
example : pass 0 5 3 7 = (5, 7) := rfl

end HadwigerNelson.Floor128
