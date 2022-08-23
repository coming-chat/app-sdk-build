# app-sdk-build
Build all project into one sdk for app.

## 已使用的包名

> gomobile 打包时只保留了 package 路径的最后的报名作为对应 package 名称，比如包 `comingchat/core/aptos` 打包结果的包名为 `aptos`。
> 如果不同项目使用了相同的包名，则合在一起打包会失败。

包名 | 项目
---|---
aptos|wallet-sdk
base|wallet-sdk
btc|wallet-sdk
core|wallet-sdk
cosmos|wallet-sdk
crossswap|go-defi-sdk
doge|wallet-sdk
eth|wallet-sdk
execution|go-defi-sdk
multi-signature-check|wallet-sdk
polka|wallet-sdk
redpacket|go-red-packet
service|go-defi-sdk
solana|wallet-sdk
types|go-defi-sdk
util|go-defi-sdk
wallet|wallet-sdk


## 如何使用 Github Private 仓库 module

#### 1）添加环境变量
```sh
export GOPRIVATE=github.com/coming-chat/go-defi-sdk
```
多个 private 仓库可以使用逗号分隔
```sh
export GOPRIVATE=github.com/coming-chat/go-defi-sdk,github.com/coming-chat/xx
```
也可以指定到 github username，则此 username 下的包都会从 github 直接拉取
```sh
export GOPRIVATE=github.com/coming-chat
```
或者整个所有 github.com 下的包都从 github 直接拉取
```sh
export GOPRIVATE=github.com
```

#### 2）配置访问权限

有两种访问权限配置方式：ssh 和 账号密码

ssh 方式（推荐）:
```sh
vi ~/.gitconfig
```
修改为
```
[user]
	email = your_github_username@example.com
	name = Sammy the Shark
	
[url "ssh://git@github.com/"]
	insteadOf = https://github.com/
```

密码方式：
```sh
vi ~/.netrc
```

修改为:
```
machine github.com
login your_github_username
password your_github_access_token
```