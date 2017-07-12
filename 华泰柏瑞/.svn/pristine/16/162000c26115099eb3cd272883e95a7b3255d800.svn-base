//
//  UserModel.m
//  htbr
//
//  Created by somepark on 2017/4/25.
//  Copyright © 2017年 宋金杰. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (id)initWithDictionary:(id)dic
{
    self = [super init];
    if (self) {
        //TODO customer inilization
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [self praseDictionary:dic];
        }
    }
    return self;
}
- (void)praseDictionary:(NSDictionary *)dic
{
    _checkIndex = [dic objectForKey:@"checkIndex"];
    _keyLN = [dic objectForKey:@"keyLN"];
    _keyTD = [dic objectForKey:@"keyTD"];
    _cerType = [dic objectForKey:@"cerType"];
    _pType = [dic objectForKey:@"pType"];
    _logtype = [dic objectForKey:@"logtype"];
    
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    
    self.checkIndex = [coder decodeObjectForKey:@"checkIndex"];
    self.keyLN = [coder decodeObjectForKey:@"keyLN"];
    self.keyTD = [coder decodeObjectForKey:@"keyTD"];
    self.cerType = [coder decodeObjectForKey:@"cerType"];
    self.pType = [coder decodeObjectForKey:@"pType"];
    self.logtype = [coder decodeObjectForKey:@"logtype"];
    
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{

    [coder encodeObject:self.checkIndex forKey:@"checkIndex"];
    [coder encodeObject:self.keyLN forKey:@"keyLN"];
    [coder encodeObject:self.keyTD forKey:@"keyTD"];
    [coder encodeObject:self.cerType forKey:@"cerType"];
    [coder encodeObject:self.pType forKey:@"pType"];
    [coder encodeObject:self.logtype forKey:@"logtype"];
    
}
@end
