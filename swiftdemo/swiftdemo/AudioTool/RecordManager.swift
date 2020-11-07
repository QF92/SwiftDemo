//
//  RecordManager.swift
//  Whisper
//
//  Created by qf on 2020/11/3.
//

import UIKit
import AVFoundation
public typealias Audioclose = (() -> Void)
class RecordManager: NSObject {
    static let shared = RecordManager()
    
    var recorder: AVAudioRecorder? //录音器
    var volumeTimer:Timer! //定时器线程，循环监测录音的音量大小
    var volumLab: UILabel! //显示录音音量
    var recordFileName:String! // 音频存储路径
    var recordMP3Name:String! // 音频转化成Mp3格式路径
    /*************************/
    var player:AVAudioPlayer? //播放器
    var IsAudioPlaying: Bool? = false
    var  CurrentVoiceUrl:String!
    public var AudioClosure: Audioclose?
    override init() {
        super.init()
        
    }
    
    func beginRcord(){
        //初始化录音器
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        //设置录音类型 // playAndRecord 听筒模式  //Playback 扬声器模式
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)
        } catch let err{
            print("设置类型失败:\(err.localizedDescription)")
        }
        //设置支持后台
        do {
            try session.setActive(true)
        } catch let err {
            print("初始化动作失败:\(err.localizedDescription)")
        }
        ////录音器设置参数数组
        let recordSetting: [String: Any] = [
            AVSampleRateKey: NSNumber(value: 16000),//采样率
            AVEncoderBitRateKey:NSNumber(value: 16000),
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),//音频格式 //kAudioFormatMPEG4AAC
            AVNumberOfChannelsKey: NSNumber(value: 2),//录音的声道数，立体声为双声道
            AVLinearPCMBitDepthKey:NSNumber(value: 16),
            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.max.rawValue)//录音质量
        ];
        
        
        recordFileName = SKMEETAudioFilePath("tempRecord.caf")
        recordMP3Name = SKMEETAudioFilePath("Record.mp3")
         
        self.SKMEETRemoveFilePath(recordFileName) //先删除本地保持的音频
        //开始录音 并初始化录音器
        do {
            let url = URL(fileURLWithPath: recordFileName)
            recorder = try AVAudioRecorder(url: url, settings: recordSetting)
            if recorder != nil {
                //开启仪表计数功能
                recorder!.isMeteringEnabled = true
                //准备录音
                recorder!.prepareToRecord()
                //开始录音
                recorder!.record()
                //启动定时器，定时更新录音音量
                volumeTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                        selector: #selector(self.levelTimer),
                                        userInfo: nil, repeats: true)
            }
            print("开始录音----")
        } catch let err {
            print("录音失败:\(err.localizedDescription)")
        }
    }
    
        //松开按钮，结束录音
      func upAction(_ sender: AnyObject) {
            recorder?.stop()  //停止录音
            recorder = nil   //录音器释放
        ConvertMp3().audioPCMtoMP3(recordFileName, mp3File: recordMP3Name)
        do {
            let Mp3Data = try Data(contentsOf: URL(fileURLWithPath: recordMP3Name))  //上传的语音data
            
//            self.SKMEETMakePlayer(recordMP3Name,true) 
        }catch{ }
            volumeTimer.invalidate() //暂停定时器
            volumeTimer = nil
            volumLab.text = "0"
        }
        //定时检测录音音量
    @objc func levelTimer(){
           recorder!.updateMeters() // 刷新音量数据
            let averageV:Float = recorder!.averagePower(forChannel: 0) //获取音量的平均值
            let maxV:Float = recorder!.peakPower(forChannel: 0) //获取音量最大值
            let lowPassResult:Double = pow(Double(10), Double(0.05*maxV))
            volumLab.text = "\(lowPassResult)"
        }
    //录音存储路径
    func SKMEETAudioFilePath(_ formatname: String) -> String {
        
        //获取Document目录
        let cachePath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first
        //  NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0]
        
        let filePath = cachePath! + ("/play.aac") //组合录音文件路径
        let fileManger = FileManager.default
        if !(fileManger.fileExists(atPath: filePath)) {
            do {
                 try fileManger.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            } catch let error  {
                print(error.localizedDescription) //文件夹创建失败
            }
        }else{
            print("file exit")
        }
        let recordFileName = filePath + "/\(formatname)"
        return recordFileName
    }
    func SKMEETRemoveFilePath(_ filePath: String){
        let fileManger = FileManager.default
        if fileManger.fileExists(atPath: filePath) {
            do {
                 try fileManger.removeItem(atPath: filePath)
            } catch {
                print("文件夹创建失败")
            }
        }
    }
    

}
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

