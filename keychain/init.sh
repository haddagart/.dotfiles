#!/usr/bin/env bash

# Check if keychain exists
if ! command -v keychain >/dev/null 2>&1; then
  return 0
fi

# Collect private keys in ~/.ssh (exclude public keys, known_hosts*, config, and *.old files)
KEYS_TO_LOAD=()

for key in "$HOME/.ssh/"*; do
  [[ -f "$key" ]] || continue
  case "$key" in
    *.pub|*known_hosts*|*config*|*.old|*authorized_keys*) continue ;;
  esac
  # Only include files that look like private keys (contain PRIVATE KEY header)
  grep -ql "PRIVATE KEY" "$key" 2>/dev/null || continue
  KEYS_TO_LOAD+=("$key")
done

# Run keychain only if we found keys
if [[ ${#KEYS_TO_LOAD[@]} -gt 0 ]]; then
  eval "$(keychain --quiet --eval ssh "${KEYS_TO_LOAD[@]}" 2>/dev/null)"
fi
