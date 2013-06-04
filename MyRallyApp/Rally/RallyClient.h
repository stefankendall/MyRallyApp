#import "AFHTTPClient.h"

@interface RallyClient : AFHTTPClient {
    __block NSString *securityToken;
}

+ (RallyClient *)instance;

- (void)setUsername:(NSString *)username andPassword:(NSString *)password;

- (void)authorize:(void (^)())success failure:(void (^)())failure;

- (void)getSecurityTokenWithSuccess:(void (^)(NSString *))successCallback andFailure:(void (^)())failureCallback;

- (NSString *)getSecurityTokenFromJson:(NSDictionary *)json;

- (void) getActiveStories:(void (^)(NSArray *))success failure:(void (^)())failure;

@end