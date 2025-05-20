#!/usr/bin/env bash

set -e

LABELS_YAML="$1"
NUMBER="$2"

if [[ -z "$LABELS_YAML" || -z "$NUMBER" ]]; then
  echo "Usage: $0 '<yaml-labels>' <issue_or_pr_number>"
  echo "Example:"
  echo "  $0 $'- bug\n- help wanted' 123"
  exit 1
fi

# Reject JSON arrays
if [[ "$LABELS_YAML" =~ ^\[.*\]$ ]]; then
  echo "Error: Only YAML arrays are accepted for labels (use - label format, not JSON array)."
  exit 1
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "GITHUB_TOKEN environment variable is not set."
  exit 1
fi

# Parse YAML array into bash array
LABELS=()
while IFS= read -r line; do
  label="${line#- }"
  label="${label%%\r}" # Remove possible Windows line endings
  if [[ -n "$label" ]]; then
    LABELS+=("$label")
  fi
done <<< "$LABELS_YAML"

if [[ ${#LABELS[@]} -eq 0 ]]; then
  echo "No labels provided."
  exit 1
fi

SUCCESS=1

for label in "${LABELS[@]}"; do
  label_trimmed="$(echo "$label" | xargs)"
  if [[ -n "$label_trimmed" ]]; then
    API_URL="https://api.github.com/repos/$REPO/issues/$NUMBER/labels/$(printf '%s' "$label_trimmed" | jq -sRr @uri)"
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE "$API_URL" \
      -H "Authorization: Bearer $GITHUB_TOKEN" \
      -H "Accept: application/vnd.github+json")
    if [[ "$RESPONSE" == "200" || "$RESPONSE" == "204" ]]; then
      echo "Removed label: $label_trimmed from Issue/PR #$NUMBER in $REPO"
    else
      case "$RESPONSE" in
        404)
          echo "Label ($label_trimmed) not found on Issue/PR #$NUMBER in $REPO." >&2
          ;;
        403)
          echo "Forbidden: You do not have permission to remove label ($label_trimmed) from Issue/PR #$NUMBER in $REPO." >&2
          SUCCESS=0
          ;;
        422)
          echo "Unprocessable Entity: The label ($label_trimmed) is not valid for Issue/PR #$NUMBER in $REPO." >&2
          SUCCESS=0
          ;;
        *)
          echo "Unexpected error: HTTP Status $RESPONSE" >&2
          SUCCESS=0
          ;;
      esac
    fi
  fi
done

if [[ $SUCCESS -eq 1 ]]; then
  exit 0
else
  exit 1
fi
