//
//  UIAllDealsViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 21.04.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIAllDealsViewController.h"

#import "UINewsDetailsViewController.h"

@interface UIAllDealsViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSArray* list;

@end

@implementation UIAllDealsViewController

- (id)initWithList:(NSArray *)list
{
    self = [super initFromNib];
    if (self)
    {
        self.list = list;
    }
    return self;
}

- (void)dealloc
{
    self.table = nil;

    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Акции";
    
    self.table.backgroundView = nil;
    self.table.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.separatorColor = [UIColor whiteColor];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list count];
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
    
    cell.textLabel.text = [[self.list objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINewsDetailsViewController* newsDetails = [[UINewsDetailsViewController alloc] initWithInfo:[self.list objectAtIndex:indexPath.row] andTitle:@"Акция"];
    [self.navigationController pushViewController:newsDetails animated:YES];
    [newsDetails release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
