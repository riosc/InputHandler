//
//  CRViewController.m
//  InputHandler
//
//  Created by Carlos Rios on 01/07/2015.
//  Copyright (c) 2014 Carlos Rios. All rights reserved.
//

#import "CRViewController.h"
#import "CRInputHandler.h"

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
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) trySignUp
{
    NSLog(@"Sign Up!");
}


#pragma mark -- UITextField Delegate

//handle the return key behaviour inside a UITexfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == birthdayTF) [self trySignUp];
    id next = [self nextInputFromInput:textField];
    if (next) [next becomeFirstResponder];
    
    return YES;
}

//selects the next fields from @param input
- (id) nextInputFromInput:(id)input
{
    NSUInteger index = [_allInputs indexOfObject:input];
    return (index < _allInputs.count - 1) ? _allInputs[index + 1] : nil;
}


#pragma mark -- UITextView Delegate

- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    //detecs when user press return key inside a UITextView, this is a hack
    if([text isEqualToString:@"\n"]) {
        id next = [self nextInputFromInput:textView];
        if (next) [next becomeFirstResponder];
        return NO;
    }
    
    return YES;
}
@end