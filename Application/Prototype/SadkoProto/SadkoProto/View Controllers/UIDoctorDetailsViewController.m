//
//  UIDoctorDetailsViewController.m
//  SadkoProto
//

#import "UIDoctorDetailsViewController.h"

@interface UIDoctorDetailsViewController ()

@property (nonatomic, retain) IBOutlet UIScrollView* scroll;
@property (nonatomic, retain) IBOutlet UIImageView* avatar;
@property (nonatomic, retain) IBOutlet UILabel* last;
@property (nonatomic, retain) IBOutlet UILabel* first;
@property (nonatomic, retain) IBOutlet UILabel* middle;
@property (nonatomic, retain) IBOutlet UILabel* speciality;
@property (nonatomic, retain) IBOutlet UITextView* resume;
@property (nonatomic, retain) IBOutlet UILabel* schedule;
@property (nonatomic, retain) IBOutlet UIButton* callButton;

@property (nonatomic, retain) NSDictionary* doctor;
@property (nonatomic, retain) UIWebView* callWebView;

- (void)initChildControls;

@end

@implementation UIDoctorDetailsViewController

- (id)initWithDoctorInfo:(NSDictionary*)doctor
{
    self = [super initFromNib];
    if (self)
    {
        self.doctor = doctor;
    }

    return self;
}

- (id)initWithDoctor:(Doctor *)doctor
{
    self = [super initFromNib];
    if (self)
    {
        self.doctor = @{@"branch":[NSNumber numberWithInteger:doctor.branch],
                        @"last": doctor.last,
                        @"first": doctor.first,
                        @"middle": doctor.middle,
                        @"speciality": doctor.speciality,
                        @"resume": doctor.resume,
                        @"picture": doctor.picture,
                        @"time": doctor.time};
    }

    return self;
}

- (void)dealloc
{
    self.scroll = nil;
    self.avatar = nil;
    self.last = nil;
    self.first = nil;
    self.middle = nil;
    self.speciality = nil;
    self.resume = nil;
    self.schedule = nil;
    self.callButton = nil;

    self.doctor = nil;
    self.callWebView = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.callWebView = [[[UIWebView alloc] init] autorelease];
    self.scroll.contentSize = CGSizeMake(self.view.bounds.size.width, 500);

    self.callButton.layer.cornerRadius = 3.0f;

    [self initChildControls];

    self.title = @"Врач";
}

#pragma mark - Public Methods

- (IBAction)callButtonPressed:(id)sender
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

#pragma mark - Private Methods

- (void)initChildControls
{
    self.avatar.image = [UIImage imageNamed:self.doctor[@"picture"]];

    self.last.text = self.doctor[@"last"];
    self.first.text = self.doctor[@"first"];
    self.middle.text = self.doctor[@"middle"];

    self.speciality.text = self.doctor[@"speciality"];
    if (self.doctor[@"resume"])
    {
        self.resume.text = self.doctor[@"resume"];
    }
    self.schedule.text = self.doctor[@"time"];
}

@end
