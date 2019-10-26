//
//  UserViewModel.m
//  iospraktis
//
//  Created by OPSolutions on 25/10/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "UserViewModel.h"
#import "User.h"

@interface UserViewModel () 

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSMutableArray *arrayOfUsers;
@property (strong, nonatomic) NSUserDefaults *userDefault;

@end

@implementation UserViewModel

- (User *)setUserWithDictionary:(NSDictionary *)dataDictionary {
    self.user = [[User alloc] initUserEmail:dataDictionary[@"email"] withPassword:dataDictionary[@"password"] withName:dataDictionary[@"name"] withPhoneNumber:dataDictionary[@"phoneNumber"]];
    
    return self.user;
}

- (void)initializeLocalObjects {
    self.userDefault = [NSUserDefaults standardUserDefaults];
    self.arrayOfUsers = [[NSMutableArray alloc] init];
}

- (BOOL)registerNewUser {
    [self setArrayOfUsers];
    if ([self hasExistingUser]) {
        NSLog(@"Has Existing User");
        return NO;
    }
    return [self saveDataToUserDefaults];
}

- (BOOL)saveDataToUserDefaults {
    [self.arrayOfUsers addObject:self.user];
    [self encodeUserArrayData];
   return [self hasExistingUser];
}

- (void)setArrayOfUsers {
    [self initializeLocalObjects];
    if ([self hasRegisteredUsers]) {
    self.arrayOfUsers = [self decodeUserArrayData];
    }
}

#pragma mark Encoding Functions

- (void)encodeUserArrayData {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.arrayOfUsers requiringSecureCoding:NO error:nil];
    [self.userDefault setObject:data forKey:@"arrayOfUsers"];
}

- (NSMutableArray *)decodeUserArrayData {
    NSData *newData = [self.userDefault objectForKey:@"arrayOfUsers"];
    NSMutableArray *decodedUserArray = [NSKeyedUnarchiver unarchiveObjectWithData:newData];
    
    return decodedUserArray;
}

#pragma mark Validation

- (BOOL)hasExistingUser {
    NSMutableArray *arrayOfUsersForValidation = [self decodeUserArrayData];
    for (User *user in arrayOfUsersForValidation) {
        if ([user.email isEqualToString:self.user.email]) {
            NSLog(@"user: %@",self.user.email);
            return YES;
        }
    }
    return NO;
}

- (BOOL)hasRegisteredUsers {
    NSMutableArray *fetchedUsersArray = [self decodeUserArrayData];
    if (fetchedUsersArray.count != 0) {
        return YES;
    }
    return NO;
}

#pragma mark Log In Authentication

- (BOOL)authenticateUser:(NSString *)email withPassword:(NSString *)password {
    [self initializeLocalObjects];
    NSMutableArray *arrayOfUsersForValidation = [self decodeUserArrayData];
   
    for (User *user in arrayOfUsersForValidation) {
        if ([user.email isEqualToString:email] && [user.password isEqualToString:password]) {
            self.user = user;
            NSLog(@"authenticte User: %@",self.user);
            return YES;
        }
    }
    return NO;
}

@end
