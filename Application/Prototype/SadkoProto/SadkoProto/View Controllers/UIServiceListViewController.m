//
//  UIServiceListViewController.m
//  SadkoProto
//

#import "UIServiceListViewController.h"

#import "UIServiceDetailsViewController.h"

@interface UIServiceListViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSDictionary* clinic;
@property (nonatomic, retain) NSArray* services;

@end

@implementation UIServiceListViewController

- (id)initWithClinicInfo:(NSDictionary*)clinic;
{
    self = [super initFromNib];
    if (self)
    {
        self.clinic = clinic;
        self.services = self.clinic[@"services"];
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

    self.title = @"Услуги";
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.services count];
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
    
    cell.textLabel.text = [[self.services objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIServiceDetailsViewController* service = [[UIServiceDetailsViewController alloc] initWithClinicInfo:self.clinic andService:[self.services objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:service animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
