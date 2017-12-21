#!/bin/bash

APP_BASE_DIR="/opt"
SH_BIN_DIR="/usr/bin"
PROJECT=Edgar.DriveSpace
DLL_BINARY="$PROJECT.dll"

echo "Started uninstalling $PROJECT"

echo "Enter project installation path:"
echo -e "\e[33;1m!!! THIS WILL DELETE THE FOLDER !!!\e[0m"
echo -e "\e[31;1m!!!    SERIOUSLY, BE CAREFUL    !!!\e[0m"
read -e -p "  Path: " -i "$APP_BASE_DIR/$PROJECT" APP_INSTALL_DIR
echo "Enter shell file installation path and name:"
read -e -p "  Path: " -i "$SH_BIN_DIR/dsize" SH_INSTALL_PATH

echo "Are you sure you want to proceed?"
read -p "(Yes/No): " CONFIRMATION

if [[ ! $CONFIRMATION =~ ^[Yy].*$ ]]; then
  echo "Uninstall cancelled"
  exit 0
fi

if [ -d "$APP_INSTALL_DIR" ]; then
  rm -Rf "$APP_INSTALL_DIR"
fi

if [ -f "$SH_INSTALL_PATH" ]; then
  rm "$SH_INSTALL_PATH"
fi

echo -e "Deleted project folder \e[4m$APP_INSTALL_DIR\e[0m and shell file \e[4m$SH_INSTALL_PATH\e[0m"
echo -e "\e[32mUninstall complete\e[0m"
