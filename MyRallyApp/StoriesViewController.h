@class StoryDataSource;
@class StoryTableDelegate;

@interface StoriesViewController : UIViewController
{
    __weak IBOutlet UITableView *storiesTable;
    StoryDataSource<UITableViewDataSource> *storiesDataSource;
    StoryTableDelegate *storiesTableDelegate;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

- (void)populateWithStories:(NSArray *)stories;
@end