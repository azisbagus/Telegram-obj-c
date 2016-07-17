/*
 * This is the source code of Telegram for iOS v. 1.1
 * It is licensed under GNU GPL v. 2 or later.
 * You should have received a copy of the license in this archive (see LICENSE).
 *
 * Copyright Peter Iakovlev, 2013.
 */

#import <UIKit/UIKit.h>

@class TGViewController;
@class TGOverlayController;

@interface TGOverlayWindowViewController : UIViewController

@end

@interface TGOverlayControllerWindow : UIWindow

@property (nonatomic) bool keepKeyboard;

- (instancetype)initWithParentController:(TGViewController *)parentController contentController:(TGOverlayController *)contentController;
- (instancetype)initWithParentController:(TGViewController *)parentController contentController:(TGOverlayController *)contentController keepKeyboard:(bool)keepKeyboard;

- (void)dismiss;

@end
