//
//  UIServiceListViewController.m
//  SadkoProto
//

#import "UIServiceListViewController.h"

#import "UIServiceDetailsViewController.h"

#import "Service.h"

#define TABLE_HEADER_HEIGHT 23

#pragma mark - Helpers categories

@interface NSArray (SSArrayOfArrays)

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation NSArray (SSArrayOfArrays)

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
}

@end

@interface NSMutableArray (SSArrayOfArrays)

- (void)addObject:(id)anObject toSubarrayAtIndex:(NSUInteger)idx;

@end

@implementation NSMutableArray (SSArrayOfArrays)

- (void)addObject:(id)anObject toSubarrayAtIndex:(NSUInteger)idx
{
    while ([self count] <= idx)
    {
        [self addObject:[NSMutableArray array]];
    }
    
    [[self objectAtIndex:idx] addObject:anObject];
}

@end

@interface UIServiceListViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;
@property (nonatomic, retain) IBOutlet UISearchBar* searchBar;
@property (nonatomic, retain) IBOutlet UIButton* shadow;

@property (nonatomic, retain) NSDictionary* clinic;
@property (nonatomic, retain) NSArray* serviceList;
@property (nonatomic, retain) NSArray* sectionedList;
@property (nonatomic, retain) NSMutableArray* filteredList;
@property (nonatomic, assign) BOOL searching;

@property (nonatomic, retain) UILocalizedIndexedCollation* collation;

- (void)initSectionsFromList:(NSArray*)list;

@end

@implementation UIServiceListViewController

- (id)initWithClinicInfo:(NSDictionary*)clinic;
{
    self = [super initFromNib];
    if (self)
    {
        self.clinic = clinic;
        self.serviceList = self.clinic[@"services"];

        self.filteredList = [[NSMutableArray alloc] init];
        [self initSectionsFromList:self.serviceList];

        self.searching = NO;
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

#pragma mark - Public Methods

- (IBAction)shadowViewPressed:(id)sender
{
    self.searching = NO;
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = nil;
    [self.table reloadData];
    [self.searchBar resignFirstResponder];

    self.shadow.hidden = YES;
}

#pragma mark - Private Methods

- (void)initSectionsFromList:(NSArray*)list;
{
    NSMutableArray *sections = [NSMutableArray array];
    self.collation = [UILocalizedIndexedCollation currentCollation];
    
    for (NSDictionary *item in list)
    {
        Service* service = [[Service alloc] initWithDictionary:item];
        NSInteger section = [_collation sectionForObject:service collationStringSelector:@selector(title)];
        [sections addObject:service toSubarrayAtIndex:section];
    }
    
    NSInteger section = 0;
    for (section = 0; section < [sections count]; section++)
    {
        NSArray *sortedSubarray = [_collation sortedArrayFromArray:[sections objectAtIndex:section] collationStringSelector:@selector(title)];
        [sections replaceObjectAtIndex:section withObject:sortedSubarray];
    }
    
    self.sectionedList = sections;
}

- (UIView*)headerViewWithTitle:(NSString*)title
{
    if (title == nil)
    {
        return nil;
    }
    
    UIView* header = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.table.bounds.size.width, TABLE_HEADER_HEIGHT)] autorelease];
    header.backgroundColor = [UIColor blackColor];
    header.alpha = 0.2f;
    
    UILabel* titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.table.bounds.size.width - 2*20, TABLE_HEADER_HEIGHT)] autorelease];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.shadowOffset = CGSizeMake(2, 2);
    titleLabel.text = title;
    [header addSubview:titleLabel];
    
    return header;
}

#pragma mark - Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	[self.filteredList removeAllObjects]; // First clear the filtered array.
    
    for (NSArray *section in self.sectionedList)
    {
        for (Service *service in section)
        {
            if ([service.title rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [self.filteredList addObject:service];
            }
            
        }
    }
    
    if (self.filteredList.count > 0 || searchText.length > 0)
    {
        self.searching = YES;
    }
    else
    {
        self.searching = NO;
    }
}

#pragma mark - UITableView data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.searching)
	{
        return 1;
    }
	else
	{
        return [self.sectionedList count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.searching)
	{
        return [self.filteredList count];
    }
	else
	{
        return [[self.sectionedList objectAtIndex:section] count];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.searching)
    {
        return nil;
    }
    else
    {
        NSString* title = ([[self.sectionedList objectAtIndex:section] count] != 0) ? [[self.collation sectionTitles] objectAtIndex:section] : nil;
        return [self headerViewWithTitle:title];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.searching)
    {
        return 0;
    }
    else
    {
        return [[self.sectionedList objectAtIndex:section] count] ? TABLE_HEADER_HEIGHT : 0;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.searching)
    {
        return nil;
    }
    else
    {
        return [self.collation sectionIndexTitles];
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    int idx = [self.collation sectionForSectionIndexTitleAtIndex:index];
    
    return (self.sectionedList.count > idx && [[self.sectionedList objectAtIndex:idx] count] != 0) ? idx : -1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellID = @"PersonCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	Service* service = nil;
	if (self.searching)
	{
        service = [self.filteredList objectAtIndex:indexPath.row];
    }
	else
	{
        service = [self.sectionedList objectAtIndexPath:indexPath];
    }
	
	cell.textLabel.text = service.title;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Service *service = nil;
	if (self.searching)
	{
        service = [self.filteredList objectAtIndex:indexPath.row];
    }
	else
	{
        service = [self.sectionedList objectAtIndexPath:indexPath];
    }

    UIServiceDetailsViewController* serviceScreen = [[UIServiceDetailsViewController alloc] initWithClinicInfo:self.clinic andService:service];
    [self.navigationController pushViewController:serviceScreen animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([_searchBar isFirstResponder])
    {
        [_searchBar resignFirstResponder];
    }
}

#pragma mark - UISearchDisplayController Delegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.shadow.hidden = YES;

    [self.searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self shadowViewPressed:nil];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.shadow.hidden = NO;
    searchBar.showsCancelButton = YES;

    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:searchText scope:[[self.searchBar scopeButtonTitles] objectAtIndex:[self.searchBar selectedScopeButtonIndex]]];
    if (self.filteredList.count == 0 && self.searchBar.text.length == 0)
    {
        self.shadow.hidden = NO;
        [self.table reloadData];
    }
    else
    {
        self.shadow.hidden = YES;
        [self.table reloadData];
    }
}

@end
