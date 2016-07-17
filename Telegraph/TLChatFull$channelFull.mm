#import "TLChatFull$channelFull.h"
#import "TLMetaClassStore.h"

//channelFull flags:# can_view_participants:flags.3?true id:int about:string participants_count:flags.0?int admins_count:flags.1?int kicked_count:flags.2?int read_inbox_max_id:int unread_count:int unread_important_count:int chat_photo:Photo notify_settings:PeerNotifySettings exported_invite:ExportedChatInvite bot_info:Vector<BotInfo> migrated_from_chat_id:flags.4?int migrated_from_max_id:flags.4?int = ChatFull;

@implementation TLChatFull$channelFull

- (void)TLserialize:(NSOutputStream *)__unused os
{
    TGLog(@"***** TLChatFull$channelFull serialization not supported");
}

- (id<TLObject>)TLdeserialize:(NSInputStream *)is signature:(int32_t)__unused signature environment:(id<TLSerializationEnvironment>)environment context:(TLSerializationContext *)__unused context error:(__autoreleasing NSError **)error
{
    TLChatFull$channelFull *result = [[TLChatFull$channelFull alloc] init];
    
    int32_t flags = [is readInt32];
    
    result.flags = flags;
    
    result.canViewParticipants = flags & (1 << 3);
    
    result.n_id = [is readInt32];
    
    result.about = [is readString];
    
    if (flags & (1 << 0)) {
        result.participants_count = [is readInt32];
    }
    
    if (flags & (1 << 1)) {
        result.admins_count = [is readInt32];
    }
    
    if (flags & (1 << 2)) {
        result.kicked_count = [is readInt32];
    }
    
    result.read_inbox_max_id = [is readInt32];
    
    result.unread_count = [is readInt32];
    result.unread_important_count = [is readInt32];
    
    {
        int32_t signature = [is readInt32];
        result.chat_photo = TLMetaClassStore::constructObject(is, signature, environment, nil, error);
    }
    
    {
        int32_t signature = [is readInt32];
        result.notify_settings = TLMetaClassStore::constructObject(is, signature, environment, nil, error);
    }
    
    {
        int32_t signature = [is readInt32];
        result.exported_invite = TLMetaClassStore::constructObject(is, signature, environment, nil, error);
    }
    
    {
        [is readInt32];
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        int32_t count = [is readInt32];
        for (int32_t i = 0; i < count; i++) {
            int32_t signature = [is readInt32];
            id item = TLMetaClassStore::constructObject(is, signature, environment, nil, error);
            if (item != nil) {
                [items addObject:item];
            }
        }
        
        result.bot_info = items;
    }
    
    if (flags & (1 << 4)) {
        result.migrated_from_chat_id = [is readInt32];
    }
    
    if (flags & (1 << 4)) {
        result.migrated_from_max_id = [is readInt32];
    }
    
    return result;
}

@end
