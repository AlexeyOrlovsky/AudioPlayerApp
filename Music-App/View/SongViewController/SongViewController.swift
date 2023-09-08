//
//  SongViewController.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

import MediaPlayer
import AVFoundation // Library for work with Audio
import SnapKit
import SwiftUI
import UIKit

class SongViewController: UIViewController {
    
    /// Conect Audio system with App
    var audioPlayer = AVAudioPlayer() // система плеера / то засчет чего играет музыка / останавливается или играет
    var repeatAction = false
    let scrollAudioRoad = UISlider() // аудио дорожка
    
    public var position: Int = 0 // position elements in struct Song / позиция элемента в списке
    public var songs: [Song] = []
    
    /// UI Elements
    let stripButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "strip"), for: .normal)
        image.setTitleColor(.black, for: .normal)
        return image
    }()
    
    let nameTrackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .black)
        return label
    }()
    
    let imageTrackButton: UIButton  = {
        let image = UIButton()
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        return image
    }()
    
    let playPauseButton: UIButton  = {
        let button = UIButton()
        let styleButton = UIImage.SymbolConfiguration(pointSize: 200, weight: .bold, scale: .large)
        let widthButton = UIImage(systemName: "pause.fill", withConfiguration: styleButton)
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        button.tintColor = .label
        button.setImage(widthButton, for: .normal)
        return button
    }()
    
    let nextButton: UIButton  = {
        let button = UIButton()
        let styleButton = UIImage.SymbolConfiguration(pointSize: 23, weight: .bold, scale: .large)
        let widthButton = UIImage(systemName: "forward.fill", withConfiguration: styleButton)
        button.tintColor = .label
        button.setImage(widthButton, for: .normal)
        return button
    }()
    
    let previousButton: UIButton  = {
        let button = UIButton()
        let styleButton = UIImage.SymbolConfiguration(pointSize: 23, weight: .bold, scale: .large)
        let widthButton = UIImage(systemName: "backward.fill", withConfiguration: styleButton)
        button.tintColor = .label
        button.setImage(widthButton, for: .normal)
        return button
    }()
    
    let textMusicButton: UIButton  = {
        let button = UIButton()
        button.setTitle("Text", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .black)
        return button
    }()
    
    let artistNameButton: UIButton  = {
        let button = UIButton()
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    var repeatButton: UIButton = {
        let repeatButton = UIButton()
        let styleButton = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)
        let widthButton = UIImage(systemName: "repeat", withConfiguration: styleButton)
        repeatButton.setImage(widthButton, for: .normal)
        repeatButton.tintColor = .secondaryLabel
        repeatButton.layer.cornerRadius = 20
        return repeatButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddSubviews()
        audioSlider()
        configure()
    }
    
    func setupAddSubviews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageTrackButton)
        view.addSubview(playPauseButton)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        view.addSubview(nameTrackLabel)
        view.addSubview(stripButton)
        view.addSubview(textMusicButton)
        view.addSubview(artistNameButton)
        view.addSubview(repeatButton)
        
        playPauseButton.addTarget(self, action: #selector(playPauseButtonAction), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        previousButton.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        repeatButton.addTarget(self, action: #selector(repeatButtonAction), for: .touchUpInside)
        textMusicButton.addTarget(self, action: #selector(textMusicButtonAction), for: .touchUpInside)
        stripButton.addTarget(self, action: #selector(stripTarget), for: .touchUpInside)
    }
    
    func audioSlider() {
        
        scrollAudioRoad.tintColor = .systemBackground
        scrollAudioRoad.minimumTrackTintColor = .label
        scrollAudioRoad.addTarget(self, action: #selector(audioScrollAction), for: .valueChanged)
        view.addSubview(scrollAudioRoad)
        
        scrollAudioRoad.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(500)
            make.width.equalToSuperview().inset(20)
        }
        
        audioScrollAction()
    }
    
    func configure() {
        if position >= 0 && position < songs.count {
            let song = songs[position]
            
            imageTrackButton.setImage(song.image, for: .normal)
            nameTrackLabel.text = song.name
            artistNameButton.setTitle(song.artistName, for: .normal)
            
            let sound = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                scrollAudioRoad.maximumValue = Float(audioPlayer.duration)
                Timer.scheduledTimer(
                    timeInterval: 0.1,
                    target: self,
                    selector: #selector(UpdateSlider),
                    userInfo: nil,
                    repeats: true
                )
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
                
                audioPlayer.play()
                audioPlayer.delegate = self
                //audioPlayer.numberOfLoops = -1 // Бесконечное воспроизведение. Loops - повторения
            } catch {
                print("Ошибка воспроизведения музыки // configure")
                print(error)
            }
        } else {
            print("Недопустимое значение индекса")
        }
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        stripButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(5)
        }
        
        imageTrackButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(70)
            make.width.equalTo(320)
            make.height.equalTo(320)
        }
        
        nameTrackLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(415)
        }
        
        artistNameButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(440)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(580)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        previousButton.snp.makeConstraints { make in
            make.centerY.equalTo(playPauseButton)
            make.left.equalToSuperview().inset(95)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(playPauseButton)
            make.right.equalToSuperview().inset(95)
        }
        
        repeatButton.snp.makeConstraints { make in
            make.left.equalTo(nextButton.snp.right).offset(30)
            make.centerY.equalTo(playPauseButton)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        textMusicButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(0)
            make.width.equalTo(410)
            make.height.equalTo(80)
        }
    }
    
    /// viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
}

