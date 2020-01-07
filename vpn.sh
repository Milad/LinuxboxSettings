#!/bin/bash

while [ "$1" != "" ]; do
    case $1 in
    up)
        swanctl -i -c zmarta
        ;;
    status)
        swanctl -l
        ;;
    down)
        swanctl -t -c zmarta
        ;;
    esac
    shift
done

