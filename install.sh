#!/bin/bash

APP_BASE_DIR="/opt"
SH_BIN_DIR="/usr/bin"
PROJECT=${PWD##*/}
DLL_BINARY="$PROJECT.dll"

cd "$PROJECT"
echo "Started installing $PROJECT"

echo "Enter project installation path:"
read -e -p "  Path: " -i "$APP_BASE_DIR/$PROJECT" APP_INSTALL_DIR
echo "Enter shell file installation path and name:"
read -e -p "  Path: " -i "$SH_BIN_DIR/dsize" SH_INSTALL_PATH

if [ ! -d "$APP_INSTALL_DIR" ]; then
  mkdir "$APP_INSTALL_DIR"
fi

dotnet publish -c Release -o "$APP_INSTALL_DIR"

if [ -f "$SH_INSTALL_PATH" ]; then
  rm "$SH_INSTALL_PATH"
fi
echo "#!/bin/bash" > "$SH_INSTALL_PATH"
echo "dotnet \"$APP_INSTALL_DIR/$DLL_BINARY\"" > "$SH_INSTALL_PATH"
chmod 755 "$SH_INSTALL_PATH"

echo -e "Installed to \e[4m$APP_INSTALL_DIR\e[0m with shell \e[4m$SH_INSTALL_PATH\e[0m"
echo -e "\e[32mInstallation complete\e[0m"
