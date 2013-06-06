#import <CoreGraphics/CoreGraphics.h>
#import "RALoginController.h"
#import "LoginDataSource.h"

@implementation RALoginController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView:tableView];

    loginDataSource = [LoginDataSource new];
    [self setFormDataSource:loginDataSource];
}

@end