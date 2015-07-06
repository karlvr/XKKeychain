//
//  XKKeychainTests.m
//  XKKeychainTests
//
//  Created by Karl von Randow on 10/24/2014.
//  Copyright (c) 2014 Karl von Randow. All rights reserved.
//

#import <XKKeychain/XKKeychainGenericPasswordItem.h>

SpecBegin(InitialSpecs)

describe(@"crud", ^{
    
    it(@"returns nil when an item doesn't exist", ^{
        NSError *error = nil;
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account Not There" error:&error];
        
        expect(item).to.beNil();
    });
    
    it(@"can create and retrieve items", ^{
        NSError *error = nil;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        createItem.service = @"Test";
        createItem.account = @"Test Account";
        BOOL created = [createItem saveWithError:&error];
        
        expect(created).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account" error:&error];
        
        expect(item).toNot.beNil();
        expect(error).to.beNil();
    });
    
    it(@"can delete created items", ^{
        NSError *error = nil;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        createItem.service = @"Test";
        createItem.account = @"Test Account";
        BOOL created = [createItem saveWithError:&error];
        
        expect(created).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account" error:&error];
        
        expect(item).toNot.beNil();
        expect(error).to.beNil();
        
        BOOL deleted = [item deleteWithError:&error];
        
        expect(deleted).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *itemAgain = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account" error:&error];
        
        expect(itemAgain).to.beNil();
        expect(error).to.beNil();
    });
    
    it(@"can store generic data", ^{
        NSError *error = nil;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        createItem.service = @"Test";
        createItem.account = @"Test Account with generic data";
        createItem.generic.stringValue = @"Generic data";
        BOOL created = [createItem saveWithError:&error];
        
        expect(created).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with generic data" error:&error];
        
        expect(item).toNot.beNil();
        expect(error).to.beNil();
        
        expect(item.generic.stringValue).to.equal(@"Generic data");
    });
    
    it(@"can update generic data", ^{
        NSError *error = nil;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        createItem.service = @"Test";
        createItem.account = @"Test Account with updating generic data";
        createItem.generic.stringValue = @"Generic data";
        BOOL created = [createItem saveWithError:&error];
        
        expect(created).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with updating generic data" error:&error];
        
        expect(item).toNot.beNil();
        expect(error).to.beNil();
        
        expect(item.generic.stringValue).to.equal(@"Generic data");
        
        item.generic.stringValue = @"Updated generic data";
        
        BOOL updated = [item saveWithError:&error];
        expect(updated).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *updatedItem = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with updating generic data" error:&error];
        
        expect(updatedItem).toNot.beNil();
        expect(error).to.beNil();
        
        expect(updatedItem.generic.stringValue).to.equal(@"Updated generic data");
    });
    
    it(@"can store dictionaries in generic", ^{
        NSError *error = nil;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        createItem.service = @"Test";
        createItem.account = @"Test Account with generic data dictionaries";
        createItem.generic.dictionaryValue = @{@"name": @"Dictionary success", @"number": @1337};
        BOOL created = [createItem saveWithError:&error];
        
        expect(created).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with generic data dictionaries" error:&error];
        
        expect(item).toNot.beNil();
        expect(error).to.beNil();
        
        expect(item.generic.dictionaryValue[@"name"]).to.equal(@"Dictionary success");
        expect(item.generic.dictionaryValue[@"number"]).to.equal(@1337);
    });
    
    it(@"can use keyed subscript on generic", ^{
        NSError *error = nil;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        createItem.service = @"Test";
        createItem.account = @"Test Account with generic data subscripts";
        createItem.generic[@"name"] = @"Subscript success";
        createItem.generic[@"number"] = @1337;
        BOOL created = [createItem saveWithError:&error];
        
        expect(created).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with generic data subscripts" error:&error];
        
        expect(item).toNot.beNil();
        expect(error).to.beNil();
        
        expect(item.generic[@"name"]).to.equal(@"Subscript success");
        expect(item.generic[@"number"]).to.equal(@1337);
    });
    
    it(@"can store various attributes", ^{
        NSError *error = nil;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        createItem.service = @"Test";
        createItem.account = @"Test Account with attributes";
        createItem.label = @"My Label";
        createItem.descriptionText = @"My description";
        createItem.invisible = @YES;
        createItem.negative = @YES;
        BOOL created = [createItem saveWithError:&error];
        
        expect(created).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with attributes" error:&error];
        
        expect(item).toNot.beNil();
        expect(error).to.beNil();
        
        expect(item.label).to.equal(@"My Label");
        expect(item.descriptionText).to.equal(@"My description");
        expect(item.invisible).to.equal(@YES);
        expect(item.negative).to.equal(@YES);
    });
    
    it(@"can update various attributes", ^{
        NSError *error = nil;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        createItem.service = @"Test";
        createItem.account = @"Test Account with updating attributes";
        createItem.label = @"My Label";
        createItem.descriptionText = @"My description";
        createItem.invisible = @YES;
        createItem.negative = @YES;
        BOOL created = [createItem saveWithError:&error];
        
        expect(created).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with updating attributes" error:&error];
        
        expect(item).toNot.beNil();
        expect(error).to.beNil();
        
        item.label = @"New Label";
        item.descriptionText = @"New description";
        item.invisible = @NO;
        item.negative = @NO;
        
        BOOL updated = [item saveWithError:&error];
        
        expect(updated).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *updatedItem = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with updating attributes" error:&error];
        
        expect(updatedItem).toNot.beNil();
        expect(error).to.beNil();
        
        expect(updatedItem.label).to.equal(@"New Label");
        expect(updatedItem.descriptionText).to.equal(@"New description");
        expect(updatedItem.invisible).to.equal(NO);
        expect(updatedItem.negative).to.equal(NO);
    });
    
    it(@"can store secrets", ^{
        NSError *error = nil;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        createItem.service = @"Test";
        createItem.account = @"Test Account with secret";
        createItem.secret.stringValue = @"Secret string";
        BOOL created = [createItem saveWithError:&error];
        
        expect(created).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with secret" error:&error];
        
        expect(item).toNot.beNil();
        expect(error).to.beNil();
        
        expect(item.secret.stringValue).to.equal(@"Secret string");
    });
    
    it(@"can store data in secrets", ^{
        NSError *error = nil;
        
        u_int8_t bytes[5];
        bytes[0] = 7;
        bytes[1] = 3;
        bytes[2] = 3;
        bytes[3] = 1;
        bytes[4] = 99;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        createItem.service = @"Test";
        createItem.account = @"Test Account with secret data";
        createItem.secret.dataValue = [NSData dataWithBytes:bytes length:5];
        BOOL created = [createItem saveWithError:&error];
        
        expect(created).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with secret data" error:&error];
        
        expect(item).toNot.beNil();
        expect(error).to.beNil();
        
        u_int8_t savedBytes[5];
        [item.secret.dataValue getBytes:savedBytes length:5];
        
        u_int8_t first = savedBytes[0];
        expect(first).to.equal(7);
        u_int8_t second = savedBytes[1];
        expect(second).to.equal(3);
        u_int8_t fourth = savedBytes[3];
        expect(fourth).to.equal(1);
        u_int8_t fifth = savedBytes[4];
        expect(fifth).to.equal(99);
    });
    
    it(@"can update secrets", ^{
        NSError *error = nil;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        createItem.service = @"Test";
        createItem.account = @"Test Account with updating secret";
        createItem.secret.stringValue = @"Secret string";
        BOOL created = [createItem saveWithError:&error];
        
        expect(created).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *item = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with updating secret" error:&error];
        
        expect(item).toNot.beNil();
        expect(error).to.beNil();
        
        expect(item.secret.stringValue).to.equal(@"Secret string");
        
        item.secret.stringValue = @"New secret";
        BOOL updated = [item saveWithError:&error];
        
        expect(updated).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *updatedItem = [XKKeychainGenericPasswordItem itemForService:@"Test" account:@"Test Account with updating secret" error:&error];
        
        expect(updatedItem).toNot.beNil();
        expect(error).to.beNil();
        
        expect(updatedItem.secret.stringValue).to.equal(@"New secret");
    });
    
});

