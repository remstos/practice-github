
# Practice Repository app

Project made to practice for interview, and honestly get back to Swift
The goal is to make an app that allows users to search for issues on selected Github repositories.

## Development Setup
> __This project is written in Swift 5 and Xcode 11 is required for development.__

Before you begin, you should already have the Xcode downloaded and set up correctly. You can find a guide on how to do this here: [Setting up Xcode](https://developer.apple.com/xcode/)

##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Steps to install Cocoapods (one time installation)

- Run `sudo gem install cocoapods` to install the latest version of cocoapods. To install cocoapods from HomeBrew, `brew install cocoapods`.

## Setting up the iOS Project

1. Download the project source. You can do this either by cloning the repository 
```
$ git clone https://github.com/kemcake/practice-github.git
```

2. Navigate to the unzipped folder and run `pod install`.

3. Open `PracticeGithub.xcworkspace` from the folder.

4. Run the app (⌘+R).and test it.


## What's included
- Manage a list of Github repositories added from the url.
- List the current open issues for a repository.
- Simple text search through the issues.

## What could be improved
- Verify that the url entered by the user is a correct github repo
- Add logging for Storage and Networking events
- UnitTests of Storage and Networking architecture
- Better UI / design.
