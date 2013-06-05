#import "StoryDivider.h"

@implementation StoryDivider

- (NSDictionary *)storiesByScheduleState:(NSArray *)stories {
    NSMutableDictionary *storiesByScheduleState = [NSMutableDictionary new];

    for (NSDictionary *story in stories) {
        NSString *state = [story objectForKey:@"ScheduleState"];
        NSMutableArray *existing = [storiesByScheduleState objectForKey:state];
        if( !existing ){
            existing = [@[] mutableCopy];
        }
        [existing addObject:story];

        [storiesByScheduleState setObject:existing forKey:state];
    }

    return storiesByScheduleState;
}
@end