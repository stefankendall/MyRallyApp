#import "StoryDetailViewControllerTests.h"
#import "StoryDetailViewController.h"

@implementation StoryDetailViewControllerTests

- (void)testSetStorySetsViewLabels {
    StoryDetailViewController *controller = [StoryDetailViewController new];
    [controller setStory:@{@"FormattedID" : @"S34567", @"Name" : @"Do the work"}];
    [controller viewWillAppear:YES];
    STAssertEqualObjects(controller.navigationItem.title, @"S34567", @"");
}

@end