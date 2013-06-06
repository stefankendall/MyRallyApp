
#import <UIKit/UIKit.h>
#import "IBAFormViewController.h"

@class LoginDataSource;

@interface RALoginController : IBAFormViewController <UIGestureRecognizerDelegate> {
    LoginDataSource *loginDataSource;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end