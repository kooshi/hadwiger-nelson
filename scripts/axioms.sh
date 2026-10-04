#!/usr/bin/env bash
# The trust receipt, checked rather than eyeballed.
#
# `scripts/Axioms.lean` prints one `#print axioms` line per public theorem, split by three printed
# banners. This script enforces the rule the banners encode — **every axiom a record carries must be
# one its section allows**, checked axiom by axiom on each record's list (FS131-T3, 2026-10-04; until
# then CLEAN was checked only for a native purchase and `sorryAx`, so a CLEAN record resting on any
# other axiom passed and was counted clean):
#
#   CLEAN      — a subset of propext / Classical.choice / Quot.sound, the empty set included.
#   PURCHASED  — a native-evaluation axiom is expected, by design: the standard three, its native axioms,
#                and declared imports, nothing else. A record here with *no* native axiom fails too: a
#                stale ledger entry means a declaration was cleaned up and the audit was never told.
#   IMPORTED   — rests on a declared outside theorem: the standard three and declared imports, nothing
#                else, and at least one declared import (a record with none belongs under CLEAN).
#
# A *declared import* is an `axiom` named by an `AxiomAudit.declareImport` line in the IMPORTED section
# of `scripts/Axioms.lean`, the one list of them (the procedure is beside that banner). Lean refuses the
# line unless the name is an axiom of the library whose docstring names a bibliography key; this script
# also fails when `ARCHITECTURE.md` § Trust does not name it in backticks, when no audited record carries
# it, and when the library declares any axiom the list does not name — the audit's last command prints
# them all, so an axiom whose consumers are never audited still reaches the gate. `sorryAx` fails
# everywhere. Each failure is one line, `FAIL <kind> <detail>`, naming the record or the axiom.
#
# Why a script and not a reading: at toolchain v4.32.0 `native_decide` mints a *per-declaration*
# axiom (`foo._native.native_decide.ax_1_1`) and `Lean.ofReduceBool` never appears. That difference
# is one long name in a wall of text, and this project's whole trust story rests on someone noticing
# it. So nobody has to.
#
# What it prints, and what it keeps: the receipt — over a thousand records — is saved whole under
# `build/gate/axioms/` (`scripts/gate-log.sh`), and the terminal gets a digest of that file from
# `scripts/gate_report.py`: every count (axiom-free declarations included, which the first version counted
# nowhere), each axiom set with how many records carry it, each purchase, each declared import and the
# records resting on it, whether `CLAUDE.md` § Trust ledger still records the right counts, and every record
# that appeared, disappeared or changed its axioms since the previous complete run. The first version
# printed the receipt raw, a wall read by its last lines.
#
#   ./scripts/axioms.sh               the gate
#   ./scripts/axioms.sh --self-test   plant each fault the gate exists to catch, in copies of the audit,
#                                     and watch each fire (controls: scripts/axioms-controls.txt)
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${REPO}/scripts/dev-env.sh"
source "${REPO}/scripts/gate-log.sh"

# `#print axioms` wraps long axiom lists across lines, so a line-oriented reading would both miss records
# and mis-report them. Rejoin each record onto one line: a record opens with a quote and `depends on axioms: [`
# and ends at its closing bracket; every other line — a banner, an axiom-free record, a `DECLARED IMPORT` or
# `LIBRARY` line, a warning — stands alone. (The first version joined any line without a bracket onto the line
# after it, so each axiom-free record was glued onto the next — found 2026-09-11 when the digest disagreed —
# and a one-line warning would have been too.)
normalize() {
  awk '
    inrec { buf = buf " " $0; if (index($0, "]") > 0) { print buf; buf = ""; inrec = 0 }; next }
    /^'"'"'/ && index($0, " depends on axioms: [") > 0 {
      if (index($0, "]") > 0) print; else { buf = $0; inrec = 1 }; next
    }
    { print }
    END { if (inrec) print buf }
  ' | sed 's/[[:space:]]\+/ /g'
}

