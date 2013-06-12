#import "StoryStoreTests.h"
#import "StoryStore.h"
#import "StoryDivider.h"

@implementation StoryStoreTests

- (void)testReturnsOrderedScheduleStates {
    [[StoryStore instance] setStoriesByScheduleState:[[[StoryDivider new] storiesByScheduleState:
            @[
                    @{@"Name" : @"Test Story", @"ScheduleState" : @"In-Progress"},
                    @{@"Name" : @"Test Story2", @"ScheduleState" : @"Completed"}
            ]
    ] mutableCopy]];

    NSArray *orderedStates = [[StoryStore instance] getOrderedScheduleStates];
    STAssertTrue([orderedStates[0] isEqualToString:@"In-Progress"], @"");
}

- (void)testUpdateStoryReplacesExistingStory {
    StoryStore *store = [StoryStore instance];
    [store setStoriesByScheduleState:[[[StoryDivider new] storiesByScheduleState:
            @[
                    @{@"ObjectID" : @1, @"Name" : @"Test Story", @"ScheduleState" : @"In-Progress"},
                    @{@"ObjectID" : @3, @"Name" : @"Test Story", @"ScheduleState" : @"In-Progress"},
                    @{@"ObjectID" : @2, @"Name" : @"Test Story2", @"ScheduleState" : @"Completed"}
            ]
    ] mutableCopy]];

    [store updateStory:@{@"ObjectID" : @1, @"Name" : @"Test Story Updated", @"ScheduleState" : @"In-Progress"}];

    NSArray *inProgressStories = [store storiesByScheduleState][@"In-Progress"];
    NSDictionary *story = inProgressStories[0];
    STAssertEqualObjects([story objectForKey:@"Name"], @"Test Story Updated", @"");
    STAssertEquals([inProgressStories count], 2U, @"");
}

- (void)testUpdateStoryNewScheduleStateMovesStory {
    StoryStore *store = [StoryStore instance];
    [store setStoriesByScheduleState:[[[StoryDivider new] storiesByScheduleState:
            @[
                    @{@"ObjectID" : @1, @"Name" : @"Test Story", @"ScheduleState" : @"In-Progress"},
                    @{@"ObjectID" : @3, @"Name" : @"Test Story", @"ScheduleState" : @"In-Progress"},
                    @{@"ObjectID" : @2, @"Name" : @"Test Story2", @"ScheduleState" : @"Completed"}
            ]
    ] mutableCopy]];

    [store updateStory:@{@"ObjectID" : @1, @"ScheduleState" : @"Completed"}];

    STAssertEquals([[store storiesByScheduleState][@"Completed"] count], 2, @"");
    STAssertEquals([[store storiesByScheduleState][@"In-Progress"] count], 1, @"");
}

@end