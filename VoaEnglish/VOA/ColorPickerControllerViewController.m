//
//  ColorPickerControllerViewController.m
//  VOA
//
//  Created by zhao song on 13-5-8.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import "ColorPickerControllerViewController.h"

@interface ColorPickerControllerViewController ()

@end

@implementation ColorPickerControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    
    InfColorPickerController* picker = [ InfColorPickerController colorPickerViewController ];
    
    picker.sourceColor = self.view.backgroundColor;
    picker.delegate = self;
    
    [ picker presentModallyOverViewController: self ];
    return nil;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) colorPickerControllerDidFinish: (InfColorPickerController*) picker
{
//	self.view.backgroundColor = picker.resultColor;
    [[UIApplication sharedApplication].keyWindow setBackgroundColor:picker.resultColor];
    
	[ self dismissModalViewControllerAnimated: YES ];
}

@end
