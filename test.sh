#!/bin/sh

BIN="./mush.sh"
FILE="./test/tpl.ms"
i=0

throw () {
  {
    printf " \n error: \`%s'\n" "$@"
  } >&2
  exit 1
}

export USER="jwerle"
export GENDER="male"
export THING="apple"
export COLOR="red"
export PERSON="tobi"
export ADJECTIVE="cool"

echo
echo " $FILE"
cat "$FILE" | $BIN | while read line; do
  ((++i))

  echo " $i $line"
  case $i in
    1)
      expected="$USER is $GENDER"

      if [ "$line" != "$expected" ]; then
        throw "$i '$line' != '$expected'"
      fi
      ;;

    2)
      expected="$THING is $COLOR"

      if [ "$line" != "$expected" ]; then
        throw "$i '$line' != '$expected'"
      fi
      ;;

    3)
      expected="$PERSON is $ADJECTIVE"

      if [ "$line" != "$expected" ]; then
        throw "$i '$line' != '$expected'"
      fi
      ;;

    4)
      expected=""

      if [ "$line" != "$expected" ]; then
        throw "$i '$line' != '$expected'"
      fi
      ;;

    5)
      expected=""

      if [ "$line" != "$expected" ]; then
        throw "$i '$line' != '$expected'"
      fi
      ;;
  esac
done

echo

if [ $? -eq 0 ]; then
  echo "+ ok!"
else
  echo "x fail"
fi
exit $?
