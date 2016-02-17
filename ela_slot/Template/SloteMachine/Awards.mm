

#import "Awards.h"
#import "cfg.h"

@implementation Awards

+(NSArray *)returnArray_a:(int)a b:(int)b c:(int)c d:(int)d
{
  return [NSArray arrayWithObjects:
     [NSNumber numberWithInt:a],
     [NSNumber numberWithInt:b],
     [NSNumber numberWithInt:c],
     [NSNumber numberWithInt:d],nil];
}

+(int)getAward:(NSString *)iconName winCount:(int)winC
{

    NSMutableDictionary *dic = [[[NSMutableDictionary alloc]init]autorelease];
    if([[UIScreen mainScreen] respondsToSelector:NSSelectorFromString(@"scale")] && [(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]&&[[UIScreen mainScreen] scale] > 1.9){
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:2 b:40 c:200 d:1000] forKeys:
          [self returnArray_a:2 b:3  c:4   d:5]]
                forKey:kICON1ipad];
        
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:2 b:30 c:150 d:400] forKeys:
          [self returnArray_a:2 b:3  c:4   d:5]]
                forKey:kICON2ipad];
        
        
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:2 b:20 c:100 d:250] forKeys:
          [self returnArray_a:2 b:3  c:4   d:5]]
                forKey:kICON3ipad];
        
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:2 b:10 c:50 d:100] forKeys:
          [self returnArray_a:2 b:3  c:4  d:5]]
                forKey:kICON4ipad];
        
        
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:20 b:45 c:200 d:0] forKeys:
          [self returnArray_a:3  b:4  c:5   d:2]]
                forKey:kAipad];
        
        
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:20 b:50 c:150 d:0] forKeys:
          [self returnArray_a:3  b:4  c:5   d:2]]
                forKey:kKipad];
        
        
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:15 b:25 c:100 d:0] forKeys:
          [self returnArray_a:3  b:4  c:5   d:2]]
                forKey:kQipad];
        
        
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:15 b:20 c:100 d:0] forKeys:
          [self returnArray_a:3  b:4  c:5   d:2]]
                forKey:kJipad];
        
        
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:10 b:20 c:50 d:0] forKeys:
          [self returnArray_a:3  b:4  c:5  d:2]]
                forKey:k10ipad];
        
        
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:5 b:50 c:500 d:5000] forKeys:
          [self returnArray_a:2 b:3  c:4   d:5]]
                forKey:kWILDipad];
        
        
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:5 b:15 c:30 d:0] forKeys:
          [self returnArray_a:3 b:4  c:5  d:2]]
                forKey:kSCATERipad];
        
        
        [dic setObject:
         [NSMutableDictionary dictionaryWithObjects:
          [self returnArray_a:0 b:0 c:0 d:0] forKeys:
          [self returnArray_a:3 b:4 c:5 d:2]]
                forKey:kBONUSipad];
            }else{
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:2 b:40 c:200 d:1000] forKeys:
                  [self returnArray_a:2 b:3  c:4   d:5]]
                        forKey:kICON1];
                
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:2 b:30 c:150 d:400] forKeys:
                  [self returnArray_a:2 b:3  c:4   d:5]]
                        forKey:kICON2];
                
                
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:2 b:20 c:100 d:250] forKeys:
                  [self returnArray_a:2 b:3  c:4   d:5]]
                        forKey:kICON3];
                
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:2 b:10 c:50 d:100] forKeys:
                  [self returnArray_a:2 b:3  c:4  d:5]]
                        forKey:kICON4];
                
                
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:20 b:45 c:200 d:0] forKeys:
                  [self returnArray_a:3  b:4  c:5   d:2]]
                        forKey:kA];
                
                
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:20 b:50 c:150 d:0] forKeys:
                  [self returnArray_a:3  b:4  c:5   d:2]]
                        forKey:kK];
                
                
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:15 b:25 c:100 d:0] forKeys:
                  [self returnArray_a:3  b:4  c:5   d:2]]
                        forKey:kQ];
                
                
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:15 b:20 c:100 d:0] forKeys:
                  [self returnArray_a:3  b:4  c:5   d:2]]
                        forKey:kJ];
                
                
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:10 b:20 c:50 d:0] forKeys:
                  [self returnArray_a:3  b:4  c:5  d:2]]
                        forKey:k10];
                
                
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:5 b:50 c:500 d:5000] forKeys:
                  [self returnArray_a:2 b:3  c:4   d:5]]
                        forKey:kWILD];
                
                
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:5 b:15 c:30 d:0] forKeys:
                  [self returnArray_a:3 b:4  c:5  d:2]]
                        forKey:kSCATER];
                
                
                [dic setObject:
                 [NSMutableDictionary dictionaryWithObjects:
                  [self returnArray_a:0 b:0 c:0 d:0] forKeys:
                  [self returnArray_a:3 b:4 c:5 d:2]]
                        forKey:kBONUS];

    }
    
    
    
    
    NSMutableDictionary *d = [dic objectForKey:iconName];
 
    NSNumber *s = [d objectForKey:[NSNumber numberWithInt:winC]];
    
    return s.intValue;

}

@end
