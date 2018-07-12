FROM debian:jessie
RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

RUN \
  pip install awsebcli awscli --upgrade

# install some additional dev tools desired or required
# we install vim-python-jedi instead of just vim to get python env required fsharp-vim plugin
RUN apt-get update -y && \
    apt-get --no-install-recommends install -yq apt-utils && \
    apt-get --no-install-recommends install -yq vim-python-jedi man less ctags wget curl git subversion ssh-client make unzip

#RUN curl -sL https://deb.nodesource.com/setup_8.x -o /nodesource_setup.sh && chmod +x /nodesource_setup.sh && /nodesource_setup.sh && apt-get install nodejs && apt-get install build-essential
#
#RUN npm install npm@latest -g
#RUN npm install gulp -g

# set up dnvim user with uid 1000 to (hopefully) match host uid
RUN useradd --shell /bin/bash -u 1000 -o -c "" -m dnvim

# set .bashrc and .vimrc (not .vimrc sets up fsharp-vim plugin using vim-plug system))
RUN mkdir /dnvim && chown dnvim /dnvim/ -R
WORKDIR /home/dnvim
COPY .bashrc .
COPY .vimrc .
#RUN mkdir /home/dnvim/host
RUN chown dnvim /home/dnvim/ -R
USER dnvim

# install vim-plug and run setup 
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN vim +PlugInstall +qall

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
ENV NVM_DIR /home/dnvim/.nvm
RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm install 6.10.0

WORKDIR /dnvim/host
CMD ["/bin/bash"]
