%W(
  autoconf
  bison
  build-essential
  libssl-dev
  libyaml-dev
  libreadline6-dev
  zlib1g-dev
  libncurses5-dev
  libffi-dev
  libgdbm3
  libgdbm-dev
).each do |pkg|
  package pkg
end

execute "install rbenv and ruby-build" do
  user node.user
  command <<-EOL
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  EOL

  not_if "test -e ~/.rbenv"
end
