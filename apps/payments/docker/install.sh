#!/bin/bash

set -exuo pipefail

# Install payments-wiki
php maintenance/install.php \
  --server "$MW_SERVER" \
  --scriptpath="$MW_SCRIPT_PATH" \
  --dbtype "$MW_DB_TYPE" \
  --dbserver="$MW_DB_HOST" \
  --dbname="$MW_DB_NAME" \
  --dbuser="$MW_DB_USER" \
  --dbpass="$MW_DB_PASS" \
  --lang "$MW_LANG" \
  --pass "$MW_PASS" \
  --with-extensions \
  "$MW_SITENAME" "$MW_USER"

composer install

# Load mw config
LS=${PWD}"/LocalSettings.php"
if [ -f "$LS" ]; then
    echo "require_once( '/docker/config/mw/CustomSettings.php');" >> "$LS"
fi

# Added default pages
php maintenance/edit.php --summary='Docker import' 'Main_Page' < '/docker/wikitext/Main_Page.wiki'
php maintenance/edit.php --summary='Docker import' 'Template:2011FR/JimmyQuote/text/en' < '/docker/wikitext/Appeal.wiki'
php maintenance/edit.php --summary='Docker import' 'Template:LanguageSwitch' < '/docker/wikitext/LanguageSwitch.wiki'
php maintenance/edit.php --summary='Docker import' 'Donate-thanks' < '/docker/wikitext/Donate-thanks.wiki'
php maintenance/edit.php --summary='Docker import' 'Donate-error' < '/docker/wikitext/Donate-error.wiki'