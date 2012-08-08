Imagine Alice
=============   

The game that uses the most powerful videochip - your imagination.  

## Building the game
Run in Terminal `git clone https://github.com/realf/imagine-alice.git`

If you do not have **ruby**, install developer tools from Xcode.  

If you do not have **CocoaPods**, you should install it, following the next steps:  
0. `sudo gem update --system` # We need this update to be able to install the latest CocoaPods.  
1. `sudo gem install cocoapods` # This is a nice app for dependency management.  

**To build the app**, type in Terminal:  
0. `pod install` # We use CocoaPods so we can properly update our dependencies now. It sets necessary targets, etc.  
1. `open Imagine Alice.xcworkspace` # Use it instead of open Imagine Alice.xcodeproj  
2. Build the app in Xcode, as usually.
