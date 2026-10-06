#!/usr/bin/env bash
# The doubled-name gate — no name is declared by two modules.
#
# `scripts/DupNames.lean` reads every imported module's own compiled constants and prints one `DOUBLED` or
# `GENERATED` line per name that two or more modules declare (at least one of them the package's), with one
# `COPY` line per declaring module. This script turns that into a pass or a fail.
#
# WHY THE GATE NEEDS IT. Lean refuses a second declaration of a name only when one declaring module imports
# the other. Two sibling modules that each declare a theorem of one name and type build, and meet in silence
# in any module importing both. Measured at v4.32.0 (FS131-T4, `data/fs131/t4/experiment-table.md`): the
# environment then keeps the constant of the module imported LAST, and `#print axioms` reads the axiom list
# stored by the module imported FIRST — never the same copy. So `scripts/axioms.sh` can print a record clean
# while the proof the environment holds rests on `sorry`, on an axiom or on a native purchase. With no name
# declared twice, each name has one stored list and it is the list of the constant the environment holds.
#
# WHAT FAILS.
#   doubled                  a name two or more modules declare. The line names every declaring module, its
#                            kind there, whether it is the copy the environment holds, whether its stored
#                            axiom list is the one `#print axioms` reads, and the axioms of that copy's proof.
#   generated-axioms-differ  a theorem Lean generates on demand (an equation lemma, a `congr_simp`; a reserved
#                            name no author can declare) whose copies rest on different axioms. Such names
#                            repeat by Lean's design and are otherwise counted and listed, never failed.
#   coverage                 the scan read a different number of the package's modules than the package has
#                            source files: a module `Proofs.lean` does not import was not scanned.
#   banners, scanned,        the scan's output is not whole, or its totals disagree with its lines: a scan
#   accounting               that did not finish, or lost a line, is never read as a clean scan.
# A scan that does not elaborate is a failure, never an empty result.
#
# WHAT IT KEEPS. The scan's complete output under `build/gate/dupnames/` (`scripts/gate-log.sh`); the terminal
# gets every count, every generated name, every failure in full, and the names that appeared or disappeared
# since the previous complete run. No count of this gate is recorded in `CLAUDE.md`: the generated names come
# and go with the proofs that ask for them, and the gate's condition is `doubled=0`.
#
#   ./scripts/dupnames.sh                         the gate (run it under the slot: it imports the library)
#   ./scripts/dupnames.sh --self-test             plant each fault the gate exists to catch, in a scratch
#                                                 library, and watch each fire (scripts/dupnames-controls.txt)
#   ./scripts/dupnames.sh --self-test --scan F    the same with F in place of scripts/DupNames.lean — for
#                                                 tools/fs131_t4_mutate.py, which breaks the scan on purpose
#                                                 and watches the controls go red. The gate itself takes no
#                                                 such option: it runs the shipped scan or nothing.
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${REPO}"
source "${REPO}/scripts/dev-env.sh"
source "${REPO}/scripts/gate-log.sh"
SCAN="${REPO}/scripts/DupNames.lean"

