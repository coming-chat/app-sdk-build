package appsdkbuild

import (
	"github.com/coming-chat/go-defi-sdk/util"
	"github.com/coming-chat/go-red-packet/redpacket"
	"github.com/coming-chat/wallet-SDK/core/aptos"
	_ "golang.org/x/mobile/bind"
)

var A int
var B error
var C string

func init() {
	A = aptos.MaxGasAmount
	B = util.ErrAddress
	C = redpacket.AptosName
}

type T struct {
}
