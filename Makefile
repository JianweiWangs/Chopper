build: install open
open: 
	open ./Example/Chopper.xcworkspace
install:
	pod install --project-directory=Example
clean:
	pod cache clean --all
quit:
	osascript -e 'quit app "Xcode"'
test:
	xcodebuild -scheme Chopper-Example -workspace Example/Chopper.xcworkspace -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone Xs,OS=12.1' build test
	
