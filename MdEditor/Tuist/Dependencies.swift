import ProjectDescription

let description = Dependencies(
	swiftPackageManager: [
		.remote(
			url: "https://github.com/layoutBox/PinLayout",
			requirement: .upToNextMajor(from: "1.10.4")
		)
	],
	platforms: [.iOS ]
)
