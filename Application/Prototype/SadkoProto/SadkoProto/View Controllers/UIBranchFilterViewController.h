//
//  UIBranchFilterViewController.h
//  SadkoProto
//
//  Created by Artyom Syrov on 28.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBaseViewController.h"

@interface UIBranchFilterViewController : UIBaseViewController

@property (nonatomic, retain) NSString* category;

- (id)initWithClinicInfo:(NSDictionary *)clinic;

@end
