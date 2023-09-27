curl -Ls https://install.tuist.io | bash 
tuist install 3.27.1
cd MdEditor
ls -a
tuist fetch
tuist generate
xcodebuild clean -quiet
xcodebuild build-for-testing \
    -workspace 'MdEditor.xcworkspace' \
    -scheme 'MdEditor' \
    -destination 'platform=iOS Simulator,name=iPhone 14'