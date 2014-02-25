//
//  UIBranchDetailsViewController.h
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBaseViewController.h"

#import <MessageUI/MessageUI.h>

@interface UIBranchDetailsViewController : UIBaseViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>

- (id)initWithBranchInfo:(NSDictionary*)branch;

@end
