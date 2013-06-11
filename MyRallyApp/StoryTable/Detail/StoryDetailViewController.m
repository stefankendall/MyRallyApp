#import "StoryDetailViewController.h"

@interface StoryDetailViewController()
@property(nonatomic, strong) EZForm *form;
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

    EZFormTextField *nameField = [[EZFormTextField alloc] initWithKey:@"name"];
    nameField.validationMinCharacters = 1;
    [self.form addFormField:nameField];
}

- (void)viewDidLoad {
    [self wireFormFields];
}

- (void)wireFormFields {
    EZFormTextField *nameFormField = [self.form formFieldForKey:@"name"];
    [nameFormField useTextField:self.nameTextField];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupFields];
}

- (void)setupFields {
    NSLog(@"%@", self.story);
    self.navigationItem.title = self.story[@"FormattedID"];
    [self.nameTextField setText:self.story[@"Name"]];
    [self.featureLabel setText:[self replaceIfNull:self.story[@"Feature"]]];
    [self.readyLabel setText:[self booleanNameOf:self.story[@"Ready"]]];
    [self.blockedLabel setText:[self booleanNameOf:self.story[@"Blocked"]]];
    [self.blockedReasonLabel setText:[self replaceIfNull:self.story[@"BlockedReason"]]];
    [self.releaseLabel setText:[self replaceIfNull:self.story[@"Release"]]];
    [self.iterationLabel setText:[self replaceIfNull:self.story[@"Iteration"]]];
    [self.planEstimateLabel setText:[self convertNumeric:self.story[@"PlanEstimate"]]];
    [self.taskEstimateTotalLabel setText:[self convertNumeric:self.story[@"TaskEstimateTotal"]]];
    [self.taskRemainingTotalLabel setText:[self convertNumeric:self.story[@"TaskRemainingTotal"]]];
    [self.taskActualTotalLabel setText:[self convertNumeric:self.story[@"TaskActualTotal"]]];
    [self.acceptedDateLabel setText:[self replaceIfNull:self.story[@"AcceptedDate"]]];
}

- (void)form:(EZForm *)form fieldDidEndEditing:(EZFormField *)formField
{
    NSLog(@"formField:%@ didEndEditing",formField);
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