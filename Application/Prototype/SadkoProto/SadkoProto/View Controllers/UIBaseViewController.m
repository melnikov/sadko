//
//  UIBaseViewController.m
//  SadkoProto
//

#import "UIBaseViewController.h"

#import "UIImage+Extensions.h"

#define TITLE_TAG 111

@interface UIBaseViewController ()

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, copy) ButtonActionBlock leftButtonActionBlock;
@property (nonatomic, copy) ButtonActionBlock rightButtonActionBlock;

@end

@implementation UIBaseViewController

#pragma mark - Initialization/deallocation

- (id)initFromNib
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = UIColorFromRGB(140, 192, 202);

    [self initTitleLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0, 109, 175)] forBarMetrics:UIBarMetricsDefault];
    [[self.navigationController.navigationBar viewWithTag:TITLE_TAG] removeFromSuperview];
    
    const CGFloat buttonWidth = 26;
    SET_FRAME_X(self.titleLabel.frame, buttonWidth);
    SET_FRAME_WIDTH(self.titleLabel.frame, self.navigationController.navigationBar.bounds.size.width - 2 * buttonWidth);
    
    [[[self navigationController] navigationBar] addSubview:[self titleLabel]];

    [self initBackButton];

    [super viewWillAppear:animated];
}

#pragma mark - UIViewcontroller methods

- (void)setTitle:(NSString *)title
{
    [self.titleLabel setText:title];
}

#pragma mark - Private Methods

- (void)initBackButton
{
    if ([[self.navigationController viewControllers] count] > 1)
    {
        [self setLeftNavigationBarButtonWithImage:[UIImage imageNamed:@"back"]
                                     pressedImage:[UIImage imageNamed:@"back"]
                                     title:@"Назад"
                                            block:^
         {
             [self.navigationController popViewControllerAnimated:YES];
         }];
    }
}

- (void)initTitleLabel
{
    [self setTitleLabel:[[[UILabel alloc] initWithFrame:[[[self navigationController] navigationBar] bounds]]autorelease]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [self.titleLabel setTag:TITLE_TAG];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
}

- (void)leftBarButtonItemWasClicked
{
    self.leftButtonActionBlock();
}


- (void)rightBarButtonItemWasClicked
{
    self.rightButtonActionBlock();
}

#pragma mark - Public Methods

- (void) setLeftNavigationBarButtonWithImage:(UIImage *)image
                                pressedImage:(UIImage *)pressedImage
                                       block:(ButtonActionBlock)block
{
    [self setLeftNavigationBarButtonWithImage:image pressedImage:pressedImage title:@"" block:^
     {
         block();
     }];
}

- (void) setRightNavigationBarButtonWithImage:(UIImage *)image
                                 pressedImage:(UIImage *)pressedImage
                                        block:(ButtonActionBlock)block
{
    [self setRightNavigationBarButtonWithImage:image pressedImage:pressedImage title:@"" block:^
     {
         block();
     }];
}

- (void) setLeftNavigationBarButtonWithImage:(UIImage *)image
                         pressedImage:(UIImage *)pressedImage
                         title:(NSString *)title
                         block:(ButtonActionBlock)block
{
    [self setLeftButtonActionBlock:block];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [button addTarget:self action:@selector(leftBarButtonItemWasClicked) forControlEvents:UIControlEventTouchUpInside];
    
    button.contentMode = UIViewContentModeLeft;
    [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [button.titleLabel setAdjustsFontSizeToFitWidth:button.frame.size.width];;
    
    [button setTitleColor:[UIColor whiteColor]            forState:UIControlStateNormal];
    [button setTitle:title                                forState:UIControlStateNormal];
    [button setImage:image                      forState:UIControlStateNormal];
    [button setImage:pressedImage               forState:UIControlStateSelected];
    
    if (IOS_VERSION_LESS_THAN(@"7.0"))
        [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    else
        [button setContentEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    button.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.navigationItem setLeftBarButtonItem:item];

    [button release];
    [item release];
}

- (void) setRightNavigationBarButtonWithImage:(UIImage *)image
                                 pressedImage:(UIImage *)pressedImage
                                        title:(NSString *)title
                                        block:(ButtonActionBlock)block
{
    [self setRightButtonActionBlock:block];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [button addTarget:self action:@selector(rightBarButtonItemWasClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [button.titleLabel setAdjustsFontSizeToFitWidth:[button frame].size.width];
    
    [button setTitleColor:[UIColor whiteColor]            forState:UIControlStateNormal];
    [button setBackgroundImage:image                      forState:UIControlStateNormal];
    [button setBackgroundImage:pressedImage               forState:UIControlStateSelected];
    [button setTitle:title                                forState:UIControlStateNormal];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.navigationItem setRightBarButtonItem:item];
    
    [button release];
    [item release];
}

@end
