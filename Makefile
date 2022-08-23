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

moduleRedpacket=github.com/coming-chat/go-red-packet
pkgRedpacket=${moduleRedpacket}/redpacket

moduleT=github.com/coming-chat/app-build
pkgBuildMod=${moduleT}/buildmod

pkgAll = ${pkgBase} ${pkgWallet} ${pkgPolka} ${pkgBtc} ${pkgEth} ${pkgCosmos} ${pkgDoge} ${pkgSolana} ${pkgAptos} ${pkgMSCheck} ${pkgUtil} ${pkgExecution} ${pkgService} ${pkgTypes} ${pkgRedpacket} ${pkgBuildMod}

iosSdkName=Wallet
andSdkName=wallet
iosZipName=wallet-SDK-ios
andZipName=wallet-SDK-android

buildAllSDKAndroid:
	gomobile bind -ldflags "-s -w" -target=android/arm,android/arm64 -o=${outdir}/${andSdkName}.aar ${pkgAll}

androidPublishVersion:
ifndef v
	@echo 发布 android 包需要指定一个版本，例如 make androidPublishVersion v=0.1.3
	@exit 1
endif
	@make buildAllSDKAndroid
	@cd ${outdir} && mkdir ${andZipName}.${v} && mv -f wallet.aar wallet-sources.jar ${andZipName}.${v}
	@cd ${outdir} && zip -ry ${andZipName}.${v}.zip ${andZipName}.${v}

iosPackageName=${iosSdkName}.xcframework
iosReposity=${outdir}/Wallet-iOS
iosCopySdk:
	@cd ${iosReposity} \
		&& rm -rf Sources/* \
		&& cp -Rf ../${iosPackageName} Sources \
		&& cp -Rf ../${iosPackageName}/ios-arm64/Wallet.framework/Versions/A/Headers Sources

iosPublishMain:
	@make iosCopySdk
	@cd ${iosReposity} \
		&& rm -rf Sources/Wallet.xcframework/ios-arm64_x86_64-simulator \
		&& git add --all \
		&& git commit -m 'Auto Publish Develop SDK' \
		&& git push origin main


build:
ifndef v
	@echo 需要指定一个版本，例如 make build v=0.1.3
	@exit 1
endif
# check sdk versions
	@read -p "wallet-sdk version(branch|tag|commithash):" tag; \
	go get github.com/coming-chat/wallet-SDK@$$tag
	@read -p "go-defi-sdk version(branch|tag|commithash):" tag; \
	go get github.com/coming-chat/go-defi-sdk@$$tag
	@read -p "go-red-packet version(branch|tag|commithash):" tag; \
	go get github.com/coming-chat/go-red-packet@$$tag

	# rm -rf ${outdir}/*

# build and zip android pkg
	@make buildAllSDKAndroid
	@cd ${outdir} && mkdir ${andZipName}.${v} && mv -f wallet.aar wallet-sources.jar ${andZipName}.${v}
	@cd ${outdir} && zip -ry ${andZipName}.${v}.zip ${andZipName}.${v}
	@cd ${outdir} && open .

# build and zip ios pkg; public ios xcframework to lib repo
	@cd ${outdir} && rm -f wallet-SDK-*.zip && rm -rf ${andZipName}.${v}
	@make buildAllSDKIOS
	@cd ${outdir} && zip -ry ${iosZipName}.${v}.zip Wallet.xcframework
	@make iosCopySdk
	@cd ${iosReposity} \
		&& git add --all \
		&& git commit -m 'Auto Publish ${v}' -m "refer to `git rev-parse HEAD`" \
		&& git tag -f ${v} \
		&& git push origin main tag ${v} --force
	@make iosPublishMain

	


	