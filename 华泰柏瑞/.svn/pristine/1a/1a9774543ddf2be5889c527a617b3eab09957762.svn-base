//
//  SecurityUtil.h
//  Smile
//
//  Created by 周 敏 on 12-11-24.
//  Copyright (c) 2012年 BOX. All rights reserved.
//

#import "SecurityUtil.h"
#import "GTMBase64.h"
#import "NSData+AES.h"
#import "NSString+MD5.h"

#define AES_KEY    @"PuffNBNBPUFFnbnb" // 密钥

@implementation SecurityUtil

#pragma mark - AES加密
+ (NSString *)encryptAESData:(NSString*)string
{
    if (string.length) {
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSData *encryptedData = [data AES256EncryptWithKey:AES_KEY];
        
        Byte *bytes = (Byte *)[encryptedData bytes];
        NSString *hexStr = @"";
        
        for(int i = 0; i < [encryptedData length]; i++) {
            NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i] & 0xFF];
            if([newHexStr length]==1) {
                hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
            } else {
                hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
            }
        }
        
        return [hexStr uppercaseString];
    } else {
        return  nil;
    }
    
}
+(NSString *)gainStringDescryptAESHex:(NSString *)hexString{
    NSData *data = [self dataFromHex:hexString];
    NSData *decryData = [data AES256DecryptWithKey:AES_KEY];
    NSString * string = [[NSString alloc]initWithData:decryData encoding:NSUTF8StringEncoding];
    return string;
}

+ (NSData *)decryptAESHex:(NSString *)hexString
{
    NSData *data = [self dataFromHex:hexString];
    NSData *decryData = [data AES256DecryptWithKey:AES_KEY];
    
    return decryData;
}

+ (NSData *)dataFromHex:(NSString *)hexString
{
    int j=0;
    Byte *bytes = malloc([hexString length]);
    for(int i = 0; i < [hexString length] - 1; i ++) {
        NSInteger int_ch;
        
        unichar hex_char1 = [hexString characterAtIndex:i];
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9') {
            int_ch1 = (hex_char1 - 48) * 16;
        } else if(hex_char1 >= 'A' && hex_char1 <='F') {
            int_ch1 = (hex_char1 - 55) * 16;
        } else {
            int_ch1 = (hex_char1 - 87) * 16;
        }
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i];
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9') {
            int_ch2 = (hex_char2 - 48);
        } else if (hex_char2 >= 'A' && hex_char2 <= 'F') {
            int_ch2 = hex_char2 - 55;
        } else {
            int_ch2 = hex_char2 - 87;
        }
        
        int_ch = int_ch1 + int_ch2;
        if(int_ch > 127) {
            int_ch = -(256 - int_ch);
        }

        bytes[j] = (int)int_ch;
        j++;
    }
    
    return [[NSData alloc] initWithBytes:bytes length:j];
}

+ (NSString *)encryptAESDataFromDictionary:(NSDictionary *)dic {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        NSLog(@"Json 解析失败");
        return nil;
    }
    
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [self encryptAESData:jsonStr];
}

@end
