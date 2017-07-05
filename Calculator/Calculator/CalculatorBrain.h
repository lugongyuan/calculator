//
//  CalculatorBrain.h
//  Calculator
//
//  Created by lugongyu on 2017/6/27.
//  Copyright © 2017年 lugongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
@property (nonatomic, strong) NSMutableArray *programStack;
@property (readonly) id program;

- (void)pushOperand:(double)operand;
-(double)popOperand;
- (double)performOperation:(NSString *)operation;
- (void)clearAll;

+ (double)runProgram:(id)program;
- (NSString *)descriptionOfProgram:(id)promram;

@end
