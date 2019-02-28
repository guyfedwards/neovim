FROM alpine:latest

RUN apk add --no-cache \
  neovim \
  python3 \
  git \
  the_silver_searcher \
  fzf \
  curl \
  bash \
  sed \
  cmake \
  gcc

RUN pip3 install neovim

ENV XDG_CONFIG_HOME=/root/.config
WORKDIR /root
# clone dotfiles & link vimrc
RUN git clone --depth=1 https://github.com/guyfedwards/dotfiles
# RUN sed -i -e '19d' dotfiles/.vimrc
# RUN ls -la $XDG_CONFIG_HOME/nvim/init.vim
# RUN mkdir $XDG_CONFIG_HOME && ./dotfiles/setup/neovim
RUN mkdir $XDG_CONFIG_HOME && \
  ln -s ~/dotfiles/.vim/ "$XDG_CONFIG_HOME/nvim" \
  && rm -f "$XDG_CONFIG_HOME/nvim/init.vim" \
  && ln -snf ~/dotfiles/.vimrc "$XDG_CONFIG_HOME/nvim/init.vim"

# RUN mkdir $XDG_CONFIG_HOME && ln -s /root/dotfiles/.vim $XDG_CONFIG_HOME/nvim
# RUN mkdir $XDG_CONFIG_HOME && mkdir $XDG_CONFIG_HOME/nvim && ln -s /root/dotfiles/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
# install vim-plug
RUN curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim +PlugInstall +qall


CMD ["nvim"]
