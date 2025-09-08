#!/bin/bash
# example:
# sudo -u nobody bash fix_name.sh <dir>

dir="$1"
num=8
padding_char="0000"

if [ x"$dir" = "x" ]; then
    echo "fix_name.sh <dir>"
    exit 0
fi

# 补齐并填充0
for fn in `ls $dir`; do
    p_fn="$padding_char$fn"
    new_fn=${p_fn: -$num}
    echo "rename: $fn => $new_fn"
    mv $fn $new_fn
done
