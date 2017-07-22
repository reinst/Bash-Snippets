#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein
currentVersion="1.14.1"
declare -a tools=(currency stocks weather crypt movies taste short geo cheat ytview cloudup qrify siteciphers todo)
usedGithubInstallMethod="0"

askInstall()
{
  echo -n "Do you wish to install $1 [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd $1 || return 1
    echo -n "Installing $1: "
    chmod a+x $1
    cp $1 /usr/local/bin > /dev/null 2>&1 || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
    echo "Success"
    cd .. || return 1
  fi
}

updateTool()
{
  if [[ -f  /usr/local/bin/$1 ]];then
    usedGithubInstallMethod="1"
    cd $1 || return 1
    echo -n "Installing $1: "
    chmod a+x $1
    cp $1 /usr/local/bin > /dev/null 2>&1 || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
    echo "Success"
    cd .. || return 1
  fi
}

singleInstall()
{
  cd $1 || exit 1
  echo -n "Installing $1: "
  chmod a+x $1
  cp $1 /usr/local/bin > /dev/null 2>&1 || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
  echo "Success"
  cd .. || exit 1
}

copyManpage()
{
  if [[ "$(uname)" == "Darwin" ]]; then manPath="/usr/local/share/man/man1"
else manPath="/usr/local/man/man1" ;fi
  cp bash-snippets.1 $manPath 2>&1  || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
}

if [[ $# == 0 ]]; then
  for tool in "${tools[@]}"
  do
    askInstall $tool || exit 1
  done
  copyManpage || exit 1
elif [[ $1 == "update" ]]; then
  echo "Updating scripts..."
  for tool in "${tools[@]}"
  do
    updateTool $tool || exit 1
  done
  if [[ $usedGithubInstallMethod == "1" ]]; then copyManpage || exit 1
else { echo "It appears you have installed bash-snippets through a package manager, you must update it with the respective package manager."; exit 0; } ;fi
elif [[ $1 == "all" ]];then
  for tool in "${tools[@]}"
  do
    singleInstall $tool || exit 1
  done
  copyManpage || exit 1
else
  singleInstall $1 || exit 1
  copyManpage || exit 1
fi



echo -n "( •_•)"
sleep .75
echo -n -e "\r( •_•)>⌐■-■"
sleep .75
echo -n -e "\r               "
echo  -e "\r(⌐■_■)"
sleep .5
echo "Bash Snippets version $currentVersion"
echo  "https://github.com/alexanderepstein/Bash-Snippets"
