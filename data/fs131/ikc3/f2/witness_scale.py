"""FS131-IKC3: for each block of an FS-66 certificate, does the converter's PSD witness at scale 2^sb still pass the
diagonal-dominance check in the converter's model (tools/fs131_ikc1_gen.py's mp_cholesky_int and check_dd, imported,
not edited)? Usage: python3 -I witness_scale.py CERT.json SB [SB ...]. Prints one line per block and scale; exit 1 if any fails.
The kernel is the check; this only says whether a smaller witness is worth generating."""
import importlib.util, json, sys, time
spec = importlib.util.spec_from_file_location("gen", "tools/fs131_ikc1_gen.py"); gen = importlib.util.module_from_spec(spec); spec.loader.exec_module(gen)
C = json.load(open(sys.argv[1])); bad = 0
for sb in [int(x) for x in sys.argv[2:]]:
    for bi, b in enumerate(C['blocks']):
        t = time.time(); M, s = gen.mp_cholesky_int(b['R'], sb); ok, row = gen.check_dd(b['R'], M, s)
        bad += not ok
        print(f"sb={sb} block={bi} m={len(b['R'])} dominant={ok} row={row} Mbits={max(abs(v) for r in M for v in r).bit_length()} {time.time()-t:.1f}s", flush=True)
print("FAILS", bad); sys.exit(1 if bad else 0)
