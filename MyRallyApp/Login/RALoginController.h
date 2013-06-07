
#import <UIKit/UIKit.h>
#import "EZForm.h"

@interface RALoginController : UITableViewController<EZFormDelegate>
{
    BOOL authorized;
}

@property (weak, nonatomic) IBOutlet UITableViewCell *emailCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *passwordCell;
@property(nonatomic, strong) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property(nonatomic, strong) IBOutlet UITextField *passwordField;

- (void)authorizeFailure;

- (void)authorizeSuccess;
@end