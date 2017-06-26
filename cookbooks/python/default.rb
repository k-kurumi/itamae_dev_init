%W(
  make
  build-essential
  libssl-dev
  zlib1g-dev
  libbz2-dev
  libreadline-dev
  libsqlite3-dev
  wget
  curl
  llvm
).each do |pkg|
  package pkg
end

execute "install pyenv and pyenv-virtualenv" do
  user node.user
  command <<-EOL
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
    git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
  EOL

  not_if "test -d ~/.pyenv"
end
