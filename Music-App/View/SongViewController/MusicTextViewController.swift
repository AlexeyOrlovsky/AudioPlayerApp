//
//  MusicTextViewController.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

import SnapKit
import SwiftUI
import UIKit

class MusicTextViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    /// UI Elements
    let stripButton: UIButton  = {
        let image = UIButton()
        image.setImage(UIImage(named: "strip"), for: .normal)
        image.setTitleColor(.black, for: .normal)
        return image
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Text Music"
        //label.textColor = UIColor(red: 207/255, green: 207/255, blue: 207/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 22, weight: .black)
        return label
    }()
    
    let musicTextLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 340, height: 600))
        //label.textColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewDidLoad()
        setupAddSubviews()
        configure()
    }
    
    func setupViewDidLoad() {
        view.backgroundColor = .systemBackground
    }
    
    func setupAddSubviews() {
        view.addSubview(stripButton)
        view.addSubview(musicTextLabel)
        view.addSubview(textLabel)
        
        stripButton.addTarget(self, action: #selector(stripTarget), for: .touchUpInside)
    }
    
    func configure() {
        let song = songs[position]
        musicTextLabel.text = song.textMusic
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        stripButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(5)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.left.equalToSuperview().inset(30)
        }
        
        musicTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview().inset(30)
            make.width.equalTo(340)
        }
    }
}

/// @objc funcs
extension MusicTextViewController {
    
    @objc func stripTarget() {
        dismiss(animated: true)
    }
}


