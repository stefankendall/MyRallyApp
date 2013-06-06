#import "LoginDataSource.h"
#import "IBATextFormField.h"
#import "IBATextFormField+Factory.h"
#import "IBAButtonFormField.h"
#import "IBAFormFieldStyle+Login.h"

@implementation LoginDataSource



- (id)initWithModel:(id)model {
    if (self = [super initWithModel:model]) {
        IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];

        IBATextFormField *email = [IBATextFormField emailTextFormFieldWithSection:basicFieldSection keyPath:@"email" title:@"Email" valueTransformer:nil];
        IBATextFormField *password = [IBATextFormField passwordTextFormFieldWithSection:basicFieldSection keyPath:@"password" title:@"Password" valueTransformer:nil];

        [email setFormFieldStyle:[IBAFormFieldStyle textFormFieldStyle]];
        [password setFormFieldStyle:[IBAFormFieldStyle textFormFieldStyle]];

        UITextField *passwordTextField = [[password textFormFieldCell] textField];
        [passwordTextField setKeyboardType:UIKeyboardTypeDefault];
        [passwordTextField setReturnKeyType:UIReturnKeyDone];


        IBAFormSection *submitFormSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
        IBAButtonFormField *submitFormField = [[IBAButtonFormField alloc] initWithTitle:@"Login"];
        [submitFormField setFormFieldStyle:[IBAFormFieldStyle buttonFormFieldStyle]];
        [submitFormSection addFormField:submitFormField];
    }
    return self;
}

@end