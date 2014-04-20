//
//  UIAboutViewController.m
//  SadkoProto
//

#import "UIAboutViewController.h"

#import "UIInfoViewController.h"

@interface UIAboutViewController ()

@property (nonatomic, retain) NSDictionary* clinic;

@property (nonatomic, retain) IBOutlet UIScrollView* scroll;
@property (nonatomic, retain) IBOutlet UIButton* phone;
@property (nonatomic, retain) IBOutlet UILabel* schedule;
@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) UIWebView* callWebView;

- (void)initChildControls;
- (void)emailSelected;

@end

@implementation UIAboutViewController

- (id)initWithClinicInfo:(NSDictionary *)clinic
{
    self = [super initFromNib];
    if (self)
    {
        self.clinic = clinic;
    }
    return self;
}

- (void)dealloc
{
    self.clinic = nil;
    
    self.scroll = nil;
    self.phone = nil;
    self.schedule = nil;
    self.table = nil;
    self.callWebView = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.scroll.contentSize = CGSizeMake(self.view.bounds.size.width, 620);

    self.callWebView = [[[UIWebView alloc] init] autorelease];

    self.table.backgroundView = nil;
    self.table.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.separatorColor = [UIColor whiteColor];

    [self initChildControls];

    self.title = @"О клинике";
}

#pragma mark - User Interaction

- (IBAction)callButtonPressed:(id)sender
{
    NSString* phoneString = [[[[self.clinic[@"main_phone"] stringByReplacingOccurrencesOfString:@" " withString:@""]
                               stringByReplacingOccurrencesOfString:@"(" withString:@""]
                              stringByReplacingOccurrencesOfString:@")" withString:@""]
                              stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSURL* callURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneString]];
    if ([[UIApplication sharedApplication] canOpenURL:callURL])
    {
        [self.callWebView loadRequest:[NSURLRequest requestWithURL:callURL]];
    }
    else
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Данное устройство не может совершать звонки." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

#pragma mark - Private Methods

- (void)initChildControls
{
    [self.phone setTitle:self.clinic[@"main_phone"] forState:UIControlStateNormal];
    self.phone.layer.cornerRadius = 3.0f;

    self.schedule.text = self.clinic[@"schedule"];
}

- (void)emailSelected
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
    
    NSArray *mailAddress = [[[NSArray alloc] initWithObjects:self.clinic[@"email"], nil] autorelease];

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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* kMenuCellId = @"DoctorsCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellId];
    
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMenuCellId] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Информация";
            break;
        case 1:
            cell.textLabel.text = @"Написать нам";
            break;
        case 2:
            cell.textLabel.text = @"Письмо руководителю";
            break;
        case 3:
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
            UIInfoViewController* infoScreen = [[UIInfoViewController alloc] initWithText:self.clinic[@"info"] andTitle:@"Информация"];
            [self.navigationController pushViewController:infoScreen animated:YES];
            [infoScreen release];
            break;
        }
        case 1:
            [self emailSelected];
            break;
        case 2:
            [self emailSelected];
            break;
        case 3:
        {
            NSURL *url = [NSURL URLWithString:self.clinic[@"web"]];
            [[UIApplication sharedApplication] openURL:url];
            break;
        }
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
