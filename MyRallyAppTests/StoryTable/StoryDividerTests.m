#import "StoryDividerTests.h"
#import "StoryDivider.h"

@implementation StoryDividerTests

- (void)testPartitionsStoriesByScheduleState {
    StoryDivider *divider = [StoryDivider new];
    NSArray *stories = @[
            @{@"ScheduleState" : @"In-Progress"},
            @{@"ScheduleState" : @"In-Progress"},
            @{@"ScheduleState" : @"Ready"},
            @{@"ScheduleState" : @"Completed"},
            @{@"ScheduleState" : @"In-Progress"},
            @{@"ScheduleState" : @"Completed"}
    ];
    NSDictionary *storiesByScheduleState = [divider storiesByScheduleState:stories];
    STAssertEquals([[storiesByScheduleState allKeys] count], 3U, @"");
    STAssertEquals([[storiesByScheduleState objectForKey:@"In-Progress"] count], 3U, @"");
    STAssertEquals([[storiesByScheduleState objectForKey:@"Completed"] count], 2U, @"");
    STAssertEquals([[storiesByScheduleState objectForKey:@"Ready"] count], 1U, @"");
}

@end