#!/usr/bin/env bash
#
# profile_zshrc.sh
# Copyright (C) 2016 KuoE0 <kuoe0.tw@gmail.com>
#
# Distributed under terms of the MIT license.
#
SED_COMMAND=sed
if [ "$(uname)" = "Darwin" ]; then
	SED_COMMAND=gsed
fi

TOTAL=0
ITERATION=10

for t in $(seq $ITERATION); do
	EXEC_TIME=$(/usr/bin/time -p zsh -i -c exit 2>&1 | \
				grep real | \
				$SED_COMMAND -e 's/real[[:space:]]\+//')
	echo "Test $t: $EXEC_TIME sec"
	TOTAL=$(echo "$TOTAL + $EXEC_TIME" | bc)
done

AVERAGE=$(echo "$TOTAL / $ITERATION" | \
          bc -l | \
          awk '{printf("%.2f", $1 + 0.005)}')
echo "Average: $(echo "$TOTAL / $ITERATION" | bc -l | awk '{printf("%.2f", $1 + 0.005)}') sec"
