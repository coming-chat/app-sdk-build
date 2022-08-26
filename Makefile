VERSION=`git describe --tags --dirty`
DATE=`date +%FT%T%z`

outdir=out

moduleWallet=github.com/coming-chat/wallet-SDK
pkgWalletCore = ${moduleWallet}/core
pkgBase = ${pkgWalletCore}/base
pkgWallet = ${pkgWalletCore}/wallet
pkgPolka = ${pkgWalletCore}/polka
pkgBtc = ${pkgWalletCore}/btc
pkgEth =  $(pkgWalletCore)/eth
pkgCosmos =  $(pkgWalletCore)/cosmos
pkgDoge =  $(pkgWalletCore)/doge
pkgSolana = ${pkgWalletCore}/solana
pkgAptos = ${pkgWalletCore}/aptos
pkgMSCheck = ${pkgWalletCore}/multi-signature-check

moduleDefi=github.com/coming-chat/go-defi-sdk
moduleCrossswap = ${moduleDefi}/core/crossswap
pkgExecution = ${moduleCrossswap}/execution
pkgService = ${moduleCrossswap}/service
pkgTypes = ${moduleCrossswap}/types
pkgUtil = ${moduleDefi}/util


aptosModule=github.com/coming-chat/go-aptos
pkgAptosClient=${aptosModule}/aptosclient

moduleRedpacket=github.com/coming-chat/go-red-packet
pkgRedpacket=${moduleRedpacket}/redpacket


pkgAll = ${pkgBase} ${pkgWallet} ${pkgPolka} ${pkgBtc} ${pkgEth} ${pkgCosmos} ${pkgDoge} ${pkgSolana} ${pkgAptos} ${pkgMSCheck} ${pkgUtil} ${pkgExecution} ${pkgService} ${pkgTypes} ${pkgAptosClient} ${pkgRedpacket}

iosSdkName=Wallet
andSdkName=wallet
iosZipName=wallet-SDK-ios
andZipName=wallet-SDK-android

#### android build

buildAllSDKAndroid:
	gomobile bind -ldflags "-s -w" -target=android/arm,android/arm64 -o=${outdir}/${andSdkName}.aar ${pkgAll}

androidReposity=${outdir}/wallet-sdk-android
androidPublicVersion:
ifndef v
	@echo 发布 android 包需要指定一个版本，例如 make androidPublishVersion v=0.1.3
	@exit 1
endif
	@cd ${androidReposity} \
		&& rm -rf library/libs/* \
		&& cp ../${andSdkName}.aar library/libs \
		&& cp ../${andSdkName}-sources.jar library/libs \
		&& git add --all \
		&& git commit -m 'Auto Publish ${v}' -m "refer to `git rev-parse HEAD`" \
		&& git tag -f ${v} \
		&& git push origin main tag ${v} --force

buildAndPublicAndroidVersion:
ifndef v
	@echo 发布 android 包需要指定一个版本，例如 make androidPublishVersion v=0.1.3
	@exit 1
endif
	@make buildAllSDKAndroid
	@make androidPublicVersion ${v}

#### android build

#### IOS build

buildAllSDKIOS:
	GOOS=ios gomobile bind -ldflags "-s -w" -target=ios  -o=${outdir}/${iosSdkName}.xcframework ${pkgAll}

iosPackageName=${iosSdkName}.xcframework
iosReposity=${outdir}/Wallet-iOS
iosCopySdk:
	@cd ${iosReposity} \
		&& rm -rf Sources/* \
		&& cp -Rf ../${iosPackageName} Sources \
		&& cp -Rf ../${iosPackageName}/ios-arm64/Wallet.framework/Versions/A/Headers Sources

iosPublishVersion:
ifndef v
	@echo 发布 iOS 包需要指定一个版本，例如 make publishIOSVersion v=1.0.1
	@exit 1
endif
	@make iosCopySdk
	@cd ${iosReposity} \
		&& git add --all \
		&& git commit -m 'Auto Publish ${v}' -m "refer to `git rev-parse HEAD`" \
		&& git tag -f ${v} \
		&& git push origin main tag ${v} --force
	@make iosPublishMain

iosPublishMain:
	@make iosCopySdk
	@cd ${iosReposity} \
		&& rm -rf Sources/Wallet.xcframework/ios-arm64_x86_64-simulator \
		&& git add --all \
		&& git commit -m 'Auto Publish Develop SDK' \
		&& git push origin main

#### IOS build

