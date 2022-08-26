#!/bin/bash

function menu() { #显示菜单
  echo "*************************************
          MENU
          1.Change Ubuntu source
          2.Change Centos7 source
          3.Install net-tools(Ubuntu)
          4.Close the desktop(Ubuntu)
          5.Open the desktop(Ubuntu)
          0.exit
*************************************"
}
function num() { #选项
  read -p "Please enter the item you need to operate: " number
  case $number in
  1)
    exec sudo mv /etc/apt/sources.list /etc/apt/sources.list.backup
    exec sudo touch /etc/apt/sources.list
    echo "deb https://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse" >/etc/apt/sources.list
    echo "deb https://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse" >/etc/apt/sources.list
    echo "deb https://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >/etc/apt/sources.list
    echo "deb https://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >/etc/apt/sources.list
    exec sudo apt-get update
    ;;
  2)
    exec sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' \
      -e 's|^#baseurl=http://mirror.centos.org/centos|baseurl=https://mirrors.ustc.edu.cn/centos|g' \
      -i.bak \
      /etc/yum.repos.d/CentOS-Base.repo
    exec yum makecache
    ;;
  3)
    exec sudo apt-get install net-tools -y
    ;;
  4)
    exec sudo systemctl set-default multi-user.target
    echo "Take effect after restart"
    ;;
  5)
    exec sudo systemctl set-default graphical.target
    echo "Take effect after restart"
    ;;
  0)
    exit 0
    ;;

  esac
}

function main() {
  while true; do
    menu
    num
  done
}
main
