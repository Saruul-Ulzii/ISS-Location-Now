//
//  NetworkManager.m
//  ISS Location Now
//
//  Created by Saruululzii on 9/6/22.
//

#import "NetworkManager.h"

@implementation NetworkManager

- (void)get:(NSString *)url parameters:(NSDictionary *)parameters {
    NSMutableString * str = [NSMutableString string];
    [str appendString:url];
    
    if (parameters.count > 0) {
        if (![str hasSuffix:@"?"]) {
            [str appendString:@"?"];
        }
        
        for (NSString * key in parameters) {
            [str appendFormat:@"%@=%@&", key, parameters[key]];
        }
        
        [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
    }
    
    NSURL * URL = [NSURL URLWithString:str];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            self.failureBlock(error);
        } else {
            self.successBlock(data);
        }
    }];
    
    [task resume];
}

@end
