//
//  MusicPlayerView.swift
//  Navigation
//
//  Created by Vadim on 11.06.2022.
//

import UIKit
import AVFoundation
import SnapKit

class MusicPlayerView: UIView {
    
    // MARK: PROPERTIES
    
    private var player = AVAudioPlayer()
    private var model = MusicViewModel()
    private var counter = 0
    
    private var currentTrackName: String {
        get {
            let singer = Array(MusicViewModel.tracks.values)[counter]
            let track = Array(MusicViewModel.tracks.keys)[counter]
            return "\(singer) - \(track)"
        }
    }
    
    private lazy var playPauseButton = CustomIcon(name: "play.fill")
    private lazy var stopButton = CustomIcon(name: "stop.fill")
    private lazy var nextTrackButton = CustomIcon(name: "forward.fill")
    private lazy var previousTrackButton = CustomIcon(name: "backward.fill")
    
    
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var playerButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousTrackButton, playPauseButton, stopButton, nextTrackButton])
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    
    // MARK: INITS
    
    init () {
        super.init(frame: .zero)
        addSubviews(playerButtonsStackView, trackNameLabel)
        setupLayout()
        setTrack()
        setActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        apply(theme: traitCollection.userInterfaceStyle == .light ? .light : .dark)
    }
    
    // MARK: METHODS
    
    private func setTrack() {
        let trackName = Array(MusicViewModel.tracks.keys)[counter]
        
        guard let trackURL = Bundle.main.url(forResource: trackName, withExtension: "mp3") else { return }
        
        do {
            try player = AVAudioPlayer(contentsOf: trackURL)
            player.prepareToPlay()
            
        } catch { print(error.localizedDescription) }
        
        trackNameLabel.text = currentTrackName
    }
    
    
    public func playSelectedTrack (forIndex index: Int) {
        counter = index
        setTrack()
        player.play()
        playPauseButton = CustomIcon(name: "pause.fill")
    }
    
    private func setupLayout() {
        
        apply(theme: traitCollection.userInterfaceStyle == .light ? .light : .dark)
        
        playerButtonsStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(32)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalTo(playerButtonsStackView.snp.top).offset(-32)
        }
    }
    
    private func setActions() {
        playPauseButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.playPauseButtonAction()
            }
        
         stopButton.tapAction = { [weak self] in
             guard let self = self else { return }
             self.stopButtonAction()
             }
        
         nextTrackButton.tapAction = { [weak self] in
             guard let self = self else { return }
             self.nextTrackAction()
             }
        
         previousTrackButton.tapAction = { [weak self] in
             guard let self = self else { return }
             self.prevTrackAction()
             }
    }
    
    
    // MARK: OBJC METHODS
    
    @objc
    private func nextTrackAction () {
        if counter == MusicViewModel.tracks.count - 1 {
            counter = 0
        } else {
            counter += 1
        }
        trackNameLabel.text = "\(currentTrackName)"
        setTrack()
        player.play()
    }
    
    
    @objc
    private func prevTrackAction () {
        if counter == 0 {
            counter = MusicViewModel.tracks.count - 1
        } else {
            counter -= 1
        }
        trackNameLabel.text = "\(currentTrackName)"
        setTrack()
        player.play()
    }
    
    @objc
    private func playPauseButtonAction() {
        
        if player.isPlaying {
            player.pause()
            playPauseButton = CustomIcon(name: "play.fill")
            
        } else {
            player.play()
            playPauseButton = CustomIcon(name: "pause.fill")
        }
    }
    
    
    @objc
    private func stopButtonAction() {
        player.stop()
        player.currentTime = 0
        playPauseButton = CustomIcon(name: "play.fill")
    }
}

extension MusicPlayerView: Themeable {
    
    func apply(theme: Theme) {
        self.backgroundColor = theme.colors.palette.foregroud
        
        [playPauseButton,
         stopButton,
         nextTrackButton,
         previousTrackButton].forEach( { $0.color = theme.colors.palette.foregroud } )
        trackNameLabel.textColor = theme.colors.palette.text
    }
}
