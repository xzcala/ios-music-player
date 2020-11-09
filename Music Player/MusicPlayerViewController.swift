//
//  MusicPlayerViewController.swift
//  Music Player
//
//  Created by Jon Basa on 5/7/20.
//  Copyright © 2020 Jon Basa. All rights reserved.
//

import AVFoundation
import UIKit

class MusicPlayerViewController: UIViewController {

    public var index: Int = 0
    public var songs: [Song] = []
    private var volume: Float = 0.5

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView()
    }

    func createView() {
        let song = songs[index]

        let urlString = Bundle.main.url(forResource: song.fileName, withExtension: "mp3")

        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

            guard let urlString = urlString else {
                return
            }

            player = try AVAudioPlayer(contentsOf: urlString)

            guard let player = player else {
                return
            }
            player.volume = volume

            player.play()
        }
        catch {
            print("File not found")
        }

        super.title = song.name + " - \(song.artist)"
        albumCover.image = UIImage(named: song.cover)
        titleLabel.text = song.name
        artistLabel.text = song.artist
        albumLabel.text = song.album
        backButton.tintColor = .black
        playPauseButton.tintColor = .black
        forwardButton.tintColor = .black
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        volumeSlider.tintColor = .black
        volumeSlider.value = volume
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(didTapForwardButton), for: .touchUpInside)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        
        if index == 0 {
            backButton.isEnabled = false
        } else if index == (songs.count - 1) {
            forwardButton.isEnabled = false
        }
    }

    @objc func didTapBackButton() {
        volume = volumeSlider.value
        if index > 0 {
            index = index - 1
            player?.stop()
            createView()
            forwardButton.isEnabled = true
            if index == 0 {
                backButton.isEnabled = false
            }
        }
    }

    @objc func didTapForwardButton() {
        volume = volumeSlider.value
        if index < (songs.count - 1) {
            index = index + 1
            player?.stop()
            createView()
            backButton.isEnabled = true
            if index == (songs.count - 1) {
                forwardButton.isEnabled = false
            }
        }
    }

    @objc func didTapPlayPauseButton() {
        if player?.isPlaying == true {
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }

    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
    }
}
