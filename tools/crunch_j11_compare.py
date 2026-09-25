#!/usr/bin/env python3
"""J11 stage 4: value-by-value comparison of J08's data with J11's (reads J08's JSON, runs no J08 tool).
Plant: --plant perturbs one of J11's values and the comparison must report exactly that divergence."""
import json
import sys
from fractions import Fraction

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from crunch_j11_band import reduction_table  # noqa: E402

plant = "--plant" in sys.argv
J = json.load(open("data/fs91/j08/threshold.json"))
K = json.load(open("data/fs91/j08/kappa-23-43.json"))
M = json.load(open("data/fs91/j11/band-lists.json"))
T = json.load(open("data/fs91/j11/targets.json"))
if plant:
    M["planes"]["31"]["chi_char"] = 9  # a planted divergence: must be the only one reported
div, agree = [], 0
jt = {r["q"]: r for r in J["table"]}
for qs, e in M["planes"].items():
    q = int(qs)
    if q not in jt:
        div.append(("missing in J08 table", q)); continue
    r = jt[q]
    for key, mine, theirs in (("chi_char", e["chi_char"], r["chi_char"]), ("kappa", e["kappa"], r["kappa"]),
                              ("argmax_c", e["chi_char_witnesses"], sorted(r["argmax_c"]))):
        if mine != theirs:
            div.append((q, key, mine, theirs))
        else:
            agree += 1
# the 23/43 detail
for t in K["targets"]:
    q = t["q"]; e = M["planes"][str(q)]
    for c, m in t["m_by_nonsquare_c"].items():
        if e["d_of_c"][c] != m:
            div.append((q, "m(c)", c, e["d_of_c"][c], m))
        else:
            agree += 1
    for k, lst in t["band_lists"].items():
        if e["band"][k] != sorted(lst):
            div.append((q, "band", k, e["band"][k], lst))
        else:
            agree += 1
# lists for W3
for k in ("6", "7"):
    theirs = {int(q): v for q, v in J["lists"][k]["band_k_below_Q_k"].items()}
    mine = {int(q): e["band"][k] for q, e in M["planes"].items() if e["band"][k]}
    if theirs != mine:
        div.append(("W3 list", k, mine, theirs))
    else:
        agree += 1
# field targets and minima
name_map = {"Q(sqrt167)": "Q(sqrt167)", "K(sqrt7)": "K(sqrt7)=Q(sqrt3,sqrt7,sqrt11)"}
for mine_name, e in T["fields"].items():
    jn = [n for n in J["fields"] if n.split("=")[0].replace(" ", "") .startswith(mine_name.split(" ")[0].replace("deGrey", "deGrey")) or mine_name.startswith(n.split("=")[0])]
    jn = jn or [n for n in J["fields"] if ("Grey" in n) == ("Grey" in mine_name) and ("167" in n) == ("167" in mine_name)]
    jf = J["fields"][jn[0]]
    if jf["min_chi_char"] != e["min_chi_char"]:
        div.append((mine_name, "min", e["min_chi_char"], jf["min_chi_char"]))
    else:
        agree += 1
    mine_t = {t["p"]: t.get("chi_char") for t in e["targets"] if "chi_char" in t}
    for tt in jf["targets_examined"]:
        if tt["q"] in mine_t:
            if mine_t[tt["q"]] != tt["chi_char"]:
                div.append((mine_name, "target chi_char", tt["q"], mine_t[tt["q"]], tt["chi_char"]))
            else:
                agree += 1
        else:
            div.append((mine_name, "target not in J11's computed list", tt["q"]))
    theirs_q = {tt["q"] for tt in jf["targets_examined"]}
    bound = jf.get("derived_bound_4(m-2)^2")
    extra = sorted(p for p in mine_t if p not in theirs_q and (bound is None or p < bound))
    if extra:
        div.append((mine_name, "J11 targets below J08's bound missing from J08", extra))
# spot checks of J08's table above 199 with J11's own reduction
spots = [q for q in (227, 499, 887, 1091, 1559, 1999, 2999) if q in jt]
for q in spots:
    D = max(reduction_table(q).values())
    cc = -(-q // D)
    if (cc, f"{Fraction(D, q).numerator}/{Fraction(D, q).denominator}") != (jt[q]["chi_char"], jt[q]["kappa"]):
        div.append((q, "spot", cc, jt[q]["chi_char"]))
    else:
        agree += 1
print("agreements", agree, "divergences", len(div), "spots", spots)
for d in div:
    print("DIV", d)
out = {"agreements": agree, "divergences": div, "spots": spots, "plant": plant}
if not plant:
    json.dump(out, open("data/fs91/j11/compare-j08.json", "w"), indent=1, default=str)
sys.exit(0)
