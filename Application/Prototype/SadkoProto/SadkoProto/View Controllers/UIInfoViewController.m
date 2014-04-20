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
@property (nonatomic, retain) NSString* textTitle;

@end

@implementation UIInfoViewController

- (id)initWithText:(NSString *)text andTitle:(NSString *)title
{
    self = [super initFromNib];
    if (self)
    {
        self.textInfo = text;
        self.textTitle = title;
    }
    return self;
}

- (void)dealloc
{
    self.textView = nil;
    self.textInfo = nil;
    self.title = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textView.text = self.textInfo;

    self.title = self.textTitle;
}

@end
