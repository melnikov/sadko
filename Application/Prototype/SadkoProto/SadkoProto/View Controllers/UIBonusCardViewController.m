//
//  UIBonusCardViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 03.03.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBonusCardViewController.h"

#import "DataManager.h"

#import "UIImage-NKDBarcode.h"
#import "NKDEAN13Barcode.h"

@interface UIBonusCardViewController ()

#define ACTION_SHEET_TAG          111
#define ALERT_MANUAL_ENTER_TAG    222
#define ALERT_SCAN_RESULT_TAG     333

@property (nonatomic, retain) IBOutlet UILabel* emptyLabel;
@property (nonatomic, retain) IBOutlet UIImageView* barCodeImage;
@property (nonatomic, retain) IBOutlet UILabel* barCodeLabel;
@property (nonatomic, retain) IBOutlet UILabel* prompt;

@property (nonatomic, retain) NSString* lastScanned;

@property (nonatomic, retain) ZBarReaderViewController* reader;

- (void)addCardButtonPressed;
- (BOOL)validateManualCode:(NSString*)code;
- (void)updateChildControls;

@end

@implementation UIBonusCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Скидка";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self updateChildControls];
}

#pragma mark - Private Methods

- (void)addCardButtonPressed
{
    NSString* code = [DataManager sharedInstance].card;
    UIActionSheet *popup = nil;

    if (code && [code length] > 0)
    {
        popup = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                 @"Ввести код вручную",
                 @"Сканировать код",
                 @"Удалить текущую карту",
                 nil];
    }
    else
    {
        popup = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                 @"Ввести код вручную",
                 @"Сканировать код",
                 nil];
    }
    popup.tag = ACTION_SHEET_TAG;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)updateChildControls
{
    NSString* code = [DataManager sharedInstance].card;

    if (code && [code length] > 0)
    {
        self.emptyLabel.hidden = YES;
        self.prompt.hidden = NO;
        self.barCodeImage.hidden = NO;
        self.barCodeLabel.hidden = NO;

        NKDBarcode* nkdbarcode = [[NKDEAN13Barcode alloc] initWithContent:code];
        UIImage* image = [UIImage imageFromBarcode:nkdbarcode];
        CGSize size = image.size;

        self.barCodeImage.frame = CGRectMake((self.view.frame.size.width - size.width) / 2, (self.view.frame.size.height - size.height) / 2, size.width, size.height);
        self.barCodeImage.image = image;

        self.barCodeLabel.frame = CGRectMake(0, self.barCodeImage.frame.origin.y + self.barCodeImage.frame.size.height + 10.0f, self.view.frame.size.width, 44.0f);
        self.barCodeLabel.text = code;

        [self setRightNavigationBarButtonWithImage:nil pressedImage:nil title:@"Изменить" block:^
        {
            [self addCardButtonPressed];
        }];
    }
    else
    {
        self.emptyLabel.hidden = NO;
        self.prompt.hidden = YES;
        self.barCodeImage.hidden = YES;
        self.barCodeLabel.hidden = YES;

        self.barCodeImage.image = nil;
        self.barCodeLabel.text = nil;

        [self setRightNavigationBarButtonWithImage:nil pressedImage:nil title:@"Добавить" block:^
        {
            [self addCardButtonPressed];
        }];
    }
}

- (BOOL)validateManualCode:(NSString *)code
{
    if (!code || ([code length] == 0))
        return NO;

    NSCharacterSet* digits = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet* stringSet = [NSCharacterSet characterSetWithCharactersInString:code];
    
    if (![digits isSupersetOfSet: stringSet])
        return NO;

    return YES;
}

#pragma mark - Action Sheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (popup.tag == ACTION_SHEET_TAG)
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
                alert.tag = ALERT_MANUAL_ENTER_TAG;
                [alert show];
                break;
            }
            case 1:
            {
                self.lastScanned = nil;

                self.reader = [ZBarReaderViewController new];
                self.reader.readerDelegate = self;
                self.reader.readerView.zoom = 1.0f;
                [self presentViewController:self.reader animated:YES completion:nil];
                break;
            }
            case 2:
            {
                [DataManager sharedInstance].card = nil;
                [self updateChildControls];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - Alert View Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERT_MANUAL_ENTER_TAG)
    {
        if (buttonIndex == 1)
        {
            NSString* code = [alertView textFieldAtIndex:0].text;
            if ([self validateManualCode:code])
            {
                [DataManager sharedInstance].card = [alertView textFieldAtIndex:0].text;

                [self updateChildControls];
            }
            else
            {
                UIAlertView  *errorMessage = [[UIAlertView alloc]initWithTitle:@"Ошибка" message:@"Код карты введен неверно. Для ввода карты используйте только цифры." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [errorMessage show];
            }
        }
    }
    else if (alertView.tag == ALERT_SCAN_RESULT_TAG)
    {
        if (buttonIndex == 1)
        {
            [DataManager sharedInstance].card = self.lastScanned;

            [self updateChildControls];
        }

        self.lastScanned = nil;
    }
}

#pragma mark - ZBar Reader Delegate Methods

- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)
    {
        self.lastScanned = symbol.data;

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Дисконтная карта" message:[NSString stringWithFormat:@"Добавить карту %@?", self.lastScanned] delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:@"ОК", nil];
        alert.tag = ALERT_SCAN_RESULT_TAG;
        [alert show];

        [self.reader dismissViewControllerAnimated:YES completion:nil];

        break; //We need only the first one
    }
}

@end
