//
//  XKKeychainDataAttribute.m
//  Pods
//
//  Created by Karl von Randow on 24/10/14.
//
//

#import "XKKeychainDataAttribute.h"

@implementation XKKeychainDataAttribute

+ (instancetype)dataAttributeWithData:(NSData *)data
{
    XKKeychainDataAttribute *result = [XKKeychainDataAttribute new];
    result.dataValue = data;
    return result;
}

- (NSString *)stringValue
{
    if (self.dataValue) {
        return [[NSString alloc] initWithData:self.dataValue encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

- (void)setStringValue:(NSString *)string
{
    self.dataValue = [string dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSDictionary *)dictionaryValue
{
    id value = [self transformableValue];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)value;
    } else {
        return nil;
    }
}

- (void)setDictionaryValue:(NSDictionary *)dictionaryValue
{
    [self setTransformableValue:dictionaryValue];
}

- (id)transformableValue
{
    if (self.dataValue) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:self.dataValue];
    } else {
        return nil;
    }
}

- (void)setTransformableValue:(id)transformable
{
    self.dataValue = [NSKeyedArchiver archivedDataWithRootObject:transformable];
}

@end
