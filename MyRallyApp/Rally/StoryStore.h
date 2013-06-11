@interface StoryStore : NSObject

@property(nonatomic, strong) NSMutableDictionary *storiesByScheduleState;

-(NSArray *) getOrderedScheduleStates;

+(StoryStore *) instance;

- (void)updateStory:(NSDictionary *)o;

@end