#import "AFHTTPClient.h"

extern NSString *const TEST_USER;
extern NSString *const TEST_PASSWORD;

@interface RallyClient : AFHTTPClient {
    __block NSString *securityToken;
}

+ (RallyClient *)instance;

- (void)setUsername:(NSString *)username andPassword:(NSString *)password;

- (void)authorize:(void (^)())success failure:(void (^)())failure;

- (void)getSecurityTokenWithSuccess:(void (^)(NSString *))successCallback andFailure:(void (^)())failureCallback;

- (NSString *)getSecurityTokenFromJson:(NSDictionary *)json;

- (void)getActiveStoriesForUser: (NSString*) username success:(void (^)(NSArray *))success failure:(void (^)())failure;

@property(nonatomic, strong) NSString *username;

@end