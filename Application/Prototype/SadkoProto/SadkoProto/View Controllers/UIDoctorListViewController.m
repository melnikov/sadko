//
//  UIDoctorListViewController.m
//  SadkoProto
//

#import "UIDoctorListViewController.h"

@interface UIDoctorListViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@end

@implementation UIDoctorListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Врачи";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
