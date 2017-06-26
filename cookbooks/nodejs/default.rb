execute "install ndenv" do
  user node.user
  command <<-EOL
    git clone https://github.com/riywo/ndenv ~/.ndenv
    git clone https://github.com/riywo/node-build.git ~/.ndenv/plugins/node-build
  EOL

  not_if "test -d ~/.ndenv"
end
