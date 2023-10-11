import ProjectDescription

let description = Dependencies(
	swiftPackageManager: SwiftPackageManagerDependencies(
		[
			.remote(
				url: "https://github.com/layoutBox/PinLayout",
				requirement: .upToNextMajor(from: "1.10.4")
			)
		],
		targetSettings: ["PinLayout": ["IPHONEOS_DEPLOYMENT_TARGET": "14.0"]]
	),
	platforms: [.iOS ]
)
