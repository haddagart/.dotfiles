# Miniforge / conda init
_conda_bin=""
for _p in \
  "$HOME/miniforge3/bin/conda" \
  "$HOME/Software/miniforge3/bin/conda" \
  "/opt/homebrew/Caskroom/miniforge/base/bin/conda" \
  "/opt/miniforge3/bin/conda"; do
  [[ -x "$_p" ]] && { _conda_bin="$_p"; break; }
done

if [[ -n "$_conda_bin" ]]; then
  eval "$("$_conda_bin" shell.zsh hook)" 2>/dev/null
fi
unset _conda_bin _p
