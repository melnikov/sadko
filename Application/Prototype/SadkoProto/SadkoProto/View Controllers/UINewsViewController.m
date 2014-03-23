//
//  UINewsViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UINewsViewController.h"

#import "UINewsDetailsViewController.h"

@interface UINewsViewController ()

@property (nonatomic, retain) IBOutlet UIScrollView* dealSelector;
@property (nonatomic, retain) IBOutlet UIPageControl* pageController;
@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSArray* news;
@property (nonatomic, retain) NSArray* deals;

- (void)dealButtonPressed;

@end

@implementation UINewsViewController

- (id)initWithScript:(NSString*)script
{
    self = [super initFromNib];
    if (self)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:script ofType:@"plist"];
        NSDictionary* info = [[[NSDictionary alloc] initWithContentsOfFile:filePath] autorelease];

        self.news = info[@"news"];
        self.deals = info[@"deals"];
    }
    return self;
}

- (void)dealloc
{
    self.table = nil;
    self.dealSelector = nil;
    self.pageController = nil;
    self.news = nil;
    self.deals = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Новости и акции";

    self.table.backgroundView = nil;
    self.table.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.separatorColor = [UIColor whiteColor];

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
    for (int i = 0; i < [self.deals count]; i++)
    {
        UIImageView* banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
        banner.frame = CGRectMake(self.dealSelector.contentSize.width, 0, self.dealSelector.bounds.size.width, self.dealSelector.bounds.size.height);;
        banner.userInteractionEnabled = YES;
        banner.backgroundColor = [UIColor clearColor];

        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealButtonPressed)];
        [banner addGestureRecognizer:tap];
        
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, banner.frame.size.width - 40, banner.frame.size.height - 40)];
        title.backgroundColor = [UIColor clearColor];
        title.numberOfLines = 0;
        title.font = [UIFont systemFontOfSize:18.0f];
        title.textColor = [UIColor blackColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = [self.deals objectAtIndex:i][@"title"];
        
        [banner addSubview:title];
        
        [self.dealSelector addSubview:banner];

        [banner release];
        [title release];
        
        self.dealSelector.contentSize = CGSizeMake(self.dealSelector.contentSize.width + banner.frame.size.width, self.dealSelector.contentSize.height);
    }
}

- (void)dealButtonPressed
{
    UINewsDetailsViewController* newsDetails = [[UINewsDetailsViewController alloc] initWithInfo:[self.deals objectAtIndex:self.pageController.currentPage] andTitle:@"Акция"];
    [self.navigationController pushViewController:newsDetails animated:YES];
    [newsDetails release];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* kMenuCellId = @"DoctorsCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellId];
    
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMenuCellId] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [self.news objectAtIndex:indexPath.row][@"title"];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINewsDetailsViewController* newsDetails = [[UINewsDetailsViewController alloc] initWithInfo:[self.news objectAtIndex:indexPath.row] andTitle:@"Новость"];
    [self.navigationController pushViewController:newsDetails animated:YES];
    [newsDetails release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
