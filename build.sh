#!/usr/bin/env bash

if [[ "$(pwd)" = *" "* ]]
then
	echo -e "\033[0;31mYour EBE path contains spaces. Move it to a directory without spaces to proceed.\033[0m" 1>&2
	exit 1
fi

EBE_DEFAULT_RELEASE=v1.7
BUILDSCRIPTS_DIR=buildscripts

# Will attempt to clone buildscripts repository...
if ! [[ -e "$BUILDSCRIPTS_DIR/.git" ]]; then
  git submodule init
  git submodule update $BUILDSCRIPTS_DIR
  git config submodule.buildscripts.ignore all
  for s in $(ls sources/); do
    git config submodule.sources/$s.ignore all
  done
fi

[[ $EBE_RELEASE ]] || EBE_RELEASE=$EBE_DEFAULT_RELEASE

pushd $BUILDSCRIPTS_DIR &> /dev/null
git checkout $EBE_RELEASE &> /dev/null
git pull &> /dev/null
popd &> /dev/null

./buildscripts/build.py --release $EBE_RELEASE $@
