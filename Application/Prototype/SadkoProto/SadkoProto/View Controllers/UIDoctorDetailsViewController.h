//
//  UIDoctorDetailsViewController.h
//  SadkoProto
//

#import "UIBaseViewController.h"

#import "Doctor.h"

@interface UIDoctorDetailsViewController : UIBaseViewController

- (id)initWithDoctorInfo:(NSDictionary*)doctor;

- (id)initWithDoctor:(Doctor*)doctor;

@end
