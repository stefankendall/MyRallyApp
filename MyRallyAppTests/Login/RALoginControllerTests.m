#import "RALoginControllerTests.h"
#import "RALoginController.h"

@implementation RALoginControllerTests

- (void) setUp {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

- (void)testAuthorizeSuccessSeguesToNextScreen {
    RALoginController *controller = [self getController];

    [controller authorizeSuccess];
    STAssertEquals([controller.navigationController.viewControllers count], 2U, @"");
}

- (void)testAuthorizeSuccessSavesEmailAndPassword{
    RALoginController *controller = [self getController];
    [controller.emailField setText:@"skendall@rallydev.com"];
    [controller.passwordField setText:@"Password"];
    [controller authorizeSuccess];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    STAssertNotNil([prefs objectForKey:@"email"], @"");
    STAssertNotNil([prefs objectForKey:@"password"], @"");
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

- (void)testSeguesWhenUsernameAndPasswordAreStored {
    RALoginController *controller = [self getController];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"skendall@rallydev.com" forKey:@"email"];
    [prefs setObject:@"Password" forKey:@"password"];

    [controller viewDidLoad];

    STAssertEquals([controller.navigationController.viewControllers count], 2U, @"");
}

- (void)testDoesNotSegueWhenUsernameAndPasswordNotStored {
    RALoginController *controller = [self getController];

    [controller viewDidLoad];

    STAssertEquals([controller.navigationController.viewControllers count], 1U, @"");
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