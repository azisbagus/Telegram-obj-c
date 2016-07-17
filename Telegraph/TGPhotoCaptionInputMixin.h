#import <Foundation/Foundation.h>
#import "TGMediaPickerCaptionInputPanel.h"

@class TGSuggestionContext;

@interface TGPhotoCaptionInputMixin : NSObject

@property (nonatomic, readonly) TGMediaPickerCaptionInputPanel *inputPanel;
@property (nonatomic, readonly) NSString *caption;
@property (nonatomic, readonly) bool isEditing;
@property (nonatomic, assign) UIInterfaceOrientation interfaceOrientation;
@property (nonatomic, readonly) CGFloat keyboardHeight;

@property (nonatomic, strong) TGSuggestionContext *suggestionContext;

@property (nonatomic, copy) UIView *(^panelParentView)(void);

@property (nonatomic, copy) void (^panelFocused)(void);
@property (nonatomic, copy) void (^finishedWithCaption)(NSString *caption);
@property (nonatomic, copy) void (^keyboardHeightChanged)(CGFloat keyboardHeight, NSTimeInterval duration, NSInteger animationCurve);

- (void)beginEditingWithCaption:(NSString *)caption;
- (void)enableDismissal;

@end
