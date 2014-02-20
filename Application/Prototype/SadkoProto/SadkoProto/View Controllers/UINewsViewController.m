//
//  UINewsViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UINewsViewController.h"

@interface UINewsViewController ()

@property (nonatomic, retain) IBOutlet UIScrollView* dealSelector;
@property (nonatomic, retain) IBOutlet UIPageControl* pageController;
@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSArray* deals;

@end

@implementation UINewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Новости и акции";

    [self initDeals];

    self.dealSelector.delegate = self;
	self.pageController.currentPage = 0;
    
    self.pageController.numberOfPages = [self.deals count];
}

#pragma mark - Private Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.dealSelector.frame.size.width;
    int page = floor((self.dealSelector.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageController.currentPage = page;
}

- (void)initDeals
{
    self.deals = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    
    NSArray* colors = [NSArray arrayWithObjects:[UIColor lightGrayColor], [UIColor redColor], [UIColor blueColor],
                       [UIColor lightGrayColor], [UIColor redColor], nil];
    
    for (int i = 0; i < [self.deals count]; i++)
    {
        UIView* banner = [[UIView alloc] init];
        banner.backgroundColor = [colors objectAtIndex:i];
        banner.frame = CGRectMake(self.dealSelector.contentSize.width, 0, self.dealSelector.bounds.size.width, self.dealSelector.bounds.size.height);
        
        [self.dealSelector addSubview:banner];
        
        self.dealSelector.contentSize = CGSizeMake(self.dealSelector.contentSize.width + banner.frame.size.width, self.dealSelector.contentSize.height);
    }
}

@end
