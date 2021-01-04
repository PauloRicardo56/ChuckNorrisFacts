fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios tests
```
fastlane ios tests
```
Run all application tests (ui/unit)
### ios screenshots
```
fastlane ios screenshots
```
Generate new localized screenshots
### ios uitests
```
fastlane ios uitests
```
Run application ui tests
### ios unittests
```
fastlane ios unittests
```
Run application unit tests
### ios release
```
fastlane ios release
```
App Store deployment

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
