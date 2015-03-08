#!/bin/sh
set -e
#set -x
getArg () {
	local argNo
	argNo="$1"
	shift
	shift $(($argNo-1))
	echo "$1"
}
rotate () {
	local cmd
	local i

	cmd="$1"
	i="$2"
	shift 2
	for i in $(seq "$i")
	do
		first="$1"
		shift
		set -- "$@" "$first"
	done
	$cmd "$@"
}
setArg () {
	local cmd
	local index
	local value
	
	read -r cmd

	while 
		read -r index &&
		read -r value
	do
		for i in $(seq "$(($index-1))")
		do    
			first="$1"
			shift
			set -- "$@" "$first"
		done      

		shift
		set -- "$@" "$value"
		
		for i in $(seq "$(($#-$index))")
		do    
			first="$1"
			shift
			set -- "$@" "$first"
		done      
	done
	
        $cmd "$@"
}
swapArgs () {
	local cmd
	local index1
	local index2

	read -r cmd &&
	read -r index1 &&
	read -r index2

	value1="$(getArg "$index1" "$@")"
	value2="$(getArg "$index2" "$@")"

	{
		echo "$cmd"
		echo "$index1"
		echo "$value2"
		echo "$index2"
		echo "$value1"
	} |
		setArg "$@"
}
args_sh_test () {
	#set -x

	getArg 2 "$@"
	echo "2 of $@ is $(getArg 2 "$@")"

	{
		echo "echo"
		echo "2"
		echo "xx"
		echo "3"
		echo "yy"
	} |
		setArg echo "$@"

	echo "$@"
	{
		echo "echo" 
		echo "2" 
		echo "3" 
	} |
		swapArgs "$@"
}
#test "$@"
