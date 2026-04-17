#!/bin/bash

set -euo pipefail

REPOSITORY=${REPO:?REPO is required, for example owner/name}
ACCESS_TOKEN=${TOKEN:?TOKEN is required}
RUNNER_ROOT=/home/docker/actions-runner
RUNNER_NAME=${RUNNER_NAME:-$(hostname)}
RUNNER_LABELS=${RUNNER_LABELS:-}
RUNNER_WORKDIR=${RUNNER_WORKDIR:-_work}
API_URL="https://api.github.com/repos/${REPOSITORY}/actions/runners"
RUNNER_URL="https://github.com/${REPOSITORY}"
CONFIGURED=false

echo "Configuring runner for ${REPOSITORY} as ${RUNNER_NAME}"

get_runner_token() {
    local token_type=$1

    curl --silent --show-error --fail --request POST \
        --header "Authorization: token ${ACCESS_TOKEN}" \
        --header "Accept: application/vnd.github+json" \
        "${API_URL}/${token_type}" | jq --raw-output '.token'
}

cleanup() {
    local exit_code=$?

    if [[ "${CONFIGURED}" == "true" ]]; then
        echo "Removing runner ${RUNNER_NAME}"
        remove_token=$(get_runner_token remove-token) || remove_token=""
        if [[ -n "${remove_token}" ]]; then
            ./config.sh remove --unattended --token "${remove_token}" || true
        fi
    fi

    exit "${exit_code}"
}

trap cleanup EXIT INT TERM

cd "${RUNNER_ROOT}"

registration_token=$(get_runner_token registration-token)

config_args=(
    --url "${RUNNER_URL}"
    --token "${registration_token}"
    --name "${RUNNER_NAME}"
    --work "${RUNNER_WORKDIR}"
    --unattended
    --ephemeral
    --replace
)

if [[ -n "${RUNNER_LABELS}" ]]; then
    config_args+=(--labels "${RUNNER_LABELS}")
fi

./config.sh "${config_args[@]}"
CONFIGURED=true

./run.sh