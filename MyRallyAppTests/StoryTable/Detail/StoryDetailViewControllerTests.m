#import "StoryDetailViewControllerTests.h"
#import "StoryDetailViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"

@implementation StoryDetailViewControllerTests

- (void)testSetStorySetsViewLabels {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    NSString *formattedId = @"S34567";
    NSString *name = @"Do the work";
    NSString *feature = @"S23456";
    [controller setStory:[@{@"FormattedID" : formattedId, @"Name" : name, @"Feature" : feature} mutableCopy]];
    [controller setupFields];
    STAssertEqualObjects(controller.navigationItem.title, formattedId, @"");
    STAssertEqualObjects([controller.nameTextField text], name, @"");
    STAssertEqualObjects([controller.featureLabel text], feature, @"");
}

- (void)testSetStoryFeatureNull {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    [controller setStory:[@{@"Feature" : [NSNull new]} mutableCopy]];
    [controller setupFields];
    STAssertEqualObjects([controller.featureLabel text], @"", @"");
}

- (void)testReadyField {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    [controller setStory:[@{@"Ready" : @0} mutableCopy]];
    [controller setupFields];
    STAssertEqualObjects([controller.readyButton titleForState:UIControlStateNormal], @"No", @"");
}

- (void)testBlockedField {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    [controller setStory:[@{@"Blocked" : @1} mutableCopy]];
    [controller setupFields];
    STAssertEqualObjects([controller.blockedButton titleForState:UIControlStateNormal], @"Yes", @"");
}

- (void)testBlockedReasonField {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    [controller setStory:[@{@"BlockedReason" : @"reason"} mutableCopy]];
    [controller setupFields];
    STAssertEqualObjects([controller.blockedReasonTextField text], @"reason", @"");
}

- (void)testPlanEstimate {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    [controller setStory:[@{@"PlanEstimate" : @1} mutableCopy]];
    [controller setupFields];
    STAssertEqualObjects([controller.planEstimateField text], @"1", @"");
}

- (void)testRelease {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];

    [controller setStory:[@{@"Release" : @{@"_rallyAPIMajor" : @2,
            @"_rallyAPIMinor" : @0, @"_ref" : @"https://rally1.rallydev.com/slm/webservice/v2.0/release/10073767343",
            @"_refObjectName" : @"2013.01.16", @"_type" : @"Release"}} mutableCopy]];
    [controller setupFields];
    STAssertEqualObjects([controller.releaseLabel text], @"2013.01.16", @"");
}

- (void)testReleaseNull {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];

    [controller setStory:[@{@"Release" : [NSNull new]} mutableCopy]];
    [controller setupFields];
    STAssertEqualObjects([controller.releaseLabel text], @"", @"");
}

- (void) testUpdateBooleanFieldChangesText {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    EZFormField *field = [controller.form formFieldForKey:@"Ready"];

    [field setFieldValue:@1];
    [controller form:controller.form didUpdateValueForField:field modelIsValid:YES];
    STAssertEqualObjects([controller.readyButton titleForState:UIControlStateNormal], @"Yes", @"");

    [field setFieldValue:@0];
    [controller form:controller.form didUpdateValueForField:field modelIsValid:YES];
    STAssertEqualObjects([controller.readyButton titleForState:UIControlStateNormal], @"No", @"");
}

@end