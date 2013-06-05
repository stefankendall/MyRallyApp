#import "StoryDataSource.h"
#import "StoryCell.h"
#import "StoryDivider.h"

@implementation StoryDataSource
@synthesize stories, storiesByScheduleState;

- (void)setStories:(NSArray *)stories1 {
    stories = stories1;
    storiesByScheduleState = [[StoryDivider new] storiesByScheduleState:stories];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[storiesByScheduleState allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [storiesByScheduleState allKeys][(NSUInteger) section];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [[storiesByScheduleState allKeys] objectAtIndex:(NSUInteger) section];
    return [storiesByScheduleState[key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
    if (cell == nil ) {
        cell = [StoryCell create];
    }

    NSString *key = [[storiesByScheduleState allKeys] objectAtIndex:(NSUInteger) [indexPath section]];
    [cell setStory:storiesByScheduleState[key][(NSUInteger) [indexPath row]]];
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