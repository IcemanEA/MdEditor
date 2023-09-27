curl -Ls https://install.tuist.io | bash 
tuist install 3.27.1
cd ..
ls -a
tuist fetch
tuist generate
xcodebuild clean -quiet
xcodebuild test-without-building \
    -workspace 'MdEditor.xcworkspace' \
    -scheme 'MdEditorTests' \
    -destination 'platform=iOS Simulator,name=iPhone 14'