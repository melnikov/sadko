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
#import "UIPriceCalcViewController.h"
#import "UIAllDealsViewController.h"
#import "UIAllContactsViewController.h"
#import "UIAllDoctorsViewController.h"

#import "UIServiceListViewController.h"

@interface UISlideMenuViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSArray* menuItems;

- (void)createMenuItems;

- (void)historyItemSelected;
- (void)sendEmailItemSelected;
- (void)priceCalcItemSelected;
- (void)allDealsItemSelected;
- (void)allContactsItemSelected;
- (void)allDoctorsItemSelected;
- (void)allServicesItemSelected;

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
    menuItem.target = self;
    menuItem.selector = @selector(allDoctorsItemSelected);
    [menu addObject:menuItem];
    
    menuItem = [MenuItem menuItemWithTitle:@"Услуги"];
    menuItem.target = self;
    menuItem.selector = @selector(allServicesItemSelected);
    [menu addObject:menuItem];
    
    menuItem = [MenuItem menuItemWithTitle:@"Отправить письмо"];
    menuItem.target = self;
    menuItem.selector = @selector(sendEmailItemSelected);
    [menu addObject:menuItem];
    
    menuItem = [MenuItem menuItemWithTitle:@"Расчет стоимости"];
    menuItem.target = self;
    menuItem.selector = @selector(priceCalcItemSelected);
    [menu addObject:menuItem];

    menuItem = [MenuItem menuItemWithTitle:@"Акции"];
    menuItem.target = self;
    menuItem.selector = @selector(allDealsItemSelected);
    [menu addObject:menuItem];

    menuItem = [MenuItem menuItemWithTitle:@"Контакты"];
    menuItem.target = self;
    menuItem.selector = @selector(allContactsItemSelected);
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

#pragma mark - MFMailComposer Delegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
    {
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			break;
		default:
			break;
	}
    controller.delegate = nil;
    [controller dismissViewControllerAnimated:YES completion:nil];
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

- (void)sendEmailItemSelected
{
    if (![MFMailComposeViewController canSendMail])
    {
        UIAlertView* downloadAlert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"На данном устройстве не настроена почта" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [downloadAlert show];
        [downloadAlert release];
        return;
    }
    
    MFMailComposeViewController* pickerCtl = [[MFMailComposeViewController alloc] init];
    pickerCtl.mailComposeDelegate = self;
    [self retain];
    
    NSArray *mailAddress = [[[NSArray alloc] initWithObjects:@"sadko-med@yandex.ru", nil] autorelease];
    
    [pickerCtl setSubject:@"Отзывы и предложения"];
    [pickerCtl setToRecipients:mailAddress];
    
    [self presentViewController:pickerCtl animated:YES completion:nil];
}

- (void)priceCalcItemSelected
{
    UIPriceCalcViewController* priceCalcVC = [[UIPriceCalcViewController alloc] initFromNib];
    [self.centerController.navigationController pushViewController:priceCalcVC animated:YES];
    [priceCalcVC release];
}

- (void)allDealsItemSelected
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"News" ofType:@"plist"];
    NSDictionary* data = [[[NSDictionary alloc] initWithContentsOfFile:filePath] autorelease];

    UIAllDealsViewController* allDealsVC = [[UIAllDealsViewController alloc] initWithList:data[@"deals"]];
    [self.centerController.navigationController pushViewController:allDealsVC animated:YES];
    [allDealsVC release];
}

- (void)allContactsItemSelected
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Clinics" ofType:@"plist"];
    NSArray* data = [[[NSArray alloc] initWithContentsOfFile:filePath] autorelease];
    
    UIAllContactsViewController* allContactsVC = [[UIAllContactsViewController alloc] initWithAllClinics:data];
    [self.centerController.navigationController pushViewController:allContactsVC animated:YES];
    [allContactsVC release];
}

- (void)allDoctorsItemSelected
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Clinics" ofType:@"plist"];
    NSArray* data = [[[NSArray alloc] initWithContentsOfFile:filePath] autorelease];
    
    UIAllDoctorsViewController* allDocsVC = [[UIAllDoctorsViewController alloc] initWithAllClinics:data];
    [self.centerController.navigationController pushViewController:allDocsVC animated:YES];
    [allDocsVC release];
}

- (void)allServicesItemSelected
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Clinics" ofType:@"plist"];
    NSArray* data = [[[NSArray alloc] initWithContentsOfFile:filePath] autorelease];
    
    UIServiceListViewController* servicesVC = [[UIServiceListViewController alloc] initWithAllClinics:data];
    [self.centerController.navigationController pushViewController:servicesVC animated:YES];
    [servicesVC release];
}

@end
