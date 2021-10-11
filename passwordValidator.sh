#!/bin/bash
args=("$@")
if [ -z ${args[0]} ]; then
        echo "No arguments were given."
        exit 1
else
        echo "First argument is: ${args[0]}"
fi

if [[ ${#args[0] -gt 10 ]]; then
    echo "Good,password is more than 10 charecters long!"
else
    echo "fail.. password is less-than 10 charecters long!"
    exit 1
fi

if [[ ${#args[0]} =~ [a-z] ]] && [[ ${#args[0]} =~ [0-9] ]]; then
        echo "good, contains both numbers & charecters!"
else
        echo "fail.. does not contain coth lower-case+numbers!.."
        exit 1
fi

if [[ ${args[0]} =~ [A-Z] ]] && [[ ${args[0]} =~ [a-z] ]]; then
        echo "good, both upper+lower case!"
else
        echo "fail.. does not contain both upper+lower case!"
        exit 1
fi