# check_scan <the scan's output> <the number of source files the package has>
# Prints one `FAIL <kind> <detail>` line per failure, one `GENERATED-NAME <name> <modules>` line per generated
# name and, last, one `COUNTS …` line; sets CHECK_OUT and CHECK_BAD (0 or 1). Every decision of the gate is
# here, so `--self-test` exercises exactly what the gate runs.
check_scan() {
  CHECK_OUT="$(awk -v sources="$2" '
    function fail(kind, msg) { print "FAIL " kind " " msg }
    /^=== DUPNAMES ===$/ { nbegin++; next }
    /^=== END ===$/ { nend++; next }
    /^SCANNED / { nscan++; for (i = 2; i <= NF; i++) { split($i, kv, "="); sc[kv[1]] = kv[2] }; next }
    /^TOTALS / { ntot++; for (i = 2; i <= NF; i++) { split($i, kv, "="); tot[kv[1]] = kv[2] }; next }
    /^(DOUBLED|GENERATED) / {
      n++; cls[n] = $1; name[n] = $2; idx[$2] = n
      for (i = 4; i <= NF; i++) { split($i, kv, "="); attr[n, kv[1]] = kv[2] }
      next
    }
    /^COPY / {
      k = idx[$2]
      if (!k) { fail("accounting", "a COPY line for " $2 ", which no DOUBLED or GENERATED line names"); next }
      ncopy[k]++; copies[k] = copies[k] (ncopy[k] > 1 ? " | " : "") substr($0, index($0, " :: ") + 4)
      next
    }
    END {
      if (nbegin != 1) fail("banners", "=== DUPNAMES === printed " (nbegin + 0) " time(s), not once: the scan did not start, or ran twice")
      if (nend != 1) fail("banners", "=== END === printed " (nend + 0) " time(s), not once: the scan did not run to its end")
      if (nscan != 1) fail("scanned", "SCANNED printed " (nscan + 0) " time(s), not once")
      else if (sc["package-modules"] != sources)
        fail("coverage", "the scan read " sc["package-modules"] " module(s) of the package and the package has " sources " source file(s): a module the root does not import was not scanned, or the scan was told the wrong root")
      for (k = 1; k <= n; k++) {
        if (ncopy[k] + 0 != attr[k, "modules"] + 0)
          fail("accounting", name[k] " is listed with modules=" attr[k, "modules"] " and " (ncopy[k] + 0) " COPY line(s) were read")
        if (cls[k] == "DOUBLED") {
          nd++
          fail("doubled", name[k] " is declared by " attr[k, "modules"] " modules (types=" attr[k, "types"] " axioms=" attr[k, "axioms"] "): " copies[k])
        } else {
          ng++
          print "GENERATED-NAME " name[k] " " attr[k, "modules"]
          if (attr[k, "axioms"] != "same") {
            ngd++
            fail("generated-axioms-differ", name[k] " is generated in " attr[k, "modules"] " modules and its copies rest on different axioms: " copies[k])
          }
        }
      }
      if (ntot != 1) fail("accounting", "TOTALS printed " (ntot + 0) " time(s), not once")
      else if (tot["doubled"] + 0 != nd + 0 || tot["generated"] + 0 != ng + 0 || tot["generated-axioms-differ"] + 0 != ngd + 0)
        fail("accounting", "TOTALS reads doubled=" tot["doubled"] " generated=" tot["generated"] " generated-axioms-differ=" tot["generated-axioms-differ"] " and the lines read give " (nd + 0) ", " (ng + 0) ", " (ngd + 0))
      printf "COUNTS doubled=%d generated=%d generated-axioms-differ=%d modules=%s package-modules=%s package-constants=%s other-constants=%s\n", \
        nd, ng, ngd, sc["modules"], sc["package-modules"], sc["package-constants"], sc["other-constants"]
    }
  ' <<< "$1")"
  if grep -q '^FAIL ' <<< "${CHECK_OUT}"; then CHECK_BAD=1; else CHECK_BAD=0; fi
}

count() { sed -n "s/.* $1=\([0-9]*\).*/\1/p" <<< " $(grep '^COUNTS ' <<< "${CHECK_OUT}" || true)"; }

