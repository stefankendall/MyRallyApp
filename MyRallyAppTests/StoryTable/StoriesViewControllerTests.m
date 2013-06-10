#import "StoriesViewControllerTests.h"
#import "StoriesViewController.h"
#import "StoryStore.h"
#import "StoryDivider.h"

@implementation StoriesViewControllerTests

- (void)setUp {
    [[StoryStore instance] setStoriesByScheduleState:[[StoryDivider new] storiesByScheduleState:
            @[
                    @{@"Name" : @"Test Story", @"ScheduleState" : @"In-Progress"},
                    @{@"Name" : @"Test Story2", @"ScheduleState" : @"Completed"}
            ]
    ]];
}

- (void)testSelectRowUsesStoryInSection {
    StoriesViewController *controller = [self getController];
    [controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSDictionary *story1 = controller.storyInDetail;

    [controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSDictionary *story2 = controller.storyInDetail;

    STAssertNotNil(story1, @"");
    STAssertFalse( story1 == story2, @"" );
}

- (StoriesViewController *)getController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    StoriesViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"myStories"];
    UINavigationController *mainNav = [storyboard instantiateViewControllerWithIdentifier:@"mainNav"];
    [mainNav setViewControllers:@[controller]];
    [controller viewDidLoad];
    return controller;
}

@end