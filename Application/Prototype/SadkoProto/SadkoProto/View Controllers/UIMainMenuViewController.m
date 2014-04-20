//
//  UIMainMenuViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 12.03.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIMainMenuViewController.h"

#import "UIMainScreenViewController.h"
#import "UIBonusCardViewController.h"

@interface UIMainMenuViewController ()

@property (nonatomic, retain) IBOutlet UIScrollView* scroll;

@property (nonatomic, retain) IBOutlet UIButton* buttonBonus;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch1;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch2;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch3;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch4;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch5;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch6;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch7;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch8;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch9;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch10;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch11;

@property (nonatomic, retain) IBOutlet UIButton* buttonCallUs;

@property (nonatomic, retain) NSArray* clinics;

@property (nonatomic, retain) UIWebView* callWebView;

- (void)initChildControls;

@end

@implementation UIMainMenuViewController

- (id)initWithScript:(NSString*)script
{
    self = [super initFromNib];
    if (self)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:script ofType:@"plist"];
        self.clinics = [[[NSArray alloc] initWithContentsOfFile:filePath] autorelease];
    }
    return self;
}

- (void)dealloc
{
    self.clinics = nil;

    self.buttonBonus = nil;
    self.buttonBranch1 = nil;
    self.buttonBranch2 = nil;
    self.buttonBranch3 = nil;
    self.buttonBranch4 = nil;
    self.buttonBranch5 = nil;
    self.buttonBranch6 = nil;
    self.buttonBranch7 = nil;
    self.buttonBranch8 = nil;
    self.buttonBranch9 = nil;
    self.buttonBranch10 = nil;
    self.buttonBranch11 = nil;

    self.callWebView = nil;

    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.scroll.contentSize = CGSizeMake(self.view.bounds.size.width, 600);

    [self initChildControls];

    self.callWebView = [[[UIWebView alloc] init] autorelease];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - Private Methods

- (void)initChildControls
{
    self.buttonBonus.layer.cornerRadius = 3.0f;
    self.buttonBranch1.layer.cornerRadius = 3.0f;
    self.buttonBranch2.layer.cornerRadius = 3.0f;
    self.buttonBranch3.layer.cornerRadius = 3.0f;
    self.buttonBranch4.layer.cornerRadius = 3.0f;
    self.buttonBranch5.layer.cornerRadius = 3.0f;
    self.buttonBranch6.layer.cornerRadius = 3.0f;
    self.buttonBranch7.layer.cornerRadius = 3.0f;
    self.buttonBranch8.layer.cornerRadius = 3.0f;
    self.buttonBranch9.layer.cornerRadius = 3.0f;
    self.buttonBranch10.layer.cornerRadius = 3.0f;
    self.buttonBranch11.layer.cornerRadius = 3.0f;
    
    self.buttonCallUs.layer.cornerRadius = 3.0f;

    self.buttonBonus.titleLabel.numberOfLines = 0;
    self.buttonBonus.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonBonus.titleLabel.textAlignment = NSTextAlignmentCenter;

    self.buttonBranch1.titleLabel.numberOfLines = 0;
    self.buttonBranch1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonBranch1.titleLabel.textAlignment = NSTextAlignmentCenter;

    self.buttonBranch2.titleLabel.numberOfLines = 0;
    self.buttonBranch2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonBranch2.titleLabel.textAlignment = NSTextAlignmentCenter;

    self.buttonBranch3.titleLabel.numberOfLines = 0;
    self.buttonBranch3.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonBranch3.titleLabel.textAlignment = NSTextAlignmentCenter;

    self.buttonBranch4.titleLabel.numberOfLines = 0;
    self.buttonBranch4.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonBranch4.titleLabel.textAlignment = NSTextAlignmentCenter;

    self.buttonBranch5.titleLabel.numberOfLines = 0;
    self.buttonBranch5.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonBranch5.titleLabel.textAlignment = NSTextAlignmentCenter;

    self.buttonBranch9.titleLabel.numberOfLines = 0;
    self.buttonBranch9.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonBranch9.titleLabel.textAlignment = NSTextAlignmentCenter;

    self.buttonBranch10.titleLabel.numberOfLines = 0;
    self.buttonBranch10.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonBranch10.titleLabel.textAlignment = NSTextAlignmentCenter;

    self.buttonBranch11.titleLabel.numberOfLines = 0;
    self.buttonBranch11.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonBranch11.titleLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - User Interaction

- (IBAction)bonusButtonPressed:(UIButton*)sender
{
    UIBonusCardViewController* bonusVC = [[UIBonusCardViewController alloc] initFromNib];
    [self.navigationController pushViewController:bonusVC animated:YES];
    [bonusVC release];
}

- (IBAction)branchButtonPressed:(UIButton*)sender
{
    NSInteger index = sender.tag - 1;

    if (index >= 0 && index < [self.clinics count])
    {
        UIMainScreenViewController* mainVC = [[UIMainScreenViewController alloc] initWithScript:@"Clinics"];
        mainVC.currentSlide = index;

        [self.navigationController pushViewController:mainVC animated:YES];
        [mainVC release];
    }
}

- (IBAction)buttonCallUsPressed:(id)sender
{
    NSURL* callURL = [NSURL URLWithString:@"tel:+78314210101"];
    if ([[UIApplication sharedApplication] canOpenURL:callURL])
    {
        [self.callWebView loadRequest:[NSURLRequest requestWithURL:callURL]];
    }
    else
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Данное устройство не может совершать звонки." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

@end
