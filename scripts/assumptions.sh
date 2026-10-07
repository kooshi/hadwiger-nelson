#!/usr/bin/env bash
# The assumptions gate — what the library rests on that the kernel did not check, in both forms it takes.
#
# `scripts/Assumptions.lean` scans the built library and prints one row per fact: every `axiom` of the
# library with the theorems whose stored axiom lists hold it; every declared hypothesis — a named `Prop`
# definition, or a proposition written out in one binder — with its kind (outside, ours, open), its source
# and the theorems whose statements take it; every closed hypothesis, classified; and a `FAIL` row for each
# thing it can decide and finds undeclared. This script turns that into a pass or a fail:
#
#   * every `FAIL` row of the scan fails the gate (the kinds are listed in the scan's header);
#   * every source must **resolve** in the records: a bibliography key in `BIBLIOGRAPHY.md` (a `**[Key]**`
#     row, or an alias in § A′), a ledger row in `LEDGER.md`, a grokking in the grokkings file, a stub in
#     `plans/FRONTIER-STUBS.md`, a derivation entry id in `LEDGER.md`, `plans/LEAN-BACKLOG.md` or a
#     `plans/*derivation*.md` (`unresolved-source`);
#   * the consumers must be the **ledger's**, exactly: `scripts/assumptions-ledger.txt` holds one row per
#     (assumption, theorem). A theorem the scan finds and the ledger lacks fails (`unlisted-consumer`); a row
#     the scan no longer finds fails (`stale-consumer`). Which theorems are conditional, and on what, is then a
#     reviewed line in a diff at every landing;
#   * the accounting must add up: one `=== SCANNED ===` and one `=== TOTALS ===` line, no declaration left
#     untelescoped, every count equal to its rows. A scan that did not reach its end is a failure, never an
#     empty result.
#
# WHAT IT CANNOT SEE, said on every run with its count (`unseen=`): a hand result or an outside theorem
# written out as a hypothesis over the theorem's own variables, in a theorem none of whose hypotheses is
# declared and whose docstring does not say so. No type separates it from a condition on the theorem's
# parameters. The other hypotheses of every theorem that does take a declared assumption are printed in full
# (`COHYP`), which is where such a one most often sits.
#
#   ./scripts/assumptions.sh                 the gate
#   ./scripts/assumptions.sh --self-test     plant each fault the gate exists to catch, in one copy of the
#                                            audit, and watch each fire (scripts/assumptions-controls.txt)
#   ./scripts/assumptions.sh --write-ledger  rewrite the ledger from this run, if nothing else fails, and
#                                            print every row added or removed
#
# The records it reads can be pointed elsewhere, for a control or a draft, and the output then says so:
# ASSUMPTIONS_BIB, ASSUMPTIONS_LEDGER_MD, ASSUMPTIONS_GROKKINGS, ASSUMPTIONS_STUBS, ASSUMPTIONS_CLAUDE,
# ASSUMPTIONS_ENTRY_EXTRA (one more file searched for entry ids), ASSUMPTIONS_AUDIT (the audit file itself: the
# mutation harness, tools/fs131_t5_mutate.py, runs mutated copies and never edits the shipped one),
# ASSUMPTIONS_GATE_REPORT (the digest script: tools/fs131_lt5_digest_mutate.py does the same for its decisions).
#
# THE RECORDED COUNTS. The nine counts are recorded twice — in the ledger's header and in `CLAUDE.md` § Trust
# ledger — and the digest compares this run with both. A record that has drifted is flagged and does not fail (a
# landing moves the counts before the front page is refiled); a record that is ABSENT, partial or doubled fails:
# a recorded count whose deletion passes is no record (inventory item 562 (d)). The failure prints the counts to
# record.
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${REPO}"
source "${REPO}/scripts/dev-env.sh"
source "${REPO}/scripts/gate-log.sh"

