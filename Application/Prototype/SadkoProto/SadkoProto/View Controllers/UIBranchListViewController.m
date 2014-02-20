//
//  UIBranchListViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBranchListViewController.h"

@interface UIBranchListViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@end

@implementation UIBranchListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Подразделения";
}

@end
