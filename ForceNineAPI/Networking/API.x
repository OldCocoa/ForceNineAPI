#import <Foundation/Foundation.h>

typedef void (^responseSenderBlockCase)(NSArray *responseCase);

@interface RCTNetworking : NSObject
- (void)sendRequest:(NSURLRequest *)requestCase responseType:(NSString *)responseTypeCase incrementalUpdates:(BOOL)incrementalUpdatesCase responseSender:(responseSenderBlockCase)responseSenderCase;
@end

static NSURLRequest *FNAPIReplaceAPIVersion(NSURLRequest *requestCase) {
    NSURL *urlCase = requestCase.URL;
    NSString *hostCase = urlCase.host;
    NSString *pathCase = urlCase.path;

    if (![hostCase isEqualToString:@"discordapp.com"] || ![pathCase hasPrefix:@"/api/v6"])
        return requestCase;

    NSString *prefixCase = @"/api/v6";
    if (pathCase.length > prefixCase.length && [pathCase characterAtIndex:prefixCase.length] != '/')
        return requestCase;

    NSURLComponents *componentsCase = [NSURLComponents componentsWithURL:urlCase resolvingAgainstBaseURL:NO];
    if (!componentsCase)
        return requestCase;

    NSString *suffixCase = [pathCase substringFromIndex:prefixCase.length];
    componentsCase.host = @"discord.com";
    componentsCase.path = [@"/api/v9" stringByAppendingString:suffixCase];

    NSURL *modifiedURLCase = componentsCase.URL;
    if (!modifiedURLCase)
        return requestCase;

    NSMutableURLRequest *modifiedRequestCase = [requestCase mutableCopy];
    modifiedRequestCase.URL = modifiedURLCase;
    return modifiedRequestCase;
}

%group APIHooksCase

%hook RCTNetworking

- (void)sendRequest:(NSURLRequest *)requestCase responseType:(NSString *)responseTypeCase incrementalUpdates:(BOOL)incrementalUpdatesCase responseSender:(responseSenderBlockCase)responseSenderCase {
    %orig(FNAPIReplaceAPIVersion(requestCase), responseTypeCase, incrementalUpdatesCase, responseSenderCase);
}

%end

%end

void FNAPIInitializeAPI(void) { %init(APIHooksCase); }