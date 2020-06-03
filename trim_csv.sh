#!/bin/bash

set -e

WORKING_DIR=$1

cd $WORKING_DIR

# garbageの箇所（先頭10行、末尾4行）を削除
for file in ./App_Annie_*.csv; do
  echo "triming...: $file"
  sed '1,10d' $file > $file;
  ghead -q -n -4 $file > $file;
done

echo 'done'
