"""Shared rules of the Local–Global Map's facts table (crunch job J43): normalisation, the grade fold, the ledger parser, the
keyword tag rule, the dyadic and stable-place rules. The checker re-implements the arithmetic rules independently and uses this
module only for text handling, so an arithmetic defect here cannot pass the checker silently."""
import re

def norm(s):
    """Markdown bold and backticks removed, whitespace collapsed: the form every pattern is matched in."""
    return " ".join(s.replace("**", "").replace("`", "").split())

# ---- the grade fold: § Notation's grades and § B's free text onto the page's seven (DESIGN.md §1.3); a mixed grade takes its weakest part
ORDER = ["kernel", "certificate", "hand-2", "hand-1", "measured", "reading", "open"]
def fold(g):
    s = (g or "").lower()
    if not s: return "open"
    if "reading" in s and not re.search(r"hand|cert|kernel|tools", s): return "reading"
    parts = []
    if re.search(r"kernel", s) and not re.search(r"hand|cert|tools|measured|solver|search|exact|proof|derived|external", s): return "kernel"
    if re.search(r"\bcert|exact-rational", s): parts.append("certificate")
    if re.search(r"hand|derived|proof|gpt astra|\bcert", s):
        # exact arithmetic inside a hand proof or a certificate is that proof's input, not a measurement: the hand part governs
        s = re.sub(r"tools,? exact|\bexact\b(?!-rational)", "", s)
    if re.search(r"tools|measured|solver|search|\bexact\b|\[exact\]", s): parts.append("measured")
    if re.search(r"hand|derived|proof|gpt astra|poros|external|re-derived", s):
        two = re.search(r"two (independent )?derivations|three derivations|two derivations|blind|re-derived|three independent|two independent", s)
        one = re.search(r"one mind|one derivation", s)
        parts.append("hand-2" if two and not one else "hand-1")
    if "kernel" in s and not parts: parts.append("kernel")
    if not parts: return "open"
    return max(parts, key=ORDER.index)

GRADE_WORDS = r"(?:kernel|cert|hand|tools|derived|measured|exact-rational|proof|reading|solver)"
def row_grade(text, where=""):
    """A ledger row's grade: kernel when its address names a Lean module and no other grade bracket opens within its first 200
    characters (the headline is the kernel result); otherwise its first bracket opening with a grade word; an unmarked row is
    kernel-checked (the table's header: "Kernel-checked unless marked")."""
    m = re.search(r"\[(" + GRADE_WORDS + r"[^\]]*)\]", text)
    if ".lean" in where and (not m or m.start() > 200 or m.group(1).startswith("kernel")): return "[kernel] (a Lean module is the row's address)"
    return "[" + m.group(1) + "]" if m else "Kernel-checked unless marked"

def split_cells(line):
    """Cells of a markdown table line. An escaped pipe is literal; so is a pipe inside a backtick code span (LEDGER.md row 75
    carries `|λ|` unescaped, which GitHub's renderer would split — reported, not fixed here)."""
    cells, cur, i, code = [], "", 0, False
    while i < len(line):
        c = line[i]
        if c == "\\" and i + 1 < len(line) and line[i + 1] == "|": cur += "|"; i += 2; continue
        if c == "`": code = not code
        if c == "|" and not code: cells.append(cur); cur = ""
        else: cur += c
        i += 1
    cells.append(cur)
    return [c.strip() for c in cells[1:-1]]

def parse_ledger(path):
    lines = open(path, encoding="utf-8").read().split("\n")
    b0 = next(i for i, l in enumerate(lines) if l.startswith("## B."))
    rows, B = [], []
    for i, l in enumerate(lines):
        if not l.startswith("| "): continue
        c = split_cells(l)
        if i < b0 and len(c) >= 4 and re.fullmatch(r"\d+", c[0]):
            rows.append(dict(n=int(c[0]), text=norm(c[1]), where=norm(c[2]), when=norm(c[3]), line=i + 1))
        elif i > b0 and len(c) >= 6 and c[0] not in ("id",) and not set(c[0]) <= set("-: "):
            B.append(dict(id=c[0], milestone=c[1], text=norm(c[2]), grade=norm(c[3]), proof=norm(c[4]), kernel=norm(c[5]), line=i + 1))
    return dict(rows=rows, B=B)

