//
//  UIQuestionAnswerViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIQuestionAnswerViewController.h"

@interface UIQuestionAnswerViewController ()

@property (nonatomic, retain) NSDictionary* info;

@property (nonatomic, retain) IBOutlet UITextView* question;
@property (nonatomic, retain) IBOutlet UITextView* answer;
@property (nonatomic, retain) IBOutlet UIImageView* picture;

@end

@implementation UIQuestionAnswerViewController

- (id)initWithInfo:(NSDictionary *)info
{
    self = [super initFromNib];
    if (self)
    {
        self.info = info;
    }
    return self;
}

- (void)dealloc
{
    self.info = nil;

    self.question = nil;
    self.answer = nil;
    self.picture = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Вопрос - ответ";

    self.picture.image = [UIImage imageNamed:self.info[@"picture"]];
}

@end
