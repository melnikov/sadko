//
//  UITopTenQuestionsViewController.h
//  SadkoProto
//
//  Created by Artyom Syrov on 20.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBaseViewController.h"

@interface UITopTenQuestionsViewController : UIBaseViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initWithScript:(NSString*)script;

@end
