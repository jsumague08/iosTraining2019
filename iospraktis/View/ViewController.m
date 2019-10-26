//
//  ViewController.m
//  iospraktis
//
//  Created by OPSolutions on 22/10/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "ViewController.h"
#import "UserViewModel.h"
#import "RegisterViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *checkBox;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) UserViewModel *userViewModel;
@property (nonatomic) BOOL checkBoxState;

- (IBAction)checkBoxPressed:(id)sender;
- (IBAction)logInButtonPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    self.userViewModel = [[UserViewModel alloc] init];
}

- (IBAction)logInButtonPressed:(id)sender {
    if ([self emailAndPasswordFilled]) {
        BOOL isUserAuthenticated = [self.userViewModel authenticateUser:self.emailTextField.text withPassword:self.passwordTextField.text];
        
        if (isUserAuthenticated) {
            [self performSegueWithIdentifier:@"showHomeScreenFromLoginSegue" sender:self];
        }
        
        if (!isUserAuthenticated) {
            NSString *alertMessage = @"Invalid Username or Password";
            [self showAlertView:alertMessage];
        }
    }
}

- (BOOL)emailAndPasswordFilled {
    if (![self.emailTextField hasText] || ![self.passwordTextField hasText]) {
        NSString *alertMessage = @"Please input Email & Password";
        [self showAlertView:alertMessage];
        return NO;
    }
    return YES;
}

- (void)showAlertView:(NSString *)alertMessage {
    if (alertMessage) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okayButton = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:okayButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)checkBoxPressed:(id)sender {
    UIImage *backgroundImage = [UIImage new];
    if (self.checkBoxState == NO) {
        
        backgroundImage = [UIImage imageNamed:@"icn_checkMark"];
        [self.checkBox setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        self.checkBoxState = YES;
    }
    else {
        [self.checkBox setBackgroundImage:nil forState:UIControlStateNormal];
        self.checkBoxState = NO;
    }
}

- (void)configureUI {
    self.checkBoxState = NO;
    self.checkBox.layer.borderWidth = 1.5;
    
    self.emailTextField.layer.cornerRadius = self.emailTextField.frame.size.height/2;
    self.passwordTextField.layer.cornerRadius = self.passwordTextField.frame.size.height/2;
    self.loginButton.layer.cornerRadius = self.loginButton.frame.size.height/2;
    
    }
@end
