# Profile

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

You can install it with the following command:

```bash
$ [sudo] gem install cocoapods
```

To integrate Profile into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/Limon-O-O/Lego.git'
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target <Your Target Name> do
	use_frameworks!
    pod 'Profile', '~> 1.0.0'
end
```

Then, run the following command:

```bash
$ pod install
```


