# Log file path (relative to dotfiles root)
LOG_FILE="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}/logs.json"

# Append a JSON log entry to logs.json
_log_entry() {
  local level="$1"
  local message="$2"
  local timestamp
  timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  # Escape double quotes and backslashes in message
  message="${message//\\/\\\\}"
  message="${message//\"/\\\"}"
  printf '{"timestamp":"%s","level":"%s","message":"%s"}\n' \
    "$timestamp" "$level" "$message" >> "$LOG_FILE"
}

info() {
  _log_entry "INFO" "$1"
}

success() {
  _log_entry "SUCCESS" "$1"
}

error() {
  _log_entry "ERROR" "$1"
}

log() {
  _log_entry "INFO" "$1"
}

ok() {
  _log_entry "OK" "$1"
}

center() {
  _log_entry "INFO" "$1"
}

center_text() {
  _log_entry "INFO" "$1"
}
