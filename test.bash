#!/bin/bash -xv
# SPDX-FileCopyrightText: 2026 Yukifumi Itohiya
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "${1}行目が違うよ"
    res=1
}

res=0


out=$(./access100)
[ "$?" = 0 ] || ng "$LINENO"


out=$(./access100 2 .)
[ "$?" = 0 ] || ng "$LINENO"
lines=$(echo "$out" | wc -l)
[ "$lines" -le 2 ] || ng "$LINENO"


out=$(./access100 abc 2>/dev/null)
[ "$?" != 0 ] || ng "$LINENO"


out=$(./access100 5 /not_exist_dir_xyz 2>/dev/null)
[ "$?" != 0 ] || ng "$LINENO"

[ "$res" = 0 ] && echo "OK"
exit $res
