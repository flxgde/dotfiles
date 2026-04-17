#!/usr/bin/env bash

languages=$(printf "go\nlua\nnodejs\npython\nrust\ntypescript\nbash\nkotlin\njava")
commands=$(printf "find\nsed\nawk\ntmux\ngit\nkubectl\nansible\nansible-playbook\ndocker\ncurl\njq")

selected=$(printf "%s\n%s" "$languages" "$commands" | fzf)
[[ -z $selected ]] && exit 0

read -rp "query: " query

if grep -qs "^$selected$" <<< "$languages"; then
    query=$(echo "$query" | tr ' ' '+')
    tmux neww bash -c "curl -s cht.sh/$selected/$query | less -R"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less -R"
fi
