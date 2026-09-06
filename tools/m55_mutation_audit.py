"""M55 mutation audit (plans/M55-absorption.md §Bʺ): each mutation drops or weakens one hypothesis in the
STATEMENT of a theorem and keeps its proof; the elaborator must refuse. A mutation that still elaborates
means the hypothesis was dead weight. Runs sequentially on scratch copies; never touches the module."""
import subprocess, sys, time
from pathlib import Path
src = Path('Proofs/HadwigerNelson/Absorb.lean').read_text()
scratch = Path('/tmp/claude-1000/-home-kooshi-source-lean-dir/da8943fd-c675-4fd2-8a7d-cd466fc9eac7/scratchpad/mut'); scratch.mkdir(parents=True, exist_ok=True)
muts = {
 'repaint-drop-independence': ("      (∀ b b' : (Aᶜ : Set V), Clashes G A c φ b → Clashes G A c φ b' → ¬ G.Adj b b') ∧\n", "      True ∧\n"),
 'repaint-drop-no-spare-neighbour': ("      (∀ b : (Aᶜ : Set V), Clashes G A c φ b → ∀ a : A, G.Adj b a → c a ≠ Fin.last k)) :", "      True) :"),
 'hubs-drop-hcomp': ("    (hcomp : ∀ b ∉ A, ∀ b' ∉ A, G.Adj b b' → hub b = hub b')\n    (hcol : ∃ ψ", "    (hcomp : True)\n    (hcol : ∃ ψ"),
 'hubs-drop-hdeg': ("    (hdeg : ∀ b ∉ A, ∀ a ∈ A, ∀ a' ∈ A, G.Adj b a → G.Adj b a' → a = a')\n    (hind : ∀ b ∉ A, ∀ b' ∉ A, (∃ a ∈ A, a ≠ hub b ∧ G.Adj b a) →", "    (hdeg : True)\n    (hind : ∀ b ∉ A, ∀ b' ∉ A, (∃ a ∈ A, a ≠ hub b ∧ G.Adj b a) →"),
 'order-k-plus-one': ("  | cons {A : Set V} {b : V} {L : List V} (hb : b ∉ A) (hdeg : (G.neighborSet b ∩ A).encard ≤ k)", "  | cons {A : Set V} {b : V} {L : List V} (hb : b ∉ A) (hdeg : (G.neighborSet b ∩ A).encard ≤ k + 1)"),
 'symcopy-k-ge-one': ("theorem extends_symCopy (S : Set V) (hk : 2 ≤ k) :", "theorem extends_symCopy (S : Set V) (hk : 1 ≤ k) :"),
}
env = 'source scripts/dev-env.sh 2>/dev/null; '
for name, (a, b) in muts.items():
    assert src.count(a) == 1, (name, src.count(a))
    f = scratch / f'{name}.lean'; f.write_text(src.replace(a, b))
    t = time.time()
    r = subprocess.run(['bash', '-c', env + f'timeout 900 lake env lean {f}'], capture_output=True, text=True)
    errs = [l for l in r.stdout.splitlines() if ': error' in l]
    verdict = 'REFUSED (as registered)' if errs else 'STILL ELABORATES — hypothesis dead weight?!'
    print(f'[mutation] {name}: {verdict}; {len(errs)} error(s); first: {errs[0][:160] if errs else "-"} [{time.time()-t:.0f}s]', flush=True)
