//
//  Utils.m
//  MegaTaxi
//

#import "Utils.h"

@implementation Utils

+ (float)systemVersion
{
    NSString *ver = [[UIDevice currentDevice] systemVersion];
    return [ver floatValue];
}

@end
