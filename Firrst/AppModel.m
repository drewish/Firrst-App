#import "AppModel.h"

@implementation AppModel

@synthesize xmlParser, dataString, currentElement;

static AppModel *sharedObject = nil;

+(id)sharedModel {
    @synchronized(self) {
        if(sharedObject == nil)
            sharedObject = [[super allocWithZone:NULL] init];
    }
    return sharedObject;
}

-(id)init {
    self = [super init];
    if(self) {
        
    }
    
    return self;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    self.currentElement = [elementName copy];
    if([elementName isEqualToString:@"shash"]){
        self.dataString = [[NSMutableString alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if([self.currentElement isEqualToString:@"shash"])
        [self.dataString appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
}

-(NSString *) makeThisURLShort:(NSString *)longURL{
    self.dataString =nil;
    //TODO figure out how to do plist files
    //NSString *APILogin = @"HavingEveryonebeanonymous";
    //NSString *APIKey = @"AndrewWeShouldProbablyHaveAPIKeys";
    
    //POST payload
    const char *data = [[NSString stringWithFormat: @"link[url]=%@",longURL] UTF8String];
    
    NSURL *xmlURL = [NSURL URLWithString: @"http://firr.st/links.xml"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:xmlURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [NSData dataWithBytes:data length:strlen(data)]];
    
    NSURLResponse *response;
    NSError *error;
    NSData *responseXML = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"response: %@", responseXML);
    
    self.xmlParser = [[NSXMLParser alloc] initWithData:responseXML];
    self.xmlParser.delegate = self;
    [self.xmlParser parse];
    
    return [NSString stringWithString:dataString];
}

@end