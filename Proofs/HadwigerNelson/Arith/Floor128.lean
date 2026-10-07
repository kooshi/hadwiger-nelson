import Proofs.HadwigerNelson.Arith.NormOneTarget
import Proofs.HadwigerNelson.Arith.FloorPlanes
import Mathlib.Data.Nat.Bitwise

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

**The bridge, as proved** (FS131-I10E; `plans/FS131-I10E-implementation.md`). `ev t n` is the value at `t` of the
polynomial coded by `n`; in characteristic 2 it turns `^^^` into `+` and `clmul` into `·` (`ev_xor`, `ev_clmul`).

* *A root* (`exists_root`): by `clmul_P_qBig` every element of the field is a root of `P` or of the cofactor, and the
  cofactor is a non-zero polynomial of degree below `2¹⁴`.
* *The register on codes* (`minimalPeriod_step`, `exists_iterate_step_eq`): `step` keeps the non-zero codes below `2¹⁴`
  and has period exactly `16383 = 3·43·127` at 1 (`counts_ok`, `order_checks`), so its `16383` states are every such
  code, once each.
* *The basis* (`ev_ne_zero`, `ev_inj`, `exists_code`): a non-zero code below `2¹⁴` is a state, whose value at a root `g`
  is a power `gʲ ≠ 0`; so the codes below `2¹⁴` are the field's elements, and `g` generates its multiplicative group.
  **`bezout4` and `bezout128` are not read by the bridge**: the exact period already says that `P` is primitive. They stay
  as an independent witness of `P`'s irreducibility — with `clmul_P_qBig`, coprimality to `x⁴ + x` and to `x¹²⁸ + x` leaves
  no factor of degree dividing 2 or 7 — which a reviewer can check without the 16,383-step orbit.
* *The sum* (`pass_class`, `class_le`, `exists_addChar`): the coordinate-0 character `ψ₀` reads the low bit of the
  register's state at `gⁿ`; over `{u : u¹²⁹ = 1} = {g^(127 j)}` the shifted sum is `129 − 2·c_r`, and `c_r ≤ 74` is the
  packed counter `r` of `counts`. Every non-trivial character is a shift of `ψ₀` (`StandingFive.exists_mulShift_eq`).

**Inhabitants.** `GaloisField 2 14` is a field of `128²` elements with the non-trivial involution `x ↦ x¹²⁸`, so
`TargetFloor n 128` does not quantify over an empty domain. (The Spec's last three examples run `exists_root`,
`charSum_128_ge` and `targetFloor_eight_128` at that model.)
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

