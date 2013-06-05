@interface StoryDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *stories;
@property(nonatomic, strong) NSDictionary *storiesByScheduleState;
@end