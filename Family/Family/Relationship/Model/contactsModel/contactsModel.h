//
//  contactsModel.h
//  Family
//
//  Created by Julis on 16/7/23.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface contactsModel : NSObject
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *pid;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSArray *photo;
@property (nonatomic,copy) NSString *isallow;
@end
