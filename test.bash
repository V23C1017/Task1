#!/bin/bash -xv
# SPDX-FileCopyrightText: 2026 YUkifumi Itohiya
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "${1}行目が違うよ"
    res=1
}

res=0

### 正常系テスト1: デフォルト実行（エラーが出ないこと・見出しが含まれること） ###
out=$(./access100)
[ "$?" = 0 ] || ng "$LINENO"
echo "$out" | grep -q "=== 最近アクセスされたファイル ===" || ng "$LINENO"

### 正常系テスト2: 件数(2件)と対象ディレクトリ(.)を指定して実行 ###
out=$(./access100 2 .)
[ "$?" = 0 ] || ng "$LINENO"
# 見出し1行 + 最大2行 = 最大3行以下であることを確認
lines=$(echo "$out" | wc -l)
[ "$lines" -le 3 ] || ng "$LINENO"

### 異常系テスト: 数字以外の引数を渡したときにエラー終了(0以外)すること ###
out=$(./access100 abc 2>/dev/null)
[ "$?" != 0 ] || ng "$LINENO"

[ "$res" = 0 ] && echo "OK"
exit $res