extension RecordManager:AVAudioPlayerDelegate{
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
            print("finished recording")
        }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.SKMEETStop()
        self.AudioClosure!()
    }
    
    
       //播放音频
    func SKMEETplayAction(_ PlayUrl:String,_ AudioStop:@escaping Audioclose) {   //播放
        if PlayUrl.isEmpty{
            return
        }
        if MD5(string: PlayUrl) == self.CurrentVoiceUrl  {
            if self.player != nil && self.IsAudioPlaying == true {
                self.SKMEETStop()
                return
            }
        }
        if (self.player != nil) {
            self.SKMEETStop()
        }
        self.IsAudioPlaying = true
        self.CurrentVoiceUrl = MD5(string: PlayUrl)
        //音频下载
        self.SKMEETAudioDownloadUrl(PlayUrl) { (Path) in
            self.SKMEETMakePlayer(Path,false)
        }
         self.AudioClosure = AudioStop
    }
   
    func SKMEETMakePlayer(_ FileUrl:String,_ PathOrUrl:Bool) {
        if FileUrl.isEmpty {
            return
        }
            do {
                player =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath:FileUrl))
            } catch let err {
                print("播放失败:\(err.localizedDescription)")
            }
            player!.prepareToPlay()  //音频播放之前需要准备播放
            player!.delegate = self
            player!.volume = 1
            UIDevice.current.isProximityMonitoringEnabled = true //开启红外线功能
            print("播放录音长度：\(player!.duration)")  //上传语音时间
            player!.play()
    }
    
    func SKMEETStop(){
        if self.player != nil {
            self.player!.stop()
            self.player!.delegate = nil
            self.player = nil
        }
        UIDevice.current.isProximityMonitoringEnabled = false
    }
    func SKMEETAudioDownloadUrl(_ URLStr: String,_ callback:@escaping(_ Path:String) -> Void ){
       
        let defaultConfigeObject = URLSessionConfiguration.default
        
        let cache =  URLCache.init(memoryCapacity: 16384, diskCapacity: 268435456, diskPath: "/AudioCache")
        defaultConfigeObject.urlCache = cache
        defaultConfigeObject.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
        
        let session = URLSession(configuration: defaultConfigeObject)
        
        let task = session.dataTask(with:URL(string: URLStr)!, completionHandler:{ [self](data, response, error) in
            //amr 格式判断 转换
            if URLStr.hasSuffix(".amr") {
//                let wavPath = NSTemporaryDirectory()  + "/AudioTempFile_fromAmr.wav"
//                do {
//                    let amrPath = NSTemporaryDirectory() + "/AudioTempFile.amr"
//                    try data?.write(to: URL(fileURLWithPath: amrPath))
//                    VoiceConverter.convertAmr(toWav: amrPath, wavSavePath:wavPath)
////                    print("wav文件：\(wavPath)")
//                }catch let err {
//                    print("转wav文件异常：\(err.localizedDescription)")
//                }
                callback(convertAmrToWav(data!))
            }else{
            let filename = (URLStr as NSString).lastPathComponent
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
            let pathHosts =  path.appending("/\(MD5(string:filename))")

            let lastPath = pathHosts + "/audio.mp3"
            let fileManger = FileManager.default
            if !(fileManger.fileExists(atPath: pathHosts)) {
                do {
                    try fileManger.createDirectory(atPath: pathHosts, withIntermediateDirectories: true, attributes: nil)
                    try  data!.write(to: URL(fileURLWithPath: lastPath))
                } catch let error  {
                    print(error.localizedDescription) //文件夹创建失败
                }
            }
//          print("++++\(lastPath)")
            callback(lastPath)
            }
        })
            task.resume()
    }
    
    func MD5(string: String) -> String {
            let length = Int(CC_MD5_DIGEST_LENGTH)
            let messageData = string.data(using:.utf8)!
            var digestData = Data(count: length)

            _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
                messageData.withUnsafeBytes { messageBytes -> UInt8 in
                    if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                        let messageLength = CC_LONG(messageData.count)
                        CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                    }
                    return 0
                }
            }
        let md5Hex =  digestData.map { String(format: "%02hhx", $0) }.joined()
        let md5Base64 = digestData.base64EncodedString()
            return md5Hex
        }
    
}
extension RecordManager{
    //#pragma mark - 工具
    
    func convertWavToAmr(){
//        let wavPath = NSHomeDirectory() + "/Documents/\(recordName!).wav"
//        do {
//            let wavData = try Data(contentsOf: URL(fileURLWithPath: wavPath))
//            let amrData = convert16khzWaveToAmr(waveData: wavData)
//            let amrPath = NSHomeDirectory() + "/Documents/\(recordName!).amr"
//            try amrData?.write(to: URL(fileURLWithPath: amrPath))
//            print("wav源文件：\(wavPath)")
//            print("amr文件：\(amrPath)")
//        }catch let err {
//            print("转amr文件异常：\(err.localizedDescription)")
//        }
        
    }
    
    func convertAmrToWav(_ amrdata:Data) -> String {
        //沙盒根路径
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let recordName = "\(timeStamp)"
        
        let wavPath = NSTemporaryDirectory()  + "/AudioTempFile_fromAmr.wav"
        let amrPath = NSTemporaryDirectory() + "/AudioTempFile.amr"
        do {
            try amrdata.write(to: URL(fileURLWithPath: amrPath))
            let wavData =  convertAmrNBToWave(data: amrdata)
            try wavData?.write(to: URL(fileURLWithPath: wavPath))
            print("amr源文件：\(amrPath)")
            print("wav文件：\(wavPath)")
        }catch let err {
            print("转wav文件异常：\(err.localizedDescription)")
        }
        return wavPath
    }
}
