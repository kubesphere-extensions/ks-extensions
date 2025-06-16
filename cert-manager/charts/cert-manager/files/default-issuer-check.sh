#!/bin/sh

set -e

issuer=$1

success_msg="Default cluster issuer is ready!"

check_status() {
  issuer_status=$(kubectl get clusterissuers.cert-manager.io "$issuer" -o \
  jsonpath='{.status}' | jq -r -c '.conditions[] | select(.type=="Ready")')

  # shellcheck disable=SC2046
  # shellcheck disable=SC2039
  is_ready=$(echo "$issuer_status" | jq -r .status)
  if [ "$is_ready" = "False" ]
  then
    reason=$(echo "$issuer_status" | jq -r .reason)
    message=$(echo "$issuer_status" | jq -r .message)
    echo "ERROR: Default cluster issuer is not ready, reason: $reason, message: $message."
    return
  elif [ "$is_ready" = "True" ]; then
    echo "$success_msg"
    return
  fi

  echo "No Status."
}

start_time=$(date +%s)
end_time=$((start_time + 60 * 3))
result="No Status"
# shellcheck disable=SC2046
# shellcheck disable=SC2154
while [ $(date +%s) -lt "$end_time" ]; do
    result=$(check_status)
    if [ "$result" = "No Status." ]
    then
      sleep 5
    else
      break
    fi
done

if [ "$result" != "$success_msg" ]
then
  echo "$result"
  exit 1
else
  echo "$result"
  exit 0
fi


