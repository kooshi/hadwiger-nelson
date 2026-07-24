#!/usr/bin/env bash
# Race several CaDiCaL configurations on one CNF; keep the first LRAT certificate produced.
# Pure wall-clock win: the certificate is checked in Lean regardless of which config made it.
set -u
CNF="$1"; OUT="$2"
CAD="${CADICAL:-$HOME/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical}"
D=$(mktemp -d)
pids=()
run() { $CAD --lrat --no-binary "$@" "$CNF" "$D/$3.lrat" >"$D/$3.log" 2>&1; echo $? > "$D/$3.rc"; }

i=0
for cfg in "--unsat" "" "--plain" "--sat"; do
  for seed in 0 1; do
    i=$((i+1))
    ( $CAD --lrat --no-binary $cfg --seed=$seed "$CNF" "$D/c$i.lrat" >"$D/c$i.log" 2>&1
      echo "$?" > "$D/c$i.rc" ) &
    pids+=($!)
  done
done

# poll for the first success (exit code 20 = UNSAT)
while :; do
  for f in "$D"/*.rc; do
    [ -e "$f" ] || continue
    if [ "$(cat "$f")" = "20" ]; then
      b="${f%.rc}"
      cp "$b.lrat" "$OUT"
      echo "winner: $(basename "$b")  $(grep -E '^c total.*process|^c .*seconds' "$b.log" | tail -1)"
      kill "${pids[@]}" 2>/dev/null
      wait 2>/dev/null
      rm -rf "$D"
      exit 0
    elif [ "$(cat "$f")" = "10" ]; then
      echo "SATISFIABLE -- the graph IS 4-colourable; certificate impossible" >&2
      kill "${pids[@]}" 2>/dev/null; rm -rf "$D"; exit 10
    fi
  done
  # all dead without success?
  if ! kill -0 "${pids[@]}" 2>/dev/null; then
    echo "all configs finished without UNSAT" >&2; rm -rf "$D"; exit 1
  fi
  sleep 2
done
