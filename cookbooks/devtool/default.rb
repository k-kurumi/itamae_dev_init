# 開発に必要そうなツール一式

execute "apt-get update" do
  user node.user
  command <<-EOL
    sudo apt-get update
  EOL
end

# bcはfishの補完に必要らしい
%W(
  bc
  vim
  build-essential
  exuberant-ctags
  curl
  wget
  w3m
  zsh
  tree
  trash-cli
  mosh
  parallel
  renameutils
  p7zip-full
  unzip
  libmysqlclient-dev
  libsqlite3-dev
  sqlite3
  aptitude
  shellcheck
).each do |pkg|
  package pkg
end

# git
%W(
  tcl
  gettext
  libcurl4-openssl-dev
).each do |pkg|
  package pkg
end

execute "install git" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    wget https://www.kernel.org/pub/software/scm/git/git-2.13.0.tar.gz
    tar zxvf git-2.13.0.tar.gz
    cd git-2.13.0
    ./configure
    make
    sudo make install
  EOL

  not_if "test -e /usr/local/bin/git"
end

# tigより見やすいツリー表示
execute "install git-foresta" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    wget https://github.com/takaaki-kasai/git-foresta/raw/master/git-foresta
    chmod +x git-foresta
    sudo mv git-foresta /usr/local/bin
  EOL

  not_if "test -e /usr/local/bin/git-foresta"
end

# rg
execute "install ripgrep" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    wget https://github.com/BurntSushi/ripgrep/releases/download/0.5.2/ripgrep-0.5.2-x86_64-unknown-linux-musl.tar.gz
    tar zxvf ripgrep-0.5.2-x86_64-unknown-linux-musl.tar.gz
    chmod +x ripgrep-0.5.2-x86_64-unknown-linux-musl/rg
    sudo mv ripgrep-0.5.2-x86_64-unknown-linux-musl/rg /usr/local/bin
  EOL

  not_if "test -e /usr/local/bin/rg"
end

# pt
execute "install the_platinum_searcher" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    wget https://github.com/monochromegane/the_platinum_searcher/releases/download/v2.1.5/pt_linux_amd64.tar.gz
    tar zxvf pt_linux_amd64.tar.gz
    chmod +x pt_linux_amd64/pt
    sudo mv pt_linux_amd64/pt /usr/local/bin
  EOL

  not_if "test -e /usr/local/bin/pt"
end

# jq
execute "install jq" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq
    chmod +x jq
    sudo mv jq /usr/local/bin
  EOL

  not_if "test -e /usr/local/bin/jq"
end

# tmux
%W(
  libevent-dev
  libncurses5-dev
).each do |pkg|
  package pkg
end

execute "install tmux" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    wget https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz
    tar zxvf tmux-2.5.tar.gz
    cd tmux-2.5
    ./configure
    make
    sudo make install
  EOL

  not_if "test -e /usr/local/bin/tmux"
end

# tig
%W(
  libncursesw5
  libncursesw5-dev
).each do |pkg|
  package pkg
end

execute "install tig" do
  user node.user
  cwd "/tmp"

  # 2バイト文字対応のためconfigureが必要
  command <<-EOL
    wget https://github.com/jonas/tig/releases/download/tig-2.2.2/tig-2.2.2.tar.gz
    tar zxvf tig-2.2.2.tar.gz
    cd tig-2.2.2
    LDLIBS=-lncursesw CPPFLAGS=-DHAVE_NCURSESW_CURSES_H ./configure
    make
    sudo make install
  EOL

  not_if "test -e /usr/local/bin/tig"
end

# vim
%W(
  python-dev
  ruby-dev
  luajit
  liblua5.2-dev
).each do |pkg|
  package pkg
end

execute "install vim" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    git clone https://github.com/vim/vim.git
    cd vim
    ./configure \
      --prefix=/usr/local \
      --with-features=huge \
      --enable-multibyte \
      --enable-pythoninterp=yes \
      --enable-rubyinterp=yes \
      --enable-luainterp=yes \
      --enable-cscope \
      --enable-gpm \
      --enable-cscope \
      --enable-fail-if-missing
    make
    sudo make install
  EOL

  not_if "test -e /usr/local/bin/vim"
end

execute "install vim-plug" do
  user node.user
  command <<-EOL
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  EOL

  not_if "test -e ~/.vim/autoload/plug.vim"
end

# cf
execute "install cf" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx
    sudo mv cf /usr/local/bin
  EOL

  not_if "test -e /usr/local/bin/cf"
end

# direnv
execute "install direnv" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    wget https://github.com/direnv/direnv/releases/download/v2.11.3/direnv.linux-amd64 -O direnv
    chmod +x direnv
    sudo mv direnv /usr/local/bin
  EOL

  not_if "test -e /usr/local/bin/direnv"
end

# massren(rename tool)
# 最新版はソースのみ提供されていてgolangがないとコンパイルできない
# バイナリがあるバージョンをインストールしている
execute "install massren" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    curl -L https://github.com/laurent22/massren/releases/download/v1.3.0/massren.linux-amd64.tar.gz | tar zx
    sudo mv massren /usr/local/bin
  EOL

  not_if "test -e /usr/local/bin/massren"
end

execute "install peco" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    wget https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_amd64.tar.gz
    tar zxvf peco_linux_amd64.tar.gz
    sudo mv peco_linux_amd64/peco /usr/local/bin
  EOL

  not_if "test -e /usr/local/bin/peco"
end

# # fish(oh-my-fishは対話型のインストーラのためレシピ化できない)
# # omfはdotfilesから手動でインストールする
# execute "install fish" do
#   user node.user
#   command <<-EOL
#     sudo apt-add-repository -y ppa:fish-shell/release-2
#     sudo apt-get update
#     sudo apt-get install -y fish

#     sudo chsh -s /usr/local/bin/fish #{node.user}
#   EOL

#   not_if "test -e /usr/local/bin/fish"
# end

# zsh関連
execute "git clone prezto" do
  user node.user
  cwd "/home/#{node.user}"
  command <<-EOL
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  EOL

  not_if "test -e ~/.zprezto"
end

execute "git clone dotfiles" do
  user node.user
  cwd "/home/#{node.user}"
  command <<-EOL
    git clone https://github.com/k-kurumi/dotfiles.git
  EOL

  not_if "test -e ~/dotfiles"
end
