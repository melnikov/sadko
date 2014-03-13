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

@property (nonatomic, retain) IBOutlet UIButton* buttonBonus;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch1;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch2;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch3;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch4;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch5;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch6;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch7;
@property (nonatomic, retain) IBOutlet UIButton* buttonBranch8;

@property (nonatomic, retain) NSArray* clinics;

@end

@implementation UIMainMenuViewController

- (id)initWithScript:(NSString*)script
{
    self = [super initFromNib];
    if (self)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:script ofType:@"plist"];
        self.clinics = [[NSArray alloc] initWithContentsOfFile:filePath];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

#pragma mark - User Interaction

- (IBAction)bonusButtonPressed:(UIButton*)sender
{
    UIBonusCardViewController* bonusVC = [[UIBonusCardViewController alloc] initFromNib];
    [self.navigationController pushViewController:bonusVC animated:YES];
}

- (IBAction)branchButtonPressed:(UIButton*)sender
{
    NSInteger index = sender.tag - 1;

    if (index >= 0 && index < [self.clinics count])
    {
        UIMainScreenViewController* mainVC = [[UIMainScreenViewController alloc] initWithScript:@"Clinics"];
        [self.navigationController pushViewController:mainVC animated:YES];
    }
}

@end
