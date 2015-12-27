#!/bin/sh
name=systemd-service
work_dir=./test
role_dir="${work_dir}/roles/${name}"
rm -rf ${role_dir}
mkdir -p ${role_dir}

for dir in "defaults handlers meta tasks templates";
do
    cp -pR ${dir} ${role_dir}
done

mkdir -p /etc/systemd/system /etc/default 
