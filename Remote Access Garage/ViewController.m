//
//  ViewController.m
//  Remote Access Garage
//
//  Created by user on 6/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self checkStatus];
    loopTimer = [NSTimer scheduledTimerWithTimeInterval:20.0
                                                 target:self
                                               selector:@selector(checkStatus)
                                               userInfo:nil
                                                repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Method called when status button is pressed
- (IBAction)statusButton:(UIButton *)sender {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"abg.jumpingcrab.com", 55555, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
    
    NSString *statusMessage = @"STATUS\0";
    NSData *data = [[NSData alloc] initWithData:[statusMessage dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
    usleep(250);
    
    len = [inputStream read:buffer maxLength:sizeof(buffer)];
    if(len > 0){
        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
        status = [output intValue];
        NSLog(@"server said: %d", status);
    }
    
    if(status == 0){
        [self.garageStatusText setText:@"GARAGE OPEN"];
        [self.garageButton setTitle:@"Close Garage" forState:UIControlStateNormal];
    }
    else if(status == 1){
        [self.garageStatusText setText:@"GARAGE CLOSED"];
        [self.garageButton setTitle:@"Open Garage" forState:UIControlStateNormal];
    }
    else{
        self.garageStatusText.text = @"READ ERROR!";
    }
    
    [inputStream close];
    [outputStream close];
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream setDelegate:nil];
    [outputStream setDelegate:nil];
    inputStream = nil;
    outputStream = nil;
}


//Method called when Garage Toggle button is pressed
- (IBAction)garageButton:(id)sender {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"abg.jumpingcrab.com", 55555, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
    
    NSString *toggleMessage = @"#$13vdY%1$@&8Ggk@3!\0";
    NSData *data = [[NSData alloc] initWithData:[toggleMessage dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
     
    [inputStream close];
    [outputStream close];
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream setDelegate:nil];
    [outputStream setDelegate:nil];
    inputStream = nil;
    outputStream = nil;
}

//Method for the Loop Timer to check Status
- (void)checkStatus
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"abg.jumpingcrab.com", 55555, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
    
    NSString *statusMessage = @"STATUS\0";
    NSData *data = [[NSData alloc] initWithData:[statusMessage dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
    usleep(250);
    
    len = [inputStream read:buffer maxLength:sizeof(buffer)];
    if(len > 0){
        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
        status = [output intValue];
        NSLog(@"server said: %d", status);
    }
    
    if(status == 0){
        [self.garageStatusText setText:@"GARAGE OPEN"];
        [self.garageButton setTitle:@"Close Garage" forState:UIControlStateNormal];
    }
    else if(status == 1){
        [self.garageStatusText setText:@"GARAGE CLOSED"];
        [self.garageButton setTitle:@"Open Garage" forState:UIControlStateNormal];
    }
    else{
        self.garageStatusText.text = @"READ ERROR!";
    }
    
    [inputStream close];
    [outputStream close];
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream setDelegate:nil];
    [outputStream setDelegate:nil];
    inputStream = nil;
    outputStream = nil;
}

@end
