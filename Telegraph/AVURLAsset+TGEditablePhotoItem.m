#import "AVURLAsset+TGEditablePhotoItem.h"

#import "TGPhotoEditorUtils.h"

#import <objc/runtime.h>

@implementation AVURLAsset (TGEditablePhotoItem)

- (void)fetchThumbnailImageWithCompletion:(void (^)(UIImage *))completion
{
    if (completion == nil)
        return;
    
    CGFloat thumbnailImageSide = TGPhotoThumbnailSizeForCurrentScreen().width;
    CGSize targetSize = TGScaleToSize(self.originalSize, CGSizeMake(thumbnailImageSide, thumbnailImageSide));
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:self];
        generator.appliesPreferredTrackTransform = true;
        generator.maximumSize = targetSize;
        CGImageRef cgImage = [generator copyCGImageAtTime:kCMTimeZero actualTime:NULL error:NULL];
        completion([UIImage imageWithCGImage:cgImage]);
    });
}

- (void)fetchOriginalScreenSizeImageWithCompletion:(void (^)(UIImage *))__unused completion
{
    
}

- (void)fetchOriginalFullSizeImageWithCompletion:(void (^)(UIImage *))__unused completion
{
    
}

- (CGSize)originalSize
{
    AVAssetTrack *track = self.tracks.firstObject;
    return CGRectApplyAffineTransform((CGRect){ CGPointZero, track.naturalSize }, track.preferredTransform).size;
}

- (NSString *)uniqueId
{
    return self.URL.absoluteString;
}

#pragma mark - 

- (id<TGMediaEditAdjustments> (^)(id<TGEditablePhotoItem>))fetchEditorValues
{
    return objc_getAssociatedObject(self, @selector(fetchEditorValues));
}

- (void)setFetchEditorValues:(id<TGMediaEditAdjustments> (^)(id<TGEditablePhotoItem>))fetchEditorValues
{
    objc_setAssociatedObject(self, @selector(fetchEditorValues), fetchEditorValues, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *(^)(id<TGEditablePhotoItem>))fetchCaption
{
    return objc_getAssociatedObject(self, @selector(fetchCaption));
}

- (void)setFetchCaption:(NSString *(^)(id<TGEditablePhotoItem>))fetchCaption
{
    objc_setAssociatedObject(self, @selector(fetchCaption), fetchCaption, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIImage *(^)(id<TGEditablePhotoItem>))fetchThumbnailImage
{
    return objc_getAssociatedObject(self, @selector(fetchThumbnailImage));
}

- (void)setFetchThumbnailImage:(UIImage *(^)(id<TGEditablePhotoItem>))fetchThumbnailImage
{
    objc_setAssociatedObject(self, @selector(fetchThumbnailImage), fetchThumbnailImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIImage *(^)(id<TGEditablePhotoItem>))fetchScreenImage
{
    return objc_getAssociatedObject(self, @selector(fetchScreenImage));
}

- (void)setFetchScreenImage:(UIImage *(^)(id<TGEditablePhotoItem>))fetchScreenImage
{
    objc_setAssociatedObject(self, @selector(fetchScreenImage), fetchScreenImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void(^)(id<TGEditablePhotoItem>, void(^)(UIImage *image)))fetchOriginalImage
{
    return objc_getAssociatedObject(self, @selector(fetchOriginalImage));
}

- (void)setFetchOriginalImage:(void(^)(id<TGEditablePhotoItem>, void(^)(UIImage *image)))fetchOriginalImage
{
    objc_setAssociatedObject(self, @selector(fetchOriginalImage), fetchOriginalImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void(^)(id<TGEditablePhotoItem>, void(^)(UIImage *image)))fetchOriginalThumbnailImage
{
    return objc_getAssociatedObject(self, @selector(fetchOriginalThumbnailImage));
}

- (void)setFetchOriginalThumbnailImage:(void(^)(id<TGEditablePhotoItem>, void(^)(UIImage *image)))fetchOriginalThumbnailImage
{
    objc_setAssociatedObject(self, @selector(fetchOriginalThumbnailImage), fetchOriginalThumbnailImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
