//
//  NetworkManager.h
//  ISS Location Now
//
//  Created by Saruululzii on 9/6/22.
//

#import <Foundation/Foundation.h>
@interface NetworkManager : NSObject
- (void) get:(NSString *)url parameters:(NSDictionary *)parameters;

@property(nonatomic,strong)void (^successBlock)(NSData *result);
@property(nonatomic,strong)void (^failureBlock)(NSError* error);
@end
