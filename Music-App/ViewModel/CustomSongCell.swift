//
//  CustomSongCell.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

import UIKit

class CustomSongCell: UICollectionViewCell {
    
    var content: Song? {
        didSet {
            guard content != nil else { return }
            
            imageTrack.image = content?.image
            trackName.text = content?.name
            artistLabel.text = content?.artistName
        }
    }
    
    fileprivate let imageTrack: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "track8")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    fileprivate let trackName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [imageTrack, trackName, artistLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            imageTrack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageTrack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageTrack.heightAnchor.constraint(equalToConstant: 52),
            imageTrack.widthAnchor.constraint(equalToConstant: 52),
        
            trackName.topAnchor.constraint(equalTo: contentView.topAnchor),
            trackName.leadingAnchor.constraint(equalTo: imageTrack.trailingAnchor, constant: 16),
            trackName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            trackName.heightAnchor.constraint(equalToConstant: 60),
            
            artistLabel.bottomAnchor.constraint(equalTo: trackName.bottomAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: imageTrack.trailingAnchor, constant: 16),
        ])
    }
    
    func configure(song: Song) {
        imageTrack.image = song.image
        trackName.text = song.name
        artistLabel.text = song.artistName
    }
}


