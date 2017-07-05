//
//  CalculatorBrain.m
//  Calculator
//
//  Created by lugongyu on 2017/6/27.
//  Copyright © 2017年 lugongyu. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain

@synthesize programStack = _programStack;


- (NSMutableArray *)operandStack
{
    if (_programStack == nil) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

- (void)setOperandStack:(NSMutableArray *)operandStack
{
    _programStack = operandStack;
}

- (void)pushOperand:(double)operand{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
    
}

-(double)popOperand
{
    NSNumber *operandObject = [self.programStack lastObject];
    if (operandObject  != nil) {
        [self.operandStack removeLastObject];
        
    }
    return  [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation{
    [self.operandStack addObject:operation];
    
    return [[self class] runProgram:self.operandStack];
}

- (void)clearAll{
    [self.operandStack removeAllObjects];
    return;
}

- (NSString *)descriptionOfProgram:(id)program
{
    NSString *textResult = @"";
    if ([program isKindOfClass:[NSArray class]]) {
        for (id someting in program)
        {
            NSString *tempStr = [[NSString alloc] initWithFormat:@"%@", someting];
            textResult = [textResult stringByAppendingString:tempStr];
        }
    }
    return textResult;
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffProgramStack:stack] +
            [self popOperandOffProgramStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffProgramStack:stack] *
            [self popOperandOffProgramStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double subtrahend = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] - subtrahend;
        } else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffProgramStack:stack];
            if (divisor) result = [self popOperandOffProgramStack:stack] / divisor;
        } else if ([operation isEqualToString:@"sin"]){
            result = sin([self popOperandOffProgramStack:stack]);
        }else if ([operation isEqualToString:@"cos"]){
            result = cos([self popOperandOffProgramStack:stack]);
        }else if ([operation isEqualToString:@"sqt"]){
            result = sqrt([self popOperandOffProgramStack:stack]);
        }else if ([operation isEqualToString:@"log"]){
            result = log([self popOperandOffProgramStack:stack]);
        }
    }
    
    return result;
}

-(id)program{
    
    return [self.programStack copy];
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffProgramStack:stack];
}
@end
