#import <QuartzCore/QuartzCore.h>
#import "StoryDetailViewController.h"
#import "RallyClient.h"
#import "StoryStore.h"
#import "DescriptionViewController.h"
#import "HtmlWrapper.h"

@interface StoryDetailViewController ()
@property(nonatomic, strong) NSDictionary *cells;
@end

@implementation StoryDetailViewController

- (void)awakeFromNib {
    [self initializeForm];
}

- (void)initializeForm {
    self.form = [EZForm new];
    self.form.inputAccessoryType = EZFormInputAccessoryTypeStandard;
    [self.form setDelegate:self];

    EZFormTextField *nameField = [[EZFormTextField alloc] initWithKey:@"Name"];
    nameField.validationMinCharacters = 1;
    [self.form addFormField:nameField];

    EZFormBooleanField *readyField = [[EZFormBooleanField alloc] initWithKey:@"Ready"];
    [self.form addFormField:readyField];

    EZFormTextField *descriptionField = [[EZFormTextField alloc] initWithKey:@"Description"];
    [self.form addFormField:descriptionField];

    EZFormBooleanField *blockedField = [[EZFormBooleanField alloc] initWithKey:@"Blocked"];
    [self.form addFormField:blockedField];

    EZFormTextField *blockedReasonField = [[EZFormTextField alloc] initWithKey:@"BlockedReason"];
    [self.form addFormField:blockedReasonField];

    EZFormTextField *planEstimateField = [[EZFormTextField alloc] initWithKey:@"PlanEstimate"];
    [self.form addFormField:planEstimateField];
}

- (void)viewDidLoad {
    [self wireFormFields];
}

- (void)wireFormFields {
    EZFormTextField *nameFormField = [self.form formFieldForKey:@"Name"];
    [nameFormField useTextField:self.nameTextField];

    EZFormTextField *descriptionFormField = [self.form formFieldForKey:@"Description"];
    [descriptionFormField useLabel:self.descriptionLabel];

    EZFormTextField *blockedReasonFormField = [self.form formFieldForKey:@"BlockedReason"];
    [blockedReasonFormField useTextField:self.blockedReasonTextField];

    EZFormBooleanField *readyField = [self.form formFieldForKey:@"Ready"];
    [readyField useButton:self.readyButton];

    EZFormBooleanField *blockedField = [self.form formFieldForKey:@"Blocked"];
    [blockedField useButton:self.blockedButton];

    EZFormTextField *planEstimateFormField = [self.form formFieldForKey:@"PlanEstimate"];
    [planEstimateFormField useTextField:self.planEstimateField];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupFields];
}

- (IBAction)saveButtonTapped:(id)sender {
    [self saveForm];
}

- (void)setupFields {
    self.navigationItem.title = self.story[@"FormattedID"];
    [self.nameTextField setText:self.story[@"Name"]];
    NSString *descriptionText = self.story[@"Description"];


    [self.descriptionWebView loadHTMLString:[[HtmlWrapper new] htmlFor:descriptionText] baseURL:nil];
    [self.descriptionLabel setText:descriptionText];
    [self.featureLabel setText:[self replaceIfNull:self.story[@"Feature"]]];
    [self setupBooleanField:self.readyButton withName:@"Ready"];
    [self setupBooleanField:self.blockedButton withName:@"Blocked"];
    [self.blockedReasonTextField setText:[self replaceIfNull:self.story[@"BlockedReason"]]];

    [self showHideBlockedReason];

    [self.releaseLabel setText:[self replaceIfNull:self.story[@"Release"]]];
    [self.iterationLabel setText:[self replaceIfNull:self.story[@"Iteration"]]];
    [self.planEstimateField setText:[self convertNumeric:self.story[@"PlanEstimate"]]];
    [self.taskEstimateTotalLabel setText:[self convertNumeric:self.story[@"TaskEstimateTotal"]]];
    [self.taskRemainingTotalLabel setText:[self convertNumeric:self.story[@"TaskRemainingTotal"]]];
    [self.taskActualTotalLabel setText:[self convertNumeric:self.story[@"TaskActualTotal"]]];
    [self.acceptedDateLabel setText:[self replaceIfNull:self.story[@"AcceptedDate"]]];
}

- (void)showHideBlockedReason {
    [CATransaction begin];
    [self.tableView beginUpdates];
    [CATransaction setCompletionBlock:^{
        [[self.blockedReasonCell contentView] setHidden:NO];
    }];
    [[self.blockedReasonCell contentView] setHidden:YES];
    [self.blockedReasonCell setHidden:!([self storyIsBlocked])];
    [self.tableView endUpdates];
    [CATransaction commit];
}

- (BOOL)storyIsBlocked {
    return [[[self.form modelValues] objectForKey:@"Blocked"] intValue] > 0;
}

- (void)setupBooleanField:(UIButton *)button withName:(NSString *)name {
    NSNumber *value = self.story[name];
    [button setTitle:[self booleanNameOf:value] forState:UIControlStateNormal];
    [[self.form formFieldForKey:name] setFieldValue:[NSNumber numberWithBool:([value intValue] > 0)]];
}

- (void)saveForm {
    [self enableDisableForm:NO];
    NSMutableDictionary *newValues = [[self.form modelValues] mutableCopy];
    [newValues setObject:self.story[@"Description"] forKey:@"Description"];
    [[RallyClient instance] updateStory:self.story withValues:newValues withSuccess:^(id json) {
        self.story = json;
        [self setupFields];
        [self enableDisableForm:YES];
        [[StoryStore instance] updateStory:json];
        [self.tableView reloadData];
    }                        andFailure:^{
        NSLog(@"%@", self.story);
        [self setupFields];
        [self enableDisableForm:YES];
    }];
}

- (void)enableDisableForm:(BOOL)enabled {
    [self.tableView endEditing:YES];
    [self.tableView setUserInteractionEnabled:enabled];
    [[self.navigationItem leftBarButtonItem] setEnabled:enabled];
    [[self.navigationItem rightBarButtonItem] setEnabled:enabled];
}

- (void)form:(EZForm *)form didUpdateValueForField:(EZFormField *)formField modelIsValid:(BOOL)isValid {
    if ([formField isKindOfClass:EZFormBooleanField.class]) {
        UIButton *button = (UIButton *) formField.userView;
        [button setTitle:[self booleanNameOf:[formField fieldValue]] forState:UIControlStateNormal];
        [self showHideBlockedReason];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1) {
        DescriptionViewController *controller = [[DescriptionViewController alloc] initWithStory:self.story];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 3 && [indexPath row] == 2 && ![self storyIsBlocked]) {
        return 0;
    }
    else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}


- (id)replaceIfNull:(id)field {
    if (![field isKindOfClass:NSNull.class]) {
        return field;
    }
    return @"";
}

- (NSString *)convertNumeric:(id)o {
    NSNumber *number = o;
    if ([number isKindOfClass:NSNull.class]) {
        return @"";
    }

    return [NSString stringWithFormat:@"%d", [number intValue]];
}

- (NSString *)booleanNameOf:(id)o {
    NSNumber *number = o;
    if ([number intValue] > 0) {
        return @"Yes";
    }
    else {
        return @"No";
    }
}

@end