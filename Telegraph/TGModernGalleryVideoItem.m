/*
 * This is the source code of Telegram for iOS v. 1.1
 * It is licensed under GNU GPL v. 2 or later.
 * You should have received a copy of the license in this archive (see LICENSE).
 *
 * Copyright Peter Iakovlev, 2013.
 */

#import "TGModernGalleryVideoItem.h"

#import "TGModernGalleryVideoItemView.h"

#import "TGVideoMediaAttachment.h"

@implementation TGModernGalleryVideoItem

- (instancetype)initWithVideoMedia:(TGVideoMediaAttachment *)videoMedia previewUri:(NSString *)previewUri
{
    self = [super init];
    if (self != nil)
    {
        _videoMedia = videoMedia;
        _previewUri = previewUri;
    }
    return self;
}

- (Class)viewClass
{
    return [TGModernGalleryVideoItemView class];
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[TGModernGalleryVideoItem class]])
    {
        return TGStringCompare(_previewUri, ((TGModernGalleryVideoItem *)object).previewUri) && TGObjectCompare(_videoMedia, ((TGModernGalleryVideoItem *)object).videoMedia);
    }
    
    return false;
}

@end
