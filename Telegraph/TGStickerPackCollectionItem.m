#import "TGStickerPackCollectionItem.h"

#import "TGStickerPackCollectionItemView.h"

@implementation TGStickerPackCollectionItem

- (instancetype)initWithStickerPack:(TGStickerPack *)stickerPack
{
    self = [super init];
    if (self != nil)
    {
        _stickerPack = stickerPack;
    }
    return self;
}

- (Class)itemViewClass
{
    return [TGStickerPackCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, 58.0f);
}

- (void)bindView:(TGStickerPackCollectionItemView *)view
{
    [super bindView:view];
    
    view.enableEditing = _enableEditing;
    view.deleteStickerPack = _deleteStickerPack;
    view.addStickerPack = _addStickerPack;
    [view setStickerPack:_stickerPack];
}

- (void)unbindView
{
    ((TGStickerPackCollectionItemView *)self.boundView).deleteStickerPack = nil;
    ((TGStickerPackCollectionItemView *)self.boundView).addStickerPack = nil;
    [super unbindView];
}

- (void)itemSelected:(id)__unused actionTarget
{
    if (_previewStickerPack)
        _previewStickerPack();
}

- (void)setStickerPack:(TGStickerPack *)stickerPack {
    _stickerPack = stickerPack;
    [((TGStickerPackCollectionItemView *)self.boundView) setStickerPack:_stickerPack];
}

@end