# check_receipt <normalized receipt> <ARCHITECTURE.md to read>
# Prints one `FAIL <kind> <detail>` line per failure and, last, one `COUNTS …` line; sets CHECK_BAD to 0 or 1.
# Every decision of the gate is here, so `--self-test` exercises exactly what the gate runs.
check_receipt() {
  local norm="$1" arch="$2" out decl short
  # Every record is collected first and judged at the end, because the declared imports are printed after
  # the CLEAN records they decide about.
  out="$(awk '
    function fail(kind, msg) { print "FAIL " kind " " msg; bad = 1 }
    function native(a) { return index(a, "._native.") > 0 || a == "Lean.ofReduceBool" || a == "Lean.trustCompiler" }
    BEGIN {
      std["propext"]; std["Classical.choice"]; std["Quot.sound"]
      want["CLEAN"]; want["PURCHASED"]; want["IMPORTED"]
      DEP = "'"'"' depends on axioms: ["; FREE = "'"'"' does not depend on any axioms"
      sec = ""; nrec = 0; nsum = 0; nlib = 0
    }
    /^=== [A-Z]+ ===$/ { sec = substr($0, 5, length($0) - 8); banner[sec]++; next }
    /^DECLARED IMPORT / { declared[substr($0, 17)]++; next }
    /^LIBRARY SUMMARY / { nsum++; for (i = 3; i <= NF; i++) { split($i, kv, "="); summ[kv[1]] = kv[2] }; next }
    /^LIBRARY AXIOM / { library[substr($0, 15)]++; nlib++; next }
    /^'"'"'/ {
      k = index($0, DEP); f = index($0, FREE)
      if (k > 0 && substr($0, length($0)) == "]") {
        nm = substr($0, 2, k - 2); ax = substr($0, k + length(DEP), length($0) - k - length(DEP))
      } else if (f > 0 && f + length(FREE) - 1 == length($0)) {
        nm = substr($0, 2, f - 2); ax = ""
      } else { fail("malformed", "a line that opens like a record and is not one: " $0); next }
      nrec++; rsec[nrec] = sec; rname[nrec] = nm; rax[nrec] = ax
      next
    }
    END {
      for (b in want) if (banner[b] != 1) fail("banners", "=== " b " === printed " (banner[b] + 0) " time(s), not once: scripts/Axioms.lean did not run to completion, or its banners changed")
      for (b in banner) if (!(b in want)) fail("banners", "an unknown banner, === " b " ===")
      for (i = 1; i <= nrec; i++) {
        s = rsec[i]; r = "'"'"'" rname[i] "'"'"'"; n = (rax[i] == "" ? 0 : split(rax[i], a, ", "))
        if (s == "") { fail("outside-banners", r " is printed before the first banner"); continue }
        nn = 0; nd = 0
        for (j = 1; j <= n; j++) {
          x = a[j]
          if (x in std) continue
          if (x == "sorryAx") { fail("sorry", s " " r " carries sorryAx"); continue }
          if (native(x)) {
            nn++
            if (s == "CLEAN") fail("native-in-clean", r " carries the native purchase " x)
            else if (s == "IMPORTED") fail("native-in-imported", r " carries the native purchase " x " (a record with a native axiom belongs under PURCHASED)")
            continue
          }
          if (x in declared) {
            nd++; carried[x]++
            if (s == "CLEAN") fail("import-in-clean", r " carries the declared import " x ": move its record under IMPORTED")
            continue
          }
          fail("undeclared-in-" tolower(s), r " carries " x ", which is not the standard three" (s == "PURCHASED" ? ", not native," : "") " and not a declared import")
        }
        if (s == "IMPORTED" && nd == 0) fail("stale-import", r " carries no declared import: its record belongs under CLEAN")
        if (s == "PURCHASED" && nn == 0) fail("stale-purchase", r " carries no native axiom: a stale ledger entry")
        if (s == "CLEAN") { if (n == 0) free++; else clean++ }
        else if (s == "IMPORTED") imported++
        else if (s == "PURCHASED") { purchased++; print "PURCHASED " rname[i] }
      }
      for (d in declared) {
        print "DECL " d
        if (declared[d] > 1) fail("declared-twice", d " is declared " declared[d] " times")
        if (!(d in library)) fail("declared-not-in-library", d " is declared but the library lists no such axiom")
        if (!(d in carried)) fail("stale-declaration", d " is declared and no audited record carries it: audit its consumers, or delete the axiom")
      }
      for (x in library) if (!(x in declared)) fail("undeclared-library-axiom", x " is an axiom of the library and no declareImport names it")
      if (nsum != 1) fail("library-accounting", "LIBRARY SUMMARY printed " nsum " time(s), not once: AxiomAudit.libraryAxioms did not run as the last command")
      else if (summ["axioms"] != nlib) fail("library-accounting", "LIBRARY SUMMARY counts " summ["axioms"] " axioms and " nlib " LIBRARY AXIOM lines were read")
      printf "COUNTS clean=%d free=%d imported=%d purchased=%d declared=%d library=%d native=%d records=%d\n", clean, free, imported, purchased, length(declared), nlib, summ["native"], nrec
    }
  ' <<< "${norm}")"

  # LEAN.md § Assumptions item 4: each declared import has its row in ARCHITECTURE.md § Trust, naming it in
  # backticks, with or without the root namespace. Read only when there is something to look for.
  if grep -q '^DECL ' <<< "${out}"; then
    local trust=""
    [[ -f "${arch}" ]] && trust="$(awk '/^## ([0-9]+\. )?Trust$/ { f = 1; next } f && /^## / { f = 0 } f' "${arch}")"
    if [[ -z "${trust}" ]]; then
      out+=$'\n'"FAIL arch-missing could not read § Trust in ${arch#"${REPO}"/}, so no declared import's row could be checked"
    else
      while IFS= read -r decl; do
        short="${decl#HadwigerNelson.}"
        if ! grep -qF "\`${decl}\`" <<< "${trust}" && ! grep -qF "\`${short}\`" <<< "${trust}"; then
          out+=$'\n'"FAIL arch-missing ${decl} is declared and ${arch#"${REPO}"/} § Trust does not name it in backticks (LEAN.md § Assumptions item 4)"
        fi
      done < <(sed -n 's/^DECL //p' <<< "${out}")
    fi
  fi

  # The two purchase ledgers must agree. `Sat/Lrat.lean` establishes the convention that every declaration
  # whose proof evaluates a certificate opens its docstring with "**Trust purchase: native evaluation.**", so
  # the *source* enumerates the purchases; the PURCHASED banner enumerates them from the *environment*. A
  # declaration in one and not the other is the failure this whole gate exists to catch: a native purchase
  # nobody wrote down, or a docstring warning about a purchase that is no longer made.
  # Matches `/-- **Trust purchase:` specifically — the convention is that the phrase *opens the declaration's
  # docstring*, so prose that merely discusses the convention (as `Sat/Lrat.lean`'s module docstring does,
  # where it is a blockquote) is correctly not a ledger entry.
  local src_ledger env_ledger diff_out
  src_ledger="$(awk '
    /^\/-- \*\*Trust purchase:/ { pending = 1; next }
    pending && /^(theorem|def|abbrev|instance) / {
      name = $2; sub(/[^A-Za-z0-9_'"'"'.]+$/, "", name); print name; pending = 0
    }
  ' $(git -C "${REPO}" ls-files 'Proofs/**/*.lean' | sed "s|^|${REPO}/|") | sort -u)"
  # The last component of each PURCHASED record's name, whether or not it has a namespace: the first version's
  # pattern required a dot, so a purchase declared at the root never reached this comparison (found by the
  # `purchased_undeclared` control, FS131-T3).
  env_ledger="$(sed -n 's/^PURCHASED //p' <<< "${out}" | sed 's/.*\.//' | sort -u)"
  if ! diff_out="$(diff <(echo "${src_ledger}") <(echo "${env_ledger}"))"; then
    out+=$'\n'"FAIL purchase-ledgers the source ledger and the environment ledger disagree ('<' = a docstring says 'Trust purchase' and scripts/Axioms.lean never audits it; '>' = audited as PURCHASED and its docstring does not warn the reader):"
    out+=$'\n'"$(sed 's/^/     /' <<< "${diff_out}")"
  else
    out+=$'\n'"LEDGERS $(grep -c . <<< "${src_ledger}" || true): $(paste -sd' ' <<< "${src_ledger}")"
  fi

  CHECK_OUT="${out}"
  if grep -q '^FAIL ' <<< "${out}"; then CHECK_BAD=1; else CHECK_BAD=0; fi
}

# ---------------------------------------------------------------------------------------------------------
# --self-test — plant each fault the gate exists to catch, and watch it fire.
#
# `RUNNING.md` § Make the gate fail, and watch it fail: a check is not known to work until it has been seen to
# fail. Each control in `scripts/axioms-controls.txt` is planted into a COPY of the shipped `scripts/Axioms.lean`
# (never the file itself) at the end of the section it names, elaborated, normalized and judged by
# `check_receipt` above — the same function the gate runs. A control expecting PASS is the partner that shows a
# refusal comes from the plant and not from the scaffolding: the unmodified audit passes, and so does a record
# resting on a properly declared import.
#
# The controls file's header lists its directives: what each control expects (PASS; a FAIL kind naming its
# culprit; a FAIL kind that must NOT fire; a copy that must not elaborate; a count), the faults planted outside
# Lean (a dropped banner, a dropped output line, a row in a copy of ARCHITECTURE.md § Trust), and the digest's
# reading of CLAUDE.md § Trust ledger against one-section copies. A control is two-sided: every FAIL it raises
# must be one it predicts.
# ---------------------------------------------------------------------------------------------------------
if [[ "${1:-}" == "--self-test" ]]; then
  gate_log_open axioms-self-test
  CONTROLS="${REPO}/scripts/axioms-controls.txt"
  AUDIT="${REPO}/scripts/Axioms.lean"
  WORK="$(mktemp -d)"
  trap 'rm -rf "${WORK}"' EXIT

  # Each anchor must occur exactly once in the shipped audit, or a plant could land nowhere and a control pass
  # for that reason.
  # The audit's order: IMPORTED, CLEAN, PURCHASED, then `libraryAxioms` (the IMPORTED banner explains why).
  declare -A ANCHOR=(
    [PRE]='#eval IO.println "=== IMPORTED ==="'
    [IMPORTED]='#eval IO.println "=== CLEAN ==="'
    [CLEAN]='#eval IO.println "=== PURCHASED ==="'
    [PURCHASED]='#eval AxiomAudit.libraryAxioms'
  )
  for s in PRE CLEAN PURCHASED IMPORTED; do
    n="$(grep -cxF "${ANCHOR[$s]}" "${AUDIT}" || true)"
    if [[ "${n}" != 1 ]]; then
      echo "==> axioms self-test: FAIL — the anchor for ${s} ('${ANCHOR[$s]}') occurs ${n} times in scripts/Axioms.lean, not once"
      exit 1
    fi
  done

  mapfile -t NAMES < <(sed -n 's/^## control //p' "${CONTROLS}")
  [[ "${#NAMES[@]}" -gt 0 ]] || { echo "==> axioms self-test: FAIL — no controls read from ${CONTROLS#"${REPO}"/}"; exit 1; }
  # the block of control $1, without its header line
  block() { awk -v c="$1" '/^## control / { on = ($3 == c); next } on' "${CONTROLS}"; }

  echo "==> axioms self-test: ${#NAMES[@]} controls, each planted in a copy of scripts/Axioms.lean"
  fails=0
  for name in "${NAMES[@]}"; do
    B="$(block "${name}")"
    lean_file="${WORK}/${name}.lean"
    # plant each section's lines immediately before that section's closing anchor
    for s in PRE CLEAN PURCHASED IMPORTED; do
      awk -v s="${s}" '/^## at / { on = ($3 == s); next } /^## / { on = 0 } on' <<< "${B}" > "${WORK}/${name}.${s}"
    done
    ANCH_0="${ANCHOR[PRE]}" ANCH_C="${ANCHOR[CLEAN]}" ANCH_P="${ANCHOR[PURCHASED]}" ANCH_I="${ANCHOR[IMPORTED]}" \
    SEG_0="${WORK}/${name}.PRE" SEG_C="${WORK}/${name}.CLEAN" SEG_P="${WORK}/${name}.PURCHASED" \
    SEG_I="${WORK}/${name}.IMPORTED" awk '
      function put(f,   l) { while ((getline l < f) > 0) print l; close(f) }
      $0 == ENVIRON["ANCH_0"] { put(ENVIRON["SEG_0"]) }
      $0 == ENVIRON["ANCH_C"] { put(ENVIRON["SEG_C"]) }
      $0 == ENVIRON["ANCH_P"] { put(ENVIRON["SEG_P"]) }
      $0 == ENVIRON["ANCH_I"] { put(ENVIRON["SEG_I"]) }
      { print }
    ' "${AUDIT}" > "${lean_file}"
    while read -r _ _ sec; do
      grep -vxF "#eval IO.println \"=== ${sec} ===\"" "${lean_file}" > "${lean_file}.tmp" || true
      mv "${lean_file}.tmp" "${lean_file}"
    done < <(grep '^## drop-banner ' <<< "${B}" || true)
    arch="${REPO}/ARCHITECTURE.md"
    if grep -q '^## arch ' <<< "${B}"; then
      arch="${WORK}/${name}.ARCHITECTURE.md"
      ROWS="$(sed -n 's/^## arch \(.*\)$/| `\1` | planted by `scripts\/axioms.sh --self-test` |/p' <<< "${B}")" \
        awk '{ print } /^## ([0-9]+\. )?Trust$/ { print ""; print ENVIRON["ROWS"] }' "${REPO}/ARCHITECTURE.md" > "${arch}"
    fi

    status=0
    raw="$(cd "${REPO}" && lake env lean "${lean_file}" 2>&1)" || status=$?
    { echo "######## control ${name} (lean exit ${status})"; echo "${raw}"; } >> "${GATE_LOG}"
    while read -r _ _ prefix; do
      raw="$(awk -v p="${prefix}" '!done && index($0, p) == 1 { done = 1; next } { print }' <<< "${raw}")"
    done < <(grep '^## drop-output ' <<< "${B}" || true)

    verdict=""; problems=(); digests=()
    if [[ "${status}" -ne 0 ]]; then
      verdict="did not elaborate"
      CHECK_OUT=""; CHECK_BAD=1
    else
      check_receipt "$(normalize <<< "${raw}")" "${arch}"
      if [[ "${CHECK_BAD}" -eq 0 ]]; then verdict="passed"
      else verdict="failed ($(grep -c '^FAIL ' <<< "${CHECK_OUT}" || true) FAIL line(s))"; fi
    fi
    while read -r _ _ kind rest; do
      case "${kind}" in
        PASS)  [[ "${status}" -eq 0 && "${CHECK_BAD}" -eq 0 ]] || problems+=("expected PASS") ;;
        ELAB)  { [[ "${status}" -ne 0 ]] && grep -qF "${rest}" <<< "${raw}"; } || problems+=("expected the copy not to elaborate, with '${rest}'") ;;
        FAIL)  read -r fkind fwho _ <<< "${rest}"
               if [[ -z "${fwho:-}" ]]; then problems+=("a FAIL expectation must name a kind and a culprit: '${rest}'")
               else grep -E "^FAIL ${fkind} " <<< "${CHECK_OUT}" | grep -qF "${fwho}" || problems+=("expected 'FAIL ${fkind}' naming ${fwho}"); fi ;;
        NOFAIL) ! grep -qE "^FAIL ${rest} " <<< "${CHECK_OUT}" || problems+=("expected no 'FAIL ${rest}'") ;;
        COUNT) grep '^COUNTS ' <<< "${CHECK_OUT}" | grep -qE "(^| )${rest}( |$)" || problems+=("expected COUNTS ${rest}") ;;
        *)     problems+=("unknown expectation '${kind}'") ;;
      esac
    done < <(grep '^## expect ' <<< "${B}")
    grep -q '^## expect ' <<< "${B}" || problems+=("no expectation: a control that expects nothing tests nothing")
    # Two-sided: every failure the plant raised must be one the control predicts. A plant that also fires
    # something unforeseen may be firing for a reason nobody stated.
    while read -r fkind; do
      grep -qxE "## expect FAIL ${fkind} .*" <<< "${B}" || problems+=("an unforeseen 'FAIL ${fkind}'")
    done < <(grep '^FAIL ' <<< "${CHECK_OUT}" | awk '{ print $2 }' | sort -u || true)

    # The digest's reading of CLAUDE.md § Trust ledger, against a one-section copy whose sentence is built from
    # this control's own counts — so the expected text is about the reading, never about today's numbers.
    printf '%s\n' "${raw}" > "${WORK}/${name}.out"
    while read -r _ _ variant dexit dtext; do
      cnt() { sed -n "s/.* $1=\([0-9]*\).*/\1/p" <<< " $(grep '^COUNTS ' <<< "${CHECK_OUT}" || true)"; }
      c="$(cnt clean)"; p="$(cnt purchased)"; i="$(cnt imported)"
      new="current audit reads ${c} clean and ${p} declared purchases, and ${i} imported (and so on)."
      case "${variant}" in
        new)     sentence="${new}" ;;
        off)     sentence="current audit reads ${c} clean and ${p} declared purchases, and $((i + 1)) imported." ;;
        old)     sentence="current audit reads ${c} clean and ${p} declared purchases (and so on)." ;;
        doubled) sentence="${new} ${new}" ;;
        *)       problems+=("unknown digest variant '${variant}'"); continue ;;
      esac
      printf '# planted\n\n## Trust ledger\n\nThe %s\n' "${sentence}" > "${WORK}/${name}.CLAUDE.md"
      dstatus=0
      dout="$(python3 "${REPO}/scripts/gate_report.py" axioms "${WORK}/${name}.out" '' "${WORK}/${name}.CLAUDE.md" 2>&1)" || dstatus=$?
      { echo "######## digest ${name} ${variant} (exit ${dstatus})"; echo "${dout}"; } >> "${GATE_LOG}"
      if [[ "${dstatus}" != "${dexit}" ]] || ! grep -qF "${dtext}" <<< "${dout}"; then
        problems+=("digest '${variant}': expected exit ${dexit} and '${dtext}', got exit ${dstatus}")
      else
        digests+=("digest ${variant}: exit ${dstatus}, '${dtext}'")
      fi
    done < <(grep '^## digest ' <<< "${B}" || true)

    if [[ "${#problems[@]}" -eq 0 ]]; then
      echo "    ok    ${name} — ${verdict}"
      for d in "${digests[@]}"; do echo "            ${d}"; done
      grep -E '^FAIL ' <<< "${CHECK_OUT}" | cut -c1-200 | sed 's/^/            /' || true
      [[ "${status}" -ne 0 ]] && grep -m1 -E 'error' <<< "${raw}" | cut -c1-200 | sed 's/^/            /' || true
    else
      echo "    FAIL  ${name} — ${verdict}; ${problems[*]}"
      { grep -E '^(FAIL|COUNTS) ' <<< "${CHECK_OUT}" || true; [[ "${status}" -ne 0 ]] && grep -m3 -E 'error' <<< "${raw}" || true; } \
        | cut -c1-200 | sed 's/^/            got: /'
      fails=$((fails + 1))
    fi
  done

  gate_log_complete
  if [[ "${fails}" -gt 0 ]]; then
    echo "==> axioms self-test: FAIL — ${fails} of ${#NAMES[@]} control(s) did not behave as designed."
    echo "    The gate cannot be trusted until every one of these behaves. Never tune a control until it agrees."
    echo "    every control's output: ${GATE_LOG#"${REPO}"/}"
    exit 1
  fi
  echo "==> axioms self-test: OK — every planted fault fired, and every partner passed."
  echo "    every control's output: ${GATE_LOG#"${REPO}"/}"
  exit 0
