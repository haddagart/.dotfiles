#!/usr/bin/env bash

# Check if keychain exists
if ! command -v keychain >/dev/null 2>&1; then
  return 0
fi

# Collect all private keys in ~/.ssh
KEYS_TO_LOAD=()

for key in "$HOME/.ssh/"*; do
  [[ -f "$key" ]] || continue
  # Skip public keys and configs
  if [[ "$key" == *.pub || "$key" == *known_hosts || "$key" == *config ]]; then
    continue
  fi
  KEYS_TO_LOAD+=("$key")
done

# Run keychain only if we found keys
if [[ ${#KEYS_TO_LOAD[@]} -gt 0 ]]; then
  eval "$(keychain --quiet --eval ssh "${KEYS_TO_LOAD[@]}")"
fi