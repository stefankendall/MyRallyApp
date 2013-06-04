@interface StoriesViewController : UIViewController
{
    __weak IBOutlet UITableView *storiesTable;
    NSObject<UITableViewDataSource> *storiesDataSource;
}
@end