/// @objc funcs
extension SongViewController {
    
    @objc func audioScrollAction() {
        
        if audioPlayer.isPlaying == true {
            audioPlayer.pause()
            audioPlayer.currentTime = TimeInterval(scrollAudioRoad.value)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } else {
            audioPlayer.pause()
            audioPlayer.currentTime = TimeInterval(scrollAudioRoad.value)
            audioPlayer.prepareToPlay()
        }
    }
    
    @objc func UpdateSlider() {
        scrollAudioRoad.value = Float(audioPlayer.currentTime)
    }
    
    @objc func repeatButtonAction() {
        repeatAction = !repeatAction
        
        if repeatAction {
            repeatButton.tintColor = .label
            audioPlayer.numberOfLoops = -1
            repeatButton.backgroundColor = .quaternaryLabel
        } else {
            repeatButton.backgroundColor = .none
            repeatButton.tintColor = .secondaryLabel
            audioPlayer.numberOfLoops = 0
        }
    }
    
    // Play, pause button action
    @objc func playPauseButtonAction() {
        if audioPlayer.isPlaying == true {
            //playPause = false
            audioPlayer.pause()
            let styleButton = UIImage.SymbolConfiguration(pointSize: 200, weight: .black, scale: .large)
            let widthButton = UIImage(systemName: "play.fill", withConfiguration: styleButton)
            //buttonPlayPause.tintColor = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
            playPauseButton.setImage(widthButton, for: .normal)
            scrollAudioRoad.maximumValue = Float(audioPlayer.duration)
        } else {
            audioPlayer.play()
            //playPause = true
            let styleButton = UIImage.SymbolConfiguration(pointSize: 200, weight: .black, scale: .large)
            let widthButton = UIImage(systemName: "pause.fill", withConfiguration: styleButton)
            //buttonPlayPause.tintColor = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
            playPauseButton.setImage(widthButton, for: .normal)
        }
    }
    
    // Next song button
    @objc func nextButtonAction() {
        if position < songs.count {
            position += 1
            audioPlayer.stop()
            let styleButton = UIImage.SymbolConfiguration(pointSize: 200, weight: .black, scale: .large)
            let widthButton = UIImage(systemName: "pause.fill", withConfiguration: styleButton)
            playPauseButton.setImage(widthButton, for: .normal)
            configure()
        } else if position == songs.count {
            audioPlayer.play()
        }
    }
    
    // Previous song View
    @objc func previousButtonAction() {
        if position > 0 {
            position -= 1
            audioPlayer.stop()
            let styleButton = UIImage.SymbolConfiguration(pointSize: 200, weight: .black, scale: .large)
            let widthButton = UIImage(systemName: "pause.fill", withConfiguration: styleButton)
            playPauseButton.setImage(widthButton, for: .normal)
            configure()
        }
    }
    
    @objc func stripTarget() {
        dismiss(animated: true)
    }
    
    @objc func textMusicButtonAction() {
        let position = position
        let vc = MusicTextViewController()
        
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }
}

/// AVAudioPlayerDelegate
extension SongViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            position += 1
            audioPlayer.stop()
            configure()
        } else {
            print("Ошибка воспроизведения следующего трека")
        }
    }
}
