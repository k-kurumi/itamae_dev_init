execute "install golang" do
  user node.user
  cwd "/tmp"
  command <<-EOL
    wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
    tar zxvf go1.8.3.linux-amd64.tar.gz -C ~
  EOL

  not_if "test -d ~/go"
end
