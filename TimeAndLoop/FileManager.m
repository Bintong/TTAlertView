//
//  FileManager.m
//  MarketWork
//
//  Created by zftank on 14-7-9.
//  Copyright (c) 2014年 MarketWork. All rights reserved.
//

#import "FileManager.h"

#define kDocumentFileKey     @"FileDocument"
#define kLibraryCommonKey    @"FileCommon"
#define kLibraryLoginKey     @"FileAccount"

@implementation FileManager

+ (NSString *)getFilePath:(NSString*)strName {
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:strName];
}

+ (NSString *)getFilePathOfLibrary:(NSString *)strName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:strName];
}

+ (NSString *)folderCatalogue:(Catalog)log {
    
    NSString *folderPath = nil;
    
    if (log == LogDocument)
    {
        folderPath = [FileManager getFilePath:kDocumentFileKey];
    }
    else if (log == LogCommon)
    {
        folderPath = [FileManager getFilePathOfLibrary:kLibraryCommonKey];
    }
    else if (log == LogAccount)
    {
        folderPath = [FileManager getFilePathOfLibrary:kLibraryLoginKey];
    }
    
    return folderPath;
}

#pragma mark -
#pragma mark File Methods

+ (NSString *)filePath:(NSString *)name catalogue:(Catalog)log {

    NSString *folderPath = [FileManager folderCatalogue:log];
    
    return [folderPath stringByAppendingPathComponent:name];
}

+ (BOOL)setObject:(id)object forKey:(NSString *)name catalogue:(Catalog)log {
    
    if (object && name && [name isKindOfClass:[NSString class]])
    {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        
        NSString *folderPath = [FileManager folderCatalogue:log];
        
        if ([fileManager fileExistsAtPath:folderPath] == NO)
        {
            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSString *filePath = [folderPath stringByAppendingPathComponent:name];
        
        NSData *saveSource = [NSKeyedArchiver archivedDataWithRootObject:object];
        
        return [fileManager createFileAtPath:filePath contents:saveSource attributes:nil];
    }
    
    return NO;
}

+ (id)objectForKey:(NSString *)name catalogue:(Catalog)log {
    
    if (name && [name isKindOfClass:[NSString class]])
    {
        NSString *filePath = [FileManager filePath:name catalogue:log];

        NSFileManager *fileManager = [[NSFileManager alloc] init];
        
        NSData *dataSource = [fileManager contentsAtPath:filePath];
        
        if (dataSource)
        {
            return [NSKeyedUnarchiver unarchiveObjectWithData:dataSource];
        }
    }
    
    return nil;
}

+ (BOOL)deleteObjectForKey:(NSString *)name catalogue:(Catalog)log {
    
    if (name && [name isKindOfClass:[NSString class]])
    {
        NSString *filePath = [FileManager filePath:name catalogue:log];
        
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        
        return [fileManager removeItemAtPath:filePath error:nil];
    }
    
    return NO;
}

+ (BOOL)deleteCatalogue:(Catalog)log {
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSString *folderPath = [FileManager folderCatalogue:log];
    
    return [fileManager removeItemAtPath:folderPath error:nil];
}

@end