# ---------------------------------------------------------------------------------------------------------
# --self-test — plant each fault the gate exists to catch, and watch it fire.
#
# `RUNNING.md` § Make the gate fail, and watch it fail. The planted library is written from the `## module`
# blocks of `scripts/dupnames-controls.txt` into `data/fs131/t4/plant/` (its own Lake package, core Lean only,
# never under `Proofs/`) and built there from nothing. Each control elaborates a COPY of the scan — its one
# `import Proofs` line replaced by the control's imports, its one `#eval DupNames.scan` line by the control's
# root — and `check_scan` above, the function the gate runs, judges the output.
# ---------------------------------------------------------------------------------------------------------
if [[ "${1:-}" == "--self-test" ]]; then
  if [[ "${2:-}" == "--scan" ]]; then
    SCAN="$(readlink -f "${3:?--scan needs a file}")"
    echo "==> dupnames self-test: the scan under test is ${SCAN}, NOT the shipped scripts/DupNames.lean"
  elif [[ -n "${2:-}" ]]; then
    echo "==> dupnames self-test: FAIL — unknown option '${2}'"; exit 2
  fi
  gate_log_open dupnames-self-test
  CONTROLS="${REPO}/scripts/dupnames-controls.txt"
  PLANT="${REPO}/data/fs131/t4/plant"
  WORK="$(mktemp -d)"
  trap 'rm -rf "${WORK}"' EXIT

  IMPORT_ANCHOR='import Proofs'
  EVAL_ANCHOR='#eval DupNames.scan #[`Proofs]'
  for a in "${IMPORT_ANCHOR}" "${EVAL_ANCHOR}"; do
    n="$(grep -cxF "${a}" "${SCAN}" || true)"
    if [[ "${n}" != 1 ]]; then
      echo "==> dupnames self-test: FAIL — the anchor '${a}' occurs ${n} times in ${SCAN#"${REPO}"/}, not once"
      exit 1
    fi
  done

  # The planted library, from the controls file; built from nothing, so a stale build can pass no control.
  mapfile -t MODULES < <(sed -n 's/^## module //p' "${CONTROLS}")
  [[ "${#MODULES[@]}" -gt 0 ]] || { echo "==> dupnames self-test: FAIL — no module read from ${CONTROLS#"${REPO}"/}"; exit 1; }
  rm -rf "${PLANT}"
  mkdir -p "${PLANT}"
  cp "${REPO}/lean-toolchain" "${PLANT}/lean-toolchain"
  printf 'name = "t4plant"\ndefaultTargets = []\n\n[[lean_lib]]\nname = "T4Plant"\n\n[[lean_lib]]\nname = "T4Dep"\n' > "${PLANT}/lakefile.toml"
  for m in "${MODULES[@]}"; do
    f="${PLANT}/${m//.//}.lean"
    mkdir -p "$(dirname "${f}")"
    awk -v m="${m}" '/^## module / { on = ($3 == m); next } /^## / { on = 0 } /^# / { next } on' "${CONTROLS}" \
      | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' > "${f}"
  done
  bstatus=0
  bout="$(cd "${PLANT}" && lake build "${MODULES[@]}" 2>&1)" || bstatus=$?
  { echo "######## the planted library: lake build of ${#MODULES[@]} modules (exit ${bstatus})"; echo "${bout}"; } >> "${GATE_LOG}"
  if [[ "${bstatus}" -ne 0 ]]; then
    echo "${bout}"
    echo "==> dupnames self-test: FAIL — the planted library did not build (above); no control was run."
    exit 1
  fi

  mapfile -t NAMES < <(sed -n 's/^## control //p' "${CONTROLS}")
  [[ "${#NAMES[@]}" -gt 0 ]] || { echo "==> dupnames self-test: FAIL — no controls read from ${CONTROLS#"${REPO}"/}"; exit 1; }
  block() { awk -v c="$1" '/^## control / { on = ($3 == c); next } /^## module / { on = 0 } on' "${CONTROLS}"; }

  echo "==> dupnames self-test: ${#NAMES[@]} controls over a planted library of ${#MODULES[@]} modules (data/fs131/t4/plant/)"
  fails=0
  for name in "${NAMES[@]}"; do
    B="$(block "${name}")"
    imports="$(sed -n 's/^## import //p' <<< "${B}")"
    root="$(sed -n 's/^## root //p' <<< "${B}")"; root="${root:-T4Plant}"
    sources="$(sed -n 's/^## sources //p' <<< "${B}")"
    problems=()
    [[ -n "${imports}" ]] || problems+=("no '## import' line")
    [[ "${sources}" =~ ^[0-9]+$ ]] || problems+=("no '## sources <n>' line")

    lean_file="${WORK}/${name}.lean"
    IMPORTS="$(printf 'import Lean\n'; for m in ${imports}; do printf 'import %s\n' "${m}"; done)" \
    EVAL="#eval DupNames.scan #[\`${root}]" IMPORT_ANCHOR="${IMPORT_ANCHOR}" EVAL_ANCHOR="${EVAL_ANCHOR}" awk '
      $0 == ENVIRON["IMPORT_ANCHOR"] { print ENVIRON["IMPORTS"]; next }
      $0 == ENVIRON["EVAL_ANCHOR"] { print ENVIRON["EVAL"]; next }
      { print }
    ' "${SCAN}" > "${lean_file}"

    status=0
    raw="$(cd "${PLANT}" && lake env lean "${lean_file}" 2>&1)" || status=$?
    { echo "######## control ${name} (lean exit ${status})"; echo "${raw}"; } >> "${GATE_LOG}"
    while read -r _ _ prefix; do
      raw="$(awk -v p="${prefix}" '!done && index($0, p) == 1 { done = 1; next } { print }' <<< "${raw}")"
    done < <(grep '^## drop-output ' <<< "${B}" || true)

    if [[ "${status}" -ne 0 ]]; then
      verdict="did not elaborate"; CHECK_OUT=""; CHECK_BAD=1
    else
      check_scan "${raw}" "${sources:-0}"
      if [[ "${CHECK_BAD}" -eq 0 ]]; then verdict="passed"
      else verdict="failed ($(grep -c '^FAIL ' <<< "${CHECK_OUT}" || true) FAIL line(s))"; fi
    fi
    while read -r _ _ kind rest; do
      case "${kind}" in
        PASS)   [[ "${status}" -eq 0 && "${CHECK_BAD}" -eq 0 ]] || problems+=("expected PASS") ;;
        ELAB)   { [[ "${status}" -ne 0 ]] && grep -qF "${rest}" <<< "${raw}"; } || problems+=("expected the copy not to elaborate, with '${rest}'") ;;
        FAIL)   read -r fkind ftext <<< "${rest}"
                if [[ -z "${ftext:-}" ]]; then problems+=("a FAIL expectation must name a kind and a text: '${rest}'")
                else grep -E "^FAIL ${fkind} " <<< "${CHECK_OUT}" | grep -qF "${ftext}" || problems+=("expected 'FAIL ${fkind}' with '${ftext}'"); fi ;;
        NOFAIL) ! grep -qE "^FAIL ${rest} " <<< "${CHECK_OUT}" || problems+=("expected no 'FAIL ${rest}'") ;;
        COUNT)  grep '^COUNTS ' <<< "${CHECK_OUT}" | grep -qE "(^| )${rest}( |$)" || problems+=("expected COUNTS ${rest}") ;;
        *)      problems+=("unknown expectation '${kind}'") ;;
      esac
    done < <(grep '^## expect ' <<< "${B}")
    grep -q '^## expect ' <<< "${B}" || problems+=("no expectation: a control that expects nothing tests nothing")
    # Two-sided: every failure the plant raised must be one the control predicts.
    while read -r fkind; do
      [[ -z "${fkind}" ]] || grep -qxE "## expect FAIL ${fkind} .*" <<< "${B}" || problems+=("an unforeseen 'FAIL ${fkind}'")
    done < <(grep '^FAIL ' <<< "${CHECK_OUT}" | awk '{ print $2 }' | sort -u || true)

    if [[ "${#problems[@]}" -eq 0 ]]; then
      echo "    ok    ${name} — ${verdict}"
      grep -E '^FAIL ' <<< "${CHECK_OUT}" | cut -c1-230 | sed 's/^/            /' || true
      [[ "${status}" -ne 0 ]] && grep -m1 -E 'error' <<< "${raw}" | cut -c1-230 | sed 's/^/            /' || true
    else
      echo "    FAIL  ${name} — ${verdict}; $(IFS=';'; echo "${problems[*]}")"
      { grep -E '^(FAIL|COUNTS) ' <<< "${CHECK_OUT}" || true; [[ "${status}" -ne 0 ]] && grep -m3 -E 'error' <<< "${raw}" || true; } \
        | cut -c1-230 | sed 's/^/            got: /'
      fails=$((fails + 1))
    fi
  done

  gate_log_complete
  if [[ "${fails}" -gt 0 ]]; then
    echo "==> dupnames self-test: FAIL — ${fails} of ${#NAMES[@]} control(s) did not behave as designed."
    echo "    The gate cannot be trusted until every one of these behaves. Never tune a control until it agrees."
    echo "    every control's output: ${GATE_LOG#"${REPO}"/}"
    exit 1
  fi
  echo "==> dupnames self-test: OK — all ${#NAMES[@]} controls behaved: every planted fault fired, and every partner passed."
  echo "    every control's output: ${GATE_LOG#"${REPO}"/}"
  exit 0
