#import <Foundation/Foundation.h>

#import <SSignalKit/SSignalKit.h>
#import "TGShareContext.h"

@class TGUserModel;

@interface TGChatListSignal : NSObject

+ (TGUserModel *)userModelWithApiUser:(Api48_User *)user;

+ (SSignal *)remoteChatListWithContext:(TGShareContext *)context;



@end
