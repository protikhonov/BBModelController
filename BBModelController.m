//
//  BBModelController.m
//  BubbleBusters
//
//  Created by Anton Tikhonov on 13.11.12.
//  Copyright (c) 2012 FPM Soft. All rights reserved.
//

#import "BBModelController.h"
#import "BBDownloader.h"
#import "Constants.h"
#import "FMDBDataAccess.h"
#import "BBIssue.h"

#define kCachesFolder @"Caches"

@implementation BBModelController

@synthesize selectedIssueCategory = selectedIssueCategory_;
@synthesize categoriesArray = categoriesArray_;
@synthesize selectedIssueTypeName = selectedIssueTypeName_;

static BBModelController * sharedModel = nil;

#pragma mark Init Singleton

+ (BBModelController *) sharedModelController {
    if (sharedModel == nil) {
	static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedModel = [[BBModelController alloc] init];
            sharedModel.selectedIssueCategory = [[BBIssueCategory alloc]init];
            sharedModel.selectedIssueTypeName = [[NSString alloc]init];
        });
    }
    return sharedModel;
}

#pragma mark Download Database

- (void) downloadSQLite {
    NSString * sqLitePath =  [[NSSearchPathForDirectoriesInDomains
                                  (NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
                                        	       		stringByAppendingPathComponent:kCachesFolder];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",K_BASE_URL,K_DOWNLOAD_SQLITE_API]];
    NSString * filename = [NSString stringWithFormat:@"%@.%@",K_DBASE_NAME,K_DBASE_FORMAT];
    [BBDownloader downloadFileWithURL:url toDirectory:sqLitePath withName:filename];
}

#pragma mark Get Objects From Database

- (BBAbout *) getAboutObject {
    return [FMDBDataAccess getAbout];
}

- (NSMutableArray *) getTipsArray {
    return [FMDBDataAccess getTips];
}

- (NSMutableArray *) getCategoriesArray {
    if (!categoriesArray) {
        self.categoriesArray = [FMDBDataAccess getCategories];
	}
    return self.categoriesArray;
}

- (BBIssue *) getIssueForIssueCategory:(BBIssueCategory *)_category byType:(int)issueType {
   return [FMDBDataAccess getIssueForCategory:_category byType:[NSNumber numberWithInt:issueType]];
}

- (NSMutableArray *) getIssuesForCategory:(BBIssueCategory *)_category byType:(int)type {
    return [FMDBDataAccess getIssuesForCategory:_category byType:[NSNumber numberWithInt:type]];
}

@end
