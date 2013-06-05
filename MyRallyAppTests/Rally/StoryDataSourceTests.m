#import "StoryDataSourceTests.h"
#import "StoryDataSource.h"
#import "StoryCell.h"

@implementation StoryDataSourceTests

- (void)testGetsStoryCells {
    StoryDataSource *dataSource = [StoryDataSource new];
    dataSource.stories = @[@{@"Name" : @"Test Story"}];

    StoryCell *cell = [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertNotNil(cell, @"");
}

@end