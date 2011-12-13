
//  Singleton with Core Data stack header
//  AppModel.h

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface AppModel : NSObject<NSXMLParserDelegate>

+(id)sharedModel;

@property(strong) NSXMLParser *xmlParser;
@property(strong) NSMutableString *dataString;
@property(strong) NSString *currentElement;

-(NSString *) makeThisURLShort:(NSString *)longURL;
@end
