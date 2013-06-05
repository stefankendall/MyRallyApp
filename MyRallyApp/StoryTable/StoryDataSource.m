#import <CoreGraphics/CoreGraphics.h>
#import "StoryDataSource.h"
#import "StoryCell.h"

@implementation StoryDataSource
@synthesize stories;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
    if (cell == nil ) {
        cell = [StoryCell create];
    }

    [cell setStory:stories[(NSUInteger) [indexPath row]]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *viewToPreventBlankRows = [UIView new];
    return viewToPreventBlankRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryCell *cell = (StoryCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell bounds].size.height;
}


@end