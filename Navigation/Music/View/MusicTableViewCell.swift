//
//  MusicTableViewCell.swift
//  Navigation
//
//  Created by Vadim on 11.06.2022.
//

import UIKit
import SnapKit

class MusicTableViewCell: UITableViewCell {
    
    // MARK: PROPERTIES
    
    private lazy var musicIcon = UIImageView()
        
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    // MARK: INITIALIZATORS

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(trackNameLabel, musicIcon)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        apply(theme: traitCollection.userInterfaceStyle == .light ? .light : .dark)
    }
    
    // MARK: METHODS

    func setupLayout() {
        
        musicIcon.tintColor = .red
        
        apply(theme: traitCollection.userInterfaceStyle == .light ? .light : .dark)

        musicIcon.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(12)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalTo(musicIcon.snp.trailing).offset(12)
        }
    }
    
    func setConfigureOfCell(model: MusicViewModel, index: Int) {
        
        var currentTrackName: String {
            get {
                let singer = Array(MusicViewModel.tracks.values)[index]
                let track = Array(MusicViewModel.tracks.keys)[index]
                return "\(singer) - \(track)"
            }
        }
        
        trackNameLabel.text = currentTrackName
    }
}

extension MusicTableViewCell: Themeable {
    
    func apply(theme: Theme) {
        self.musicIcon.image = getIcon("music.note", 24, theme.colors.palette.text)
        self.contentView.backgroundColor = theme.colors.palette.cell
        self.trackNameLabel.textColor = theme.colors.palette.text
        self.musicIcon.tintColor = theme.colors.palette.foregroud
    }
}
