//
//  ViewController.h
//  Calculator
//
//  Created by lugongyu on 2017/6/27.
//  Copyright © 2017年 lugongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *display;

- (IBAction)digitPressed:(id)sender;

- (IBAction)operationPressed:(id)sender;
- (IBAction)enterPressed;
- (IBAction)cancelAll;
- (IBAction)showBrain;
- (IBAction)backSpace;

@end

