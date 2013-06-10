#import "StoryStore.h"

@implementation StoryStore

- (NSArray *)getOrderedScheduleStates {
    NSArray *scheduleStateOrder = @[@"Idea", @"Defined", @"In-Progress", @"Completed", @"Accepted", @"Released"];
    NSArray *scheduleStates = [[[StoryStore instance] storiesByScheduleState] allKeys];
    return [scheduleStates sortedArrayUsingComparator:^(id obj1, id obj2) {
        NSString *state1 = obj1;
        NSString *state2 = obj2;

        int index1 = [scheduleStateOrder indexOfObject:state1];
        int index2 = [scheduleStateOrder indexOfObject:state2];

        return index1 > index2 ? NSOrderedDescending : (index2 > index1 ? NSOrderedAscending : NSOrderedSame);
    }];
}

+ (StoryStore *)instance {
    static dispatch_once_t onceToken = 0;
    static StoryStore *store = nil;

    dispatch_once(&onceToken, ^{
        store = [StoryStore new];
    });

    return store;
}


@end