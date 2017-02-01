# fish-shellとndenvは相性が悪いためnodebrewを使う
execute "install nodebrew" do
  user node.user
  command <<-EOL
    curl -L git.io/nodebrew | perl - setup
  EOL

  not_if "test -e ~/.nodebrew"
end