AUDIT="${ASSUMPTIONS_AUDIT:-${REPO}/scripts/Assumptions.lean}"
LEDGER="${REPO}/scripts/assumptions-ledger.txt"
CONTROLS="${REPO}/scripts/assumptions-controls.txt"
BIB="${ASSUMPTIONS_BIB:-${REPO}/BIBLIOGRAPHY.md}"
LEDGER_MD="${ASSUMPTIONS_LEDGER_MD:-${REPO}/LEDGER.md}"
GROKKINGS="${ASSUMPTIONS_GROKKINGS:-${REPO}/.claude/skills/grokkings/SKILL.md}"
STUBS="${ASSUMPTIONS_STUBS:-${REPO}/plans/FRONTIER-STUBS.md}"
CLAUDE_MD="${ASSUMPTIONS_CLAUDE:-${REPO}/CLAUDE.md}"
ENTRY_EXTRA="${ASSUMPTIONS_ENTRY_EXTRA:-}"
GATE_REPORT="${ASSUMPTIONS_GATE_REPORT:-${REPO}/scripts/gate_report.py}"

RECORD_KEYS="axioms rests named inline outside ours open takes mentions"
kept() { echo "    full output: ${GATE_LOG#"${REPO}"/}"; }
total() { sed -n "s/.* $1=\([0-9]*\).*/\1/p" <<< " $2" | head -1; }

# resolves <class> <token> — does the reference exist in the records? Fixed strings wherever the token is
# ours to choose; awk for the two shapes that need a pattern (never `grep -E`: CLAUDE.md § Searching).
resolves() {
  local class="$1" tok="$2" f
  case "${class}" in
    bib)
      [[ -f "${BIB}" ]] || return 1
      grep -qF "**[${tok}]**" "${BIB}" && return 0
      awk '/^### A′\. Retired and alternate keys/ { f = 1; next } f && /^## / { f = 0 } f' "${BIB}" | grep -qF "[${tok}]" ;;
    row)
      [[ -f "${LEDGER_MD}" ]] || return 1
      awk -v n="${tok}" 'index($0, "| " n " |") == 1 { found = 1 } END { exit !found }' "${LEDGER_MD}" ;;
    grokking)
      [[ -f "${GROKKINGS}" ]] || return 1
      grep -qwF "G${tok}" "${GROKKINGS}" ;;
    stub)
      [[ -f "${STUBS}" ]] || return 1
      grep -qwF -- "${tok}" "${STUBS}" ;;
    entry)
      for f in "${LEDGER_MD}" "${REPO}/plans/LEAN-BACKLOG.md" "${REPO}"/plans/*derivation*.md ${ENTRY_EXTRA:+"${ENTRY_EXTRA}"}; do
        [[ -f "${f}" ]] && grep -qwF -- "${tok}" "${f}" && return 0
      done
      return 1 ;;
    *) return 1 ;;
  esac
}

# check_receipt <the scan's output> <ledger file>
# Sets CHECK_OUT (every `FAIL <kind> <culprit> :: …` line, the scan's and this script's, then one `COUNTS …`
# line) and CHECK_BAD. Every decision of the gate is here, so `--self-test` exercises exactly what the gate runs.
check_receipt() {
  local raw="$1" ledger="$2" out="" line id ref class tok n
  out="$(grep '^FAIL ' <<< "${raw}" || true)"
  add() { out+="${out:+$'\n'}$1"; }

  # the accounting
  local nscanned ntotals scanned totals
  nscanned="$(grep -c '^=== SCANNED === ' <<< "${raw}" || true)"
  ntotals="$(grep -c '^=== TOTALS === ' <<< "${raw}" || true)"
  scanned="$(grep '^=== SCANNED === ' <<< "${raw}" | head -1 || true)"
  totals="$(grep '^=== TOTALS === ' <<< "${raw}" | head -1 || true)"
  if [[ "${nscanned}" != 1 || "${ntotals}" != 1 ]]; then
    add "FAIL accounting scan :: '=== SCANNED ===' printed ${nscanned} time(s) and '=== TOTALS ===' ${ntotals}, not once each: the scan did not run to its end"
  else
    [[ "$(total untelescoped "${scanned}")" == 0 ]] || add "FAIL accounting scan :: $(total untelescoped "${scanned}") declaration(s) could not be telescoped and were not read"
    rows() { grep -c "$1" <<< "${raw}" || true; }
    local key pat
    while read -r key pat; do
      n="$(rows "${pat}")"
      [[ "$(total "${key}" "${totals}")" == "${n}" ]] || add "FAIL accounting scan :: TOTALS records ${key}=$(total "${key}" "${totals}") and ${n} such row(s) were printed"
    done <<'KEYS'
axioms ^AXIOM
rests ^RESTS
named ^ASSUMPTION .* form=named
inline ^ASSUMPTION .* form=inline
takes ^TAKES
mentions ^MENTIONS
conditions ^CONDITION
cohyp ^COHYP
fails ^FAIL
KEYS
  fi

  # every source resolves in the records
  while read -r line; do
    [[ -z "${line}" ]] && continue
    id="$(awk '{ print $2 }' <<< "${line}")"
    ref="$(sed -n 's/.* ref=\([^ ]*\).*/\1/p' <<< "${line}")"
    class="${ref%%:*}"; tok="${ref#*:}"
    [[ "${ref}" == NONE || "${ref}" == MISSING || -z "${ref}" ]] && continue   # the scan's own FAIL row covers it
    resolves "${class}" "${tok}" || add "FAIL unresolved-source ${id} :: its source ${ref} is not in the records (bib: a **[Key]** row of ${BIB#"${REPO}"/}; row: ${LEDGER_MD#"${REPO}"/}; grokking; stub; entry: LEDGER.md, plans/LEAN-BACKLOG.md, plans/*derivation*.md)"
  done < <(grep -E '^(AXIOM|ASSUMPTION) ' <<< "${raw}" || true)

  # the consumers are the ledger's, exactly
  if [[ ! -f "${ledger}" ]]; then
    add "FAIL ledger-missing ${ledger#"${REPO}"/} :: no ledger to compare the consumers with; write it with --write-ledger"
  else
    local found listed
    found="$(grep -E '^(RESTS|TAKES|MENTIONS) ' <<< "${raw}" | awk '{ print $1, $2, $3 }' | LC_ALL=C sort -u || true)"
    listed="$(grep -E '^(RESTS|TAKES|MENTIONS) ' "${ledger}" | awk '{ print $1, $2, $3 }' | LC_ALL=C sort -u || true)"
    while read -r line; do
      [[ -n "${line}" ]] && add "FAIL unlisted-consumer $(awk '{ print $3 }' <<< "${line}") :: the scan finds '${line}' and the ledger does not list it"
    done < <(LC_ALL=C comm -23 <(printf '%s\n' "${found}") <(printf '%s\n' "${listed}"))
    while read -r line; do
      [[ -n "${line}" ]] && add "FAIL stale-consumer $(awk '{ print $3 }' <<< "${line}") :: the ledger lists '${line}' and the scan does not find it"
    done < <(LC_ALL=C comm -13 <(printf '%s\n' "${found}") <(printf '%s\n' "${listed}"))
  fi

  if [[ -n "${totals}" ]]; then add "COUNTS ${totals#=== TOTALS === }"; fi
  CHECK_OUT="${out}"
  if grep -q '^FAIL ' <<< "${out}"; then CHECK_BAD=1; else CHECK_BAD=0; fi
}

