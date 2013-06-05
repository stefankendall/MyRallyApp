#import "RALoginController.h"

@implementation RALoginController

- (void)viewDidLoad {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideEditing)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)hideEditing {
    [self.view endEditing:YES];
}


@end