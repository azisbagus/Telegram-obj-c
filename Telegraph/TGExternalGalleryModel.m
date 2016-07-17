#import "TGExternalGalleryModel.h"

#import "TGExternalGalleryItem.h"

#import "TGGenericPeerMediaGalleryActionsAccessoryView.h"
#import "TGActionSheet.h"

#import "TGApplication.h"

#import "TGWebPageMediaAttachment.h"
#import "TGProgressWindow.h"
#import "TGInstagramMediaIdSignal.h"

#import "TGRemoteImageView.h"

#import "TGAppDelegate.h"

#import "TGGenericPeerMediaGalleryImageItem.h"

#import "TGMediaAssetsLibrary.h"
#import "TGAccessChecker.h"

@interface TGExternalGalleryModel ()
{
    TGWebPageMediaAttachment *_webPage;
}

@end

@implementation TGExternalGalleryModel

- (instancetype)initWithWebPage:(TGWebPageMediaAttachment *)webPage peerId:(int64_t)peerId messageId:(int32_t)messageId
{
    self = [super init];
    if (self != nil)
    {
        _webPage = webPage;
        
        //TGExternalGalleryItem *item = [[TGExternalGalleryItem alloc] initWithWebPage:webPage];
        //NSArray *items = @[item];
        
        TGGenericPeerMediaGalleryImageItem *item = [[TGGenericPeerMediaGalleryImageItem alloc] initWithImageId:webPage.photo.imageId orLocalId:0 peerId:peerId messageId:messageId legacyImageInfo:webPage.photo.imageInfo];
        item.date = webPage.photo.date;
        item.messageId = messageId;
        item.caption = webPage.photo.caption;
        NSArray *items = @[item];
        
        [self _replaceItems:items focusingOnItem:item];
    }
    return self;
}

- (UIView<TGModernGalleryDefaultFooterAccessoryView> *)createDefaultLeftAccessoryView
{
    TGGenericPeerMediaGalleryActionsAccessoryView *accessoryView = [[TGGenericPeerMediaGalleryActionsAccessoryView alloc] init];
    __weak TGExternalGalleryModel *weakSelf = self;
    accessoryView.action = ^(id<TGModernGalleryItem> item)
    {
        if ([item isKindOfClass:[TGGenericPeerMediaGalleryImageItem class]])
        {
            __strong TGExternalGalleryModel *strongSelf = weakSelf;
            if (strongSelf != nil)
            {
                UIView *actionSheetView = nil;
                if (strongSelf.actionSheetView)
                    actionSheetView = strongSelf.actionSheetView();
                
                if (actionSheetView != nil)
                {
                    NSMutableArray *actions = [[NSMutableArray alloc] init];
                
                    NSString *openInText = TGLocalized(@"Web.OpenExternal");
                    if ([[_webPage.siteName lowercaseString] isEqualToString:@"instagram"])
                        openInText = TGLocalized(@"Preview.OpenInInstagram");
                    
                    [actions addObject:[[TGActionSheetAction alloc] initWithTitle:openInText action:@"open" type:TGActionSheetActionTypeGeneric]];
                    
                    NSString *imageUrl = [_webPage.photo.imageInfo closestImageUrlWithSize:CGSizeMake(1000.0f, 1000.0f) resultingSize:NULL];
                    
                    NSData *data = nil;
                    
                    static NSString *filesDirectory = nil;
                    static dispatch_once_t onceToken;
                    dispatch_once(&onceToken, ^ {
                        filesDirectory = [[TGAppDelegate documentsPath] stringByAppendingPathComponent:@"files"];
                    });
                    
                    if (_webPage.photo.imageId != 0)
                    {
                        NSString *photoDirectoryName = nil;
                        photoDirectoryName = [[NSString alloc] initWithFormat:@"image-remote-%" PRIx64 "", (int64_t)_webPage.photo.imageId];
                        NSString *photoDirectory = [filesDirectory stringByAppendingPathComponent:photoDirectoryName];
                    
                        NSString *imagePath = [photoDirectory stringByAppendingPathComponent:@"image.jpg"];
                        data = [NSData dataWithContentsOfFile:imagePath options:NSDataReadingMappedIfSafe error:NULL];
                    }
                    
                    if (data == nil) {
                        data = [NSData dataWithContentsOfFile:[[TGRemoteImageView sharedCache] pathForCachedData:imageUrl] options:NSDataReadingMappedIfSafe error:NULL];
                    }
                    
                    if (data != nil) {
                        [actions addObject:[[TGActionSheetAction alloc] initWithTitle:TGLocalized(@"Preview.SaveToCameraRoll") action:@"save" type:TGActionSheetActionTypeGeneric]];
                    }
                    
                    [actions addObject:[[TGActionSheetAction alloc] initWithTitle:TGLocalized(@"Common.Cancel") action:@"cancel" type:TGActionSheetActionTypeCancel]];
                    
                    [[[TGActionSheet alloc] initWithTitle:nil actions:actions actionBlock:^(__unused id target, NSString *action)
                    {
                        if ([action isEqualToString:@"open"])
                        {
                            __strong TGExternalGalleryModel *strongSelf = weakSelf;
                            if (strongSelf != nil)
                            {
                                NSString *instagramShortcode = [self instagramShortcodeFromText:strongSelf->_webPage.url];
                                if (instagramShortcode.length != 0)
                                {
                                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"instagram://media?id=1"]])
                                    {
                                        TGProgressWindow *progressWindow = [[TGProgressWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                                        [progressWindow show:true];
                                        [[[[TGInstagramMediaIdSignal instagramMediaIdForShortcode:instagramShortcode] deliverOn:[SQueue mainQueue]] onDispose:^
                                        {
                                            [progressWindow dismiss:true];
                                        }] startWithNext:^(NSString *mediaId)
                                        {
                                            NSURL *clientUrl = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"instagram://media?id=%@", mediaId]];
                                            if ([[UIApplication sharedApplication] canOpenURL:clientUrl])
                                            {
                                                [[UIApplication sharedApplication] openURL:clientUrl];
                                                return;
                                            }
                                        } error:^(__unused id error)
                                        {
                                            __strong TGExternalGalleryModel *strongSelf = weakSelf;
                                            if (strongSelf != nil)
                                            {
                                                [(TGApplication *)[UIApplication sharedApplication] openURL:[NSURL URLWithString:strongSelf->_webPage.url] forceNative:true];
                                            }
                                        } completed:nil];
                                    }
                                    else
                                    {
                                        __strong TGExternalGalleryModel *strongSelf = weakSelf;
                                        if (strongSelf != nil)
                                        {
                                            [(TGApplication *)[UIApplication sharedApplication] openURL:[NSURL URLWithString:strongSelf->_webPage.url] forceNative:true];
                                        }
                                    }
                                    return;
                                }
                                
                                [(TGApplication *)[UIApplication sharedApplication] openURL:[NSURL URLWithString:strongSelf->_webPage.url] forceNative:true];
                            }
                        }
                        else if ([action isEqualToString:@"save"]) {
                            [strongSelf _saveImageDataToCameraRoll:data];
                        }
                    } target:strongSelf] showInView:actionSheetView];
                }
            }
        }
    };
    return accessoryView;
}

