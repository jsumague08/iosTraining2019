//
//  RegisterViewController.m
//  iospraktis
//
//  Created by OPSolutions on 25/10/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserViewModel.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) UserViewModel *userViewModel;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    self.userViewModel = [[UserViewModel alloc] init];
}

- (IBAction)registerButtonPressed:(id)sender {
    if (![self textFieldsAreFilledAndPasswordsMatch]) {
        return;
    }
    
    NSDictionary *dataDictionary = @{ @"email" : self.emailTextField.text, @"name" : self.nameTextField.text, @"password" : self.passwordTextField.text, @"phoneNumber" : self.phoneNumberTextField.text };
    
    [self.userViewModel setUserWithDictionary:dataDictionary];
    
    BOOL registeringSuccess = [self.userViewModel registerNewUser];
    
    if (registeringSuccess) {        
        [self performSegueWithIdentifier:@"showHomeScreenFromRegisterSegue" sender:self];
        }
    
    if (!registeringSuccess) {
        [self showAlertView:@"User Already Exists"];
    }
}

- (void)showAlertView:(NSString *)alertMessage {
    if (alertMessage) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okayButton = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:okayButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (BOOL)confirmPasswordMatch {
    if ([self.confirmPasswordTextField.text isEqualToString:self.passwordTextField.text]) {
        return YES;
    }
    return NO;
}

- (BOOL)textFieldsFilled {
    if ([self.emailTextField hasText] && [self.passwordTextField hasText] && [self.confirmPasswordTextField hasText] && [self.nameTextField hasText] && [self.phoneNumberTextField hasText]) {
        return YES;
    }
    return NO;
}

- (BOOL)textFieldsAreFilledAndPasswordsMatch {
    NSString *alertMessage;
    if  (![self textFieldsFilled]) {
        alertMessage = @"Please fill up required fields";
        [self showAlertView:alertMessage];
        return NO;
    }
    
    if  (![self confirmPasswordMatch]) {
        alertMessage = @"Password does not match";
        [self showAlertView:alertMessage];
        return NO;
    }
    
    return YES;
}

- (void)configureUI {
    
    self.emailTextField.layer.cornerRadius = self.emailTextField.frame.size.height/2;
    self.nameTextField.layer.cornerRadius = self.nameTextField.frame.size.height/2;
    self.phoneNumberTextField.layer.cornerRadius = self.phoneNumberTextField.frame.size.height/2;
    self.passwordTextField.layer.cornerRadius = self.passwordTextField.frame.size.height/2;
    self.confirmPasswordTextField.layer.cornerRadius = self.confirmPasswordTextField.frame.size.height/2;
    self.registerButton.layer.cornerRadius = self.registerButton.frame.size.height/2;
}

@end
