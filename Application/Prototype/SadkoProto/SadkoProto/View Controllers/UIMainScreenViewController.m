//
//  UIMainScreenViewController.m
//  SadkoProto
//

#import "UIMainScreenViewController.h"

#import "UIAboutViewController.h"
#import "UIDoctorCategoryViewController.h"
#import "UIServiceListViewController.h"
#import "UINewsViewController.h"
#import "UITopTenQuestionsViewController.h"
#import "UIHumanSchemeViewController.h"
#import "UIBranchListViewController.h"
#import "UIBranchDetailsViewController.h"

@interface UIMainScreenViewController ()

@property (nonatomic, retain) IBOutlet UIScrollView* clinicSelector;
@property (nonatomic, retain) IBOutlet UIPageControl* pageController;

@property (nonatomic, retain) IBOutlet UIView* viewMenu;
@property (nonatomic, retain) IBOutlet UIButton* buttonDoctors;
@property (nonatomic, retain) IBOutlet UIButton* buttonAbout;
@property (nonatomic, retain) IBOutlet UIButton* buttonServices;
@property (nonatomic, retain) IBOutlet UIButton* buttonNews;
@property (nonatomic, retain) IBOutlet UIButton* buttonSymptoms;
@property (nonatomic, retain) IBOutlet UIButton* buttonContacts;

@property (nonatomic, retain) IBOutlet UIButton* buttonCallUs;

@property (nonatomic, retain) NSArray* clinics;

@property (nonatomic, retain) UIWebView* callWebView;

- (void)initClinics;

@end

@implementation UIMainScreenViewController

- (id)initWithScript:(NSString*)script
{
    self = [super initFromNib];
    if (self)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:script ofType:@"plist"];
        self.clinics = [[NSArray alloc] initWithContentsOfFile:filePath];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initClinics];
    
    self.title = @"Садко";

    self.clinicSelector.delegate = self;
	self.pageController.currentPage = 0;

    self.pageController.numberOfPages = [self.clinics count];

    [self selectionChanged];
    
    self.callWebView = [[UIWebView alloc] init];
}

#pragma mark - Private Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.clinicSelector.frame.size.width;
    int page = floor((self.clinicSelector.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    int oldPage = self.pageController.currentPage;
    
    self.pageController.currentPage = page;

    if (oldPage != page)
    {
        [self selectionChanged];
    }
}

- (void)initClinics
{
    for (int i = 0; i < [self.clinics count]; i++)
    {
        UIImageView* banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
        banner.frame = CGRectMake(self.clinicSelector.contentSize.width, 0, self.clinicSelector.bounds.size.width, self.clinicSelector.bounds.size.height);
        banner.backgroundColor = [UIColor clearColor];
    
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, banner.frame.size.width - 40, banner.frame.size.height - 40)];
        title.backgroundColor = [UIColor clearColor];
        title.numberOfLines = 0;
        title.font = [UIFont systemFontOfSize:24.0f];
        title.textColor = [UIColor blackColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = [self.clinics objectAtIndex:i][@"title"];

        [banner addSubview:title];
        
        [self.clinicSelector addSubview:banner];

        self.clinicSelector.contentSize = CGSizeMake(self.clinicSelector.contentSize.width + banner.frame.size.width, self.clinicSelector.contentSize.height);
    }
}

- (void)selectionChanged
{
    NSDictionary* clinic = [self.clinics objectAtIndex:self.pageController.currentPage];

    if ([[clinic objectForKey:@"top10"] boolValue])
    {
        [self.buttonSymptoms setTitle:@"TOP-10" forState:UIControlStateNormal];
    }
    else
    {
        [self.buttonSymptoms setTitle:@"Что болит?" forState:UIControlStateNormal];
    }
}

#pragma mark - User Interaction

- (IBAction)buttonDoctorsPressed:(id)sender
{
    UIDoctorCategoryViewController* doctorsScreen = [[UIDoctorCategoryViewController alloc] initWithClinicInfo:[self.clinics objectAtIndex:self.pageController.currentPage]];
    [self.navigationController pushViewController:doctorsScreen animated:YES];
}

- (IBAction)buttonAboutPressed:(id)sender
{
    UIAboutViewController* aboutScreen = [[UIAboutViewController alloc] initWithClinicInfo:[self.clinics objectAtIndex:self.pageController.currentPage]];
    [self.navigationController pushViewController:aboutScreen animated:YES];
}

- (IBAction)buttonServicesPressed:(id)sender
{
    UIServiceListViewController* servicesScreen = [[UIServiceListViewController alloc] initWithClinicInfo:[self.clinics objectAtIndex:self.pageController.currentPage]];
    [self.navigationController pushViewController:servicesScreen animated:YES];
}

- (IBAction)buttonNewsPressed:(id)sender
{
    UINewsViewController* newsScreen = [[UINewsViewController alloc] initWithScript:@"News"];
    [self.navigationController pushViewController:newsScreen animated:YES];
}

- (IBAction)buttonSymptomsPressed:(id)sender
{
    NSDictionary* options = [self.clinics objectAtIndex:self.pageController.currentPage];
    
    if ([[options objectForKey:@"top10"] boolValue])
    {
        UITopTenQuestionsViewController* top10Screen = [[UITopTenQuestionsViewController alloc] initWithScript:@"FAQ"];
        [self.navigationController pushViewController:top10Screen animated:YES];
    }
    else
    {
        UIHumanSchemeViewController* schemeScreen = [[UIHumanSchemeViewController alloc] initFromNib];
        [self.navigationController pushViewController:schemeScreen animated:YES];
    }
}

- (IBAction)buttonContactsPressed:(id)sender
{
    NSArray* branches = [self.clinics objectAtIndex:self.pageController.currentPage][@"branches"];

    if ([branches count] > 1)
    {
        UIBranchListViewController* contactScreen = [[UIBranchListViewController alloc] initWithClinicInfo:[self.clinics objectAtIndex:self.pageController.currentPage]];
        [self.navigationController pushViewController:contactScreen animated:YES];
    }
    else if ([branches count] > 0)
    {
        UIBranchDetailsViewController* detailsScreen = [[UIBranchDetailsViewController alloc] initWithBranchInfo:[branches objectAtIndex:0]];
        [self.navigationController pushViewController:detailsScreen animated:YES];
    }
}

- (IBAction)buttonCallUsPressed:(id)sender
{
    NSURL* callURL = [NSURL URLWithString:@"tel:+78314210101"];
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

@end
