//
//  ConvertMp3.h
//  Whisper
//
//  Created by qf on 2020/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConvertMp3 : NSObject
- (void)audioPCMtoMP3:(NSString *)audioFileSavePath mp3File:(NSString *)mp3FilePath;

@end

NS_ASSUME_NONNULL_END
