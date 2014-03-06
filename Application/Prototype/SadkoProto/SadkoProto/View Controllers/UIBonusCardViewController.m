//
//  UIBonusCardViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 03.03.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBonusCardViewController.h"

#import "DataManager.h"

@interface UIBonusCardViewController ()

@property (nonatomic, retain) IBOutlet UITableView* table;
@property (nonatomic, retain) IBOutlet UILabel* emptyLabel;

@property (nonatomic, retain) ZBarReaderViewController* reader;

- (void)addCardButtonPressed;

@end

@implementation UIBonusCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.table.backgroundView = nil;
    self.table.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.separatorColor = [UIColor whiteColor];
    
    self.title = @"Карты";

    [self setRightNavigationBarButtonWithImage:nil pressedImage:nil title:@"Добавить" block:^
    {
        [self addCardButtonPressed];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSArray* cards = [DataManager sharedInstance].cards;

    if (!cards || ([cards count] == 0))
    {
        self.emptyLabel.hidden = NO;
        self.table.hidden = YES;
    }
    else
    {
        self.emptyLabel.hidden = YES;
        self.table.hidden = NO;
    }

    [self.table reloadData];
}

#pragma mark - Private Methods

- (void)addCardButtonPressed
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Ввести код вручную",
                            @"Сканировать код",
                            nil];
    popup.tag = 111;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark - Action Sheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (popup.tag == 111)
    {
        switch (buttonIndex)
        {
            case 0:
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Введите номер карты:"
                                                                 message:nil
                                                                delegate:self
                                                       cancelButtonTitle:@"Отмена"
                                                      otherButtonTitles:@"ОК", nil];
                [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                alert.tag = 222;
                [alert show];
                break;
            }
            case 1:
            {
                self.reader = [ZBarReaderViewController new];
                self.reader.readerDelegate = self;
                self.reader.readerView.zoom = 1.0f;
                [self presentViewController:self.reader animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - Alert View Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 222)
    {
        if (buttonIndex == 1)
        {
            if([[alertView textFieldAtIndex:0].text length] > 0)
            {
                NSString* value = [alertView textFieldAtIndex:0].text;
                [[DataManager sharedInstance].cards addObject:value];

                self.table.hidden = NO;
                self.emptyLabel.hidden = YES;
                [self.table reloadData];
            }
            else
            {
                UIAlertView  *errorMessage = [[UIAlertView alloc]initWithTitle:@"Ошибка" message:@"Код карты введен неверно" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [errorMessage show];
            }
        }
    }
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DataManager sharedInstance].cards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* kMenuCellId = @"DoctorsCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellId];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMenuCellId];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [[DataManager sharedInstance].cards objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)
    {
        NSString *upcString = symbol.data;
        [[DataManager sharedInstance].cards addObject:upcString];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Добавление карты" message:[NSString stringWithFormat:@"Добавлена карта: %@", upcString] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        [self.reader dismissViewControllerAnimated:YES completion:nil];
        break;
    }
}

@end
