#!/bin/bash

# 判断是否已安装 Python
function is_python_installed() {
    if command -v python &>/dev/null; then
        echo "Python is already installed."
        exit 0
    fi
}

# 安装 Python 3.9.9
function install_python() {
    # 检查系统是否已安装 Python
    is_python_installed

    echo "开始安装 Python 3.9.9"

    # 安装 Python 编译所需的库
    sudo apt update
    sudo apt install -y build-essential libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
                        libreadline-dev libffi-dev zlib1g-dev make

    # 下载 Python 3.9.9 源码并安装
    wget https://www.python.org/ftp/python/3.9.9/Python-3.9.9.tgz
    tar -zxvf Python-3.9.9.tgz
    cd Python-3.9.9
    ./configure --enable-optimizations
    make -j$(nproc)
    sudo make altinstall

    # 清理安装过程中产生的临时文件
    cd ..
    rm -rf Python-3.9.9.tgz Python-3.9.9

    echo "Python 3.9.9 安装完成。"
}

# 主程序
install_python
