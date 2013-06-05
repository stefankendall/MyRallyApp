#import "StoryDataSource.h"
#import "StoryCell.h"
#import "StoryDivider.h"

@implementation StoryDataSource
@synthesize stories, storiesByScheduleState;

- (id)init {
    self = [super init];
    if (self) {
        scheduleStateOrder = @[@"Idea", @"Defined", @"In-Progress", @"Completed", @"Accepted", @"Released"];
    }

    return self;
}


- (void)setStories:(NSArray *)stories1 {
    stories = stories1;
    storiesByScheduleState = [[StoryDivider new] storiesByScheduleState:stories];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[storiesByScheduleState allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self getOrderedScheduleStates][(NSUInteger) section];
}

- (NSArray *)getOrderedScheduleStates {
    NSArray *scheduleStates = [storiesByScheduleState allKeys];
    return [scheduleStates sortedArrayUsingComparator:^(id obj1, id obj2) {
        NSString *state1 = obj1;
        NSString *state2 = obj2;

        int index1 = [scheduleStateOrder indexOfObject:state1];
        int index2 = [scheduleStateOrder indexOfObject:state2];

        return index1 > index2 ? NSOrderedDescending : (index2 > index1 ? NSOrderedAscending: NSOrderedSame);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [self getOrderedScheduleStates][(NSUInteger) section];
    return [storiesByScheduleState[key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
    if (cell == nil ) {
        cell = [StoryCell create];
    }

    NSString *key = [self getOrderedScheduleStates][(NSUInteger) [indexPath section]];
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