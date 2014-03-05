//
//  UIDoctorListViewController.m
//  SadkoProto
//

#import "UIDoctorListViewController.h"

#import "UIDoctorDetailsViewController.h"

#import "DataManager.h"

@interface UIDoctorListViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSDictionary* clinic;
@property (nonatomic, retain) NSString* category;
@property (nonatomic, retain) NSArray* doctors;

- (void)initDoctorListWithCategory:(NSString *)category;
- (void)filterChanged;

@end

@implementation UIDoctorListViewController

- (id)initWithClinicInfo:(NSDictionary *)clinic andCategory:(NSString *)category
{
    self = [super initFromNib];
    if (self)
    {
        self.clinic = clinic;
        self.category = category;

        [self initDoctorListWithCategory:category];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterChanged)  name:@"FILTER_CHANGED" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.table.backgroundView = nil;
    self.table.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.separatorColor = [UIColor whiteColor];
    
    self.title = @"Врачи";
}

#pragma mark - Private Methods

- (void)initDoctorListWithCategory:(NSString *)category
{
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:[self.clinic[@"docs"] count]];

    NSArray* filter = [DataManager sharedInstance].filter;

    for (NSDictionary* doc in self.clinic[@"docs"])
    {
        NSInteger branch = [doc[@"branch"] integerValue];
        
        if (![[filter objectAtIndex:branch] boolValue])
            continue;

        if ([doc[@"speciality"] isEqualToString:category])
        {
            [result addObject:doc];
        }
    }

    self.doctors = [NSArray arrayWithArray:result];
}

- (void)filterChanged
{
    [self initDoctorListWithCategory:self.category];
    
    [self.table reloadData];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.doctors count];
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

    NSDictionary* doc = [self.doctors objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", doc[@"last"], doc[@"first"], doc[@"middle"]];
    cell.imageView.image = [UIImage imageNamed:doc[@"picture"]];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIDoctorDetailsViewController* doc = [[UIDoctorDetailsViewController alloc] initWithDoctorInfo:[self.doctors objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:doc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
