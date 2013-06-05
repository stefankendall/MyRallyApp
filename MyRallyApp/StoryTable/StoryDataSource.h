@interface StoryDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *scheduleStateOrder;
}

@property(nonatomic, strong) NSArray *stories;
@property(nonatomic, strong) NSDictionary *storiesByScheduleState;


- (NSArray *)getOrderedScheduleStates;

@end