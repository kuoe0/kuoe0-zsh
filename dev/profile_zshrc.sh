#!/usr/bin/env bash
#
# profile_zshrc.sh
# Copyright (C) 2016 KuoE0 <kuoe0.tw@gmail.com>
#
# Distributed under terms of the MIT license.
#
TOTAL=0
ITERATION=10
for t in $(seq $ITERATION); do
	EXEC_TIME=$(/usr/bin/time -p zsh -i -c exit 2>&1 | head -n1 | gsed -e 's/.*real[[:space:]]\+//')
	echo "Test $t: $EXEC_TIME sec"
	TOTAL=$(echo "$TOTAL + $EXEC_TIME" | bc)
done
echo "Average: $(echo "$TOTAL / $ITERATION" | bc -l | awk '{printf("%.2f", $1 + 0.005)}') sec"
