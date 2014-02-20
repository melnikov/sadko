//
//  UIServiceListViewController.m
//  SadkoProto
//

#import "UIServiceListViewController.h"

@interface UIServiceListViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@end

@implementation UIServiceListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Услуги";
}

@end
