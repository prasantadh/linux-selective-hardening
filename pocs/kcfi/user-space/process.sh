#!/bin/bash

echo "after 17179869192 calls to a CFI protected function"
echo
echo level $'\t\t'min$'\t\t'max$'\t\t'mean$'\t\t'median
echo ===== $'\t\t'===$'\t\t'===$'\t\t'====$'\t\t'======
echo -n none$'\t\t'
grep -i none results.txt | cut -d ' ' -f 2 | datamash min 1 max 1 mean 1 median 1
echo -n selective$'\t'
grep -i selective results.txt | cut -d ' ' -f 2 | datamash min 1 max 1 mean 1 median 1
echo -n full$'\t\t'
grep -i full results.txt | cut -d ' ' -f 2 | datamash min 1 max 1 mean 1 median 1

echo
echo "On average we see about no overhead with selective CFI"
echo "while we see about 16% overhead with full CFI"
