//
//  UIBranchListViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBranchListViewController.h"

#import "UIBranchDetailsViewController.h"

@interface UIBranchListViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSDictionary* clinic;
@property (nonatomic, retain) NSArray* branches;

@end

@implementation UIBranchListViewController

- (id)initWithClinicInfo:(NSDictionary *)clinic
{
    self = [super initFromNib];
    if (self)
    {
        self.clinic = clinic;
        self.branches = self.clinic[@"branches"];
    }
    return self;
}

- (void)dealloc
{
    self.table = nil;
    
    self.clinic = nil;
    self.branches = nil;
    
    [super dealloc];
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

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.branches count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* kMenuCellId = @"DoctorsCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellId];
    
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kMenuCellId] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    cell.textLabel.text = [[self.branches objectAtIndex:indexPath.row] objectForKey:@"address"];
    cell.detailTextLabel.text = [[self.branches objectAtIndex:indexPath.row] objectForKey:@"phone"];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBranchDetailsViewController* branch = [[UIBranchDetailsViewController alloc] initWithBranchInfo:[self.branches objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:branch animated:YES];
    [branch release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