# The ledger's text for a scan's output: a header with the recorded counts, then the rows, sorted.
ledger_text() {
  local raw="$1" totals key
  totals="$(grep '^=== TOTALS === ' <<< "${raw}" | head -1)"
  echo "# The assumptions ledger — every (assumption, theorem) pair the scan finds, compared exactly by"
  echo "# scripts/assumptions.sh: RESTS <axiom> <theorem> (the theorem's stored axiom list holds the axiom),"
  echo "# TAKES <assumption> <theorem> (its statement assumes it), MENTIONS <assumption> <theorem> (its statement"
  echo "# holds it at unknown polarity). An inline assumption is inline:<Label>. Rewritten only by"
  echo "#   ./scripts/assumptions.sh --write-ledger"
  echo "# which prints every row it adds or removes. The counts this ledger was written from:"
  printf '#  '
  for key in ${RECORD_KEYS}; do printf ' %s=%s' "${key}" "$(total "${key}" "${totals}")"; done
  printf '\n'
  grep -E '^(RESTS|TAKES|MENTIONS) ' <<< "${raw}" | awk '{ print $1, $2, $3 }' | LC_ALL=C sort -u
}

# ---------------------------------------------------------------------------------------------------------
# --self-test — plant each fault the gate exists to catch, and watch it fire.
#
# `RUNNING.md` § Make the gate fail, and watch it fail. Every control of `scripts/assumptions-controls.txt` is
# planted into ONE copy of the shipped audit — its declarations before the `planted` list, its entries in it —
# beside the shipped list, so the plants are read exactly as the library is; the copy is elaborated once and
# judged by `check_receipt` above against a control ledger (the shipped one plus the controls' rows) and control
# records (the real ones plus one planted bibliography key, ledger row, grokking, stub and entry id). Then:
# each control's expectations are read off the rows; **every `FAIL` row naming a planted name must be one some
# control predicts** (two-sided); a failure naming no planted name is the shipped list's own, which the gate
# reports and this does not judge; the accounting is broken on purpose in copies of the output; and the digest
# is read against one-section copies of `CLAUDE.md`. Planted names start `t5c_` (labels `T5c`).
# ---------------------------------------------------------------------------------------------------------
if [[ "${1:-}" == "--self-test" ]]; then
  gate_log_open assumptions-self-test
  WORK="$(mktemp -d)"
  trap 'rm -rf "${WORK}"' EXIT
  ANCHOR='def AssumptionAudit.planted : Array AssumptionAudit.Entry := #[]'
  n="$(grep -cxF "${ANCHOR}" "${AUDIT}" || true)"
  if [[ "${n}" != 1 ]]; then
    echo "==> assumptions self-test: FAIL — the anchor line occurs ${n} times in scripts/Assumptions.lean, not once"; exit 1
  fi
  mapfile -t NAMES < <(sed -n 's/^## control \([^ ]*\).*/\1/p' "${CONTROLS}")
  [[ "${#NAMES[@]}" -gt 0 ]] || { echo "==> assumptions self-test: FAIL — no controls read from ${CONTROLS#"${REPO}"/}"; exit 1; }
  section() { awk -v s="$1" '/^## (lean|entry)$/ { on = ($2 == s); next } /^## / { on = 0 } on' "${CONTROLS}"; }
  block() { awk -v c="$1" '/^## control / { on = ($3 == c); next } on' "${CONTROLS}"; }

  # the planted copy
  section lean > "${WORK}/planted.lean"
  { echo 'def AssumptionAudit.planted : Array AssumptionAudit.Entry := #['
    section entry | sed '/^[[:space:]]*$/d' | sed '$!s/$/,/'
    echo '  ]'; } > "${WORK}/planted.entries"
  SEG_L="${WORK}/planted.lean" SEG_E="${WORK}/planted.entries" ANCH="${ANCHOR}" awk '
    function put(f,   l) { while ((getline l < f) > 0) print l; close(f) }
    $0 == ENVIRON["ANCH"] { put(ENVIRON["SEG_L"]); put(ENVIRON["SEG_E"]); next }
    { print }' "${AUDIT}" > "${WORK}/Assumptions.lean"

  # the control ledger and the control records
  { [[ -f "${LEDGER}" ]] && cat "${LEDGER}"; sed -n 's/^## ledger //p' "${CONTROLS}"; } > "${WORK}/ledger.txt"
  { cat "${BIB}"; echo '| **[Planted2026]** | planted by `scripts/assumptions.sh --self-test` |'; } > "${WORK}/BIBLIOGRAPHY.md"
  { cat "${LEDGER_MD}"; echo '| 99999 | planted by `scripts/assumptions.sh --self-test` |'; } > "${WORK}/LEDGER.md"
  { cat "${GROKKINGS}"; echo 'G99999 planted by scripts/assumptions.sh --self-test'; } > "${WORK}/grokkings.md"
  { cat "${STUBS}"; echo 'FS-99999 planted by scripts/assumptions.sh --self-test'; } > "${WORK}/stubs.md"
  echo 'T5C-ENTRY-1 planted by scripts/assumptions.sh --self-test' > "${WORK}/entries.md"
  BIB="${WORK}/BIBLIOGRAPHY.md"; LEDGER_MD="${WORK}/LEDGER.md"; GROKKINGS="${WORK}/grokkings.md"
  STUBS="${WORK}/stubs.md"; ENTRY_EXTRA="${WORK}/entries.md"

  echo "==> assumptions self-test: ${#NAMES[@]} controls, planted together in one copy of scripts/Assumptions.lean"
  status=0
  RAW="$(lake env lean "${WORK}/Assumptions.lean" 2>&1)" || status=$?
  printf '%s\n' "${RAW}" > "${GATE_LOG}"
  if [[ -n "${ASSUMPTIONS_KEEP:-}" ]]; then
    mkdir -p "${ASSUMPTIONS_KEEP}"
    cp "${WORK}/Assumptions.lean" "${WORK}/ledger.txt" "${ASSUMPTIONS_KEEP}/"; cp "${GATE_LOG}" "${ASSUMPTIONS_KEEP}/control-run.out"
  fi
  if [[ "${status}" -ne 0 ]]; then
    grep -m5 -E 'error' <<< "${RAW}" | cut -c1-300
    echo "==> assumptions self-test: FAIL — the control run did not elaborate (above)."; kept; exit 1
  fi
  gate_log_complete
  check_receipt "${RAW}" "${WORK}/ledger.txt"
  grep -E '^=== (SCANNED|TOTALS) ===' <<< "${RAW}" | cut -c1-400 | sed 's/^/    control run: /'

  fails=0; ran=0
  ok() { echo "    ok    $1"; }
  bad() { echo "    FAIL  $1"; fails=$((fails + 1)); }
  # the culprit of a FAIL row is its third field; a site's culprit is `<theorem>:<binder>`
  failrows() { grep '^FAIL ' <<< "${CHECK_OUT}" || true; }
  for name in "${NAMES[@]}"; do
    B="$(block "${name}")"
    why="$(sed -n "s/^## control ${name} — //p" "${CONTROLS}")"
    problems=()
    grep -q '^## expect ' <<< "${B}" || problems+=("no expectation: a control that expects nothing tests nothing")
    while read -r _ _ kind rest; do
      case "${kind}" in
        FAIL)  read -r fkind fwho <<< "${rest}"
               failrows | awk -v k="${fkind}" -v w="${fwho}" '$2 == k && $3 == w { f = 1 } END { exit !f }' \
                 || problems+=("expected 'FAIL ${fkind} ${fwho}'") ;;
        CLEAN) failrows | awk -v w="${rest}" '$3 == w || index($3, w ":") == 1 { f = 1 } END { exit !f }' \
                 && problems+=("expected no FAIL naming ${rest}") ;;
        ROW)   grep -qF -- "${rest}" <<< "${RAW}" || problems+=("expected a row '${rest}'") ;;
        NOROW) grep -qF -- "${rest}" <<< "${RAW}" && problems+=("expected no row '${rest}'") ;;
        *)     problems+=("unknown expectation '${kind}'") ;;
      esac
    done < <(grep '^## expect ' <<< "${B}" || true)
    ran=$((ran + 1))
    if [[ "${#problems[@]}" -eq 0 ]]; then ok "${name} — ${why}"
    else
      bad "${name} — ${why}: $(IFS=';'; echo "${problems[*]}")"
      grep -F -- "t5c_" <<< "$(failrows)" | grep -F -- "$(sed -n 's/^## expect [A-Z]* \(.*\)/\1/p' <<< "${B}" | awk '{ print $NF }' | head -1)" | cut -c1-220 | sed 's/^/            got: /' || true
    fi
  done

  # two-sided: every failure that names a planted name is one some control predicts
  unforeseen=0
  while read -r _ fkind fwho rest; do
    [[ -z "${fkind:-}" ]] && continue
    case "${fwho} ${rest}" in *t5c_*|*T5c*) ;; *) continue ;; esac
    grep -qxF "## expect FAIL ${fkind} ${fwho}" "${CONTROLS}" || { echo "    FAIL  unforeseen: FAIL ${fkind} ${fwho} ${rest:0:160}"; unforeseen=$((unforeseen + 1)); }
  done < <(failrows)
  ran=$((ran + 1))
  if [[ "${unforeseen}" -eq 0 ]]; then ok "two-sided — every failure naming a planted name is one a control predicts"
  else fails=$((fails + 1)); fi
  own="$(failrows | grep -vcE 't5c_|T5c' || true)"
  echo "    (the shipped list's own failures in this run, judged by the gate and not here: ${own})"

  # the accounting, broken on purpose in copies of the output
  acct() {  # acct <label> <mutated output> <text the FAIL must carry>
    local keep_out="${CHECK_OUT}" keep_bad="${CHECK_BAD}"
    check_receipt "$2" "${WORK}/ledger.txt"
    ran=$((ran + 1))
    if grep '^FAIL accounting ' <<< "${CHECK_OUT}" | grep -qF -- "$3"; then ok "accounting: $1 — FAIL accounting, '$3'"
    else bad "accounting: $1 — expected 'FAIL accounting' with '$3'"; fi
    CHECK_OUT="${keep_out}"; CHECK_BAD="${keep_bad}"
  }
  acct "the TOTALS line dropped (a scan that died before its end)" "$(grep -v '^=== TOTALS === ' <<< "${RAW}")" "did not run to its end"
  acct "one TAKES row dropped (rows that disagree with the totals)" "$(awk '!d && /^TAKES / { d = 1; next } { print }' <<< "${RAW}")" "TOTALS records takes="
  acct "an untelescoped declaration" "$(sed 's/^\(=== SCANNED === .*\)untelescoped=0/\1untelescoped=1/' <<< "${RAW}")" "could not be telescoped"
  keep_out="${CHECK_OUT}"; keep_bad="${CHECK_BAD}"
  check_receipt "${RAW}" "${WORK}/no-such-ledger.txt"
  ran=$((ran + 1))
  if grep -q '^FAIL ledger-missing ' <<< "${CHECK_OUT}"; then ok "ledger: a missing ledger fails (FAIL ledger-missing), never a free pass"
  else bad "ledger: a missing ledger did not fail"; fi
  CHECK_OUT="${keep_out}"; CHECK_BAD="${keep_bad}"

  # the digest's reading of the recorded counts, against one-section copies whose sentence is built from this run
  COUNTS="$(grep '^COUNTS ' <<< "${CHECK_OUT}")"
  sentence=""; for key in ${RECORD_KEYS}; do sentence+=" ${key}=$(total "${key}" "${COUNTS}")"; done
  first="$(total axioms "${COUNTS}")"
  digest() {  # digest <variant> <the section's sentence> <expected exit> <expected text>
    printf '# planted\n\n## Trust ledger\n\n%s\n' "$2" > "${WORK}/CLAUDE-$1.md"
    local dstatus=0 dout
    dout="$(python3 "${GATE_REPORT}" assumptions "${GATE_LOG}" '' "${WORK}/ledger-digest.txt" "${WORK}/CLAUDE-$1.md" 2>&1)" || dstatus=$?
    { echo "######## digest $1 (exit ${dstatus})"; echo "${dout}"; } >> "${GATE_LOG}.digests"
    ran=$((ran + 1))
    if [[ "${dstatus}" == "$3" ]] && grep -qF -- "$4" <<< "${dout}"; then ok "digest $1 — exit ${dstatus}, '$4'"
    else bad "digest $1 — expected exit $3 and '$4', got exit ${dstatus}"; fi
  }
  ledger_text "${RAW}" > "${WORK}/ledger-digest.txt"
  digest match "The assumptions scan reads \`${sentence# }\`." 0 "match (9 of 9 compared)"
  digest stale "The assumptions scan reads \`${sentence/ axioms=${first}/ axioms=$((first + 1))}\`." 0 "RECORDED COUNTS ARE STALE"
  # absence fails, and says what to add: the partner is `match` above — the same section with the sentence in it
  digest absent "The audit reads other things." 3 "RECORDED COUNTS ABSENT"
  digest absent-says-what-to-add "The audit reads other things." 3 "Add the sentence that holds them: \`${sentence# }\`"
  digest partial "The assumptions scan reads \`axioms=${first} rests=0\`." 3 "could not read the counts"
  digest doubled "The assumptions scan reads \`${sentence# }\`, and again \`${sentence# }\`." 3 "recorded more than once"
  sed -i 's/ takes=[0-9]*/ takes=0/' "${WORK}/ledger-digest.txt"
  digest ledger-header "The assumptions scan reads \`${sentence# }\`." 0 "RECORDED COUNTS ARE STALE in"

  if [[ "${fails}" -gt 0 ]]; then
    echo "==> assumptions self-test: FAIL — ${fails} of ${ran} check(s) did not behave as designed."
    echo "    The gate cannot be trusted until every one of these behaves. Never tune a control until it agrees."
    kept; exit 1
  fi
  echo "==> assumptions self-test: OK — all ${ran} checks behaved: every planted fault fired, and every partner stayed silent."
  kept; exit 0
