#import "RALoginController.h"

#define kFieldLabelTag 101

@interface RALoginController ()
@property(nonatomic, strong) EZForm *loginForm;
@property(nonatomic, strong) NSDictionary *formCells;
@end

@implementation RALoginController

- (void)awakeFromNib {
    [self initializeForm];
}

- (void)initializeForm {
    self.loginForm = [EZForm new];
    self.loginForm.inputAccessoryType = EZFormInputAccessoryTypeStandard;
    [self.loginForm setDelegate:self];

    EZFormTextField *emailField = [[EZFormTextField alloc] initWithKey:@"email"];
    emailField.validationMinCharacters = 1;
    [self.loginForm addFormField:emailField];

    EZFormTextField *passwordField = [[EZFormTextField alloc] initWithKey:@"password"];
    passwordField.validationMinCharacters = 1;
    [self.loginForm addFormField:passwordField];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    EZFormTextField *emailFormField = [self.loginForm formFieldForKey:@"email"];
    [emailFormField useTextField:self.emailField];

    EZFormTextField *passwordFormField = [self.loginForm formFieldForKey:@"password"];
    [passwordFormField useTextField:self.passwordField];
    [self.passwordField addTarget:self
                           action:@selector(passwordSet:)
                 forControlEvents:UIControlEventEditingDidEndOnExit];

    [self.loginForm autoScrollViewForKeyboardInput:self.tableView];

    self.formCells = @{@"email" : self.emailCell, @"password" : self.passwordCell};
    [self updateLoginOnValidity];
    [self.loginButton addTarget:self action:@selector(attemptLogin) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateLoginOnValidity {
    if ([self.loginForm isFormValid]) {
        [self.loginButton setEnabled:YES];
        [self.loginButton setAlpha:1];
    }
    else {
        [self.loginButton setEnabled:NO];
        [self.loginButton setAlpha:0.4];
    }
}

- (void)passwordSet:(id)password {
    if ([self.loginForm isFormValid]) {
        [self attemptLogin];
    }
}

- (void)attemptLogin {
    [self.view endEditing:YES];
}

- (void)updateValidityIndicatorForField:(EZFormField *)formField {
    UITableViewCell *cell = [self.formCells valueForKey:[formField key]];
    UILabel *label = (UILabel *) [cell viewWithTag:kFieldLabelTag];
    if ([formField isValid]) {
        label.textColor = [UIColor blackColor];
        if ([label.text hasSuffix:@"*"]) {
            label.text = [label.text substringToIndex:[label.text length] - 1];
        }
    }
    else {
        label.textColor = [UIColor redColor];
        if (![label.text hasSuffix:@"*"]) {
            label.text = [label.text stringByAppendingString:@"*"];
        }
    }
}

- (void)form:(EZForm *)form didUpdateValueForField:(EZFormField *)formField modelIsValid:(BOOL)isValid {
    [self updateValidityIndicatorForField:formField];
    [self updateLoginOnValidity];
}

@end