//
//  User.m
//  iospraktis
//
//  Created by OPSolutions on 25/10/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "User.h"

@interface User () <NSCoding>

@end

@implementation User

- (instancetype)initUserEmail:(NSString *)email withPassword:(NSString *)password withName:(NSString *)name withPhoneNumber:(NSString *)phoneNumber {
    if (self) {
        self.email = email;
        self.password = password;
        self.name = name;
        self.phoneNumber = phoneNumber;
    }
    return self;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.email forKey:@"email"];
    [coder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    [coder encodeObject:self.password forKey:@"password"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.email = [coder decodeObjectForKey:@"email"];
        self.phoneNumber = [coder decodeObjectForKey:@"phoneNumber"];
        self.password = [coder decodeObjectForKey:@"password"];
    }
    return self;
}

@end
