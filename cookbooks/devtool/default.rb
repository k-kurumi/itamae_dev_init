# 開発に必要そうなツール一式

execute "apt-get update" do
  user node.user
  command <<-EOL
    sudo apt-get update
  EOL
end

%W(
  vim
  build-essential
  git
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
).each do |pkg|
  package pkg
end

# rg
execute "install ripgrep" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    wget https://github.com/BurntSushi/ripgrep/releases/download/0.2.5/ripgrep-0.2.5-x86_64-unknown-linux-musl.tar.gz
    tar zxvf ripgrep-0.2.5-x86_64-unknown-linux-musl.tar.gz
    sudo mv ripgrep-0.2.5-x86_64-unknown-linux-musl/rg /usr/local/bin
  EOL

  not_if "test -e /usr/local/bin/rg"
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
    wget https://www.kernel.org/pub/software/scm/git/git-2.10.2.tar.gz
    tar zxvf git-2.10.2.tar.gz
    cd git-2.10.2
    ./configure
    make
    sudo make install
  EOL

  not_if "test -e /usr/local/bin/git"
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
    wget https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz
    tar zxvf tmux-2.3.tar.gz
    cd tmux-2.3
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
  command <<-EOL
    wget https://github.com/jonas/tig/releases/download/tig-2.2/tig-2.2.tar.gz
    tar zxvf tig-2.2.tar.gz
    cd tig-2.2
    make configure
    LDLIBS=-lncursesw CFLAGS=-I/usr/include/ncursesw ./configure --prefix=/usr/local
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
    wget https://github.com/direnv/direnv/releases/download/v2.9.0/direnv.linux-amd64 -O direnv
    chmod +x direnv
    sudo mv direnv /usr/local/bin
  EOL

  not_if "test -e /usr/local/bin/direnv"
end

# massren(rename tool)
execute "install massren" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    curl -L https://github.com/laurent22/massren/releases/download/v1.3.0/massren.linux-amd64.tar.gz | tar zx
    sudo mv massren /usr/local/bin
  EOL

  not_if "test -e /usr/local/bin/massren"
end
