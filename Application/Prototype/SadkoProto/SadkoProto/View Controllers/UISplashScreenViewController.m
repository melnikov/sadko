//
//  UISplashScreenViewController.m
//  SadkoProto
//

#import "AppDelegate.h"
#import "MBProgressHUD.h"

#import "UISplashScreenViewController.h"

#import "JASidePanelController.h"

#import "UISlideMenuViewController.h"
#import "UIMainMenuViewController.h"

@interface UISplashScreenViewController ()

@property (nonatomic, retain) IBOutlet UIImageView* background;

@property (nonatomic, retain) MBProgressHUD* hud;
@property (nonatomic, retain) NSTimer* progressTimer;

@end

@implementation UISplashScreenViewController

- (void)dealloc
{
    self.background = nil;
    self.hud = nil;

    [self.progressTimer invalidate];
    self.progressTimer = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (isPhone568)
    {
        self.background.image = [UIImage imageNamed: @"Default-568h"];
    }
    else
    {
        self.background.image = [UIImage imageNamed: @"Default~iphone"];
    }

    UIAlertView* downloadAlert = [[[UIAlertView alloc] initWithTitle:@"Обновление данных" message:@"На сервере доступно обновление данных для приложения. Загрузить?" delegate:self cancelButtonTitle:@"Не сейчас" otherButtonTitles:@"Загрузить", nil] autorelease];
    [downloadAlert show];
}

- (void)progressTimerCallback
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];

    UIMainMenuViewController* mainScreen = [[UIMainMenuViewController alloc] initWithScript:@"Clinics"];
    UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController:mainScreen];
    [[UIApplication sharedApplication] delegate].window.rootViewController = navVC;

    [navVC release];
    [mainScreen release];
}

#pragma mark - Alert View Delegate Methods

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud.labelText = @"Загрузка";
        self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(progressTimerCallback) userInfo:nil repeats:NO];
    }
    else
    {
        UISlideMenuViewController* slideMenu = [[[UISlideMenuViewController alloc] initFromNib] autorelease];
        UIMainMenuViewController* mainScreen = [[UIMainMenuViewController alloc] initWithScript:@"Clinics"];
        UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController:mainScreen];
        
        JASidePanelController* sidePanelViewController = [[JASidePanelController alloc] init];
        sidePanelViewController.bounceOnSidePanelOpen = NO;
        sidePanelViewController.bounceOnSidePanelClose = NO;
        sidePanelViewController.bounceOnCenterPanelChange = NO;
        
        slideMenu.sidePanelController = sidePanelViewController;
        slideMenu.centerController = mainScreen;
        
        sidePanelViewController.leftPanel = slideMenu;
        sidePanelViewController.centerPanel = navVC;
        sidePanelViewController.shouldDelegateAutorotateToVisiblePanel = NO;
        
        [[UIApplication sharedApplication] delegate].window.rootViewController = sidePanelViewController;
    }
}

@end
