#!/usr/bin/env bash
# EXT-OAI1 stage 3: every construct in the cone that a kernel would not check, by text.
# usage: conegrep.sh <lean-root> <file-list>      (file-list: paths relative to lean-root, one per line)
# Uses rg (PCRE2 with -P); never grep -E (CLAUDE.md § Searching).  Prints, per pattern, the hits with file:line, and a count.
set -u
ROOT="$1"; LIST="$2"
mapfile -t FILES < <(sed "s|^|$ROOT/|" "$LIST")
echo "files=${#FILES[@]}  lines=$(cat "${FILES[@]}" | wc -l)"
pat() { # name, regex
  local name="$1" re="$2" out n
  out=$(rg -n -P --no-heading "$re" "${FILES[@]}" 2>&1); n=$(printf '%s' "$out" | grep -c . )
  echo "== $name  /$re/  hits=$n"
  [ "$n" -gt 0 ] && printf '%s\n' "$out" | sed "s|$ROOT/||" | cut -c1-220
  return 0
}
pat "axiom declaration"            '^\s*(?:@\[[^\]]*\]\s*)*(?:private\s+|protected\s+|noncomputable\s+|unsafe\s+)*axiom\b'
pat "the word axiom anywhere"      '\baxiom\b'
pat "sorry"                        '\bsorry\b'
pat "admit"                        '\badmit\b'
pat "sorryAx"                      'sorryAx'
pat "native_decide"                'native_decide'
pat "decide +native / +kernel"     'decide\s*\+\s*(native|kernel)|decide\s*\(\s*config'
pat "bv_decide / ofReduceBool / reduceBool / trustCompiler" 'bv_decide|ofReduceBool|reduceBool|ofReduceNat|reduceNat|trustCompiler'
pat "implemented_by"               'implemented_by'
pat "extern"                       '\bextern\b'
pat "csimp"                        '\bcsimp\b'
pat "unsafe"                       '\bunsafe\b'
pat "opaque"                       '\bopaque\b'
pat "partial"                      '^\s*(?:private\s+|protected\s+)*partial\b'
pat "set_option (any)"             'set_option'
pat "debug.skipKernelTC / bootstrap" 'skipKernelTC|bootstrap\.|debug\.'
pat "meta: elab/macro/syntax/notation/run_cmd/run_elab/run_meta/initialize/#eval/#exit/elab_rules/macro_rules" '^\s*(?:local\s+|scoped\s+)?(?:elab|macro|syntax|notation|infix[lr]?|prefix|postfix|run_cmd|run_elab|run_meta|initialize|builtin_initialize|elab_rules|macro_rules|declare_syntax_cat)\b|#eval|#exit|#print|#check|#reduce'
pat "open Lean / import Lean / Lean.Elab / Lean.Meta / addDecl" '\bopen\s+Lean\b|import\s+Lean\b|Lean\.Elab|Lean\.Meta|addDecl|addAndCompile|Environment'
pat "attribute commands"           '^\s*(?:local\s+|scoped\s+)?attribute\s*\['
pat "local/scoped instance, instance priority" '^\s*(?:local|scoped)\s+instance\b|instance\s*\(priority'
pat "#exit / end-of-input tricks: 'stop' tactic" '^\s*stop\b|\bstop$'
pat "include/omit"                 '^\s*(include|omit)\b'
pat "universe-polymorphic hypotheses: variable lines" '^\s*variable\b'
pat "theorem/lemma count"          '^\s*(?:@\[[^\]]*\]\s*)*(?:private\s+|protected\s+|noncomputable\s+)*(?:theorem|lemma)\b'
pat "def/abbrev/structure/class/inductive/instance count" '^\s*(?:@\[[^\]]*\]\s*)*(?:private\s+|protected\s+|noncomputable\s+)*(?:def|abbrev|structure|class|inductive|instance)\b'
