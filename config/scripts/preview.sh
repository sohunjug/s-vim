#!/usr/bin/env bash

REVERSE="\x1b[7m"
RESET="\x1b[m"

if [ -z "$1" ]; then
  echo "usage: $0 FILENAME[:LINENO][:IGNORED]"
  exit 1
fi

IFS=':' read -r -a INPUT <<< "$1"
FILE=${INPUT[0]}
CENTER=${INPUT[1]}

if [[ $1 =~ ^[A-Z]:\\ ]]; then
  FILE=$FILE:${INPUT[1]}
  CENTER=${INPUT[2]}
fi

if [[ -n "$CENTER" && ! "$CENTER" =~ ^[0-9] ]]; then
  exit 1
fi
CENTER=${CENTER/[^0-9]*/}

FILE="${FILE/#\~\//$HOME/}"
if [ ! -r "$FILE" ]; then
  echo "File not found ${FILE}"
  exit 1
fi

FILE_LENGTH=${#FILE}
MIME=$(file --dereference --mime "$FILE")
if [[ "${MIME:FILE_LENGTH}" =~ binary ]]; then
  echo "$MIME"
  exit 0
fi

if [ -z "$CENTER" ]; then
  CENTER=0
fi

if [ -n "$FZF_PREVIEW_LINES" ]; then
  LINES=$FZF_PREVIEW_LINES
else
  if [ -r /dev/tty ]; then
    LINES=$(stty size < /dev/tty | awk '{print $1}')
  else
    LINES=40
  fi
fi

FIRST=$(($CENTER-$LINES/3))
FIRST=$(($FIRST < 1 ? 1 : $FIRST))
LAST=$((${FIRST}+${LINES}-1))

if [ -z "$FZF_PREVIEW_COMMAND" ] && command -v bat > /dev/null; then
  bat --style="${BAT_STYLE:-numbers}" --color=always --pager=never \
      --line-range=$FIRST:$LAST --highlight-line=$CENTER "$FILE"
  exit $?
else
    rel_center=$((${CENTER} - ${FIRST}))
    rel=$(sed -n "${FIRST},${LAST}p" "$FILE")
    IFS="\n"; read -r -a arr <<< "$rel"
    idx=0
    echo $rel | while read line
    do
        if [ ${idx} -eq ${rel_center} ]
        then
            echo -e "\033[32;49;1m → ${line} \033[39;49;0m"
        else
            echo ${line}
        fi
        let idx++
    done
    exit $?
fi

DEFAULT_COMMAND="highlight -O ansi -l {} || coderay {} || rougify {} || cat {}"
CMD=${FZF_PREVIEW_COMMAND:-$DEFAULT_COMMAND}
CMD=${CMD//{\}/$(printf %q "$FILE")}

eval "$CMD" 2> /dev/null | awk "NR >= $FIRST && NR <= $LAST { \
    if (NR == $CENTER) \
        { gsub(/\x1b[[0-9;]*m/, \"&$REVERSE\"); printf(\"$REVERSE%s\n$RESET\", \$0); } \
    else printf(\"$RESET%s\n\", \$0); \
    }"