fi

gate_log_open axioms

# Capture the status explicitly. Under `set -e` a failing command substitution aborts the script
# with no output at all, so an audit file that stops elaborating — a declaration renamed or removed
# without updating it, which is exactly what this gate exists to catch — would look like a silent
# pass to anyone who piped the output. Found the hard way at M04.
if ! RAW="$(cd "${REPO}" && lake env lean scripts/Axioms.lean 2>&1)"; then
  printf '%s\n' "${RAW}" > "${GATE_LOG}"
  echo "${RAW}"
  echo "==> axioms: FAIL — scripts/Axioms.lean did not elaborate (above)."
  echo "    A missing constant here means the audit is no longer auditing what it names."
  exit 1
fi
printf '%s\n' "${RAW}" > "${GATE_LOG}"

NORM="$(normalize <<< "${RAW}")"

# Here-strings, not pipes: under `pipefail` a `grep -q` that exits on its first match
# SIGPIPEs the `echo` once the text outgrows the 64 KB pipe buffer, and the check
# reports "banners missing" on output that carries both banners. Found the hard way
# when the M26 audit lines pushed the receipt past 64 KB.
for b in CLEAN PURCHASED IMPORTED; do
  if ! grep -q "^=== ${b} ===\$" <<< "${NORM}"; then
    echo "==> axioms: FAIL — the ${b} banner is missing; scripts/Axioms.lean did not run to completion"
    echo "    full output: ${GATE_LOG#"${REPO}"/}"
    exit 1
  fi
