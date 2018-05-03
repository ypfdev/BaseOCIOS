//
//  HCCoreDataManager.m
//  PureGarden
//
//  Created by Dason on 2017/6/20.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "HCCoreDataManager.h"

@implementation HCCoreDataManager

+ (instancetype)defaultManager{

    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super alloc]init];
    });

    return instance;
}

- (NSManagedObjectContext *)managedContext{

    if(_managedContext == nil){
        _managedContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        _managedContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    
    return _managedContext;
}

- (NSManagedObjectModel *)managedModel{

    if (_managedModel == nil) {
        //获取模型路径
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"CoreData" withExtension:@"momd"];
        //根据模型文件创建模型对象
        _managedModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
        }
    return _managedModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
//
//    if (_persistentStoreCoordinator == nil) {
//        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managedModel];
//        
//        //设置调度存储器
//        NSURL *url = [[self getDocumentPathUrl]URLByAppendingPathComponent:@"sqlite.db" isDirectory:YES];
//       
//        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:nil];
//    }
//    return _persistentStoreCoordinator;
    
    
    
    if (nil != _persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
 
    NSError *error = NULL;
    NSURL *storeURL = [[self getDocumentPathUrl]URLByAppendingPathComponent:@"sqlite.db" isDirectory:YES];
    
    //如果对coredata 的xcdatamodeld文件进行了操作,如添加了属性之类的,这个时候我们再使用这个persistentStoreCoordinator的时候会奔溃出现错误提示@"Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'This NSPersistentStoreCoordinator has no persistent stores.  It cannot perform a save operation.'"
    //因为修改后,对应的数据结构不匹配了,所以创建不了会出错,
    //在网上查到解决方案:(数据迁移)
    //一:点击xcdatamodeld文件 Editor->add Model version 中创建下一个版本,然后做对应的增加字段等修改
    //二:在persistentStoreCoordinator这里配置一下options,这两个key是数据迁移的key
    //NSMigratePersistentStoresAutomaticallyOption:是否支持版本迁移
    //NSInferMappingModelAutomaticallyOption:是否支持版本迁移映射
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedModel];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options  error:&error]) {
        NSLog(@"Error : %@\n", [error localizedDescription]);
        NSAssert1(YES, @"Failed to create store %@ with NSSQLiteStoreType", [storeURL path]);
    }

    return _persistentStoreCoordinator;
}

//获取document路径
- (NSURL *)getDocumentPathUrl{

   NSURL *url = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];

    return url;
}

@end
