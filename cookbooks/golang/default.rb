execute "install golang" do
  user node.user
  command <<-EOL
    cd /tmp
    wget https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz
    tar zxvf go1.7.4.linux-amd64.tar.gz -C ~
  EOL

  not_if "test -e ~/go"
end
