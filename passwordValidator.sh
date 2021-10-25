#!/bin/bash

runtest() {
    arg=$1
    if [[ ${#arg} -gt 10 ]]; then
        echo "Good,  password is more than 10 charecters long!"
    else
        echo "fail,  password is less-than 10 charecters long!"
    fi

    if [[ $arg =~ [a-zA-Z] ]] && [[ $arg =~ [0-9] ]]; then
            echo "good,  contains both numbers & charecters!"
    else
            echo "fail,  does not contain both lower-case+numbers!.."
    fi

    if [[ "$arg" =~ [[:upper:]] ]] && [[ "$arg" =~ [[:lower:]] ]]; then
            echo "good,  both upper+lower case!"
    else
        echo "fail,  does not contain both upper+lower case!"
    fi
    echo ""
    echo ""
}

loop_through() {
   declare -a arg1=("$@")
    for i in "${arg1[@]}"
    do
        if [ "$flag" = "true" ]; then
            echo "running test on: $i"
            runtest $i
        else
            echo "value: $i"
        fi
    done
    echo "------------------------------"
}

print_usage() {
  echo "Usage: -p for direct pass, can pass several with ',' as delimiter :)"
  echo "Usage: -f for file input"
}

while getopts 'p:f:' flag; do
  case "${flag}" in
    p)  arg="${OPTARG}"
        readarray -td, a <<<"$arg,"; unset 'a[-1]'; declare -p a;
        echo ""
        flag="true"
        loop_through ${a[@]}
        exit 1 ;;
    f)  input="${OPTARG}"
        arg=()
        while IFS= read -r line
        do
            arg+=("$line")
        done < "$input" ;;
    *) print_usage
       exit 1 ;;
  esac
done

if [ -z ${arg[0]} ]; then
        echo "No arguments were given."
        exit 1
else
        echo "argument\s: "
        flag="false"
        loop_through ${arg[@]}
fi
flag="true"
loop_through "${arg[@]}"
