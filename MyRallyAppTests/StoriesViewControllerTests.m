#import "StoriesViewControllerTests.h"
#import "StoriesViewController.h"

@implementation StoriesViewControllerTests

-(void) testShowsHidesLoadingIndicator {
    StoriesViewController *controller = [StoriesViewController new];
    STAssertFalse([[controller loadingIndicator] isHidden], @"");

    [controller populateWithStories: @[]];
    STAssertTrue([[controller loadingIndicator] isHidden], @"");
}

@end