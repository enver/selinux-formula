#!/bin/bash

APPLICATION="$1"
PROTOCOL="$2"
PORT="$3"

TYPE="${APPLICATION}_port_t"

EXISTS=`semanage port -l | tr -d ',' | grep " ${PORT} " | grep ${PROTOCOL} | grep ${TYPE} | wc -l`
MODIFY=`semanage port -l | tr -d ',' | grep " ${PORT} " | grep ${PROTOCOL} | grep -v ${TYPE} | wc -l`

if [ "${EXISTS}" -eq 0 ]
then
    if [ "${MODIFY}" -ne 0 ]
    then
        semanage port -m -t "${TYPE}"  -p "${PROTOCOL}" "${PORT}"
    else
        semanage port -a -t "${TYPE}"  -p "${PROTOCOL}" "${PORT}"
    fi
fi
