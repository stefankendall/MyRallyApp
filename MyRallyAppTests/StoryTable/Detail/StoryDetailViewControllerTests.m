#import "StoryDetailViewControllerTests.h"
#import "StoryDetailViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"

@implementation StoryDetailViewControllerTests

- (void)testSetStorySetsViewLabels {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    NSString *formattedId = @"S34567";
    NSString *name = @"Do the work";
    NSString *feature = @"S23456";
    [controller setStory:@{@"FormattedID" : formattedId, @"Name" : name, @"Feature" : feature}];
    [controller setupFields];
    STAssertEqualObjects(controller.navigationItem.title, formattedId, @"");
    STAssertEqualObjects([controller.nameTextField text], name, @"");
    STAssertEqualObjects([controller.featureLabel text], feature, @"");
}

- (void)testSetStoryFeatureNull {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    [controller setStory:@{@"Feature" : [NSNull new]}];
    [controller setupFields];
    STAssertEqualObjects([controller.featureLabel text], @"", @"");
}

- (void)testReadyField {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    [controller setStory:@{@"Ready" : @0}];
    [controller setupFields];
    STAssertEqualObjects([controller.readyLabel text], @"No", @"");
}

- (void)testBlockedField {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    [controller setStory:@{@"Blocked" : @1}];
    [controller setupFields];
    STAssertEqualObjects([controller.blockedLabel text], @"Yes", @"");
}

- (void)testBlockedReasonField {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    [controller setStory:@{@"BlockedReason" : @"reason"}];
    [controller setupFields];
    STAssertEqualObjects([controller.blockedReasonLabel text], @"reason", @"");
}

- (void) testPlanEstimate {
    StoryDetailViewController *controller = [self getControllerByStoryboardIdentifier:@"detailView"];
    [controller setStory:@{@"PlanEstimate" : @1}];
    [controller setupFields];
    STAssertEqualObjects([controller.planEstimateLabel text], @"1", @"");
}

@end