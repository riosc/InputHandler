//
// InputHandler.h
//
// Copyright (c) 2015 Carlos Rios
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * CRInputHandler is a UI Helper class that facilitates the re-location (if needed) of inputs texts like
 * `UITextField` and `UITextView` in iOS applications. If have worked with forms in iOS
 * aplications before, you could note that sometimes the iOS keyboard overlap the 
 * input text making a little painful the user experience. So this
 * class helps you to keep always visible the input when it is on focus.
 * Also this class manages the user tap actions outside input text views to hide 
 * the keyboard.
 * 
 * This class works observing the events of `UITextField` and `UITextView` classes,
 * so it does not override any delegate method of these UIKit Component.
 *
 * ## How to use it
 *
 * You should put your inputs inside a `UIScrollView` and use the `-(id)initWithContainer:`
 * to init the class. Your view herarchy should  looks similar like this:
 * 
 * UIView
 * |-UIScrollView
 * | |--UITextField
 * | |--UITextView
 * |--
 *
 * The main goals is set the inputs views inside UIScrollView container.
 *
 */
@interface CRInputHandler : NSObject

/**
 *  Init a CRInputHandler class with a container.
 *
 *  @param container UIScrollview that contains a inputs text elements
 *
 *  @return CRInputHandler instance
 */
- (id) initWithContainer:(UIScrollView *)container;

/**
 * Register the `UITextField` or `UITextView` elements to be re-located when these are on
 * focus. This methods does not keep strong references to `fields` array of inputs and ignores
 * elements distints to these input classes.
 *
 *  @param fields A NSArray containing all inputs to be registered
 */
- (void) setFields:(NSArray *)fields;

@end
