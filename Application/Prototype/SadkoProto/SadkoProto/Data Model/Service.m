//
//  Service.m
//  SadkoProto
//
//  Created by Artyom Syrov on 28.02.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "Service.h"

@implementation Service

- (id)initWithDictionary:(NSDictionary*)info
{
    self = [super init];
    if (self)
    {
        self.title = info[@"title"];
        self.description = info[@"description"];
        self.image = info[@"picture"];
        self.doctors = info[@"docs"];
    }
    return self;
}

- (void)dealloc
{
    self.title = nil;
    self.description = nil;
    self.image = nil;
    self.doctors = nil;
    
    [super dealloc];
}

@end
