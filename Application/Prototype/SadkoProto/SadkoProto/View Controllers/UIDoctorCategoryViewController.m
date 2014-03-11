//
//  UIDoctorCategoryViewController.m
//  SadkoProto
//

#import "UIDoctorCategoryViewController.h"

#import "UIBranchFilterViewController.h"
#import "UIDoctorListViewController.h"

@interface UIDoctorCategoryViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSDictionary* clinic;
@property (nonatomic, retain) NSArray* categories;

- (void)initCategoryListWithArray:(NSArray*)docs;

@end

@implementation UIDoctorCategoryViewController

- (id)initWithClinicInfo:(NSDictionary *)clinic
{
    self = [super initFromNib];
    if (self)
    {
        self.clinic = clinic;

        [self initCategoryListWithArray:self.clinic[@"docs"]];
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
    
    self.title = @"Cпециальности";
}

#pragma mark - Private Methods

- (void)initCategoryListWithArray:(NSArray *)docs
{
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:[docs count]];

    for (NSDictionary* doc in docs)
    {
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
    NSArray* branches = self.clinic[@"branches"];
    
    if ([branches count] > 1)
    {
        UIBranchFilterViewController* filterScreen = [[UIBranchFilterViewController alloc] initWithClinicInfo:self.clinic];
        filterScreen.category = [self.categories objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:filterScreen animated:YES];
    }
    else if ([branches count] > 0)
    {
        UIDoctorListViewController* docList = [[UIDoctorListViewController alloc] initWithClinicInfo:self.clinic category:[self.categories objectAtIndex:indexPath.row] andBranchIndex:-1];
        [self.navigationController pushViewController:docList animated:YES];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
