//
//  UISlideMenuViewController.h
//  SadkoProto
//
//  Created by Artyom Syrov on 21.04.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBaseViewController.h"

#import "JASidePanelController.h"

typedef enum
{
    UISlideMenuItemHistory = 0,
    UISlideMenuItemDoctors,
    UISlideMenuItemServices,
    UISlideMenuItemSendEmail,
    UISlideMenuItemCalc,
    UISlideMenuItemDeals,
    UISlideMenuItemContacts,
    //-------------------------//
    UISlideMenuItemTotal
}
UIMainMenuItem;

@interface UISlideMenuViewController : UIBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) JASidePanelController* sidePanelController;

@property (nonatomic, retain) UIViewController* centerController;

@end
