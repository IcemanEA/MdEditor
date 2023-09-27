curl -Ls https://install.tuist.io | bash 
tuist install 13.6 
tuist fetch
tuist generate
xcodebuild clean -quiet
xcodebuild test-without-building \
    -workspace 'MdEditor.xcworkspace' \
    -scheme 'MdEditorTests' \
    -destination 'platform=iOS Simulator,name=iPhone 14'