done

# The output is whole, so this run becomes the one the next run is compared with, and the digest is
# printed from the saved file. The checks below still decide pass or fail; the digest only reports.
PREV="${GATE_PREV}"
gate_log_complete
# Its exit status says which failure it is: 2, the audit's output is not the shape the digest reads; 3, the
# digest is complete but the recorded count could not be read, so the comparison did not run (J32).
DIGEST=0
python3 "${REPO}/scripts/gate_report.py" axioms "${GATE_LOG}" "${PREV}" "${REPO}/CLAUDE.md" || DIGEST=$?
if [[ "${DIGEST}" -eq 3 ]]; then
  echo "==> axioms: FAIL — the recorded count in CLAUDE.md § Trust ledger could not be read (above), so the"
  echo "    comparison did not run. The audit itself is fine and its digest above is complete; the section must"
  echo "    hold the sentence 'current audit reads N clean and M declared purchases, and I imported' exactly once"
  echo "    (or, before any import is declared, the older 'current audit reads N clean and M declared purchases')."
  echo "    full output: ${GATE_LOG#"${REPO}"/}"
  exit 1
elif [[ "${DIGEST}" -ne 0 ]]; then
  echo "==> axioms: FAIL — no digest could be built from this run's output (above); it is saved at"
  echo "    ${GATE_LOG#"${REPO}"/}"
  exit 1
