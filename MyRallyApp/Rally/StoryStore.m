#import "StoryStore.h"
#import "NSArray+Enumerable.h"

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

- (void)updateStory:(NSDictionary *)updatedStory {
    NSNumber *objectId = [updatedStory objectForKey:@"ObjectID"];
    NSString *scheduleState = [updatedStory objectForKey:@"ScheduleState"];

    int index = [self.storiesByScheduleState[scheduleState] findIndexWithBlock:^BOOL(NSDictionary *story) {
        return [[story objectForKey:@"ObjectID"] isEqual:objectId];
    }];

    if (index >= 0) {
        [self replaceStoryInScheduleState:updatedStory scheduleState:scheduleState index:index];
    }
    else {
        NSArray *existing = self.storiesByScheduleState[scheduleState];
        if (!existing) {
            [self.storiesByScheduleState setObject:@[updatedStory] forKey:scheduleState];
        }
        else {
            NSArray *stories = self.storiesByScheduleState[scheduleState];
            NSMutableArray *newStories = [stories mutableCopy];
            [newStories addObject:updatedStory];
            self.storiesByScheduleState[scheduleState] = newStories;
        }
        [self removeExistingStoryInAnotherScheduleState:updatedStory];
    }
}

- (void)removeExistingStoryInAnotherScheduleState:(NSDictionary *)story {
    NSString *scheduleState = [story objectForKey:@"ScheduleState"];
    NSArray *otherScheduleStates = [[self getOrderedScheduleStates] select:^BOOL(NSString *state) {
        return ![state isEqualToString:scheduleState];
    }];

    [otherScheduleStates each:^(NSString *state) {
        NSArray *stories = self.storiesByScheduleState[state];
        NSDictionary *matchingStory = [stories detect:^BOOL(NSDictionary *otherStory) {
            return [[otherStory objectForKey:@"ObjectID"] isEqual:[story objectForKey:@"ObjectID"]];
        }];

        if (matchingStory) {
            NSArray *newStories = [stories reject:^BOOL(NSDictionary *otherStory) {
                return otherStory == matchingStory;
            }];
            self.storiesByScheduleState[state] = newStories;
        }
    }];
}

- (void)replaceStoryInScheduleState:(NSDictionary *)updatedStory scheduleState:(NSString *)scheduleState index:(int)index {
    NSArray *stories = self.storiesByScheduleState[scheduleState];
    NSMutableArray *newStories = [stories mutableCopy];
    [newStories replaceObjectAtIndex:(NSUInteger) index withObject:updatedStory];
    [self.storiesByScheduleState setObject:newStories forKey:scheduleState];
}


@end