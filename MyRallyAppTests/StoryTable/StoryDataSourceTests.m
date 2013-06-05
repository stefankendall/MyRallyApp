#import "StoryDataSourceTests.h"
#import "StoryDataSource.h"
#import "StoryCell.h"

@implementation StoryDataSourceTests

- (void)testGetsStoryCells {
    StoryDataSource *dataSource = [StoryDataSource new];
    dataSource.stories = @[@{@"Name" : @"Test Story"}];

    StoryCell *cell = (StoryCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertNotNil(cell, @"");
}

- (void)testReturnsDifferentStoriesPerSection {
    StoryDataSource *dataSource = [StoryDataSource new];
    dataSource.stories = @[
            @{@"Name" : @"Test Story", @"ScheduleState" : @"In-Progress"},
            @{@"Name" : @"Test Story2", @"ScheduleState" : @"Completed"}
    ];

    StoryCell *cell1 = (StoryCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    StoryCell *cell2 = (StoryCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    STAssertFalse([[cell1.nameLabel text] isEqualToString:[cell2.nameLabel text]], @"");
}

@end