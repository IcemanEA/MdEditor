import ProjectDescription

let productName = "MdEditor"
let unitTestsName = "MdEditorTests"

let swiftLintScriptBody = "SwiftLint/swiftlint --fix && SwiftLint/swiftlint"
let swiftLintScript = TargetScript.post(
	script: swiftLintScriptBody,
	name: "SwiftLint",
	basedOnDependencyAnalysis: false
)

let baseSettings = SettingsDictionary()
	.currentProjectVersion("1")
	.marketingVersion("1.0")

let target = Target(
	name: productName,
	platform: .iOS,
	product: .app,
	productName: "MdEditor",
	bundleId: "IcemanEATeam.MdEditor",
	deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
	infoPlist: "MdEditor/Supporting Files/Info.plist",
	sources: ["MdEditor/Sources/**", "MdEditor/Shared/**"],
	resources: ["MdEditor/Resources/**"],
	scripts: [swiftLintScript],
	dependencies: [.external(name: "PinLayout")],
	settings: .settings(base: baseSettings)
)

let testTarget = Target(
	name: unitTestsName,
	platform: .iOS,
	product: .unitTests,
	bundleId: "IcemanEATeam.MdEditorTests",
	deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
	sources: ["MdEditorTests/Sources/**", "MdEditor/Shared/**"],
	dependencies: [
		.target(name: productName)
	]
)

let project = Project(
	name: "MdEditor",
	organizationName: "Ledkov Team",
	targets: [target, testTarget],
	schemes: [
		Scheme(
			name: productName,
			shared: true,
			buildAction: .buildAction(targets: ["MdEditor"]),
			testAction: .targets([ "MdEditorTests"]),
			runAction: .runAction(executable: "MdEditor")
		),
		Scheme(
			name: unitTestsName,
			shared: true,
			buildAction: .buildAction(targets: ["MdEditorTests"]),
			testAction: .targets([ "MdEditorTests"]),
			runAction: .runAction(executable: "MdEditorTests")
		)
	]
)
