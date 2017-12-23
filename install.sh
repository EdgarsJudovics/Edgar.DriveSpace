#!/bin/bash

PROJECT="Edgar.DriveSpace"
APPS="/usr/local"
BIN="/usr/local/bin"
COMMAND="dsize"

echo "$PROJECT installer"

echo "Are you sure you want to install $PROJECT?"
read -p "(Yes/No): " CONFIRMATION

if [[ ! "$CONFIRMATION" =~ ^[Yy].*$ ]]; then
  echo "Installation cancelled"
  exit 0
fi

if [ ! -d "$APPS/$PROJECT" ]; then
  mkdir "$APPS/$PROJECT"
fi

if [ ! -d "$BIN" ]; then
  mkdir "$BIN"
fi

dotnet publish "$PROJECT/$PROJECT.csproj" -c Release -o "$APPS/$PROJECT"

if [ -f "$APPS/$PROJECT/$COMMAND" ]; then
  rm "$APPS/$PROJECT/$COMMAND"
fi

echo "#!/bin/bash" > "$APPS/$PROJECT/$COMMAND"
echo "dotnet \"$APPS/$PROJECT/$PROJECT.dll\"" > "$APPS/$PROJECT/$COMMAND"
chmod +x "$APPS/$PROJECT/$COMMAND"

ln -s "$APPS/$PROJECT/$COMMAND" "$BIN/$COMMAND"

echo -e "Installed to \e[4m$APPS/$PROJECT\e[0m with shell \e[4m$BIN/$COMMAND\e[0m"
echo -e "\e[32mInstallation complete\e[0m"