def scoped_text(path_text_cache, root, src, scope):
    """The normalised text a pattern must occur in: a whole file, one ledger row, or one § B entry."""
    key = src
    if key not in path_text_cache: path_text_cache[key] = (root / src).read_text(encoding="utf-8")
    raw = path_text_cache[key]
    if not scope: return norm(raw)
    led = parse_ledger(root / src)
    if "row" in scope:
        r = [x for x in led["rows"] if x["n"] == scope["row"]]
        return " | ".join([r[0]["text"], r[0]["where"], r[0]["when"]]) if r else None
    if "B" in scope:
        r = [x for x in led["B"] if x["id"] == scope["B"]]
        return " | ".join([r[0]["text"], r[0]["grade"], r[0]["proof"]]) if r else None
    return None

WORD = {1: "one", 2: "two", 3: "three", 4: "four", 5: "five", 6: "six", 7: "seven", 8: "eight"}
def fill(pat, fact, graw):
    v = fact.get("v")
    w = WORD.get(v - 1, "") if isinstance(v, int) else ""
    return norm(pat.replace("{{", "\x00").replace("}}", "\x01").replace("{v}", str(v)).replace("{g}", graw).replace("{w}", w)
                .replace("\x00", "{").replace("\x01", "}"))

# ---- the keyword tag rule: which theorems MENTION which field, place and colour count (mentions, not coverage)
TAG_RULES = {
 "field": {
  "Q47": r"ℚ\(√47\)", "Q167": r"ℚ\(√167\)", "Q59": r"ℚ\(√59\)|type-?\s?\(B\)", "Q83": r"ℚ\(√83\)|type-?\s?\(B\)", "Q131": r"ℚ\(√131\)|type-?\s?\(B\)",
  "Q11": r"ℚ\(√11\)", "Q23": r"ℚ\(√23\)", "Q71": r"ℚ\(√71\)", "Q95": r"ℚ\(√95\)", "Q191": r"ℚ\(√191\)", "Q143": r"ℚ\(√143\)",
  "Q311": r"ℚ\(√311\)", "Q335": r"ℚ\(√335\)", "Q1055": r"ℚ\(√1055\)", "Q4703": r"ℚ\(√4703\)", "Q2351": r"ℚ\(√2351\)",
  "Q3": r"ℚ\(√3\)(?!,)", "Q7": r"ℚ\(√7\)", "Q2": r"ℚ\(√2\)(?!,)", "Q5": r"ℚ\(√5\)|golden", "Q": r"ℚ²|over ℚ(?![(\w_])|χ\(ℚ²\)",
  "Q3_5": r"ℚ\(√3, ?√5\)(?!, ?√)", "Q2_3": r"ℚ\(√2, ?√3\)", "Qa7": r"ℚ\(α, ?√7\)",
  "K": r"(?<![A-Za-z_\\])K(?![A-Za-z_(₀-₉])|K\(i\)|ℚ\(√3, ?√11\)|seam|Moser (lattice|ring)|de Grey's lattice",
  "K35": r"K\(√35\)", "K5": r"K\(√5\)(?!, ?√7)|Heule", "K247": r"K\(√247\)", "K7": r"K\(√7\)|ρ₆₃",
  "DG": r"de Grey's (field|1581|graph)|ℚ\(√3, ?√5, ?√7, ?√11\)|K\(√5, ?√7\)|\b1581\b", "C79": r"𝔽₂₇.*√79|√79",
  "R": r"ℝ²|χ\(ℝ²\)|the (Euclidean )?plane\b",
 },
 "place": {
  "inf": r"real place|archimedean|m₁|measurable chromatic|χ_m\b|χ_B",
  "2": r"dyadic|2-adic|above 2|at 2\b|𝔽₄|U₃₂|U₆₄|U_Q|8Λ|𝔓⁴|ℚ₂|ℤ₂",
  "3": r"3-adic|above 3|at 3\b|𝔽₃\b|𝔽₃[^0-9₀-₉]|𝔽₉|1/3\b", "7": r"Γ₇|𝔽₇\b|𝔽₇[^0-9₀-₉₁]|at 7\b|plane at 7|ℤ/49",
  "11": r"Γ₁₁|𝔽₁₁|at 11\b|ℤ/121|plane at 11", "19": r"Γ₁₉|𝔽₁₉|at 19\b|ℤ/361", "23": r"Γ₂₃|𝔽₂₃|at 23\b|ℤ/529|q = 23",
  "27": r"Γ₂₇|𝔽₂₇|at 27\b|q = 27", "31": r"Γ₃₁|𝔽₃₁|at 31\b", "43": r"Γ₄₃|𝔽₄₃|at 43\b", "47": r"Γ₄₇|𝔽₄₇|at 47\b",
  "59": r"Γ₅₉|at 59\b", "67": r"Γ₆₇|at 67\b", "71": r"Γ₇₁|at 71\b", "79": r"Γ₇₉|at 79\b", "83": r"Γ₈₃|𝔽₈₃|at 83\b",
  "p1": r"split (prime|place)|p ≡ 1 \(mod 4\)|≡ 1 \(4\)|ℤ\[i\]\[1/|band rigidity|band character|RQ₄|RQ₅|U₅\b|U_S|Berend",
 },
 "k": {
  "2": r"two-colour|2-colour|bipartite|two colours", "3": r"three-colour|3-colour|three colours|Θ₃|k = 3",
  "4": r"four-colour|4-colour|four colours|Θ₄|k = 4|X₄", "5": r"five-colour|5-colour|five colours|Θ₅|k = 5|fifth colour|5-chromatic|five-chromatic",
  "6": r"six-colour|6-colour|six colours|k = 6|six-chromatic|6-chromatic|χ ≥ 6|≥ 6\b", "7": r"seven-colour|7-colour|seven colours|seven-chromatic|≤ 7\b",
 },
}
def tags_of(text):
    out = {}
    for axis, rules in TAG_RULES.items():
        out[axis] = sorted(k for k, rx in rules.items() if re.search(rx, text))
    return out

