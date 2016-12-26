//
//  MultiLanguageManager.m
//  Digisocial
//
//  Created by lazybone on 1/3/14.
//
//

#import "MultiLanguageManager.h"
#import "CG.h"

@implementation MultiLanguageManager

static MultiLanguageManager *g_shareMultiLanguage=nil;

+ (MultiLanguageManager *)shareInstance
{
    if(g_shareMultiLanguage==nil)
    {
        g_shareMultiLanguage=[[MultiLanguageManager alloc] init];
    }
    
    return g_shareMultiLanguage;
}

-(id)init
{
    self = [super init];
    if (self != nil) {
    }
    
    return self;
}

-(void)dealloc
{
}

-(NSString *)MlocalizedStringForKey:(NSString *)strKey
                        withComment:(NSString *)strcomment
{
    if (_bundle == nil)
    {
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]];
        _bundle = bundle;
    }
    
    NSString *strValue = NSLocalizedStringWithDefaultValue(strKey, nil, _bundle, @" ", strcomment);
    if ([strValue isEqualToString:@" "])
    {
        return strcomment;
    }
    
    return strValue;
}


@end
