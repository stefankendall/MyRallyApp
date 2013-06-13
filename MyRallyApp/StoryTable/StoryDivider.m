#import "StoryDivider.h"

@implementation StoryDivider

- (NSMutableDictionary *)storiesByScheduleState:(NSArray *)stories {
    NSMutableDictionary *storiesByScheduleState = [NSMutableDictionary new];

    for (NSDictionary *story in stories) {
        NSString *state = [story objectForKey:@"ScheduleState"];
        NSMutableArray *existing = [storiesByScheduleState objectForKey:state];
        if (!existing) {
            existing = [@[] mutableCopy];
        }
        [existing addObject:[story mutableCopy]];

        [storiesByScheduleState setObject:existing forKey:state];
    }

    return storiesByScheduleState;
}
@end