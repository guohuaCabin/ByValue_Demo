//
//  kSingleton.m
//  iOS_TransferValue_Demo
//
//  Created by TOMO on 16/6/29.
//  Copyright © 2016年 TOMO. All rights reserved.
//

#import "kSingleton.h"

@implementation kSingleton
{
    NSString *_string;
}
@synthesize string = _string;
/**
 *  两个类中属性引用的其实是同一个对象，因为用[kSingleton sharedInstance]这种方式智能创建一个对象，大家都是共享这个一的，这就是所谓的单例模式。
 *
 *  因为这个单例类有一个NSString的属性，因此所有引用这个单例对象的类都共享这个属性，因此就可以通过这个属性在不同类之间进行传值。
 */
+(kSingleton *)sharedInstance
{
    static kSingleton *singleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        singleton = [[self alloc]init];
    });
    return singleton;
}




@end