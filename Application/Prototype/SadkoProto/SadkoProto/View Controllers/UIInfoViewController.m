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

@property (nonatomic, retain) NSString* textInfo;

@end

@implementation UIInfoViewController

- (id)initWithText:(NSString *)text
{
    self = [super initFromNib];
    if (self)
    {
        self.textInfo = text;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textView.text = self.textInfo;

    self.title = @"Информация";
}

@end