fi

gate_log_open assumptions
if ! RAW="$(lake env lean "${AUDIT}" 2>&1)"; then
  printf '%s\n' "${RAW}" > "${GATE_LOG}"
  echo "${RAW}" | cut -c1-400
  echo "==> assumptions: FAIL — scripts/Assumptions.lean did not elaborate (above)."
  echo "    A missing constant here means the list names something the library no longer holds."
  exit 1
fi
printf '%s\n' "${RAW}" > "${GATE_LOG}"
PREV="${GATE_PREV}"
gate_log_complete

for pair in "scripts/Assumptions.lean:${AUDIT}" "BIBLIOGRAPHY.md:${BIB}" "LEDGER.md:${LEDGER_MD}" "CLAUDE.md:${CLAUDE_MD}" "scripts/gate_report.py:${GATE_REPORT}"; do
  [[ "${pair#*:}" == "${REPO}/${pair%%:*}" ]] || echo "    NOTE: ${pair%%:*} is read from ${pair#*:}, not from the repository's own file"
done

# The digest: its exit status says which failure it is (read here directly, never through a pipe): 2, the
# scan's output is not the shape the digest reads; 3, a recorded count is absent or could not be read.
python3 "${GATE_REPORT}" assumptions "${GATE_LOG}" "${PREV}" "${LEDGER}" "${CLAUDE_MD}"
DIGEST=$?
if [[ "${DIGEST}" -eq 3 ]]; then
  echo "==> assumptions: FAIL — a recorded count is absent or could not be read (above), so the comparison with it did not run."
  kept; exit 1
