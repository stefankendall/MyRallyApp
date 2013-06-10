#import "StoryDataSource.h"
#import "StoryCell.h"
#import "StoryStore.h"

@implementation StoryDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[[StoryStore instance] storiesByScheduleState] allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[StoryStore instance] getOrderedScheduleStates][(NSUInteger) section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [[StoryStore instance] getOrderedScheduleStates][(NSUInteger) section];
    return [[[StoryStore instance] storiesByScheduleState] [key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
    if (cell == nil ) {
        cell = [StoryCell create];
    }

    NSString *key = [[StoryStore instance] getOrderedScheduleStates][(NSUInteger) [indexPath section]];
    [cell setStory:[[StoryStore instance] storiesByScheduleState] [key][(NSUInteger) [indexPath row]]];
    return cell;
}

@end