- (void)_saveImageDataToCameraRoll:(NSData *)data
{
    if (data == nil)
        return;
    
    if (![TGAccessChecker checkPhotoAuthorizationStatusForIntent:TGPhotoAccessIntentSave alertDismissCompletion:nil])
        return;
    
    TGProgressWindow *progressWindow = [[TGProgressWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [progressWindow show:true];
    
    [[[[TGMediaAssetsLibrary sharedLibrary] saveAssetWithImageData:data] deliverOn:[SQueue mainQueue]] startWithNext:nil error:^(__unused id error)
    {
        [TGAccessChecker checkPhotoAuthorizationStatusForIntent:TGPhotoAccessIntentSave alertDismissCompletion:nil];
        [progressWindow dismiss:true];
    } completed:^
    {
        [progressWindow dismissWithSuccess];
    }];
}

- (NSString *)instagramShortcodeFromText:(NSString *)text
{
    if ([text hasPrefix:@"http://instagram.com/p/"] || [text hasPrefix:@"https://instagram.com/p/"])
    {
        NSString *prefix = [text hasPrefix:@"http://instagram.com/p/"] ? @"http://instagram.com/p/" : @"https://instagram.com/p/";
        int length = (int)text.length;
        bool badCharacters = false;
        int slashCount = 0;
        for (int i = (int)prefix.length; i < length; i++)
        {
            unichar c = [text characterAtIndex:i];
            if ((c >= '0' && c <= '9') || (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_' || c == '/' || c == '-')
            {
                if (c == '/')
                {
                    if (slashCount >= 2)
                    {
                        badCharacters = true;
                        break;
                    }
                    slashCount++;
                }
            }
            else
            {
                badCharacters = true;
                break;
            }
        }
        
        if (!badCharacters)
        {
            NSString *shortcode = [text substringFromIndex:prefix.length];
            if ([shortcode hasSuffix:@"/"])
                shortcode = [shortcode substringToIndex:shortcode.length - 1];
            
            return shortcode;
        }
    }
    
    return nil;
}

@end
