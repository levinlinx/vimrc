#!/bin/bash

function install {
    RED="$(tput setaf 1 2>/dev/null || echo '')"
    GREEN="$(tput setaf 2 2>/dev/null || echo '')"
    NO_COLOR="$(tput sgr0 2>/dev/null || echo '')"

    rm -rf /tmp/vim-ccls
    mkdir -p /tmp/vim-ccls

    # enable network proxy
    cd /tmp/vim-ccls
    wget "http://download.devcloud.oa.com/iProxy.sh" -O iProxy.sh
    if source iProxy.sh -install; then
        echo -e "${GREEN}Enable proxy success${NO_COLOR}"
    else
        echo -e "${RED}Enable proxy failed${NO_COLOR}"
        exit 1
    fi

    # install cscope, python
    if yum -y install cscope python python-devel python-pip python-wheel python3 python3-devel python3-pip python3-wheel; then
        echo -e "${GREEN}Install cscope & python success${NO_COLOR}"
    else
        echo -e "${RED}Install cscope & python failed${NO_COLOR}"
        exit 1
    fi

    # install compdb
    rm -rf ~/.cache/pip
    if pip install compdb; then
        echo -e "${GREEN}Install compdb success${NO_COLOR}"
    else
        echo -e "${RED}Install compdb failed${NO_COLOR}"
        exit 1
    fi

    # install node
    if curl -sL install-node.now.sh/lts | bash -s -- -y; then
        echo -e "${GREEN}Install Node.js success${NO_COLOR}"
    else
        echo -e "${RED}Install Node.js failed${NO_COLOR}"
        exit 1
    fi

    # install vim8
    cd /tmp/vim-ccls
    git clone https://github.com/vim/vim.git
    cd vim
    git checkout v8.2.1266
    cd src
    ./configure --enable-cscope --enable-largefile --enable-multibyte --enable-mzschemeinterp --enable-xim --enable-tclinterp=dynamic --enable-perlinterp=dynamic --enable-pythoninterp=yes --enable-python3interp=yes --with-python-command=python --enable-rubyinterp=dynamic --enable-luainterp=dynamic --enable-gui=no --enable-fontset --enable-terminal --with-features=huge
    make -j$(nproc)
    if make install; then
        echo -e "${GREEN}Install vim8 success${NO_COLOR}"
    else
        echo -e "${RED}Install vim8 failed${NO_COLOR}"
        exit 1
    fi

    # install gtags
    cd /tmp/vim-ccls
    wget --no-check-certificate https://tamacom.com/global/global-6.6.4.tar.gz
    tar -zxvf global-6.6.4.tar.gz
    cd global-6.6.4
    ./configure
    make -j$(nproc)
    if make install; then
        echo -e "${GREEN}Install gtags success${NO_COLOR}"
    else
        echo -e "${RED}Install gtags failed${NO_COLOR}"
        exit 1
    fi

    exit 0
}

RED="$(tput setaf 1 2>/dev/null || echo '')"
GREEN="$(tput setaf 2 2>/dev/null || echo '')"
NO_COLOR="$(tput sgr0 2>/dev/null || echo '')"

export -f install
echo -e "${RED}Please input the root password:${NO_COLOR}"
su root -c install || exit 1

# make iProxy and vim8 available
source /etc/profile
source /etc/bashrc
source ~/.bashrc

# vim config
cd
if [ -d .vim_runtime ]; then
    cd .vim_runtime
    git pull
else
    git clone https://github.com/shandianling/vimrc.git .vim_runtime
fi

cd ~/.vim_runtime
if ./install.sh; then
    echo -e "${GREEN}Install vim configuration success${NO_COLOR}"
    echo -e "${GREEN}Enjoy!${NO_COLOR}"
else
    echo -e "${RED}Install vim configuration failed${NO_COLOR}"
fi


#~/.vim/plugged/vim-tcpp/bin/ccls --index=. --init='{"clang":{"extraArgs": ["--gcc-toolchain=/usr"], "resourceDir": "/data/home/wallenwang/.vim/plugged/vim-tcpp/clang"}}'
