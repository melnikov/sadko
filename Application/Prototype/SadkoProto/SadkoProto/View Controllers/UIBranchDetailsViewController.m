//
//  UIBranchDetailsViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBranchDetailsViewController.h"

#import "UIMapViewController.h"

@interface UIBranchDetailsViewController ()

@property (nonatomic, retain) IBOutlet UIScrollView* scroll;
@property (nonatomic, retain) IBOutlet UILabel* branchTitle;
@property (nonatomic, retain) IBOutlet UILabel* address;
@property (nonatomic, retain) IBOutlet UILabel* phone;
@property (nonatomic, retain) IBOutlet UILabel* schedule;
@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSDictionary* branch;

- (void)initChildControls;
- (void)emailSelected;

@end

@implementation UIBranchDetailsViewController

- (id)initWithBranchInfo:(NSDictionary*)branch
{
    self = [super initFromNib];
    if (self)
    {
        self.branch = branch;
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

    [self initChildControls];

    self.title = @"Филиал";
}

#pragma mark - Private Methods

- (void)initChildControls
{
    self.branchTitle.text = self.branch[@"title"];
    self.address.text = self.branch[@"address"];
    self.phone.text = self.branch[@"phone"];
    self.schedule.text = self.branch[@"schedule"];
}

- (void)emailSelected
{
    if (![MFMailComposeViewController canSendMail])
    {
        UIAlertView* downloadAlert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"На данном устройстве не настроена почта" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [downloadAlert show];
        return;
    }
    
    MFMailComposeViewController* pickerCtl = [[MFMailComposeViewController alloc] init];
    pickerCtl.mailComposeDelegate = self;
    [self retain];
    
    NSArray *mailAddress = [[[NSArray alloc] initWithObjects:self.branch[@"email"], nil] autorelease];
    
    [pickerCtl setSubject:@"Отзывы и предложения"];
    [pickerCtl setToRecipients:mailAddress];
    
    [self presentViewController:pickerCtl animated:YES completion:nil];
}

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

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Показать карту";
            break;
        case 1:
            cell.textLabel.text = @"Отправить письмо";
            break;
        case 2:
            cell.textLabel.text = @"Перейти на сайт";
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            UIMapViewController* mapVC = [[UIMapViewController alloc] initFromNib];
            [self.navigationController pushViewController:mapVC animated:YES];
            break;
        }
        case 1:
            [self emailSelected];
            break;
        case 2:
        {
            NSURL *url = [NSURL URLWithString:self.branch[@"web"]];
            [[UIApplication sharedApplication] openURL:url];
            break;
        }
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
