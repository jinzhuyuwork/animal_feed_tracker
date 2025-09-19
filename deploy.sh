#!/bin/bash

echo "==================================================="
echo "Start static code analyzing and format checking ..."
echo "==================================================="

bundle exec rubocop

echo "Done static code analyzing and format checking."

echo "==================================================="
echo "Start unit/integration testing ..."
echo "==================================================="

bundle exec rails test test

echo "Done unit/integration testing."

echo "==================================================="
echo "Start static code security scaning ..."
echo "==================================================="

bundle exec brakeman --format=junit --output=brakeman_junit.xml

echo "Done  static code security scaning."

echo "==================================================="
echo "Start dependent libraries security scaning ..."
echo "==================================================="

bundle-audit check --update

echo "Done dependent libraries security scaning."

echo "==================================================="
echo "Start deploying ..."
echo "==================================================="
read -p "Do you want to deploy to GitHub and restart the server? (YES/NO): " answer

# Convert to uppercase to make it case-insensitive
answer=$(echo "$answer" | tr '[:lower:]' '[:upper:]')

if [ "$answer" = "NO" ]; then
  echo "Exiting..."
  exit 1
else
  git push origin main
  echo "Done deployment. Server will restart shortly."
fi
