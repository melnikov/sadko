//
//  UIDoctorCategoryViewController.m
//  SadkoProto
//

#import "UIDoctorCategoryViewController.h"

@interface UIDoctorCategoryViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@end

@implementation UIDoctorCategoryViewController

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
    
    self.title = @"Cпециальность";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
