@interface DescriptionViewController : UIViewController <UITextViewDelegate> {}

- (id)initWithNibName:(NSString *)nibNameOrNil story: (NSMutableDictionary *) story1;

- (IBAction) editViewValueChanged: (id) sender;

- (NSString *)htmlFor:(NSString *)description;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) NSMutableDictionary *story;

@end