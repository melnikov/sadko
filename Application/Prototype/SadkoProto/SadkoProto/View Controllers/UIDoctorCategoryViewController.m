//
//  UIDoctorCategoryViewController.m
//  SadkoProto
//

#import "UISidePanelViewController.h"

#import "UIDoctorCategoryViewController.h"

#import "UIDoctorListViewController.h"
#import "UIBranchFilterViewController.h"

#import "DataManager.h"

@interface UIDoctorCategoryViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSDictionary* clinic;
@property (nonatomic, retain) NSArray* categories;

- (void)initCategoryListWithArray:(NSArray*)docs;
- (void)filterChanged;

@end

@implementation UIDoctorCategoryViewController

- (id)initWithClinicInfo:(NSDictionary *)clinic
{
    self = [super initFromNib];
    if (self)
    {
        self.clinic = clinic;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterChanged)  name:@"FILTER_CHANGED" object:nil];

    [self initCategoryListWithArray:self.clinic[@"docs"]];
    
    [self.table reloadData];
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
    
    self.title = @"Cпециальность";
}

#pragma mark - Private Methods

- (void)initCategoryListWithArray:(NSArray *)docs
{
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:[docs count]];

    NSArray* filter = [DataManager sharedInstance].filter;

    for (NSDictionary* doc in docs)
    {
        NSInteger branch = [doc[@"branch"] integerValue];

        if (![[filter objectAtIndex:branch] boolValue])
            continue;

        NSString* category = doc[@"speciality"];
        NSInteger i = 0;
        for (i = 0; i < [result count]; ++i)
        {
            NSString* cat = result[i];
            if ([cat isEqualToString:category])
                break;
        }

        if (i == [result count])
        {
            [result addObject:category];
        }
    }

    self.categories = [NSArray arrayWithArray:result];
}

- (void)filterChanged
{
    [self initCategoryListWithArray:self.clinic[@"docs"]];
    
    [self.table reloadData];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* kMenuCellId = @"CategoriesCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellId];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMenuCellId];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    cell.textLabel.text = [self.categories objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UISidePanelViewController* panel = [[UISidePanelViewController alloc] init];
    
    panel.bounceOnSidePanelOpen = NO;
    panel.bounceOnSidePanelClose = NO;
    panel.bounceOnCenterPanelChange = NO;
    panel.shouldDelegateAutorotateToVisiblePanel = NO;
    
    UIDoctorListViewController* docList = [[UIDoctorListViewController alloc] initWithClinicInfo:self.clinic andCategory:[self.categories objectAtIndex:indexPath.row]];
    UIBranchFilterViewController* filterScreen = [[UIBranchFilterViewController alloc] initWithBranchesInfo:self.clinic[@"branches"]];
    
    panel.centerPanel = docList;
    panel.rightPanel = filterScreen;
    
    [self.navigationController pushViewController:panel animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
