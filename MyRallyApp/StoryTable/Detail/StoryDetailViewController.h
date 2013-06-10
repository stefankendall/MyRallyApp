@interface StoryDetailViewController : UITableViewController
{}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property(nonatomic, strong) NSDictionary *story;
@end