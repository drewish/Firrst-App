#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FirrstLink: NSObject<NSXMLParserDelegate>

+(id)sharedModel;

@property(strong) NSXMLParser *xmlParser;
@property(strong) NSMutableString *dataString;
@property(strong) NSString *currentElement;

-(NSString *) makeThisURLShortWithBitly:(NSString *)longURL;
-(NSString *) makeThisURLShort:(NSString *)longURL;
@end
