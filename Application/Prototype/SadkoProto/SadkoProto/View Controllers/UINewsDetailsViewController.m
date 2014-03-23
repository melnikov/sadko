//
//  UINewsDetailsViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UINewsDetailsViewController.h"

@interface UINewsDetailsViewController ()

@property (nonatomic, retain) IBOutlet UILabel* infoTitle;
@property (nonatomic, retain) IBOutlet UITextView* infoText;

@property (nonatomic, retain) NSDictionary* info;
@property (nonatomic, retain) NSString* screenTitle;

- (void)initChildControls;

@end

@implementation UINewsDetailsViewController

- (id)initWithInfo:(NSDictionary *)info andTitle:(NSString *)title
{
    self = [super initFromNib];
    if (self)
    {
        self.info = info;
        self.screenTitle = title;
    }
    return self;
}

- (void)dealloc
{
    self.infoTitle = nil;
    self.infoText = nil;
    self.info = nil;
    self.screenTitle = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initChildControls];

    self.title = self.screenTitle;
}

#pragma mark - Private Methods

- (void)initChildControls
{
    self.infoTitle.text = self.info[@"title"];
    self.infoText.text = self.info[@"description"];
}

@end
