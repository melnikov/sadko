//
//  UISlideMenuViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 21.04.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UISlideMenuViewController.h"

#import "MenuItem.h"

#import "UIInfoViewController.h"

@interface UISlideMenuViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSArray* menuItems;

- (void)createMenuItems;

- (void)historyItemSelected;

@end

@implementation UISlideMenuViewController

#pragma mark - Initialization/Destruction

- (void)dealloc
{
    self.table = nil;
    self.menuItems = nil;
    self.sidePanelController = nil;
    
    [super dealloc];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:UIColorFromRGB(0, 109, 175)];
    
    self.table.backgroundView = nil;
    self.table.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.table.backgroundColor = [UIColor clearColor];
    
    if (self.sidePanelController)
    {
        SET_FRAME_WIDTH(self.table.frame, self.sidePanelController.leftVisibleWidth);
    }

    [self createMenuItems];
}

#pragma mark - Private Methods

- (void)setupViewController
{
    self.menuItems = nil;
    self.sidePanelController = nil;
    
    [self createMenuItems];
}

- (void)createMenuItems
{
    NSMutableArray* menu = [[NSMutableArray alloc] init];
    MenuItem* menuItem = nil;
    
    menuItem = [MenuItem menuItemWithTitle:@"История компании"];
    menuItem.target = self;
    menuItem.selector = @selector(historyItemSelected);
    [menu addObject:menuItem];
    
    menuItem = [MenuItem menuItemWithTitle:@"Выбрать врача"];
    [menu addObject:menuItem];
    
    menuItem = [MenuItem menuItemWithTitle:@"Услуги"];
    [menu addObject:menuItem];
    
    menuItem = [MenuItem menuItemWithTitle:@"Отправить письмо"];
    [menu addObject:menuItem];
    
    menuItem = [MenuItem menuItemWithTitle:@"Расчет стоимости"];
    [menu addObject:menuItem];

    menuItem = [MenuItem menuItemWithTitle:@"Акции"];
    [menu addObject:menuItem];

    menuItem = [MenuItem menuItemWithTitle:@"Контакты"];
    [menu addObject:menuItem];
    
    self.menuItems = [NSArray arrayWithArray:menu];
    [menu release];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuItem* item = [self.menuItems objectAtIndex:indexPath.row];
    return item.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* kMenuCellId = @"MainMenuCell";
    MenuItem* item = [self.menuItems objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMenuCellId] autorelease];

    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = item.title;
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self.sidePanelController toggleLeftPanel:nil];

    MenuItem* item = [self.menuItems objectAtIndex:indexPath.row];

    if ([item.target respondsToSelector:item.selector])
    {
        [item.target performSelector:item.selector withObject:nil];
    }
}

#pragma mark - Menu Items Handling

- (void)historyItemSelected
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"General" ofType:@"plist"];
    NSDictionary* data = [[[NSDictionary alloc] initWithContentsOfFile:filePath] autorelease];

    UIInfoViewController* infoScreen = [[UIInfoViewController alloc] initWithText:data[@"history"] andTitle:@"История компании"];
    [self.centerController.navigationController pushViewController:infoScreen animated:YES];
    [infoScreen release];
}

@end
