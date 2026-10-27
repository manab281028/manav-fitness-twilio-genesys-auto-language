#!/usr/bin/env bash
# Set TWILIO_ACCOUNT_SID and TWILIO_AUTH_TOKEN in your shell before running.
# Use only a number you are authorized to query.
set -eu
: "${TWILIO_ACCOUNT_SID:?Set TWILIO_ACCOUNT_SID first}"
: "${TWILIO_AUTH_TOKEN:?Set TWILIO_AUTH_TOKEN first}"
PHONE_NUMBER="${1:?Usage: ./curl-example.sh +14155552671}"
curl --fail-with-body --silent --show-error \
  --user "$TWILIO_ACCOUNT_SID:$TWILIO_AUTH_TOKEN" \
  "https://lookups.twilio.com/v2/PhoneNumbers/${PHONE_NUMBER}"
