import sys
sys.set_int_max_str_digits(200000)
N = int(sys.argv[1]); OP = sys.argv[2]
X = (1 << 6324) - 1 - (1 << 17)     # dense 6324-bit
Y = sum(1 << (i*7 % 6324) for i in range(900))
W = sum(1 << (i*13 % 50000) for i in range(2000))   # 50 Kbit chunk
ops = {
  "none":     "acc + 1",
  "and":      "acc ^^^ (X &&& Y)",
  "andxor":   "acc ^^^ (X ^^^ (X &&& Y))",
  "shl":      "acc ^^^ (1 <<< (f % 6324))",
  "shlsmall": "acc ^^^ (1 <<< (f % 60))",
  "mod2p":    "acc ^^^ (W % (2 ^ 216))",
  "modlit":   "acc ^^^ (W % 105312291668557186697918027683670432318895095400549111254310977536)",
  "shr":      "acc ^^^ (W >>> (f % 200))",
  "pow":      "acc ^^^ (2 ^ 216)",
  "predand":  "acc ^^^ (X &&& (X - 1))",
}
print(f"""set_option maxRecDepth 4000000
def X : Nat := {X}
def Y : Nat := {Y}
def W : Nat := {W}
def loop : Nat → Nat → Nat
  | 0, acc => acc
  | f+1, acc => loop f ({ops[OP]})
theorem bm : loop {N} 0 ≠ 999999999 := by decide +kernel""")
