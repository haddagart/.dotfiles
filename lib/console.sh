# Colors for output
BLUE="\033[34m"
GREEN="\033[0;32m"
RED="\033[0;31m"
RESET="\033[0m"
YELLOW="\033[1;33m"

echo ""

# Function for logging
info() {
  printf "${BLUE}[INFO]${RESET} %s\n" "$1"
}

success() {
  printf "${GREEN}[OK]${RESET} %s\n" "$1"
}

error() {
  printf "${RED}[ERROR]${RESET} %s\n" "$1"
}

log() {
  printf "${YELLOW}[INFO]${RESET} %s\n" "$1"
}

ok() {
  printf "${GREEN}[OK]${RESET} %s\n" "$1"
}

center() {
  printf "${BLUE} %s ${RESET}\n" "$1"
}

# Center text with optional width (default: 72) and '=' as fill
center_text() {
  local text="$1"
  local width="${2:-72}"
  local fill_char="="

  # Get terminal width if smaller than requested width
  local term_width
  term_width=$(tput cols 2>/dev/null || echo "$width")
  if [ "$term_width" -lt "$width" ]; then
    width=$term_width
  fi

  # Text length
  local text_length=${#text}
  local padding=$(( (width - text_length) / 2 ))

  # Left and right padding
  local left_pad
  local right_pad
  left_pad=$(printf "%*s" $padding "")
  right_pad=$(printf "%*s" $((width - padding - text_length)) "")

  # Replace spaces with fill character
  left_pad=${left_pad// /$fill_char}
  right_pad=${right_pad// /$fill_char}

  # Build final string
  local full_text="${left_pad} ${text} ${right_pad}"

  # Delegate printing to your `center` function
  center "$full_text"
}