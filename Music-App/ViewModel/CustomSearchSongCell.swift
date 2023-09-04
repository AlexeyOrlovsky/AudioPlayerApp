//
//  ContactCell.swift
//  MessenjertTestFirebaseConect
//
//  Created by Алексей Орловский on 16.04.2023.
//

import UIKit

class CustomSearchSongCell: UITableViewCell {
    
    let avatar = UIImageView()
    
    let trackName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        //label.textColor = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Constraints for tableView object
    
    private func setupCell() {
        [avatar, trackName].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
           
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatar.heightAnchor.constraint(equalToConstant: 48),
            avatar.widthAnchor.constraint(equalToConstant: 48),
            
            trackName.topAnchor.constraint(equalTo: avatar.centerYAnchor, constant: -16),
            trackName.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 8),
            trackName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
        ])
    }
    
//    func configure(contact: Contact) {
//        avatar.image = contact.image
//        nameLabel.text = contact.name
//        descriptionLabel.text = contact.status
    //        arrow.image = contact.arrow
    //    }
    
    func configCell(song: Song) {
        trackName.text = song.name
        avatar.image = song.image
    }
}
