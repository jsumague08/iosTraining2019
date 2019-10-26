//
//  UserViewModel.h
//  iospraktis
//
//  Created by OPSolutions on 25/10/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserViewModel : NSObject

- (User *)setUserWithDictionary:(NSDictionary *)dataDictionary;
- (BOOL)registerNewUser;
- (BOOL)authenticateUser:(NSString *)email withPassword:(NSString *)password;
    
@end

NS_ASSUME_NONNULL_END
