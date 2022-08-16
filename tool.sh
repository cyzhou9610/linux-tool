#!/bin/bash

function menu() { #显示菜单
  echo "*************************************
          MENU
          1.更换Ubuntu源
          2.更换Centos7源
          3.安装网络管理(Ubuntu)
          4.关闭桌面(Ubuntu)
          5.打开桌面(Ubuntu)
          0.exit
*************************************"
}
function num() { #选项
  read -p "请输入您需要操作的项目: " number
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
    echo "重启后生效"
    ;;
  4)
    exec sudo systemctl set-default graphical.target
    echo "重启后生效"
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
