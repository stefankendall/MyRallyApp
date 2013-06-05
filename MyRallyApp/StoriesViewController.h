@class StoryDataSource;

@interface StoriesViewController : UIViewController
{
    __weak IBOutlet UITableView *storiesTable;
    StoryDataSource<UITableViewDataSource> *storiesDataSource;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

- (void)populateWithStories:(NSArray *)stories;
@end