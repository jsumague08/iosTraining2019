//
//  User.h
//  iospraktis
//
//  Created by OPSolutions on 25/10/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *password;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *phoneNumber;

- (instancetype)initUserEmail:(NSString *)email withPassword:(NSString *)password withName:(NSString *)name withPhoneNumber:(NSString *)phoneNumber;

@end

NS_ASSUME_NONNULL_END
