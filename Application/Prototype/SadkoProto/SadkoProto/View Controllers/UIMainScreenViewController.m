//
//  UIMainScreenViewController.m
//  SadkoProto
//

#import "UIMainScreenViewController.h"

#import "UIAboutViewController.h"
#import "UIDoctorCategoryViewController.h"
#import "UIServiceListViewController.h"
#import "UINewsViewController.h"

@interface UIMainScreenViewController ()

@property (nonatomic, retain) IBOutlet UIScrollView* branchSelector;
@property (nonatomic, retain) IBOutlet UIPageControl* pageController;

@property (nonatomic, retain) IBOutlet UIView* viewMenu;
@property (nonatomic, retain) IBOutlet UIButton* buttonDoctors;
@property (nonatomic, retain) IBOutlet UIButton* buttonAbout;
@property (nonatomic, retain) IBOutlet UIButton* buttonServices;
@property (nonatomic, retain) IBOutlet UIButton* buttonNews;
@property (nonatomic, retain) IBOutlet UIButton* buttonSymptoms;
@property (nonatomic, retain) IBOutlet UIButton* buttonContacts;

@property (nonatomic, retain) IBOutlet UIButton* buttonCallUs;

@property (nonatomic, retain) NSArray* branches;

- (void)initBranches;

@end

@implementation UIMainScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initBranches];
    
    self.title = @"Садко";

    self.branchSelector.delegate = self;
	self.pageController.currentPage = 0;

    self.pageController.numberOfPages = [self.branches count];
}

#pragma mark - Private Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.branchSelector.frame.size.width;
    int page = floor((self.branchSelector.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageController.currentPage = page;
}

- (void)initBranches
{
    self.branches = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];

    NSArray* colors = [NSArray arrayWithObjects:[UIColor lightGrayColor], [UIColor redColor], [UIColor blueColor],
                                                [UIColor lightGrayColor], [UIColor redColor], [UIColor blueColor],
                                                [UIColor lightGrayColor], [UIColor redColor], [UIColor blueColor], [UIColor yellowColor], nil];

    for (int i = 0; i < [self.branches count]; i++)
    {
        UIView* banner = [[UIView alloc] init];
        banner.backgroundColor = [colors objectAtIndex:i];
        banner.frame = CGRectMake(self.branchSelector.contentSize.width, 0, self.branchSelector.bounds.size.width, self.branchSelector.bounds.size.height);
        
        [self.branchSelector addSubview:banner];

        self.branchSelector.contentSize = CGSizeMake(self.branchSelector.contentSize.width + banner.frame.size.width, self.branchSelector.contentSize.height);
    }
}

#pragma mark - User Interaction

- (IBAction)buttonDoctorsPressed:(id)sender
{
    UIDoctorCategoryViewController* aboutScreen = [[UIDoctorCategoryViewController alloc] initFromNib];
    [self.navigationController pushViewController:aboutScreen animated:YES];
}

- (IBAction)buttonAboutPressed:(id)sender
{
    UIAboutViewController* aboutScreen = [[UIAboutViewController alloc] initFromNib];
    [self.navigationController pushViewController:aboutScreen animated:YES];
}

- (IBAction)buttonServicesPressed:(id)sender
{
    UIServiceListViewController* aboutScreen = [[UIServiceListViewController alloc] initFromNib];
    [self.navigationController pushViewController:aboutScreen animated:YES];
}

- (IBAction)buttonNewsPressed:(id)sender
{
    UINewsViewController* aboutScreen = [[UINewsViewController alloc] initFromNib];
    [self.navigationController pushViewController:aboutScreen animated:YES];
}

- (IBAction)buttonSymptomsPressed:(id)sender
{
    
}

- (IBAction)buttonContactsPressed:(id)sender
{
    
}

- (IBAction)buttonCallUsPressed:(id)sender
{
    
}

@end
