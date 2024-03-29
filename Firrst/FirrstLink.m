#import "FirrstLink.h"

@implementation FirrstLink

@synthesize xmlParser, dataString, currentElement;

static FirrstLink *sharedObject = nil;

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
    if([elementName isEqualToString:@"shortUrl"]){  //TODO update for firr.st 'shash'
        self.dataString = [[NSMutableString alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if([self.currentElement isEqualToString:@"shortUrl"])  //TODO shash
        [self.dataString appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
}

// TODO: this it probably too liberal
+(NSURL*)validateURL:(NSString*)possibleURL
{
    if ([possibleURL length] == 0) {
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString: possibleURL];
    // Make sure it's considered valid and has a scheme.
    if (url == nil) {
        return nil;
    }
    
    // Make sure the URL has a scheme e.g. google.com => http://google.com
    if ([url.scheme length] == 0) {
        NSLog(@"URL is missing a scheme adding http adding %@", [NSString stringWithFormat: @"http://%s", url.absoluteURL]);
        url = [NSURL URLWithString: [NSString stringWithFormat: @"http://%@", url.absoluteURL]];
    }
    return url;
}

+(void)shortenURLAsynchronous:(NSURL*)inputURL onComplete:(void (^)(NSString*))handler
{
    NSString *longURL = [inputURL absoluteString];
    NSString *APILogin = @"rovertus";
    NSString *APIKey = @"R_7ee14f1ff14f0d733843f12af494bacd";
    NSString *requestURL = [[NSString alloc] initWithFormat:@"http://api.bit.ly/shorten?version=2.0.1&longUrl=%@&login=%@&apiKey=%@&format=json", longURL, APILogin, APIKey];
    
    // Build a block for parsing the URL from the JSON and then handing that
    // to their handler.
    void (^complete)(NSURLResponse*, NSData*, NSError*) = ^(NSURLResponse *r, NSData *d, NSError *e) {
        // TODO this really needs error checking... or probably just be done
        // via regex.
        id result = [NSJSONSerialization JSONObjectWithData:d 
                                                    options:NSJSONReadingMutableContainers 
                                                      error:nil];
        NSLog(@"Response %@", result);
        NSString *shortURL = [[[result objectForKey: @"results"] objectForKey: longURL] objectForKey: @"shortUrl"];
        handler(shortURL);
    };
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:requestURL]];
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:complete];
    
}

-(NSString *) makeThisURLShortWithBitly:(NSString *)longURL{
    self.dataString =nil;
    NSString *APILogin = @"rovertus";
    NSString *APIKey = @"R_7ee14f1ff14f0d733843f12af494bacd";
    NSString *requestString = [[NSString alloc] initWithFormat:@"http://api.bit.ly/shorten?version=2.0.1&longUrl=%@&login=%@&apiKey=%@&format=xml",longURL,APILogin,APIKey];
    NSURL *xmlURL = [NSURL URLWithString:requestString];
    
    self.xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    self.xmlParser.delegate = self;
    [self.xmlParser parse];
    
    return [NSString stringWithString:dataString];
}

-(NSString *) makeThisURLShort:(NSString *)longURL{
    self.dataString =nil;
    //TODO figure out how to do plist files
    //TODO RestKit?
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