#import "StoryStoreTests.h"
#import "StoryStore.h"
#import "StoryDivider.h"

@implementation StoryStoreTests

- (void)testReturnsOrderedScheduleStates {
    [[StoryStore instance] setStoriesByScheduleState:[[StoryDivider new] storiesByScheduleState:
            @[
                    @{@"Name" : @"Test Story", @"ScheduleState" : @"In-Progress"},
                    @{@"Name" : @"Test Story2", @"ScheduleState" : @"Completed"}
            ]
    ]];

    NSArray *orderedStates = [[StoryStore instance] getOrderedScheduleStates];
    STAssertTrue([orderedStates[0] isEqualToString:@"In-Progress"], @"");
}

@end