fi

check_receipt "${NORM}" "${REPO}/ARCHITECTURE.md"

# A leftover `sorry` anywhere in the receipt, record or not — the check above judges records; this keeps the
# older, wider net.
if grep -nE 'sorryAx' <<< "${NORM}"; then
  echo "==> FAIL: sorryAx on the audited surface (above)"
  CHECK_BAD=1
fi

grep -E '^(FAIL |     )' <<< "${CHECK_OUT}" | sed 's/^/    /' || true
if [[ "${CHECK_BAD}" -ne 0 ]]; then
  echo "==> axioms: FAIL — $(grep -c '^FAIL ' <<< "${CHECK_OUT}" || true) check(s) failed (above)"
  echo "    full output: ${GATE_LOG#"${REPO}"/}"
  exit 1
fi

if ! COUNTS="$(grep '^COUNTS ' <<< "${CHECK_OUT}")"; then
  echo "==> axioms: FAIL — the check printed no COUNTS line, so it did not run to its end"
  exit 1
fi
count() { sed -n "s/.* $1=\([0-9]*\).*/\1/p" <<< " ${COUNTS}"; }
echo "    purchase ledgers agree — the docstrings warn of exactly the purchases the audit finds ($(sed -n 's/^LEDGERS //p' <<< "${CHECK_OUT}"))"
echo "    declared imports: $(count declared); library axioms other than native auxiliaries: $(count library), every one declared;" \
  "native auxiliaries: $(count native)"
echo "==> axioms: OK — $(count clean) clean, $(count free) axiom-free, $(count imported) imported, $(count purchased) declared purchase(s)"
echo "    full output: ${GATE_LOG#"${REPO}"/}"
