#!/usr/bin/env bash

set -e

if docker run -t --rm tfenv
then
    echo "Success!"
    exit 0
else
    echo "Failed.."
    exit 1
fi
