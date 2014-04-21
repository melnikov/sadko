//
//  Service.h
//  SadkoProto
//
//  Created by Artyom Syrov on 28.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSArray* doctors;

@property (nonatomic, retain) NSDictionary* clinicInfo;

- (id)initWithDictionary:(NSDictionary*)info;

@end
