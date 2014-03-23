//
//  UIServiceDetailsViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIServiceDetailsViewController.h"

#import "UIDoctorDetailsViewController.h"

@interface UIServiceDetailsViewController ()

@property (nonatomic, retain) IBOutlet UIScrollView* scroll;
@property (nonatomic, retain) IBOutlet UILabel* serviceTitle;
@property (nonatomic, retain) IBOutlet UIImageView* logo;
@property (nonatomic, retain) IBOutlet UITextView* description;
@property (nonatomic, retain) IBOutlet UITableView* table;
@property (nonatomic, retain) IBOutlet UIButton* callButton;

@property (nonatomic, retain) NSDictionary* clinic;
@property (nonatomic, retain) Service* service;
@property (nonatomic, retain) UIWebView* callWebView;

- (void)initChildControls;

@end

@implementation UIServiceDetailsViewController

- (id)initWithClinicInfo:(NSDictionary*)clinic andService:(Service*)service
{
    self = [super initFromNib];
    if (self)
    {
        self.clinic = clinic;
        self.service = service;
    }
    return self;
}

- (void)dealloc
{
    self.table = nil;
    self.scroll = nil;
    self.serviceTitle = nil;
    self.clinic = nil;
    self.logo = nil;
    self.description = nil;
    self.callButton = nil;

    self.service = nil;
    self.callWebView = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.callWebView = [[[UIWebView alloc] init] autorelease];
    self.scroll.contentSize = CGSizeMake(self.view.bounds.size.width, 970);

    [self initChildControls];

    self.table.backgroundView = nil;
    self.table.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.separatorColor = [UIColor whiteColor];

    self.callButton.layer.cornerRadius = 3.0f;

    self.title = @"Услуга";
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
    self.serviceTitle.text = self.service.title;

    self.logo.image = [UIImage imageNamed:self.service.image];
    if (self.service.description)
    {
        self.description.text = self.service.description;
    }
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.service.doctors count];
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
    }

    NSInteger docIndex = [[self.service.doctors objectAtIndex:indexPath.row] integerValue];
    NSDictionary* doc = [self.clinic[@"docs"] objectAtIndex:docIndex];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", doc[@"last"], doc[@"first"], doc[@"middle"]];
    cell.imageView.image = [UIImage imageNamed:doc[@"picture"]];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger docIndex = [[self.service.doctors objectAtIndex:indexPath.row] integerValue];
    NSDictionary* doc = [self.clinic[@"docs"] objectAtIndex:docIndex];

    UIDoctorDetailsViewController* doctor = [[UIDoctorDetailsViewController alloc] initWithDoctorInfo:doc];
    [self.navigationController pushViewController:doctor animated:YES];
    [doctor release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
