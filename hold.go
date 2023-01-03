// 此文件不会被编译到 sdk，主要是用作引用其他项目，方式 go mod tidy 删掉 mod 引用
package appsdkbuild

import (
	"github.com/coming-chat/go-defi-sdk/util"
	"github.com/coming-chat/go-dmens-sdk/dmens"
	"github.com/coming-chat/go-red-packet/redpacket"
	"github.com/coming-chat/wallet-SDK/core/aptos"
	_ "golang.org/x/mobile/bind"
)

var A int
var B error
var C string
var DmensAction int

func init() {
	A = aptos.MaxGasAmount
	B = util.ErrAddress
	C = redpacket.AptosName
	DmensAction = dmens.ACTION_POST
}

type T struct {
}
