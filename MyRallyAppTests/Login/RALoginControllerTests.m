#import "RALoginControllerTests.h"
#import "RALoginController.h"
#import "SenTestCase+ControllerTestAdditions.h"

@implementation RALoginControllerTests

- (void) setUp {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

- (void)testAuthorizeSuccessSeguesToNextScreen {
    RALoginController *controller = [self getControllerByStoryboardIdentifier:@"login"];

    [controller authorizeSuccess];
    STAssertEquals([controller.navigationController.viewControllers count], 2U, @"");
}

- (void)testAuthorizeSuccessSavesEmailAndPassword{
    RALoginController *controller = [self getControllerByStoryboardIdentifier:@"login"];
    [controller.emailField setText:@"skendall@rallydev.com"];
    [controller.passwordField setText:@"Password"];
    [controller authorizeSuccess];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    STAssertNotNil([prefs objectForKey:@"email"], @"");
    STAssertNotNil([prefs objectForKey:@"password"], @"");
}

- (void)testSegueIsBlockedByAuth {
    RALoginController *controller = [self getControllerByStoryboardIdentifier:@"login"];

    STAssertFalse([controller shouldPerformSegueWithIdentifier:@"loginSegue" sender:controller], @"");

    [controller authorizeSuccess];
    STAssertTrue([controller shouldPerformSegueWithIdentifier:@"loginSegue" sender:controller], @"");
}

- (void)testFailureClearsPassword {
    RALoginController *controller = [self getControllerByStoryboardIdentifier:@"login"];
    [controller.passwordField setText:@"test"];
    [controller authorizeFailure];

    STAssertTrue([[controller.passwordField text] isEqualToString:@""], @"");
}

- (void)testSeguesWhenUsernameAndPasswordAreStored {
    RALoginController *controller = [self getControllerByStoryboardIdentifier:@"login"];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"skendall@rallydev.com" forKey:@"email"];
    [prefs setObject:@"Password" forKey:@"password"];

    [controller viewDidLoad];

    STAssertEquals([controller.navigationController.viewControllers count], 2U, @"");
}

- (void)testDoesNotSegueWhenUsernameAndPasswordNotStored {
    RALoginController *controller = [self getControllerByStoryboardIdentifier:@"login"];

    [controller viewDidLoad];

    STAssertEquals([controller.navigationController.viewControllers count], 1U, @"");
}

@end