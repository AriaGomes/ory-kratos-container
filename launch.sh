#!/bin/sh

if [[ ! -f "/home/ory/config/config.yml" && ! -f "/home/ory/config/config.yml" ]]; then
    mkdir /home/ory/config
    cp /home/ory/identity.schema.json /home/ory/config.yml /home/ory/config/
fi

kratos serve -c "/home/ory/config/config.yml"