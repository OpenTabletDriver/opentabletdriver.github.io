#!/bin/bash

TESTSDIR="tests"

cd "$(dirname "${BASH_SOURCE[0]}")"

declare -A testParams # [testName]=>"testArgs"

testParams["check-site-paths"]="${PWD} ${PWD}/_site"

for testName in "$TESTSDIR"/*; do
  name="$(basename "$testName")"
  testExecutable="$testName"/"$name".sh

  if [ ! -f $testExecutable ]; then
    echo $testExecutable
    echo "Invalid test '$testName', passing..."
    continue
  fi

  if [ ! -z "${testParams[$name]}" ]; then
    ARGS="${testParams[$name]}"
  else
    ARGS=""
  fi

  unset ERROR

  echo "Running $testName:"

  $testExecutable $ARGS || ERROR=$?

  if [ ! -z "$ERROR" ]; then
    echo "$testName FAIL, return value: $ERROR"
  else
    echo "$testName PASS"
  fi
done

if [ -z "$ERROR" ]; then
  echo "All tests passed!"
  exit 0
else
  echo "At least 1 test didn't pass"
  exit 1
fi
