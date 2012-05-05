//
//  ViewController.m
//  RPNCalculator
//
//  Created by Harish Hoon on 12/29/11.
//  Copyright (c) 2011 Soclivity. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

// Making a change - Kanav

// Private properties
@interface ViewController()
@property (nonatomic) BOOL inTheMiddleOfTyping;
@property (nonatomic) BOOL DecimalEntered;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

// Implementation
@implementation ViewController
@synthesize display;
@synthesize log;
@synthesize inTheMiddleOfTyping;
@synthesize brain = _brain;

// Initializing the brain
- (CalculatorBrain *) brain 
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

// Action when any of the digits are pressed
- (IBAction)digitPressed:(UIButton *)sender 
{
    if(self.inTheMiddleOfTyping)
        self.display.text = [self.display.text stringByAppendingString:[sender currentTitle]];
    else {
        self.display.text = [sender currentTitle];
        self.inTheMiddleOfTyping = YES;
    }
}

// Action when the enter button is pressed
- (IBAction)enterPressed 
{
    if(self.inTheMiddleOfTyping)
    {
        [self.brain pushOperand:[self.display.text doubleValue]];
        self.inTheMiddleOfTyping = NO;
        self.DecimalEntered = NO;
        self.log.text = [self.log.text stringByAppendingString:self.display.text];
        self.log.text = [self.log.text stringByAppendingString:@" "];

    }
}

// Action when any of the operation buttons are pressed
- (IBAction)operationPressed:(UIButton *)sender 
{
    if(self.inTheMiddleOfTyping){
        [self enterPressed]; 
    }
    
    NSString *operation = [sender currentTitle];
    self.log.text = [self.log.text stringByAppendingString:[sender currentTitle]];
    
    self.log.text = [self.log.text stringByAppendingString:@" "];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

// Action when a decimal is pressed
- (IBAction)enterDecimal:(UIButton *)sender 
{
    if(!self.DecimalEntered) 
    {
        if(self.inTheMiddleOfTyping){
            self.display.text = [self.display.text stringByAppendingString:[sender currentTitle]];
        }
        else
        {
            self.display.text = [sender currentTitle];
            self.inTheMiddleOfTyping = YES;
        }
        self.DecimalEntered = YES;
    }
}

// Action when Zero is entered
- (IBAction)enterZero:(UIButton *)sender 
{
    if(self.inTheMiddleOfTyping){
        self.display.text = [self.display.text stringByAppendingString:[sender currentTitle]];
    }
    else {
        self.display.text = [sender currentTitle];
    }
}

// Action when the clear button is pressed
- (IBAction)clearPressed:(UIButton *)sender 
{
    self.inTheMiddleOfTyping = NO;
    self.DecimalEntered = NO;
    self.display.text = @"0";
    self.log.text = @"";
    [self.brain emptyBrain];
}
@end
