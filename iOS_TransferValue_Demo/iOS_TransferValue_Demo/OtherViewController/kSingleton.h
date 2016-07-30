//
//  kSingleton.h
//  iOS_TransferValue_Demo
//
//  Created by TOMO on 16/6/29.
//  Copyright © 2016年 TOMO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface kSingleton : NSObject

@property(nonatomic,strong)NSString *string;

+(kSingleton *)sharedInstance;

@end
