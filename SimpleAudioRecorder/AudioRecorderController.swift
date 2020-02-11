//
//  ViewController.swift
//  AudioRecorder
//
//  Created by Paul Solt on 10/1/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//
import AVFoundation
import UIKit

class AudioRecorderController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var audioVisualizer: AudioVisualizer!
	
	private lazy var timeIntervalFormatter: DateComponentsFormatter = {
        // NOTE: DateComponentFormatter is good for minutes/hours/seconds
        // DateComponentsFormatter is not good for milliseconds, use DateFormatter instead)
        
		let formatting = DateComponentsFormatter()
		formatting.unitsStyle = .positional // 00:00  mm:ss
		formatting.zeroFormattingBehavior = .pad
		formatting.allowedUnits = [.minute, .second]
		return formatting
	}()
    
    
    // MARK: - View Controller Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        // Use a font that won't jump around as values change
        timeElapsedLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeElapsedLabel.font.pointSize,
                                                          weight: .regular)
        timeRemainingLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeRemainingLabel.font.pointSize,
                                                                   weight: .regular)
        loadAudio()
        
        
	}
    private func updateViews(){
        playButton.isSelected = isPlaying
    }
    
    
    
    // MARK: - Playback
    
    func loadAudio(){
        
        // app bundle is read only folder
        
        let songURL = Bundle.main.url(forResource: "piano", withExtension: "mp3")!
        
        audioPlayer = try? AVAudioPlayer(contentsOf: songURL) // FIXME..Better error handling needed

        
    }
    
    
    var isPlaying: Bool {
        audioPlayer?.isPlaying ?? false
    }
    func play(){
        audioPlayer?.play()
        updateViews()
    }
    
    func pause(){
        audioPlayer?.pause()
        updateViews()
    }
    
    func playPause(){
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    // MARK: - Recording
    
    
    
    // MARK: - Actions
    
    @IBAction func togglePlayback(_ sender: Any) {
        playPause()
	}
    
    @IBAction func updateCurrentTime(_ sender: UISlider) {
        
    }
    
    @IBAction func toggleRecording(_ sender: Any) {
        
    }
}

extension AudioRecorderController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        updateViews()
    }

    
    /* if an error occurs while decoding it will be reported to the delegate. */
  
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?){
        if let error = error {
            print("AudioPlayer Error: \(error)")
        }
    }

    
    
    
}
