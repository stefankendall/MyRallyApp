
#import <UIKit/UIKit.h>
#import "EZForm.h"

@interface RALoginController : UITableViewController<EZFormDelegate>
{}

@property (weak, nonatomic) IBOutlet UITableViewCell *emailCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *passwordCell;
@property(nonatomic, strong) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property(nonatomic, strong) IBOutlet UITextField *passwordField;
@end