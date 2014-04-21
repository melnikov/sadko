//
//  UIAllContactsViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 21.04.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIAllContactsViewController.h"

#import "UIBranchDetailsViewController.h"

@interface UIAllContactsViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSArray* contacts;

- (void)initContactsfFromClinics:(NSArray*)list;

@end

@implementation UIAllContactsViewController

- (id)initWithAllClinics:(NSArray *)clinics
{
    self = [super initFromNib];
    if (self)
    {
        [self initContactsfFromClinics:clinics];
    }
    return self;
}

- (void)dealloc
{
    self.table = nil;
    self.contacts = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Контакты";
    
    self.table.backgroundView = nil;
    self.table.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.separatorColor = [UIColor whiteColor];
    self.table.rowHeight = 60.0f;
}

- (void)initContactsfFromClinics:(NSArray *)list
{
    NSMutableArray* result = [[[NSMutableArray alloc] init] autorelease];

    for (NSDictionary* clinic in list)
    {
        [result addObjectsFromArray:clinic[@"branches"]];
    }

    self.contacts = [NSArray arrayWithArray:result];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contacts count];
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
    
    cell.textLabel.text = [[self.contacts objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[self.contacts objectAtIndex:indexPath.row] objectForKey:@"address"];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBranchDetailsViewController* branch = [[UIBranchDetailsViewController alloc] initWithBranchInfo:[self.contacts objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:branch animated:YES];
    [branch release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
