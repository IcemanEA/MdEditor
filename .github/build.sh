curl -Ls https://install.tuist.io | bash 
tuist install 13.6 
cd ..
tuist fetch
tuist generate
xcodebuild clean -quiet
xcodebuild build-for-testing \
    -workspace 'MdEditor.xcworkspace' \
    -scheme 'MdEditor' \
    -destination 'platform=iOS Simulator,name=iPhone 14'