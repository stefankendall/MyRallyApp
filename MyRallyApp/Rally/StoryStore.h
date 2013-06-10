@interface StoryStore : NSObject

@property(nonatomic, strong) NSDictionary *storiesByScheduleState;

-(NSArray *) getOrderedScheduleStates;

+(StoryStore *) instance;

@end