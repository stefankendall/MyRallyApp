@class StoryDataSource;

@interface StoriesViewController : UIViewController <UITableViewDelegate> {
    __weak IBOutlet UITableView *storiesTable;
    StoryDataSource<UITableViewDataSource> *storiesDataSource;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property(nonatomic, strong) NSDictionary *storyInDetail;

- (void)populateWithStories:(NSArray *)stories;
@end