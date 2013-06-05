#import "StoryCellTests.h"
#import "StoryCell.h"

@implementation StoryCellTests

- (void)testSetStorySetsLabels {
    StoryCell *cell = [StoryCell create];
    [cell setStory:@{@"Name" : @"Test Name"}];
    STAssertTrue( [[[cell nameLabel] text] isEqualToString:@"Test Name"], [[cell nameLabel] text]);
}

@end