//
//  BBModelController.h
//  BubbleBusters
//
//  Created by Anton Tikhonov on 13.11.12.
//  Copyright (c) 2012 FPM Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBAbout.h"
#import "BBIssue.h"
#import "BBIssueCategory.h"
@interface BBModelController : NSObject 

@property (nonatomic, strong) NSString * selectedIssueTypeName;
@property (nonatomic, strong) NSMutableArray * categoriesArray;
@property (nonatomic, strong) BBIssueCategory * selectedIssueCategory;

#pragma mark Init Singleton

+ (id) sharedModelController;

#pragma mark Download Database

- (void)downloadSQLite;

#pragma mark Get Objects From Database

- (BBAbout*) getAboutObject;
- (NSMutableArray*) getTipsArray;
- (NSMutableArray*) getCategoriesArray;
- (BBIssue*) getIssueForIssueCategory: (BBIssueCategory*)_category 
															byType: (int)issueType;
- (NSMutableArray*) getIssuesForCategory: (BBIssueCategory*)_category 
															byType: (int)type;

@end
