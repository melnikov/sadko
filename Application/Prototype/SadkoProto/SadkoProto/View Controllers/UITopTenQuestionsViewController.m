//
//  UITopTenQuestionsViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UITopTenQuestionsViewController.h"

#import "UIQuestionAnswerViewController.h"

@interface UITopTenQuestionsViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;

@property (nonatomic, retain) NSArray* questions;

@end

@implementation UITopTenQuestionsViewController

- (id)initWithScript:(NSString*)script
{
    self = [super initFromNib];
    if (self)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:script ofType:@"plist"];
        self.questions = [[[NSArray alloc] initWithContentsOfFile:filePath] autorelease];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.table.backgroundView = nil;
    self.table.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.separatorColor = [UIColor whiteColor];

    self.title = @"Вопросы врачу";
}

- (void)dealloc
{
    self.table = nil;
    self.questions = nil;
    
    [super dealloc];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.questions count];
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

    cell.textLabel.text = [NSString stringWithFormat:@"Вопрос №%d", (int)indexPath.row + 1];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIQuestionAnswerViewController* question = [[UIQuestionAnswerViewController alloc] initWithInfo:[self.questions objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:question animated:YES];
    [question release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
