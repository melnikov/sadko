//
//  DataManager.m
//  SadkoProto
//
//  Created by Artyom Syrov on 05.03.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

SYNTHESIZE_SINGLETON_FOR_CLASS(DataManager)

#pragma mark - Initialization/Destruction

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.filter = nil;
        self.card = nil;
    }
    
    return self;
}

- (void)dealloc
{
    self.filter = nil;
    self.card = nil;
    
    [super dealloc];
}

-(void)resetFilterWithCapacity:(NSInteger)count
{
    self.filter = [[[NSMutableArray alloc] initWithCapacity:count] autorelease];

    for (int i = 0; i < count; i ++)
    {
        [self.filter addObject:[NSNumber numberWithBool:YES]];
    }
}

@end
