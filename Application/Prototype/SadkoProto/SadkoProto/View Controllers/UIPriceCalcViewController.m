//
//  UIPriceCalcViewController.m
//  SadkoProto
//
//  Created by Artyom Syrov on 21.04.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIPriceCalcViewController.h"

#import "MBProgressHUD.h"

@interface UIPriceCalcViewController ()

@property (nonatomic, retain) IBOutlet UITextField* nameField;
@property (nonatomic, retain) IBOutlet UITextField* phoneField;
@property (nonatomic, retain) IBOutlet UITextView* textView;
@property (nonatomic, retain) IBOutlet UIButton* sendButton;

@property (nonatomic, retain) MBProgressHUD* hud;
@property (nonatomic, retain) NSTimer* progressTimer;

- (void)doneButtonPressed;

@end

@implementation UIPriceCalcViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Расчет стоимости";

    self.sendButton.layer.cornerRadius = 3.0f;

    UIBarButtonItem* doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed)];
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    [keyboardToolbar setBarStyle:UIBarStyleDefault];
    [keyboardToolbar setItems:@[doneButtonItem] animated:YES];
    
    self.nameField.inputAccessoryView = keyboardToolbar;
    self.phoneField.inputAccessoryView = keyboardToolbar;
    self.textView.inputAccessoryView = keyboardToolbar;
}

- (void)dealloc
{
    self.nameField = nil;
    self.phoneField = nil;
    self.textView = nil;
    self.sendButton = nil;

    self.hud = nil;
    [self.progressTimer invalidate];
    self.progressTimer = nil;

    [super dealloc];
}

#pragma mark - User Interaction

- (IBAction)sendButtonPressed:(id)sender
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Отправка";
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(progressTimerCallback) userInfo:nil repeats:NO];
}

#pragma mark - Private Methods

- (void)progressTimerCallback
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    
    UIAlertView* downloadAlert = [[[UIAlertView alloc] initWithTitle:@"Отправка запроса" message:@"Ваш запрос успешно отправлен" delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil] autorelease];
    [downloadAlert show];
}

- (void)doneButtonPressed
{
    if ([self.nameField isFirstResponder])
    {
        [self.nameField resignFirstResponder];
    }

    if ([self.phoneField isFirstResponder])
    {
        [self.phoneField resignFirstResponder];
    }

    if ([self.textView isFirstResponder])
    {
        [self.textView resignFirstResponder];
    }
}

#pragma mark - Alert View Delegate Methods

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
