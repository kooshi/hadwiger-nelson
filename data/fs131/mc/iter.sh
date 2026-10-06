#!/usr/bin/env bash
# FS131-MC1: elaborate one module against the built library (iteration only, never evidence). usage: data/fs131/mc/iter.sh <file.lean>
cd "$(dirname "$0")/../../.."
/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 2 -- lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$1" 2>&1 | grep -v "^slot:"