describe(@"bulk", ^{
    
    beforeEach(^{
        NSError *error = nil;
        BOOL created;
        
        XKKeychainGenericPasswordItem *createItem = [XKKeychainGenericPasswordItem new];
        
        createItem.service = @"Test Bulk";
        createItem.account = @"Test Account 1";
        createItem.secret.stringValue = @"Secret string 1";
        created = [createItem saveWithError:&error];
        expect(created).to.beTruthy();
        
        createItem.account = @"Test Account 2";
        createItem.secret.stringValue = @"Secret string 2";
        created = [createItem saveWithError:&error];
        expect(created).to.beTruthy();
        
        createItem.account = @"Different Account 1";
        createItem.secret.stringValue = @"Secret string 3";
        created = [createItem saveWithError:&error];
        expect(created).to.beTruthy();
    });
    
    it(@"can have multiple accounts", ^{
        NSError *error = nil;
        NSArray *items = [XKKeychainGenericPasswordItem itemsForService:@"Test Bulk" error:&error];
        expect(items.count).to.equal(3);
    });
    
    it(@"can query accounts by prefix", ^{
        NSError *error = nil;
        NSArray *items = [XKKeychainGenericPasswordItem itemsForService:@"Test Bulk" accountPrefix:@"Test Account" error:&error];
        expect(items.count).to.equal(2);
    });
    
    it(@"can have multiple accounts with secrets", ^{
        NSError *error = nil;
        NSArray *items = [XKKeychainGenericPasswordItem itemsForService:@"Test Bulk" accountPrefix:@"Test Account" error:&error];
        expect(items.count).to.equal(2);
        
        XKKeychainGenericPasswordItem *item1 = items[0];
        XKKeychainGenericPasswordItem *item2 = items[1];
        if ([item1.secret.stringValue isEqualToString:@"Secret string 1"]) {
            expect(item2.secret.stringValue).to.equal(@"Secret string 2");
        } else if ([item1.secret.stringValue isEqualToString:@"Secret string 2"]) {
            expect(item2.secret.stringValue).to.equal(@"Secret string 1");
        } else {
            expect(NO).to.equal(YES);
        }
    });
    
    it(@"can bulk delete created items", ^{
        NSError *error = nil;
        
        BOOL deleted = [XKKeychainGenericPasswordItem removeItemsForService:@"Test Bulk" accountPrefix:@"Test Account" error:&error];
        
        expect(deleted).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *itemAgain = [XKKeychainGenericPasswordItem itemForService:@"Test Bulk" account:@"Test Account 1" error:&error];
        
        expect(itemAgain).to.beNil();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *itemAgain2 = [XKKeychainGenericPasswordItem itemForService:@"Test Bulk" account:@"Test Account 2" error:&error];
        
        expect(itemAgain2).to.beNil();
        expect(error).to.beNil();
    });
    
    it(@"can selectively bulk delete created items", ^{
        NSError *error = nil;
        
        BOOL deleted = [XKKeychainGenericPasswordItem removeItemsForService:@"Test Bulk" accountPrefix:@"Test Account 1" error:&error];
        
        expect(deleted).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *itemAgain = [XKKeychainGenericPasswordItem itemForService:@"Test Bulk" account:@"Test Account 1" error:&error];
        
        expect(itemAgain).to.beNil();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *itemAgain2 = [XKKeychainGenericPasswordItem itemForService:@"Test Bulk" account:@"Test Account 2" error:&error];
        
        expect(itemAgain2).toNot.beNil();
        expect(error).to.beNil();
    });
    
    it(@"can selectively bulk delete created items", ^{
        NSError *error = nil;
        
        BOOL deleted = [XKKeychainGenericPasswordItem removeItemsForService:@"Test Bulk" error:&error];
        
        expect(deleted).to.beTruthy();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *itemAgain = [XKKeychainGenericPasswordItem itemForService:@"Test Bulk" account:@"Test Account 1" error:&error];
        
        expect(itemAgain).to.beNil();
        expect(error).to.beNil();
        
        XKKeychainGenericPasswordItem *itemAgain2 = [XKKeychainGenericPasswordItem itemForService:@"Test Bulk" account:@"Test Account 2" error:&error];
        
        expect(itemAgain2).to.beNil();
        expect(error).to.beNil();
    });
    
});

SpecEnd
