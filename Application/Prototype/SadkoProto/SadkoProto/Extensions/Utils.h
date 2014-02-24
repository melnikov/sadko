//
//  Utils.h
//  MegaTaxi
//

#import <Foundation/Foundation.h>

#define isTablet ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define isPhone568 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
#define iPhone568ImageNamed(image) (isPhone568 ? [NSString stringWithFormat:@"%@-568h@2x.%@", [image stringByDeletingPathExtension], [image pathExtension]] : image)
#define iPhone568Image(image) ([UIImage imageNamed:iPhone568ImageNamed(image)])
#define iosDeviceType [UIDevice currentDevice].model

#define UNKNOWN -1

@interface Utils : NSObject

+ (float)systemVersion;

@end
