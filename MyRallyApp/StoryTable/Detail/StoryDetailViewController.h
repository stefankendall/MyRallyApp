#import "EZForm.h"

@interface StoryDetailViewController : UITableViewController<EZFormDelegate>
{}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *featureLabel;
@property (weak, nonatomic) IBOutlet UIButton *readyButton;
@property (weak, nonatomic) IBOutlet UIButton *blockedButton;
@property (weak, nonatomic) IBOutlet UITextField *planEstimateField;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *blockedReasonTextField;


@property (weak, nonatomic) IBOutlet UIWebView *descriptionWebView;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *iterationLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskEstimateTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskRemainingTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskActualTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *acceptedDateLabel;

@property(nonatomic, strong) NSMutableDictionary *story;
- (IBAction)saveButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property(nonatomic, strong) EZForm *form;
@property (weak, nonatomic) IBOutlet UITableViewCell *blockedReasonCell;

- (void)setupFields;
@end