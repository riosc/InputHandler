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

#import "CRInputHandler.h"

#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)

@interface CRInputHandler()<UIGestureRecognizerDelegate>
{
    CGRect keyboardRect;
}

@property (nonatomic, weak) UIScrollView * scrollView;
@property (nonatomic, weak) UIView * rootView;
@property (nonatomic, assign) CGPoint scrollOffSet;
@property (nonatomic, weak) UIView * current;
@property (nonatomic, assign, getter = keyboardIsOpen) BOOL keyboardOpen;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, weak) NSMutableArray * inputs;

@end

@implementation CRInputHandler

- (id) initWithContainer:(UIScrollView *)scroll
{
    self = [super init];
    
    if (self) {
        _scrollView     = scroll;
        _rootView       = [self rootView:_scrollView];
        _keyboardPaddingTop = 100.f;
        _windowPaddingTop   = 50.0f;
        [self setup];
    }
    
    return self;
}

#pragma mark -- setup methods


- (void) setup
{
    [self addTapRecognizer];
    [self registerKeyboardNotifications];
}

/*
 * A    
 */
- (void) addTapRecognizer
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTapped)];
    [tap setDelegate:self];
    [_rootView addGestureRecognizer:tap];
}


- (void) screenTapped
{
    [_scrollView endEditing:YES];
}

- (void) setFields:(NSArray *)fields
{
    for (id view in fields) [self addObserversToInputView:view];
}

/*
 * Find the container view of whole elements
 */
- (UIView *)rootView:(UIView *)subView
{
    return (subView.superview != nil) ? [self rootView:subView.superview] : subView;
}

- (void) addObserversToInputView:(id)view
{
    if ([view isKindOfClass:[UITextView class]]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:view];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:)   name:UITextViewTextDidEndEditingNotification object:view];
        
    }else if ([view isKindOfClass:[UITextField class]]){
        [view addTarget:self action:@selector(inputDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
        [view addTarget:self action:@selector(inputDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    }
}

#pragma mark -- UITextView Obervers Methods

- (void)textViewDidEndEditing:(NSNotification *)notification
{
    _current = nil;
}

- (void)textViewDidBeginEditing:(NSNotification *)notification
{
    UITextView * sender = [notification object];
    [self setOffsetAccordingView:sender];
    _current            = sender;
}

#pragma mark -- UITextField Observer Methods

- (void)inputDidEndEditing:(id)sender
{
    _current = nil;
}

- (void)inputDidBeginEditing:(id)sender
{
    if (_keyboardOpen) [self setOffsetAccordingView:sender];
    _current = sender;
}


#pragma mark -- UIKeyboard Observer Methods

- (void)registerKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    _keyboardHeight = (_landscapeMode) ? CGRectGetWidth(keyboardRect) : CGRectGetHeight(keyboardRect);
    _keyboardHeight +=_keyboardPaddingTop;
    
    if(!_keyboardOpen) _scrollOffSet = [_scrollView contentOffset];
    [self setOffsetAccordingView:_current];
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    _keyboardOpen = YES;
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    [_scrollView setContentOffset:_scrollOffSet animated:YES];
}

- (void)keyboardDidHide:(NSNotification*)notification
{
    _keyboardOpen = NO;
}

- (void) setOffsetAccordingView:(UIView *)view
{
    
    CGFloat yPosKeyboard            = ((_landscapeMode) ? SCREEN_WIDTH : SCREEN_HEIGHT) - _keyboardHeight;
    CGPoint inputPositionOnScreen   = [view.superview convertPoint:view.frame.origin toView:_rootView];
    
    CGFloat yPosBottomInput         = inputPositionOnScreen.y + view.frame.size.height;
    
    if (yPosBottomInput > yPosKeyboard)
    {
        CGFloat requiredOffset      = yPosBottomInput  - yPosKeyboard;
        [_scrollView setContentOffset:CGPointMake(0, _scrollView.contentOffset.y + requiredOffset) animated:YES];
    }else if (yPosKeyboard - yPosBottomInput > _keyboardPaddingTop && _closinAtTop)
    {
        CGFloat offsetExtra = yPosKeyboard - yPosBottomInput - _windowPaddingTop;
        [_scrollView setContentOffset:CGPointMake(0, _scrollView.contentOffset.y - offsetExtra) animated:YES];
    }
}


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIGestureRecognizerDelegate methods

/*
 * This method of UIGestureDelegate cancel the screen tap when the keyboard is
 * hidden.
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch
{
    return _keyboardOpen;
}
@end
