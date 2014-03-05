//
//  UIBranchFilterViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 28.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBranchFilterViewController.h"

#import "DataManager.h"

@interface UIBranchFilterViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSArray* branches;

- (void)filterChanged;

@end

@implementation UIBranchFilterViewController

- (id)initWithBranchesInfo:(NSArray *)branches
{
    self = [super initFromNib];
    if (self)
    {
        self.branches = branches;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterChanged)  name:@"FILTER_CHANGED" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
}

- (void)filterChanged
{
    [self.table reloadData];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMenuCellId];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    
    NSDictionary* branch = [self.branches objectAtIndex:indexPath.row];
    cell.textLabel.text = branch[@"title"];

    NSMutableArray* filter = [DataManager sharedInstance].filter;

    if ([[filter objectAtIndex:indexPath.row] boolValue])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray* filter = [DataManager sharedInstance].filter;

    NSNumber* newValue = [NSNumber numberWithBool:![[filter objectAtIndex:indexPath.row] boolValue]];

    [[DataManager sharedInstance].filter replaceObjectAtIndex:indexPath.row withObject:newValue];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"FILTER_CHANGED" object:nil];
}

@end
