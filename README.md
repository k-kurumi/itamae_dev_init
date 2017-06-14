### usage

実行する
```
itamae ssh --vagrant --host default -y nodes/vagrant.yml roles/vagrant/default.rb
```

ロールを作る
```
itamae g role xxx
```

レシピを作る
```
itamae g cookbook xxx
```

----

### boxについて

原因は不明だが box の `ubuntu/xenial64` は、itamae適用後に `vagrant ssh` がパスワード認証になる。
また、ユーザが ubuntu となりvagrantの他boxと違っている。

bentoを使うとよい

```
vagrant init bento/ubuntu-16.04
```