CRUNCH_ROWS = set(range(98, 116))
CRUNCH_B = {"FS-91", "M2", "M3", "row 88", "FS-67"}

# ---- arithmetic rules (the checker re-implements these independently)
def _sqfree(n):
    s = 1 if n > 0 else -1; n = abs(n); out = 1; p = 2
    while p * p <= n:
        e = 0
        while n % p == 0: n //= p; e += 1
        if e % 2: out *= p
        p += 1
    return s * out * n

def classes(rad):
    G = {1}
    for d in rad: G |= {_sqfree(g * d) for g in G}
    return G

def dyadic_state(rad):
    """G35 / G38: the wall is broken iff some odd square class ≡ 7 (mod 8); else inert iff some odd class ≡ 3 (mod 8); else ramified."""
    odd = [c for c in classes(rad) if c % 2]
    if any(c % 8 == 7 for c in odd): return "split"
    if any(c % 8 == 3 for c in odd): return "inert"
    return "ramified"

def stable_state(rad, p):
    """p ≡ 3 (mod 4): the places above p are stable (residue field 𝔽_p) iff every p-unit square class is a square mod p."""
    for c in classes(rad):
        if c % p == 0: continue
        if pow(c % p, (p - 1) // 2, p) != 1: return "split"
    return "stable"
