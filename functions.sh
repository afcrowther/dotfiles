gac () {
  git add . && git commit -m "$@"
}

gacp () {
  gac $@ && git push
}

vdiff () {
  if [ "${#}" -ne 2 ] ; then
    echo "vdiff requires two arguments"
    echo "  comparing dirs:  vdiff dir_a dir_b"
    echo "  comparing files: vdiff file_a file_b"
    return 1
  fi

  local left="${1}"
  local right="${2}"

  if [ -d "${left}" ] && [ -d "${right}" ]; then
    vim +"DirDiff ${left} ${right}"
  else
    vim -d "${left}" "${right}"
  fi
}

function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg
