#=============================================================================
#     FileName: function.zsh
#         Desc: function definition
#       Author: KuoE0
#        Email: kuoe0.tw@gmail.com
#     HomePage: http://kuoe0.ch/
#=============================================================================


cpu_load() {
	echo $@ $(uptime | awk -F'load average:' '{ print $2 }' | sed "s/ //g" | cut -d"," -f1)
}

user_numbers() {
	echo $@ $(who | cut -d" " -f1 | sort | uniq | wc -l)
}

ssh_clinet_ip() {
	if [ "${SSH_CLIENT:-x}" != x ]; then
		echo $@ $SSH_CLIENT | cut -d" " -f1 | tr -d '\n'
	fi
}

host_ip() {
	echo $@ $(curl -s http://ifconfig.me)
}

mac_memory() {

	FREE_MEM=`vm_stat| grep free | awk '{ print $3 }' | sed 's/\.//'`
	SPECULATIVE_MEM=`vm_stat| grep speculative | awk '{ print $3 }' | sed 's/\.//'`
	WIRED_MEM=`vm_stat| grep wired | awk '{ print $4 }' | sed 's/\.//'`
	ACTIVE_MEM=`vm_stat| grep -v inactive | grep active | awk '{ print $3 }' | sed 's/\.//'`
	INACITVE_MEM=`vm_stat| grep inactive | awk '{ print $3 }' | sed 's/\.//'`

	# page size of 4096 bytes
	# for gigabyte (GB)
	FREE=$((($FREE_MEM + $SPECULATIVE_MEM) * 4.0 / (1024 * 1024)))
	WIRED=$(($WIRED_MEM * 4.0 / (1024 * 1024)))
	ACTIVE=$(($ACTIVE_MEM * 4.0 / (1024 * 1024)))
	INACITVE=$(($INACITVE_MEM * 4.0 / (1024 * 1024)))

	# format output
	if [ "$1" = "-f" ]; then
		printf "\x1b[0;32mFree:     %.2lf GB\x1b[m\n" $FREE
		printf "\x1b[0;31mWired:    %.2lf GB\x1b[m\n" $WIRED
		printf "\x1b[0;33mActive:   %.2lf GB\x1b[m\n" $ACTIVE
		printf "\x1b[0;34mInactive: %.2lf GB\x1b[m\n" $INACITVE
	else
		printf "%.2lf,%.2lf,%.2lf,%.2lf" $FREE $WIRED $ACTIVE $INACITVE
	fi
}

memory_usage() {

	if [ "$OS" = "Darwin" ]; then
		MEM_STAT=$(mac_memory)
		TOTAL=$(echo $mem_stat | awk -F',' '{for (i=1; i <= NF; ++i) sum+=$i; print sum}')
		USED=$(($TOTAL - $(echo $mem_stat | cut -d',' -f1)))
		RET=$(printf "%.0f" $(echo $(($USED / $TOTAL * 100))))
		if [ "$1" = "-f" ]; then
			echo "Memory Usage: $RET %"
		else
			echo -n $RET
		fi
	fi

}

################################################################################
# utilities
################################################################################

# colourifide cat
ccat() {
	if which source-highlight-esc.sh &> /dev/null; then
		source-highlight-esc.sh $1
	else
		echo "\x1b[31mcommand not found: source-highlight\x1b[0m" 1>&2
		cat $1
	fi
}

# colourifide less
cless() {
	ccat $1 | less
}

