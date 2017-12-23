#!/bin/bash

PROJECT="Edgar.DriveSpace"
APPS="/usr/local"
BIN="/usr/local/bin"
COMMAND="dsize"

echo "Started uninstalling $PROJECT"

echo "Are you sure you want to uninstall $PROJECT?"
read -p "(Yes/No): " CONFIRMATION

if [[ ! "$CONFIRMATION" =~ ^[Yy].*$ ]]; then
  echo "Uninstall cancelled"
  exit 0
fi

if [ -d "$APPS/$PROJECT" ]; then
  rm -Rf "$APPS/$PROJECT"
fi

if [ -f "$BIN/$COMMAND" ]; then
  rm "$BIN/$COMMAND"
fi

echo -e "Deleted project folder \e[4m$APPS/$PROJECT\e[0m and shell file \e[4m$BIN/$COMMAND\e[0m"
echo -e "\e[32mUninstall complete\e[0m"
