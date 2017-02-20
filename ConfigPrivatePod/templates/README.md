# __ProjectName__

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

You can install it with the following command:

```bash
$ [sudo] gem install cocoapods
```

To integrate __ProjectName__ into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source '__SpecsRepo__'
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target <Your Target Name> do
	use_frameworks!
    pod '__ProjectName__', '~> 1.0.0'
end
```

Then, run the following command:

```bash
$ pod install
```


