#!/bin/sh

while read line
do
  echo ${line}
    HOSTNAME=`echo ${line} | cut -d ' ' -f 1`
    ADDRESS=`echo ${line} | cut -d ' ' -f 2`

    case ${SERF_EVENT} in
    "member-join")
      cat << __EOF__ > "/etc/munin/conf.d/node-${ADDRESS}.conf"
[node;${HOSTNAME}]
    address ${ADDRESS}
    use_node_name yes
__EOF__
;;
    "member-leave" | "member-failed")
      rm -f /etc/munin/conf.d/node-${ADDRESS}.conf;;
    \?)
      echo "other";;
    esac
    break
done 

exit 0

