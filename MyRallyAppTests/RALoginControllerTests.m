#import "RALoginControllerTests.h"
#import "RALoginController.h"

@implementation RALoginControllerTests

- (void)testAuthorizeSuccessSeguesToNextScreen {
    RALoginController *controller = [self getController];

    [controller authorizeSuccess];
    STAssertEquals([controller.navigationController.viewControllers count], 2U, @"");
}

- (void)testSegueIsBlockedByAuth {
    RALoginController *controller = [self getController];

    STAssertFalse([controller shouldPerformSegueWithIdentifier:@"loginSegue" sender:controller], @"");

    [controller authorizeSuccess];
    STAssertTrue([controller shouldPerformSegueWithIdentifier:@"loginSegue" sender:controller], @"");
}

- (void)testFailureClearsPassword {
    RALoginController *controller = [self getController];
    [controller.passwordField setText:@"test"];
    [controller authorizeFailure];

    STAssertTrue([[controller.passwordField text] isEqualToString:@""], @"");
}

- (RALoginController *)getController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    RALoginController *controller = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    UINavigationController *mainNav = [storyboard instantiateViewControllerWithIdentifier:@"mainNav"];
    [mainNav setViewControllers:@[controller]];
    [controller viewDidLoad];
    return controller;
}

@end