fi

if [[ -n "${1:-}" ]]; then
  echo "==> dupnames: FAIL — unknown option '${1}' (the gate takes none; --self-test runs the controls)"; exit 2
fi

gate_log_open dupnames
# The status is captured explicitly, never through a pipe: a scan that cannot run is not a clean scan.
STATUS=0
RAW="$(lake env lean "${SCAN}" 2>&1)" || STATUS=$?
printf '%s\n' "${RAW}" > "${GATE_LOG}"
if [[ "${STATUS}" -ne 0 ]]; then
  echo "${RAW}" | tail -40
  echo "==> dupnames: FAIL — scripts/DupNames.lean did not elaborate (exit ${STATUS}; above)."
  echo "    An import that fails with 'environment already contains' is a doubled name the importer refuses —"
  echo "    two definitions, or two theorems of different types; the message names it and both modules."
  echo "    full output: ${GATE_LOG#"${REPO}"/}"
  exit 1
fi
PREV="${GATE_PREV}"

# The package's source files, counted as `scripts/build_order.py` finds its modules.
SOURCES="$(( $(find "${REPO}/Proofs" -name '*.lean' | wc -l) + 1 ))"
check_scan "${RAW}" "${SOURCES}"
# Only a whole output becomes the run the next one is compared with.
grep -q '^FAIL banners ' <<< "${CHECK_OUT}" || gate_log_complete

