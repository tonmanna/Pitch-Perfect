//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Tonman-PC on 8/14/2558 BE.
//  Copyright (c) 2558 TBD. All rights reserved.
//
import UIKit
import AVFoundation
class RecourdSoundViewController: UIViewController , AVAudioRecorderDelegate {
    @IBOutlet weak var lbRecord: UILabel!
    @IBOutlet weak var lbTapRecord: UILabel!
    
    @IBOutlet weak var btRecord: UIButton!
    @IBOutlet weak var btStop: UIButton!
    //Declared Globally
    var audioRecorder:AVAudioRecorder!
    var recordedAudio : RecordedAudio!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        btStop.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopAudio(sender: UIButton) {
        btRecord.enabled = true
        lbRecord.hidden = true
        lbTapRecord.hidden = false;
        btStop.hidden = true
        
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    @IBAction func recordAcudio(sender: UIButton) {
        ///TODO: Show text recording in progress"

        lbRecord.hidden = false
        lbTapRecord.hidden = true
        btStop.hidden = false
        btRecord.enabled = false
        

        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)
            performSegueWithIdentifier("stopRecording",sender :recordedAudio)
        }
        else{
            let uiAlertView = UIAlertView()
            uiAlertView.title = "Error!!";
            uiAlertView.message = "Record is not successful"
            uiAlertView.addButtonWithTitle("OK")
            uiAlertView.show();

            btRecord.enabled = true
            btStop.hidden = true
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.recivededAudio = data
        }
        super.prepareForSegue(segue,sender: sender)
    }
}