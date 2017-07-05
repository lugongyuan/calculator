//
//  ViewController.m
//  Calculator
//
//  learned by lugongyu on 2017/6/27.
//  copy form stadford ios lession.
//  Copyright © 2017年 lugongyu. All rights reserved.
//
/*从斯坦福大学IOS教程视频中学习的代码，主题框架和主要代码；
 
 todo：把此项目改造为中缀表达式 转换为后缀表达式，然后计算的代码，即：删除Enter按钮，更换为=按钮，做一个标准的计算器项目
 */

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
@property (nonatomic) BOOL userIsInTherMiddleOfEnteringANumber;
@property (nonatomic , strong) CalculatorBrain *brain;
@end

@implementation ViewController


@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)digitPressed:(id)sender {
    
    NSString *digit = [sender currentTitle];
    
    if ([digit isEqualToString:@"."]){
        if (([self.display.text containsString:@"."])
            || (self.display.text.length == 0))
        {
            return;
        }
    }
    if (self.userIsInTherMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }else{
        self.display.text = digit;
        self.userIsInTherMiddleOfEnteringANumber = YES;
    }
    return;

}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTherMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    
    double result = [self.brain performOperation:operation];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTherMiddleOfEnteringANumber = NO;
}

- (IBAction)cancelAll {
    [self.brain clearAll];
    self.display.text = 0;
    self.userIsInTherMiddleOfEnteringANumber = NO;
    
    return;
}

- (IBAction)showBrain {
    NSString *stack = [self.brain descriptionOfProgram:self.brain.programStack];
    NSString *equal = @"=";
    stack= [stack stringByAppendingString:equal];
    self.display.text = [stack stringByAppendingString:self.display.text];
    return;
}

- (IBAction)backSpace {
    if (self.userIsInTherMiddleOfEnteringANumber && (self.display.text.length > 0)) {
        self.display.text = [self.display.text substringToIndex:(self.display.text.length - 1)];
    }
    if (self.display.text.length == 0){
        self.display.text = @"0";
    }
    return;
}

@end
