//
//  UISplashScreenViewController.m
//  SadkoProto
//

#import "AppDelegate.h"
#import "MBProgressHUD.h"

#import "UISplashScreenViewController.h"

#import "UIMainScreenViewController.h"

@interface UISplashScreenViewController ()

@property (nonatomic, strong) IBOutlet UIImageView* background;

@property (nonatomic, strong) MBProgressHUD* hud;
@property (nonatomic, strong) NSTimer* progressTimer;

@end

@implementation UISplashScreenViewController

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

    UIAlertView* downloadAlert = [[UIAlertView alloc] initWithTitle:@"Обновление данных" message:@"На сервере доступно обновление данных для приложения. Загрузить?" delegate:self cancelButtonTitle:@"Не сейчас" otherButtonTitles:@"Загрузить", nil];
    [downloadAlert show];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)progressTimerCallback
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];

    UIMainScreenViewController* mainScreen = [[UIMainScreenViewController alloc] initWithScript:@"Clinics"];
    UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController:mainScreen];
    [[UIApplication sharedApplication] delegate].window.rootViewController = navVC;
}

#pragma mark - Alert View Delegate Methods

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud.labelText = @"Загрузка";
        self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(progressTimerCallback) userInfo:nil repeats:YES];
    }
    else
    {
        UIMainScreenViewController* mainScreen = [[UIMainScreenViewController alloc] initWithScript:@"Clinics"];
        UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController:mainScreen];
        [[UIApplication sharedApplication] delegate].window.rootViewController = navVC;
    }
}

@end