elif [[ "${DIGEST}" -ne 0 ]]; then
  echo "==> assumptions: FAIL — no digest could be built from this run's output (above)."
  kept; exit 1
fi

check_receipt "${RAW}" "${LEDGER}"
COUNTS="$(grep '^COUNTS ' <<< "${CHECK_OUT}" || true)"

if [[ "${1:-}" == "--write-ledger" ]]; then
  OTHER="$(grep '^FAIL ' <<< "${CHECK_OUT}" | grep -vE '^FAIL (unlisted-consumer|stale-consumer|ledger-missing) ' || true)"
  if [[ -n "${OTHER}" ]]; then
    echo "==> assumptions: FAIL — --write-ledger refused: this run fails for a reason a ledger cannot record:"
    sed 's/^/      /' <<< "${OTHER}"
    kept; exit 1
  fi
  NEW="$(ledger_text "${RAW}")"
  OLD=""; [[ -f "${LEDGER}" ]] && OLD="$(cat "${LEDGER}")"
  echo "    --- rows the ledger gains (+) and loses (-) ---"
  diff <(grep -vE '^#' <<< "${OLD}" || true) <(grep -vE '^#' <<< "${NEW}") | sed -n 's/^> /    + /p; s/^< /    - /p'
  printf '%s\n' "${NEW}" > "${LEDGER}"
  echo "==> assumptions: ledger written ($(grep -cvE '^#' "${LEDGER}") rows) — read the rows above; a row is a theorem that is conditional."
  kept; exit 0
