//
//  MultiLanguageManager.h
//  Digisocial
//
//  Created by lazybone on 1/3/14.
//
//

#import <Foundation/Foundation.h>

#define MLocalizableString(strkey,strcomment) \
[[MultiLanguageManager shareInstance] MlocalizedStringForKey:strkey withComment:strcomment]


@interface MultiLanguageManager : NSObject
{
    NSBundle *_bundle;
}


+ (MultiLanguageManager *)shareInstance;

- (NSString *)MlocalizedStringForKey:(NSString *)strKey
                        withComment:(NSString *)strcomment;
@end
