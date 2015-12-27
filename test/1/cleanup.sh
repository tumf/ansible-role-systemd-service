files="
/etc/default/swarm-manager
/etc/systemd/system/swarm-manager.service
"

for file in $files;
do
    [ -f $file ] && rm -rf $file
done
