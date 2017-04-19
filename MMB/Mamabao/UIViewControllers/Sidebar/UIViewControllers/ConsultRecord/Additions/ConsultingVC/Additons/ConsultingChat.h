//
//  ConsultingChat.h
//  Mamabao
//
//  Created by Michael on 15/11/14.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "ViewPagerController.h"
#import "Mp3Recorder.h" //语音
#import "UUPHUD.h"      //语音提示
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ConsultingChat : UIViewController<Mp3RecorderDelegate,AVAudioPlayerDelegate>
{
    //语音
    BOOL isbeginVoiceRecord;
    Mp3Recorder *MP3;
    NSInteger playTime;
    NSTimer *playTimer;
    UUPHUD *hud;
    AVAudioPlayer *audioPlayer;
    NSInteger currentIndex;
    NSInteger oldIndex;
}

@property (nonatomic, assign) NSInteger detailId;
@property (nonatomic, assign) NSInteger *talker;//talker=0 表示用户  //talker = 1表示医生

@end
