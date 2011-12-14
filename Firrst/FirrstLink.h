#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FirrstLink: NSObject<NSXMLParserDelegate>

+(id)sharedModel;

@property(strong) NSXMLParser *xmlParser;
@property(strong) NSMutableString *dataString;
@property(strong) NSString *currentElement;

/*!
 * @abstract Pass in a string and it'll check if it can become a valid URL. 
 * Returns either nil or a NSURL. If no scheme is provided http will be used.
 */
+(NSURL*)validateURL:(NSString*)possibleURL;
/*!
 * @abstract Shorten a URL asynchronously and use the handler block to process
 * the result.
 */
+(void)shortenURLAsynchronous:(NSURL*)inputURL onComplete:(void (^)(NSString *shortUrl))handler;

-(NSString *) makeThisURLShortWithBitly:(NSString *)longURL;
-(NSString *) makeThisURLShort:(NSString *)longURL;
@end
