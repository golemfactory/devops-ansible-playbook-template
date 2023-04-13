#!/bin/bash

die() {
    echo "$@" >&2
    exit 1
}

git_submodule_status="$(git submodule status)"
if grep -q '^-' <<<"$git_submodule_status"; then
    die "ERROR: Run git submodule update --init"
fi
if grep -q '^+' <<<"$git_submodule_status"; then
    echo "WARNING: Remember to run 'git submodule update'"
    sleep 1
fi

if [[ -e .vagrant-ssh-config ]]; then
    env_dir="envs/vagrant"
    export ANSIBLE_SSH_COMMON_ARGS="-A -F ./.vagrant-ssh-config"
else
    env_dir="envs/production"
    export ANSIBLE_SSH_COMMON_ARGS="-A -o StrictHostKeyChecking=accept-new"
fi

exec ansible-playbook \
    -i "${env_dir}/inventory.yml" \
    play.yml \
    "$@"
