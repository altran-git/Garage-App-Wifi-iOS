//
//  ViewController.h
//  Remote Access Garage
//
//  Created by user on 6/14/13.
//  Copyright (c) 2013 user. All rights reserved.

#import <UIKit/UIKit.h>

NSInputStream *inputStream;
NSOutputStream *outputStream;
int status;
int len;
uint8_t buffer[10];

@interface ViewController : UIViewController <NSStreamDelegate>
{
    NSTimer* loopTimer;
}

@property (strong, nonatomic) IBOutlet UITextView *garageStatusText;
@property (strong, nonatomic) IBOutlet UIButton *garageButton;


- (IBAction)statusButton:(id)sender;
- (IBAction)garageButton:(id)sender;

@end
