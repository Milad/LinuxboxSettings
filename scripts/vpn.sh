#!/bin/bash

case "$1" in
up)
    swanctl -i -c zmarta
    ;;
status)
    swanctl -l
    ;;
down)
    swanctl -t -c zmarta
    ;;
*)
    echo Please supply either: up down status
    exit 1
    ;;
esac