/-- `a4·P + b4·(x⁴ + x) = 1`: no root of `P` lies in `𝔽₄`. Not read by the bridge: an independent witness of `P`'s
irreducibility (with `bezout128` and `clmul_P_qBig`, Rabin's test). -/
theorem bezout4 : clmul 15 P a4 ^^^ clmul 14 b4 (2 ^ 4 ^^^ 2) = 1 := by decide +kernel

/-- `a128·P + b128·(x¹²⁸ + x) = 1`: no root of `P` lies in `𝔽₁₂₈`. Not read by the bridge: an independent witness of `P`'s
irreducibility (with `bezout4` and `clmul_P_qBig`, Rabin's test). -/
theorem bezout128 : clmul 15 P a128 ^^^ clmul 14 b128 (2 ^ 128 ^^^ 2) = 1 := by decide +kernel

/-- `g^(16383/r) ≠ 1` for `r = 3, 43, 127`, in coordinates: `g` generates the multiplicative group. -/
theorem order_checks : (pass 5461 1 0 0).1 ≠ 1 ∧ (pass 381 1 0 0).1 ≠ 1 ∧ (pass 129 1 0 0).1 ≠ 1 := by decide +kernel

/-- **The certified spectrum**: the orbit closes and every class has at most 74 ones — so every non-trivial character sum
is at least `129 − 2·74 = −19`. -/
theorem counts_ok : countsOk 74 = true := by decide +kernel

/-! ### The code: `𝔽₂[x]` in `Nat`, evaluated at a point -/

/-- The value at `t` of the polynomial coded by `n`: `ev t n = Σ bitᵢ(n)·tⁱ` (bit `i` of `n` is the coefficient of
`xⁱ`). -/
def ev {R : Type*} [Semiring R] (t : R) : ℕ → R
  | 0 => 0
  | n + 1 => (if (n + 1) % 2 = 1 then 1 else 0) + t * ev t ((n + 1) / 2)
decreasing_by omega

section Semiring

variable {R : Type*} [Semiring R] (t : R)

/-- The empty code is the zero polynomial. -/
@[simp] theorem ev_zero : ev t 0 = 0 := by rw [ev]

/-- The defining recursion, at every `n`: the low bit, and `t` times the value of the rest. -/
theorem ev_eq (n : ℕ) : ev t n = (if n % 2 = 1 then 1 else 0) + t * ev t (n / 2) := by
  cases n with
  | zero => simp
  | succ n => rw [ev]

/-- The code 1 is the constant polynomial 1. -/
theorem ev_one : ev t 1 = 1 := by rw [ev_eq]; simp

/-- Doubling a code multiplies by `x`. -/
theorem ev_two_mul (n : ℕ) : ev t (2 * n) = t * ev t n := by rw [ev_eq]; simp

/-- `<<< 1` multiplies by `x`. -/
theorem ev_shiftLeft_one (n : ℕ) : ev t (n <<< 1) = t * ev t n := by
  rw [Nat.shiftLeft_eq, pow_one, mul_comm, ev_two_mul]

/-- The code `2ᵐ` is the monomial `xᵐ`. -/
theorem ev_two_pow (m : ℕ) : ev t (2 ^ m) = t ^ m := by
  induction m with
  | zero => simpa using ev_one t
  | succ m ih => rw [pow_succ', ev_two_mul, ih, pow_succ']

/-- The code 2 is `x`. -/
theorem ev_two : ev t 2 = t := by simpa using ev_two_pow t 1

/-- `ev` is natural in the point: a ring homomorphism carries the value at `t` to the value at its image. -/
theorem map_ev {S : Type*} [Semiring S] (f : R →+* S) (n : ℕ) : f (ev t n) = ev (f t) n := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    rcases Nat.eq_zero_or_pos n with rfl | hn
    · simp
    · rw [ev_eq t n, ev_eq (f t) n, map_add, map_mul, ih (n / 2) (Nat.div_lt_self hn one_lt_two)]
      split_ifs <;> simp

open Polynomial in
/-- At `t = X` the code is read back: the coefficient of `Xⁱ` is bit `i`. -/
theorem coeff_ev_X (n i : ℕ) : (ev (X : R[X]) n).coeff i = if n.testBit i then 1 else 0 := by
  induction i generalizing n with
  | zero =>
    rw [ev_eq, coeff_add, coeff_X_mul_zero, add_zero, Nat.testBit_zero]
    split_ifs <;> simp_all
  | succ i ih =>
    have hc : (if n % 2 = 1 then (1 : R[X]) else 0).coeff (i + 1) = 0 := by split_ifs <;> simp [coeff_one]
    rw [ev_eq, coeff_add, hc, zero_add, coeff_X_mul, ih, Nat.testBit_add_one]

end Semiring

section CharTwo

variable {R : Type*} [CommRing R] [CharP R 2] (t : R)

/-- In characteristic 2 the sum of coded polynomials is `^^^`. -/
theorem ev_xor (a b : ℕ) : ev t (a ^^^ b) = ev t a + ev t b := by
  induction a using Nat.strong_induction_on generalizing b with
  | _ a ih =>
    rcases Nat.eq_zero_or_pos a with rfl | ha
    · simp
    · have hbit : (if (a ^^^ b) % 2 = 1 then (1 : R) else 0)
          = (if a % 2 = 1 then 1 else 0) + (if b % 2 = 1 then 1 else 0) := by
        rcases Nat.mod_two_eq_zero_or_one a with h | h <;> rcases Nat.mod_two_eq_zero_or_one b with h' | h' <;>
          rw [Nat.xor_mod_two_eq, Nat.add_mod, h, h'] <;> simp [CharTwo.add_self_eq_zero]
      rw [ev_eq t (a ^^^ b), ev_eq t a, ev_eq t b, Nat.xor_div_two, ih (a / 2) (Nat.div_lt_self ha one_lt_two), hbit]
      ring

/-- In characteristic 2 `clmul` is the product of coded polynomials, once the fuel covers the first factor's bits. -/
theorem ev_clmul (fuel a b : ℕ) (ha : a < 2 ^ fuel) : ev t (clmul fuel a b) = ev t a * ev t b := by
  induction fuel generalizing a b with
  | zero =>
    have h0 : a = 0 := by simpa using ha
    subst h0
    simp [clmul]
  | succ fuel ih =>
    have h0 : ev t (if a.testBit 0 then b else 0) = (if a % 2 = 1 then 1 else 0) * ev t b := by
      rw [Nat.testBit_zero]
      by_cases h : a % 2 = 1 <;> simp [h]
    have ha' : a >>> 1 < 2 ^ fuel := by
      rw [Nat.shiftRight_eq_div_pow, pow_one]
      exact Nat.div_lt_of_lt_mul (by rw [← pow_succ']; exact ha)
    rw [clmul, ev_xor, h0, ih _ _ ha', ev_shiftLeft_one, ev_eq t a, Nat.shiftRight_eq_div_pow, pow_one]
    ring

/-- At a root `g` of `P`, `step` is multiplication by `g`. -/
theorem ev_step {g : R} (hg : ev g P = 0) (x : ℕ) : ev g (step x) = g * ev g x := by
  unfold step
  split_ifs
  · rw [ev_xor, ev_shiftLeft_one, hg, add_zero]
  · rw [ev_shiftLeft_one]

/-- At a root `g` of `P`, `n` steps of the register multiply by `gⁿ`. -/
theorem ev_iterate_step {g : R} (hg : ev g P = 0) (n x : ℕ) : ev g (step^[n] x) = g ^ n * ev g x := by
  induction n generalizing x with
  | zero => simp
  | succ n ih => rw [Function.iterate_succ_apply, ih, ev_step hg, pow_succ, mul_assoc]

end CharTwo

/-! ### A root of `P` -/

/-- The cofactor has its bits below `2¹⁴`: as a polynomial, degree below `2¹⁴`. -/
theorem qBig_lt : qBig < 2 ^ 16384 := by decide +kernel

/-- The cofactor is not the zero polynomial: its coefficient of `x` is 1. -/
theorem qBig_testBit_one : qBig.testBit 1 = true := by decide +kernel

/-- A field of `2¹⁴` elements has characteristic 2. -/
theorem charP_two {k : Type*} [Field k] [Fintype k] (hcard : Fintype.card k = 128 ^ 2) : CharP k 2 := by
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  exact charP_of_card_eq_prime_pow (f := 14) (by rw [hcard]; norm_num)

open Polynomial in
/-- **`P` has a root in every field of `2¹⁴` elements.** By `clmul_P_qBig` every element is a root of `P` or of its
cofactor, and the cofactor, a non-zero polynomial of degree below `2¹⁴`, cannot vanish everywhere. -/
theorem exists_root {k : Type*} [Field k] [Fintype k] (hcard : Fintype.card k = 128 ^ 2) : ∃ g : k, ev g P = 0 := by
  haveI := charP_two hcard
  by_contra hne
  push Not at hne
  have hq : ∀ a : k, ev a qBig = 0 := by
    intro a
    have h := ev_clmul a 15 P qBig (by decide)
    have ha : a ^ 16384 = a := by
      have h1 := FiniteField.pow_card a
      rwa [hcard] at h1
    rw [clmul_P_qBig, ev_xor, ev_two_pow, ev_two, ha, CharTwo.add_self_eq_zero] at h
    exact (mul_eq_zero.mp h.symm).resolve_left (hne a)
  have hdeg : (ev (X : k[X]) qBig).natDegree < Fintype.card k := by
    rw [hcard]
    refine lt_of_le_of_lt (natDegree_le_iff_coeff_eq_zero.mpr fun N hN => ?_) (by norm_num : 16383 < 128 ^ 2)
    have hN' : 16384 ≤ N := hN
    have h2 : (2 : ℕ) ^ 16384 ≤ 2 ^ N := pow_le_pow_right₀ one_le_two hN'
    rw [coeff_ev_X, Nat.testBit_lt_two_pow (lt_of_lt_of_le qBig_lt h2)]
    rfl
  have hF := eq_zero_of_natDegree_lt_card_of_eval_eq_zero (ev (X : k[X]) qBig) (f := id) Function.injective_id
    (fun a => by rw [id, ← coe_evalRingHom, map_ev, coe_evalRingHom, eval_X]; exact hq a) hdeg
  have h1 := coeff_ev_X (R := k) qBig 1
  rw [hF, coeff_zero, qBig_testBit_one] at h1
  exact zero_ne_one h1

/-! ### The register on codes -/

/-- `step` keeps the codes below `2¹⁴`: the shift's bit 14 is cancelled by `P`'s. -/
theorem step_lt {x : ℕ} (hx : x < 2 ^ 14) : step x < 2 ^ 14 := by
  refine Nat.lt_pow_two_of_testBit _ fun i hi => ?_
  have hx' : ∀ j, 14 ≤ j → x.testBit j = false := fun j hj =>
    Nat.testBit_lt_two_pow (lt_of_lt_of_le hx (pow_le_pow_right₀ one_le_two hj))
  unfold step
  split_ifs with h13
  · rw [Nat.testBit_xor, Nat.testBit_shiftLeft]
    rcases Nat.eq_or_lt_of_le hi with rfl | hi'
    · have hP : P.testBit 14 = true := by decide
      simp [h13, hP]
    · have hP : P.testBit i = false :=
        Nat.testBit_lt_two_pow (lt_of_lt_of_le (by decide : P < 2 ^ 15) (pow_le_pow_right₀ one_le_two hi'))
      rw [hP, hx' (i - 1) (by omega)]
      simp
  · rw [Nat.testBit_shiftLeft]
    rcases Nat.eq_or_lt_of_le hi with rfl | hi'
    · simpa using h13
    · rw [hx' (i - 1) (by omega)]
      simp

/-- `step` keeps the non-zero codes: `P` is odd and a shift is even. -/
theorem step_ne_zero {x : ℕ} (hx : x ≠ 0) : step x ≠ 0 := by
  unfold step
  split_ifs
  · have h : (x <<< 1 ^^^ P) % 2 = 1 := by
      rw [Nat.xor_mod_two_eq_one, Nat.shiftLeft_eq, pow_one]
      unfold P
      omega
    omega
  · rw [Nat.shiftLeft_eq, pow_one]
    omega

/-- The register's state after `n` steps of `pass`. -/
theorem pass_fst (n x i acc : ℕ) : (pass n x i acc).1 = step^[n] x := by
  induction n generalizing x i acc with
  | zero => rfl
  | succ n ih => rw [pass, ih, Function.iterate_succ_apply]

/-- The register's counters after `n` steps of `pass`: the low bit of each state, added at the position of its index
mod 127. -/
theorem pass_snd (n x i acc : ℕ) (hi : i < 127) :
    (pass n x i acc).2 = acc + ∑ m ∈ range n, step^[m] x % 2 * 2 ^ (8 * ((i + m) % 127)) := by
  induction n generalizing x i acc with
  | zero => simp [pass]
  | succ n ih =>
    have hi' : (if i = 126 then 0 else i + 1) < 127 := by split_ifs <;> omega
    have hmod : ∀ m, ((if i = 126 then 0 else i + 1) + m) % 127 = (i + (m + 1)) % 127 := by
      intro m
      split_ifs with h <;> omega
    rw [pass, ih _ _ _ hi', Finset.sum_range_succ', Nat.and_one_is_mod, Nat.shiftLeft_eq]
    simp only [Function.iterate_succ_apply, hmod, Function.iterate_zero, id, add_zero, Nat.mod_eq_of_lt hi]
    ring

/-! ### The orbit of 1: every non-zero code below `2¹⁴`, once -/

/-- The states of the register stay below `2¹⁴`. -/
theorem iterate_step_lt (n : ℕ) : step^[n] 1 < 2 ^ 14 := by
  induction n with
  | zero => norm_num
  | succ n ih => rw [Function.iterate_succ_apply']; exact step_lt ih

/-- The states of the register are non-zero. -/
theorem iterate_step_ne_zero (n : ℕ) : step^[n] 1 ≠ 0 := by
  induction n with
  | zero => norm_num
  | succ n ih => rw [Function.iterate_succ_apply']; exact step_ne_zero ih

/-- The orbit closes after `16383` steps (`counts_ok`'s first clause). -/
theorem iterate_step_period : step^[16383] 1 = 1 := by
  have h := counts_ok
  rw [countsOk, Bool.and_eq_true, beq_iff_eq, counts, pass_fst] at h
  exact h.1

/-- A divisor of `16383 = 3·43·127` that divides none of `16383/3`, `16383/43`, `16383/127` is `16383`. -/
theorem eq_of_dvd_of_not_dvd {d : ℕ} (hd : d ∣ 16383) (h1 : ¬d ∣ 5461) (h2 : ¬d ∣ 381) (h3 : ¬d ∣ 129) :
    d = 16383 := by
  have d3 : 3 ∣ d := by
    by_contra h
    exact h1 (Nat.Coprime.dvd_of_dvd_mul_right ((Nat.Prime.coprime_iff_not_dvd Nat.prime_three).2 h).symm hd)
  have d43 : 43 ∣ d := by
    by_contra h
    exact h2 (Nat.Coprime.dvd_of_dvd_mul_right ((Nat.Prime.coprime_iff_not_dvd (by norm_num)).2 h).symm hd)
  have d127 : 127 ∣ d := by
    by_contra h
    exact h3 (Nat.Coprime.dvd_of_dvd_mul_right ((Nat.Prime.coprime_iff_not_dvd (by norm_num)).2 h).symm hd)
  exact Nat.dvd_antisymm hd
    (Nat.Coprime.mul_dvd_of_dvd_of_dvd (by norm_num) (Nat.Coprime.mul_dvd_of_dvd_of_dvd (by norm_num) d3 d43) d127)

/-- **The register has period exactly `16383` at 1** (`counts_ok`, `order_checks`; `16383 = 3·43·127`). -/
theorem minimalPeriod_step : Function.minimalPeriod step 1 = 16383 := by
  have hmin := Function.isPeriodicPt_minimalPeriod step 1
  obtain ⟨h1, h2, h3⟩ := order_checks
  rw [pass_fst] at h1 h2 h3
  exact eq_of_dvd_of_not_dvd (Function.IsPeriodicPt.minimalPeriod_dvd iterate_step_period)
    (fun h => h1 (hmin.trans_dvd h)) (fun h => h2 (hmin.trans_dvd h)) (fun h => h3 (hmin.trans_dvd h))

/-- The first `16383` states of the register are distinct. -/
theorem iterate_step_injOn : Set.InjOn (fun n => step^[n] 1) (Set.Iio 16383) := by
  have h := Function.iterate_injOn_Iio_minimalPeriod (f := step) (x := 1)
  rwa [minimalPeriod_step] at h

/-- **Every non-zero code below `2¹⁴` is a state of the register**: `16383` distinct states among `16383` codes. -/
theorem exists_iterate_step_eq {n : ℕ} (hn : n < 2 ^ 14) (h0 : n ≠ 0) : ∃ j < 16383, step^[j] 1 = n := by
  have hsub : (range 16383).image (fun j => step^[j] 1) ⊆ (range (2 ^ 14)).erase 0 := by
    intro m hm
    obtain ⟨j, -, rfl⟩ := mem_image.mp hm
    exact mem_erase.mpr ⟨iterate_step_ne_zero j, mem_range.mpr (iterate_step_lt j)⟩
  have hcard : ((range (2 ^ 14)).erase 0).card ≤ ((range 16383).image (fun j => step^[j] 1)).card := by
    rw [card_image_of_injOn (by simpa using iterate_step_injOn), card_erase_of_mem (by simp), card_range, card_range]
    norm_num
  have hmem : n ∈ (range 16383).image (fun j => step^[j] 1) := by
    rw [eq_of_subset_of_card_le hsub hcard]
    exact mem_erase.mpr ⟨h0, mem_range.mpr hn⟩
  obtain ⟨j, hj, rfl⟩ := mem_image.mp hmem
  exact ⟨j, mem_range.mp hj, rfl⟩

/-! ### Reading the packed counters -/

/-- Digit `i` of `Σ d_r·Bʳ` is `d_i`, when every digit is below `B`. -/
theorem digit_sum {B : ℕ} (d : ℕ → ℕ) (hd : ∀ r, d r < B) (N i : ℕ) (hi : i < N) :
    (∑ r ∈ range N, d r * B ^ r) / B ^ i % B = d i := by
  have hB : 0 < B := Nat.zero_lt_of_lt (hd 0)
  induction i generalizing N d with
  | zero =>
    obtain ⟨N, rfl⟩ : ∃ M, N = M + 1 := ⟨N - 1, by omega⟩
    have hs : ∑ r ∈ range N, d (r + 1) * B ^ (r + 1) = B * ∑ r ∈ range N, d (r + 1) * B ^ r := by
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun r _ => by ring
    rw [Finset.sum_range_succ', hs, pow_zero, Nat.div_one, mul_one, Nat.mul_add_mod, Nat.mod_eq_of_lt (hd 0)]
  | succ i ih =>
    obtain ⟨N, rfl⟩ : ∃ M, N = M + 1 := ⟨N - 1, by omega⟩
    have hs : ∑ r ∈ range N, d (r + 1) * B ^ (r + 1) = B * ∑ r ∈ range N, d (r + 1) * B ^ r := by
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun r _ => by ring
    rw [Finset.sum_range_succ', hs, pow_zero, mul_one, pow_succ', ← Nat.div_div_eq_div_mul, Nat.mul_add_div hB,
      Nat.div_eq_of_lt (hd 0), add_zero]
    exact ih (fun r => d (r + 1)) (fun r => hd _) N (by omega)

/-- A sum over `a·b` consecutive indices, by residue mod `a`. -/
theorem sum_range_mul_eq (f : ℕ → ℕ) (a b : ℕ) :
    ∑ n ∈ range (a * b), f n = ∑ r ∈ range a, ∑ j ∈ range b, f (a * j + r) := by
  rw [Finset.sum_comm]
  induction b with
  | zero => simp
  | succ b ih => rw [Nat.mul_succ, Finset.sum_range_add, ih, Finset.sum_range_succ]

/-- **The counters are the classes**, for a pass of `127·b` steps from any state `x`: the `r`-th packed counter is the
number of `j < b` with the low bit of the state `127·j + r` set. (Stated with `x` and `b` free: at `x = 1`, `b = 129` the
sums are closed terms, and a rewrite that changes an instance path sends the kernel to evaluate them.) -/
theorem pass_class (x b : ℕ) (hb : b < 256) (r : ℕ) (hr : r < 127) :
    (pass (127 * b) x 0 0).2 / 2 ^ (8 * r) % 256 = ∑ j ∈ range b, step^[127 * j + r] x % 2 := by
  have hc : (pass (127 * b) x 0 0).2 = ∑ r ∈ range 127, (∑ j ∈ range b, step^[127 * j + r] x % 2) * 256 ^ r := by
    rw [pass_snd _ _ _ _ (by norm_num), zero_add, sum_range_mul_eq]
    refine Finset.sum_congr rfl fun r hr => ?_
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [zero_add, Nat.mul_add_mod, Nat.mod_eq_of_lt (mem_range.mp hr), pow_mul]
    norm_num
  have hd : ∀ r, (∑ j ∈ range b, step^[127 * j + r] x % 2) < 256 := by
    intro r
    calc ∑ j ∈ range b, step^[127 * j + r] x % 2 ≤ ∑ _j ∈ range b, 1 :=
          Finset.sum_le_sum fun j _ => Nat.le_of_lt_succ (Nat.mod_lt _ two_pos)
      _ = b := by simp
      _ < 256 := hb
  rw [hc, pow_mul, show (2 : ℕ) ^ 8 = 256 from rfl]
  exact digit_sum _ hd 127 r hr

/-- **Every class has at most 74 ones** (`counts_ok`'s second clause, read through `pass_class`): among the 129 states
`127·j + r`, `j < 129`, at most 74 have their low bit set. -/
theorem class_le (r : ℕ) (hr : r < 127) : ∑ j ∈ range 129, step^[127 * j + r] 1 % 2 ≤ 74 := by
  have h := counts_ok
  rw [countsOk, Bool.and_eq_true, List.all_eq_true] at h
  have h1 := h.2 r (List.mem_range.mpr hr)
  rw [decide_eq_true_eq, Nat.shiftRight_eq_div_pow, show (255 : ℕ) = 2 ^ 8 - 1 from rfl,
    Nat.and_two_pow_sub_one_eq_mod, show (2 : ℕ) ^ 8 = 256 from rfl, counts] at h1
  rw [← pass_class 1 129 (by norm_num) r hr]
  exact h1

/-! ### The field: the codes below `2¹⁴` are its elements, the register's states are the powers of `g`

Every hypothesis `ev g P = 0` below is met in every field of `2¹⁴` elements (`exists_root`), and `GaloisField 2 14` is
one (the Spec's last example). -/

section Field

variable {k : Type*} [Field k] [CharP k 2] {g : k}

/-- A root of `P` has `g ^ 16383 = 1`: the register closes. -/
theorem root_pow_eq_one (hg : ev g P = 0) : g ^ 16383 = 1 := by
  have h := ev_iterate_step hg 16383 1
  rw [iterate_step_period, ev_one, mul_one] at h
  exact h.symm

/-- **The basis** (the plan's B3, by the register's orbit): a non-zero code below `2¹⁴` has a non-zero value at a
root `g` of `P` — it is a state of the register, whose value is a power of `g`. -/
theorem ev_ne_zero (hg : ev g P = 0) {n : ℕ} (hn : n < 2 ^ 14) (h0 : n ≠ 0) : ev g n ≠ 0 := by
  have hg0 : g ≠ 0 := by
    rintro rfl
    have h := root_pow_eq_one (g := (0 : k)) hg
    rw [zero_pow (by norm_num)] at h
    exact zero_ne_one h
  obtain ⟨j, -, rfl⟩ := exists_iterate_step_eq hn h0
  rw [ev_iterate_step hg, ev_one, mul_one]
  exact pow_ne_zero _ hg0

/-- The codes below `2¹⁴` have distinct values at a root of `P`: `1, g, …, g¹³` are independent over `𝔽₂`. -/
theorem ev_inj (hg : ev g P = 0) {m n : ℕ} (hm : m < 2 ^ 14) (hn : n < 2 ^ 14) (h : ev g m = ev g n) : m = n := by
  by_contra hne
  refine ev_ne_zero hg (Nat.xor_lt_two_pow hm hn) (fun h0 => hne (Nat.xor_eq_zero_iff.mp h0)) ?_
  rw [ev_xor, h, CharTwo.add_self_eq_zero]

/-- The powers `gʲ`, `j < 16383`, of a root of `P` are distinct. -/
theorem root_pow_inj (hg : ev g P = 0) {i j : ℕ} (hi : i < 16383) (hj : j < 16383) (h : g ^ i = g ^ j) : i = j := by
  refine iterate_step_injOn hi hj (ev_inj hg (iterate_step_lt i) (iterate_step_lt j) ?_)
  rw [ev_iterate_step hg, ev_iterate_step hg, ev_one, mul_one, mul_one, h]

/-- Every element of a field of `2¹⁴` elements is the value at a root `g` of `P` of a code below `2¹⁴`: `1, g, …, g¹³`
is a basis over `𝔽₂`. -/
theorem exists_code [Fintype k] (hcard : Fintype.card k = 128 ^ 2) (hg : ev g P = 0) (x : k) :
    ∃ n < 2 ^ 14, ev g n = x := by
  have hinj : Function.Injective fun n : Fin (2 ^ 14) => ev g (n : ℕ) := fun m n h => Fin.ext (ev_inj hg m.2 n.2 h)
  have hbij := (Fintype.bijective_iff_injective_and_card _).mpr
    ⟨hinj, by rw [Fintype.card_fin, hcard]; norm_num⟩
  obtain ⟨n, hn⟩ := hbij.2 x
  exact ⟨n, n.2, hn⟩

/-- Every non-zero element is a power `gʲ`, `j < 16383`: a root of `P` generates the multiplicative group. -/
theorem exists_root_pow_eq [Fintype k] (hcard : Fintype.card k = 128 ^ 2) (hg : ev g P = 0) {x : k} (hx : x ≠ 0) :
    ∃ j < 16383, g ^ j = x := by
  obtain ⟨n, hn, rfl⟩ := exists_code hcard hg x
  have h0 : n ≠ 0 := by
    rintro rfl
    exact hx (ev_zero g)
  obtain ⟨j, hj, rfl⟩ := exists_iterate_step_eq hn h0
  exact ⟨j, hj, by rw [ev_iterate_step hg, ev_one, mul_one]⟩

/-- **The norm-one set is the 129 powers of `g ^ 127`** (`StandingFive.card_normOne` at `Q = 128`). -/
theorem normOne_eq_image [Fintype k] [DecidableEq k] (hcard : Fintype.card k = 128 ^ 2) (hg : ev g P = 0) :
    univ.filter (fun u : k => u ^ (128 + 1) = 1) = (range 129).image fun j => g ^ (127 * j) := by
  symm
  refine eq_of_subset_of_card_le ?_ ?_
  · intro u hu
    obtain ⟨j, -, rfl⟩ := mem_image.mp hu
    have h1 : (g ^ (127 * j)) ^ (128 + 1) = 1 := by
      rw [← pow_mul, show 127 * j * (128 + 1) = 16383 * j by ring, pow_mul, root_pow_eq_one hg, one_pow]
    exact mem_filter.mpr ⟨mem_univ _, h1⟩
  · rw [StandingFive.card_normOne hcard, card_image_of_injOn, card_range]
    intro j hj j' hj' h
    have hj := mem_range.mp (mem_coe.mp hj)
    have hj' := mem_range.mp (mem_coe.mp hj')
    have := root_pow_inj hg (by omega) (by omega) h
    omega

/-- **The coordinate-0 character**: `x ↦ (−1)^(bit 0 of the code of x)` is a non-trivial additive character, and at
`gⁿ` it reads the low bit of the register's `n`-th state. -/
theorem exists_addChar [Fintype k] (hcard : Fintype.card k = 128 ^ 2) (hg : ev g P = 0) :
    ∃ ψ₀ : AddChar k ℂ, ψ₀ ≠ 1 ∧ ∀ n, ψ₀ (g ^ n) = 1 - 2 * ((step^[n] 1 % 2 : ℕ) : ℂ) := by
  choose c hc_lt hc using exists_code hcard hg
  have hc_ev : ∀ {n}, n < 2 ^ 14 → c (ev g n) = n := fun hn => ev_inj hg (hc_lt _) hn (hc _)
  have hc_add : ∀ x y, c (x + y) = c x ^^^ c y := fun x y =>
    ev_inj hg (hc_lt _) (Nat.xor_lt_two_pow (hc_lt x) (hc_lt y)) (by rw [hc, ev_xor, hc, hc])
  have hpow : ∀ m : ℕ, (-1 : ℂ) ^ m = 1 - 2 * ((m % 2 : ℕ) : ℂ) := by
    intro m
    rw [neg_one_pow_eq_pow_mod_two]
    rcases Nat.mod_two_eq_zero_or_one m with h | h <;> rw [h] <;> norm_num
  have hc0 : c 0 = 0 := by simpa using hc_ev (n := 0) (by norm_num)
  have hc1 : c 1 = 1 := by simpa [ev_one] using hc_ev (n := 1) (by norm_num)
  refine ⟨⟨fun x => (-1) ^ c x, ?_, ?_⟩, ?_, ?_⟩
  · show (-1 : ℂ) ^ c 0 = 1
    rw [hc0, pow_zero]
  · intro x y
    show (-1 : ℂ) ^ c (x + y) = (-1) ^ c x * (-1) ^ c y
    rw [hc_add, neg_one_pow_eq_pow_mod_two, Nat.xor_mod_two_eq, ← neg_one_pow_eq_pow_mod_two, pow_add]
  · intro h
    have h1 : (-1 : ℂ) ^ c 1 = 1 := DFunLike.congr_fun h 1
    rw [hc1] at h1
    norm_num at h1
  · intro n
    show (-1 : ℂ) ^ c (g ^ n) = _
    have hcn : c (g ^ n) = step^[n] 1 := by
      have h := hc_ev (iterate_step_lt n)
      rwa [ev_iterate_step hg, ev_one, mul_one] at h
    rw [hcn, hpow]

end Field

/-! ### The bridge (the leaf) and the floors -/

/-- **The character sums of `μ₁₂₉` in a field of `2¹⁴` elements are at least `−19`.** The bridge from the certificate:
`P` has a root `g` (`clmul_P_qBig`), the powers `1, …, g¹³` are a basis (`bezout4`, `bezout128`), `g` is a generator
(`order_checks`); `x ↦ (−1)^(x₀)` is a non-trivial additive character `ψ₀`, every non-trivial `ψ` is `ψ₀(a ·)`, `a = gⁱ`,
and `Σ_{u ∈ μ₁₂₉} ψ₀(gⁱ u) = Σ_{j < 129} ψ₀(g^(i + 127 j)) = 129 − 2·c_{i mod 127}` (`counts_ok`).

**As proved (FS131-I10E)**: the basis is read from the register's orbit — on codes `step` has period exactly `16383` at
1 (`minimalPeriod_step`: `counts_ok`, `order_checks`), so its states are every non-zero code below `2¹⁴`, and such a
code has the value `gʲ ≠ 0` (`ev_ne_zero`); `bezout4` and `bezout128` are not read. "Every non-trivial `ψ` is
`ψ₀(a ·)`" is `StandingFive.exists_mulShift_eq`, and `{u : u¹²⁹ = 1}` has 129 elements by `StandingFive.card_normOne`. -/
theorem charSum_128_ge {k : Type} [Field k] [Fintype k] [DecidableEq k] (hcard : Fintype.card k = 128 ^ 2)
    (ψ : AddChar k ℂ) (hψ : ψ ≠ 1) : -(19 : ℝ) ≤ (∑ u ∈ univ.filter (fun u : k => u ^ (128 + 1) = 1), ψ u).re := by
  haveI := charP_two hcard
  obtain ⟨g, hg⟩ := exists_root hcard
  obtain ⟨ψ₀, hψ₀, hval⟩ := exists_addChar hcard hg
  obtain ⟨a, rfl⟩ := StandingFive.exists_mulShift_eq ψ₀ hψ₀ ψ
  have ha : a ≠ 0 := by
    rintro rfl
    exact hψ (AddChar.mulShift_zero ψ₀)
  obtain ⟨i, -, rfl⟩ := exists_root_pow_eq hcard hg ha
  -- `g ^ i = g ^ (i % 127) · v` with `v = g ^ (127 · (i / 127))` in the norm-one set, which `v ·` permutes
  have hv : (g ^ (127 * (i / 127))) ^ (128 + 1) = 1 := by
    rw [← pow_mul, show 127 * (i / 127) * (128 + 1) = 16383 * (i / 127) by ring, pow_mul, root_pow_eq_one hg, one_pow]
  have hv0 : g ^ (127 * (i / 127)) ≠ 0 := by
    intro h
    rw [h, zero_pow (by norm_num)] at hv
    exact zero_ne_one hv
  have hsum : ∑ u ∈ univ.filter (fun u : k => u ^ (128 + 1) = 1), ψ₀.mulShift (g ^ i) u
      = ∑ j ∈ range 129, (1 - 2 * ((step^[127 * j + i % 127] 1 % 2 : ℕ) : ℂ)) := by
    calc ∑ u ∈ univ.filter (fun u : k => u ^ (128 + 1) = 1), ψ₀.mulShift (g ^ i) u
        = ∑ u ∈ univ.filter (fun u : k => u ^ (128 + 1) = 1), ψ₀ (g ^ (i % 127) * u) := by
          refine Finset.sum_equiv (Equiv.mulLeft₀ _ hv0) (fun u => ?_) (fun u _ => ?_)
          · simp only [mem_filter, mem_univ, true_and, Equiv.mulLeft₀_apply, mul_pow, hv, one_mul]
          · rw [AddChar.mulShift_apply, Equiv.mulLeft₀_apply, ← mul_assoc, ← pow_add, Nat.mod_add_div]
      _ = ∑ j ∈ range 129, ψ₀ (g ^ (i % 127) * g ^ (127 * j)) := by
          rw [normOne_eq_image hcard hg, Finset.sum_image]
          intro j hj j' hj' h
          have hj := mem_range.mp hj
          have hj' := mem_range.mp hj'
          have := root_pow_inj hg (by omega) (by omega) h
          omega
      _ = ∑ j ∈ range 129, (1 - 2 * ((step^[127 * j + i % 127] 1 % 2 : ℕ) : ℂ)) := by
          refine Finset.sum_congr rfl fun j _ => ?_
          rw [← pow_add, add_comm, hval]
  -- the class of `i % 127` has at most 74 ones: the sum is `129 − 2·c ≥ −19`
  have hle := class_le (i % 127) (Nat.mod_lt i (by norm_num))
  have hle' : ((∑ j ∈ range 129, step^[127 * j + i % 127] 1 % 2 : ℕ) : ℝ) ≤ 74 := by exact_mod_cast hle
  rw [hsum, Finset.sum_sub_distrib, Finset.sum_const, card_range, ← Finset.mul_sum, ← Nat.cast_sum]
  simp only [nsmul_eq_mul, mul_one, Complex.sub_re, Complex.mul_re, Complex.natCast_re, Complex.natCast_im,
    Complex.re_ofNat, Complex.im_ofNat, zero_mul, sub_zero, Nat.cast_ofNat]
  linarith

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
-- `ev` reads a code as a polynomial: at `t = 2` over `ℕ` it returns the number (`13 = 2³ + 2² + 1`), and at `t = 10` the
-- code `5 = 101₂` is `10² + 1` (it would fail if the bits were read from the top, or the recursion dropped a bit).
example : ev (2 : ℕ) 13 = 13 := by norm_num [ev_eq 2 13, ev_eq 2 6, ev_eq 2 3, ev_eq 2 1]
example : ev (10 : ℕ) 5 = 101 := by norm_num [ev_eq 10 5, ev_eq 10 2, ev_eq 10 1]
-- `digit_sum` at two decimal digits: the tens digit of `3 + 7·10` is 7.
example : (∑ r ∈ range 2, (if r = 0 then 3 else 7) * 10 ^ r) / 10 ^ 1 % 10 = 7 :=
  digit_sum (fun r => if r = 0 then 3 else 7) (fun r => by split_ifs <;> norm_num) 2 1 (by norm_num)
-- the model the module docstring names: `GaloisField 2 14` is a field of `128²` elements, so `P` has a root there and
-- the bridge speaks of its 16,383 non-trivial additive characters — neither theorem quantifies over an empty domain.
example [Fintype (GaloisField 2 14)] : ∃ g : GaloisField 2 14, ev g P = 0 :=
  exists_root (by rw [← Nat.card_eq_fintype_card, GaloisField.card 2 14 (by norm_num)]; norm_num)
example [Fintype (GaloisField 2 14)] [DecidableEq (GaloisField 2 14)] (ψ : AddChar (GaloisField 2 14) ℂ) (hψ : ψ ≠ 1) :
    -(19 : ℝ) ≤ (∑ u ∈ univ.filter (fun u : GaloisField 2 14 => u ^ (128 + 1) = 1), ψ u).re :=
  charSum_128_ge (by rw [← Nat.card_eq_fintype_card, GaloisField.card 2 14 (by norm_num)]; norm_num) ψ hψ
-- `targetFloor_eight_128` at a model of every hypothesis of `TargetFloor`: `GaloisField 2 14` with the 128-th power map,
-- an involution that is not the identity (`StandingFive.card_filter_pow_eq_self`: it fixes 128 elements of 16,384) —
-- eight colours for an actual graph, `U₁₂₈` itself.
example : (8 : ℕ∞) ≤ (normOneCayley (GaloisField 2 14) (iterateFrobenius (GaloisField 2 14) 2 7)).chromaticNumber := by
  classical
  haveI := Fintype.ofFinite (GaloisField 2 14)
  have hcard : Fintype.card (GaloisField 2 14) = 128 ^ 2 := by
    rw [← Nat.card_eq_fintype_card, GaloisField.card 2 14 (by norm_num)]
    norm_num
  have hσ : ∀ x : GaloisField 2 14, iterateFrobenius (GaloisField 2 14) 2 7 x = x ^ 128 := fun x => by
    rw [iterateFrobenius_def]
    norm_num
  refine targetFloor_eight_128 (GaloisField 2 14) _ (fun x => ?_) (fun h => ?_)
    (by rw [Nat.card_eq_fintype_card, hcard])
  · rw [hσ, hσ, ← pow_mul]
    have h := FiniteField.pow_card x
    rwa [hcard] at h
  · have hall := card_filter_pow_eq_self hcard
    rw [Finset.filter_true_of_mem (fun x _ => by rw [← hσ, h]; rfl), Finset.card_univ, hcard] at hall
    norm_num at hall

end HadwigerNelson.Floor128