fi

echo "    --- what this check cannot see, said every run ---"
echo "    A hand result or an outside theorem written out as a hypothesis over the theorem's own variables, in a"
echo "    theorem none of whose hypotheses is declared and whose docstring does not say so, is not told from a"
echo "    condition on the theorem's parameters. Hypotheses of that shape read and not decided: unseen=$(total unseen "${COUNTS}");"
echo "    beside declared assumptions (printed in full, COHYP rows): cohyp=$(total cohyp "${COUNTS}"); theorems whose docstrings use the"
echo "    words and take nothing declared (HINT rows): hints=$(total hints "${COUNTS}")."

if [[ "${CHECK_BAD}" -ne 0 ]]; then
  grep '^FAIL ' <<< "${CHECK_OUT}" | sed 's/^/    /'
  echo "==> assumptions: FAIL — $(grep -c '^FAIL ' <<< "${CHECK_OUT}" || true) check(s) failed (above)"
  kept; exit 1
fi
if [[ -z "${COUNTS}" ]]; then
  echo "==> assumptions: FAIL — the check printed no COUNTS line, so it did not run to its end"; kept; exit 1
fi
echo "==> assumptions: OK — $(total axioms "${COUNTS}") outside theorem(s) as axioms, with $(total rests "${COUNTS}") theorem(s) resting on them;" \
  "$(total named "${COUNTS}") named and $(total inline "${COUNTS}") inline hypotheses ($(total outside "${COUNTS}") outside, $(total ours "${COUNTS}") ours, $(total open "${COUNTS}") open)," \
  "taken by $(total takes "${COUNTS}") statement(s) and mentioned by $(total mentions "${COUNTS}")"
kept
