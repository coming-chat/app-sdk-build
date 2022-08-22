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
