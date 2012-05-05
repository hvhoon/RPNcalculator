//
//  CalculatorBrain.m
//  RPNCalculator
//
//  Created by Harish Hoon on 1/9/12.
//  Copyright (c) 2012 Soclivity. All rights reserved.
//

#import "CalculatorBrain.h"
#import "math.h"


// These are my local commits to Calculatorbrain - Harish

// Private properties
@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

// Implementation
@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

// Getter for operandStack
- (NSMutableArray *)operandStack {
    // Check if the array has been initialized yet is not null
    if(!_operandStack)
        _operandStack = [[NSMutableArray alloc] init];
    
    return _operandStack;
}

// Method to add an operation to the stack
- (void)pushOperand:(double)operand {
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

// Method to pop an item off the stack
- (double) popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    
    // Remove the last object from the array
    if(operandObject) 
        [self.operandStack removeLastObject];
    
    return [operandObject doubleValue];
}

// Method to perform an operation
- (double)performOperation:(NSString *)operation {
    double result = 0;
    
    // Performing operations
    if ([operation isEqualToString:@"+"])
        result = [self popOperand] + [self popOperand];
    else if ([operation isEqualToString:@"*"])
        result = [self popOperand] * [self popOperand];
    else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }
    else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    }
    else if ([operation isEqualToString:@"sin"]) {
        result = sin(M_PI*([self popOperand]/180));
    }
    else if ([operation isEqualToString:@"cos"]) {
        result = cos(M_PI*([self popOperand]/180));
    }
    else if ([operation isEqualToString:@"sqrt"]) {
        result = sqrt([self popOperand]);
    }
    else if ([operation isEqualToString:@"π"]) {
        result = M_PI;
    }
    
    [self pushOperand:result];
    return result;
}

// Method to clear the operandStack
- (void)emptyBrain {
    [self.operandStack removeAllObjects];
}

@end
