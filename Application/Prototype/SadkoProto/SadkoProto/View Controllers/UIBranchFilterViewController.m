//
//  UIBranchFilterViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 28.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBranchFilterViewController.h"

#import "UIDoctorListViewController.h"

@interface UIBranchFilterViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSDictionary* clinic;
@property (nonatomic, retain) NSString* category;
@property (nonatomic, retain) NSArray* branches;

- (void)initBranchList;

@end

@implementation UIBranchFilterViewController

- (id)initWithClinicInfo:(NSDictionary *)clinic andCategory:(NSString *)category
{
    self = [super initFromNib];
    if (self)
    {
        self.clinic = clinic;
        self.category = category;

        [self initBranchList];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.table.backgroundView = nil;
    self.table.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.separatorColor = [UIColor whiteColor];

    self.title = @"Филиалы";
}

#pragma mark - Private Methods

- (void)initBranchList
{
    NSMutableArray* result = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSDictionary* branch in self.clinic[@"branches"])
    {
        NSInteger count = 0;
        for (NSDictionary* doc in self.clinic[@"docs"])
        {
            NSString* category = doc[@"speciality"];
            NSInteger brachIndex = [doc[@"branch"] integerValue];

            if ([category isEqualToString:self.category] && (brachIndex == [self.clinic[@"branches"] indexOfObject:branch]))
            {
                count++;
            }
        }

        if (count > 0)
        {
            [result addObject:branch];
        }
    }
    
    self.branches = [NSArray arrayWithArray:result];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.branches count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* kMenuCellId = @"DoctorsCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellId];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kMenuCellId];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Все филиалы";
    }
    else
    {
        NSDictionary* branch = [self.branches objectAtIndex:indexPath.row - 1];
        cell.textLabel.text = branch[@"address"];
        cell.detailTextLabel.text = branch[@"phone"];
    }
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger branch = -1;

    if (indexPath.row != 0)
    {
        branch = indexPath.row - 1;
    }

    UIDoctorListViewController* docList = [[UIDoctorListViewController alloc] initWithClinicInfo:self.clinic category:self.category andBranchIndex:branch];
    [self.navigationController pushViewController:docList animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
