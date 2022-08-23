package buildmod

import "github.com/coming-chat/wallet-SDK/core/aptos"

var A int

func init() {
	A = aptos.MaxGasAmount
}

type T struct {
}
