# "__ProjectName__"

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
