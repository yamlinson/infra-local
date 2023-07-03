#!/usr/bin/env bash

# EXAMPLE #
# Quick script to set up the environment to allow connections to Vault
# Creates a Vault token to use as well
# This gets copied over with sync.sh, run it from the infrastructure management machine

# Run with `. env.sh` to set environment variables correctly

export VAULT_IP="1.2.3.4"
export VAULT_ADDR="http(s)://$VAULT_IP:8200"
unset VAULT_TOKEN
vault login
export VAULT_TOKEN=$(vault token create -ttl=2h -policy=policy_name -field=token)
export TF_VAR_VAULT_ADDR=$VAULT_ADDR
export TF_VAR_VAULT_TOKEN=$VAULT_TOKEN
export ANSIBLE_HASHI_VAULT_ADDR=$VAULT_ADDR
export ANSIBLE_HASHI_VAULT_TOKEN=$VAULT_TOKEN