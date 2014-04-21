//
//  UIAllDoctorsViewController.h
//  SadkoProto
//
//  Created by Artyom Syrov on 21.04.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "UIBaseViewController.h"

@interface UIAllDoctorsViewController : UIBaseViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate>

- (id)initWithAllClinics:(NSArray*)clinics;

@end
