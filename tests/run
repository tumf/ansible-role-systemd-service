#!/bin/bash

usage_exit() {
        echo "Usage: $0 [-w] name" 1>&2
        exit 1
}
user=$(id -un)
group=$(id -gn)
ansible_opts="-e ansible_unit_test=true -e ansible_unit_test_user=$user -e ansible_unit_test_group=$group"

outputs="outputs"

while getopts wh option
do
    case $option in
        w)
            outputs="cases"
            ;;
        h)
            usage_exit
            ;;
    esac
done

shift $((OPTIND - 1))

[ -f tests/test.yml ] && cd tests

cases=$(ls cases)
if [ ! -z $1 ];then
    cases=$1
fi

errors=0
passes=0

for case in $cases
do
    rm -rf ${outputs}/${case}
done

mkdir -p cases ${outputs}
for case in $cases
do
    echo "* Test: $case"
    ansible-playbook ./test.yml -i 127.0.0.1, -t $case-setup -e ansible_unit_test_prefix_dir="${outputs}/${case}" -e prefix_dir="${outputs}/${case}" ${ansible_opts} >/dev/null
    ansible-playbook ./test.yml -i 127.0.0.1, -t $case -e ansible_unit_test_prefix_dir="${outputs}/${case}" -e prefix_dir="${outputs}/${case}" ${ansible_opts} || exit 255


    if diff -uNr cases/${case} ${outputs}/${case} >/dev/null 2>&1 ;then
        passes=$(( passes+1 ))
        echo "TestCase: $case OK"
    else
        diff -uNr cases/${case} ${outputs}/${case}
        errors=$(( errors+1 ))
        echo "TestCase: $case ERROR"
    fi
done

if [ $errors -eq 0 ]
then
    echo "${passes} test case(s) passed"
else
    echo "${errors} error(s)"
fi
exit $errors
