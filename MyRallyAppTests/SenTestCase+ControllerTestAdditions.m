#import "SenTestCase+ControllerTestAdditions.h"

@implementation SenTestCase (ControllerTestAdditions)

- (id)getControllerByStoryboardIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:identifier];
    UINavigationController *mainNav = [storyboard instantiateViewControllerWithIdentifier:@"mainNav"];
    [mainNav setViewControllers:@[controller]];
    [controller viewDidLoad];
    [controller viewWillAppear:YES];
    return controller;
}

@end