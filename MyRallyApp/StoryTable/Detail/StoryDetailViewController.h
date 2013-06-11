#import "EZForm.h"

@interface StoryDetailViewController : UITableViewController<EZFormDelegate>
{}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *featureLabel;
@property (weak, nonatomic) IBOutlet UILabel *readyLabel;
@property (weak, nonatomic) IBOutlet UILabel *blockedLabel;
@property (weak, nonatomic) IBOutlet UILabel *blockedReasonLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *iterationLabel;
@property (weak, nonatomic) IBOutlet UILabel *planEstimateLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskEstimateTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskRemainingTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskActualTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *acceptedDateLabel;

@property(nonatomic, strong) NSDictionary *story;
- (IBAction)saveButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

- (void)setupFields;
@end