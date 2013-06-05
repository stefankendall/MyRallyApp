@interface StoryDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *stories;
@end