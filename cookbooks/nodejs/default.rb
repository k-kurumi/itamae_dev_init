execute "install ndenv" do
  user node.user
  command <<-EOL
    git clone https://github.com/riywo/ndenv.git ~/.ndenv
    git clone https://github.com/riywo/node-build.git ~/.ndenv/plugins/node-build
  EOL

  not_if "test -e ~/.ndenv"
end
