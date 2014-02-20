//
//  UIAboutViewController.m
//  SadkoProto
//

#import "UIAboutViewController.h"

@interface UIAboutViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@end

@implementation UIAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"О клинике";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent; // For light status bar
}

@end