if ! grep -q '^COUNTS ' <<< "${CHECK_OUT}"; then
  echo "==> dupnames: FAIL — the check printed no COUNTS line, so it did not run to its end"
  echo "    full output: ${GATE_LOG#"${REPO}"/}"
  exit 1
fi
echo "    scanned $(count modules) modules, $(count package-modules) of them the package's (${SOURCES} source files);" \
  "$(count package-constants) constants of the package against $(count other-constants) of its dependencies"
GEN="$(sed -n 's/^GENERATED-NAME //p' <<< "${CHECK_OUT}")"
if [[ -n "${GEN}" ]]; then
  echo "    --- generated by Lean on demand in several modules, by design; not failures ($(grep -c . <<< "${GEN}")) ---"
  awk '{ printf "    %s (%s modules)\n", $1, $2 }' <<< "${GEN}"
fi
# What changed since the previous complete run: the repeated names, by class.
if [[ -n "${PREV}" && -f "${PREV}" ]]; then
  CHANGED="$(diff <(grep -E '^(DOUBLED|GENERATED) ' "${PREV}" | awk '{ print $1, $2 }' | sort) \
                  <(grep -E '^(DOUBLED|GENERATED) ' <<< "${RAW}" | awk '{ print $1, $2 }' | sort) | grep -E '^[<>]' || true)"
  if [[ -n "${CHANGED}" ]]; then
    echo "    --- changed since the previous complete run ('<' gone, '>' new) ---"
    sed 's/^/    /' <<< "${CHANGED}"
  else
    echo "    no repeated name appeared or disappeared since the previous complete run"
  fi
fi

if [[ "${CHECK_BAD}" -ne 0 ]]; then
  grep -E '^FAIL ' <<< "${CHECK_OUT}" | sed 's/^/    /'
  echo "==> dupnames: FAIL — $(grep -c '^FAIL ' <<< "${CHECK_OUT}" || true) check(s) failed (above); doubled names: $(count doubled)."
  echo "    A doubled theorem builds in silence, and then \`#print axioms\` reads the list stored by the module"
  echo "    imported first while the environment holds the proof of the module imported last (LEAN.md § The gate)."
  echo "    Make each doubled name one declaration, in a module every user of it imports."
  echo "    full output: ${GATE_LOG#"${REPO}"/}"
  exit 1
fi
echo "==> dupnames: OK — no name is declared by two modules ($(count generated) generated on demand, listed above)"
echo "    full output: ${GATE_LOG#"${REPO}"/}"
