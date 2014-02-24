//
//  UIServiceDetailsViewController.h
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBaseViewController.h"

@interface UIServiceDetailsViewController : UIBaseViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initWithClinicInfo:(NSDictionary*)clinic andService:(NSDictionary*)service;

@end
