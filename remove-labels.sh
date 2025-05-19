#!/bin/bash
set -e

LABELS_RAW="$1"
NUMBER="$2"
DELIMITER="$3"

if [[ -z "$LABELS_RAW" || -z "$NUMBER" || -z "$REPO" ]]; then
  echo "Usage: $0 '<label1 | label2 | ...>' <issue_number> <owner/repo>"
  exit 1
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "GITHUB_TOKEN environment variable is not set."
  exit 1
fi

IFS="$DELIMITER" read -ra LABELS_ARR <<< "$LABELS_RAW"
SUCCESS=1
for label in "${LABELS_ARR[@]}"; do
  label_trimmed="$(echo "$label" | xargs)"
  if [[ -n "$label_trimmed" ]]; then
    API_URL="https://api.github.com/repos/$REPO/issues/$NUMBER/labels/$(printf '%s' "$label_trimmed" | jq -sRr @uri)"
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE "$API_URL" \
      -H "Authorization: Bearer $GITHUB_TOKEN" \
      -H "Accept: application/vnd.github+json")
    if [[ "$RESPONSE" == "200" || "$RESPONSE" == "204" ]]; then
      echo "Removed label: $label_trimmed from Issue/PR #$NUMBER in $REPO"
    else
      echo "Error removing label ($label_trimmed) from Issue/PR #$NUMBER in $REPO. HTTP Status: $RESPONSE" >&2
      SUCCESS=0
    fi
  fi
done

if [[ $SUCCESS -eq 1 ]]; then
  exit 0
else
  exit 1
fi
