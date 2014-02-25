//
//  UIInfoViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 25.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIInfoViewController.h"

@interface UIInfoViewController ()

@property (nonatomic, retain) IBOutlet UITextView* textView;

@property (nonatomic, retain) NSDictionary* clinic;

@end

@implementation UIInfoViewController

- (id)initWithClinicInfo:(NSDictionary *)clinic
{
    self = [super initFromNib];
    if (self)
    {
        self.clinic = clinic;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textView.text = self.clinic[@"info"];

    self.title = @"Информация";
}

@end
