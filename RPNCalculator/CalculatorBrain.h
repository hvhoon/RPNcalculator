//
//  CalculatorBrain.h
//  RPNCalculator
//
//  Created by Harish Hoon on 1/9/12.
//  Copyright (c) 2012 Soclivity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
- (void)pushOperand: (double)operand;
- (double)performOperation: (NSString *)operation;
- (void)emptyBrain;

@end
