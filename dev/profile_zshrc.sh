#!/usr/bin/env bash
#
# profile_zshrc.sh
# Copyright (C) 2016 KuoE0 <kuoe0.tw@gmail.com>
#
# Distributed under terms of the MIT license.
#

ITERATION=${1:-10}

SED_COMMAND=sed
if [ "$(uname)" = "Darwin" ]; then
	SED_COMMAND=gsed
fi

TOTAL_TIME=0
for t in $(seq $ITERATION); do
	EXEC_TIME=$(/usr/bin/time -p zsh -i -c exit 2>&1 | grep real | grep -o -e '[[:digit:]]\+\.[[:digit:]]\+')
	echo "Test $t: $EXEC_TIME sec"
	TOTAL_TIME=$(echo "$TOTAL_TIME + $EXEC_TIME" | bc -l)
done

AVERAGE_TIME=$(echo "$TOTAL_TIME / $ITERATION" | bc -l | awk '{printf("%.2f", $1 + 0.005)}')
echo "Average: $AVERAGE_TIME sec"
