# CRInputHandler

[![CI Status](http://img.shields.io/travis/Carlos Rios/InputHandler.svg?style=flat)](https://travis-ci.org/Carlos Rios/InputHandler)
[![Version](https://img.shields.io/cocoapods/v/InputHandler.svg?style=flat)](http://cocoadocs.org/docsets/InputHandler)
[![License](https://img.shields.io/cocoapods/l/InputHandler.svg?style=flat)](http://cocoadocs.org/docsets/InputHandler)
[![Platform](https://img.shields.io/cocoapods/p/InputHandler.svg?style=flat)](http://cocoadocs.org/docsets/InputHandler)

CRInputHandler is a UI Helper class that facilitates the re-location (if needed) of inputs texts like
`UITextField` and `UITextView` in iOS applications when it is on focus state. If have worked with forms in iOS
aplications before, you could note that sometimes the iOS keyboard overlap the 
input text making a little painful the user experience. So this
class helps you to keep always visible the input when it is on focus.
Also this class manages the user tap actions outside input text views to hide 
the keyboard.

This class works observing the events of `UITextField` and `UITextView` classes,
so it does not override any delegate method of these UIKit Component.

## Usage

You need to put your inputs texts inside a `UIScrollView` and use the `-(id)initWithContainer:`
to init the class. Your view herarchy should looks similar like this:

```
UIView
|-UIScrollView
| |--UITextField
| |--UITextView
|--

```

The main goals is set the inputs views inside UIScrollView container.

Code Example:
```Objective-C
@interface CRViewController ()
{
__weak IBOutlet UITextField * firstNameTF;
__weak IBOutlet UITextField * lastNameTF;
__weak IBOutlet UITextView * bioTV;
__weak IBOutlet UITextField * emailTF;
__weak IBOutlet UITextField * birthdayTF;

__weak IBOutlet UIScrollView * container;

}

@property (nonatomic, strong) CRInputHandler * inputHandler;
@property (nonatomic, strong) NSArray * allInputs;
@end

@implementation CRViewController

- (void)viewDidLoad {
[super viewDidLoad];

_allInputs      = @[firstNameTF, lastNameTF, bioTV, emailTF, birthdayTF];
_inputHandler   = [[CRInputHandler alloc] initWithContainer:container];
[_inputHandler setFields:_allInputs];

}
```
If you want take a look to Example project, so to run the example project, 
clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 7 or higher

## Installation

InputHandler is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "CRInputHandler"

## Author

Carlos Rios, rioscarlosd@gmail.com

## License

CRInputHandler is available under the MIT license. See the LICENSE file for more info.

