import sys
sys.path.insert(0, "tools")
import numpy as np
import fs54_d4_quad as Q
orig = Q._compress_block
def plant_a(nvar, label, m, rows, cols, vals, const):     # one '+-' block's values scaled by 1 + 1e-9
    if label.startswith("+-@") and not getattr(plant_a, "done", False):
        plant_a.done = True
        vals = vals * (1 + 1e-9)
    return orig(nvar, label, m, rows, cols, vals, const)
def plant_b(nvar, label, m, rows, cols, vals, const):     # one '--' block loses one raw term
    if label.startswith("--@") and not getattr(plant_b, "done", False):
        plant_b.done = True
        rows, cols, vals = rows[1:], cols[1:], vals[1:]
    return orig(nvar, label, m, rows, cols, vals, const)
for name, pl in (("scale one +- block by 1+1e-9", plant_a), ("drop one raw term of one -- block", plant_b)):
    Q._compress_block = pl
    rec = Q.lean_compare(11, None, "l3", workers=1, log=lambda *a: None)
    print(f"PLANT {name}: same={rec['same']} max diff {rec['max_abs_entry_difference']:.2e} -> {'FIRED' if not rec['same'] else 'DID NOT FIRE'}")
Q._compress_block = orig
rec = Q.lean_compare(11, None, "l3", workers=1, log=lambda *a: None)
print(f"restored: same={rec['same']} max diff {rec['max_abs_entry_difference']:.2e}")
