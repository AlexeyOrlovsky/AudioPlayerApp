//
//  Storage.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

// MARK: SceneDelegate
//guard let _ = (scene as? UIWindowScene) else { return }
//
//window?.rootViewController = SignInViewController()


// MARK: Item Collection on Home view / func createSectionLayout
// Item

//let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize (widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
//
//item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
//
//// Group
//
//let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(360)), subitem: item, count: 3)
//
//let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(390)), subitem: verticalGroup, count: 1)
//
//// Section
//
//let section = NSCollectionLayoutSection(group: horizontalGroup)
//// Позволяет скролить в сторону
//section.orthogonalScrollingBehavior = .groupPaging // .groupPaging подтягивает скрол туда, где перепадает больший процент, .continuous - делает скрол без анимации
//return section
//


//
//_ = songs[position]
//
//let urIString = Bundle.main.path(forResource: "song1", ofType: "mp3")
//do {
//    try AVAudioSession.sharedInstance().setMode(.default)
//    try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
//
//    guard urIString != nil else {
//        print("urlString is nil")
//        return
//    }
//    player = try AVAudioPlayer(contentsOf: URL(string: urIString!)!)
//
//    guard let player = player else {
//        print("player is nil")
//        return
//    }
//    player.play()
//}
//catch {
//    print ("error occurred")
//}
//
////
//
//}
//
//override func viewWillDisappear(_ animated: Bool) {
//super.viewWillDisappear(animated)
//if let player = player {
//    player.stop()
//}
//}
//}
//
////    func configure() {
////        // set up player
////        let song = songs[position]
////
////        let urIString = Bundle.main.path(forResource: "song1", ofType: "mp3")
////        do {
////            try AVAudioSession.sharedInstance().setMode(.default)
////            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
////
////            guard urIString != nil else {
////                print("urlString is nil")
////                return
////            }
////            player = try AVAudioPlayer(contentsOf: URL(string: urIString!)!)
////
////            guard let player = player else {
////                print("player is nil")
////                return
////            }
////            player.play()
////        }
////        catch {
////            print ("error occurred")
////        }
////
////        //
////
////    }
////
////    override func viewWillDisappear(_ animated: Bool) {
////        super.viewWillDisappear(animated)
////        if let player = player {
////            player.stop()
////        }
////    }
///
///
///
///


// Notification

//setUpRemoteTransparentControls()
//setupNotification()


//func pauseSong() {
//    if audioPlayer.isPlaying {
//        audioPlayer.pause()
//    }
//}
//
//func setUpRemoteTransparentControls() {
//
//    let commandCenter = MPRemoteCommandCenter.shared()
//    commandCenter.playCommand.addTarget { [self] event in
//        if !audioPlayer.isPlaying {
//            self.playPauseButton()
//            return .success
//        }
//        return .commandFailed
//    }
//    commandCenter.pauseCommand.addTarget { [self] event in
//        if audioPlayer.isPlaying {
//            self.pauseSong()
//            return .success
//        }
//        return .commandFailed
//    }
//
//    commandCenter.nextTrackCommand.addTarget { [self] event in
//        if audioPlayer.isPlaying {
//            self.nextButton()
//        }
//        return .commandFailed
//    }
//
//    commandCenter.previousTrackCommand.addTarget { [self] event in
//        if audioPlayer.isPlaying {
//            self.previousButton()
//        }
//        return .commandFailed
//    }
//
//    commandCenter.changePlaybackPositionCommand.addTarget(self, action: #selector(changeTumbSlider(_:)))
//}
//
//
//
//@objc func changeTumbSlider(_ event: MPChangePlaybackPositionCommandEvent) -> MPRemoteCommandHandlerStatus {
//
//    audioPlayer.currentTime = event.positionTime
//    return .success
//}
//
//func setupNotification() {
//
//    let notificationCenter = NotificationCenter.default
//    notificationCenter.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: nil)
//    notificationCenter.addObserver(self, selector: #selector(handleRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
//}
//
//@objc func handleInterruption(notification: Notification) {
//
//    guard let userInfo = notification.userInfo,
//    let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
//     let type = AVAudioSession.InterruptionType(rawValue: typeValue)
//    else {
//        return
//    }
//
//    if type == .began {
//        print("began")
//    }
//    else if type == .ended {
//        if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
//            let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
//
//            if options.contains(.shouldResume) {
//                playPauseButton()
//            } else {
//                print("end")
//            }
//        }
//    }
//}
//
//@objc func handleRouteChange(notification: Notification) {
//
//    guard let userInfo = notification.userInfo,
//    let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
//    let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue)
//
//    else {
//        return
//    }
//
//    switch reason {
//    case .newDeviceAvailable:
//        let session = AVAudioSession.sharedInstance()
//        for outPut in session.currentRoute.outputs where outPut.portType == AVAudioSession.Port.headphones {
//            print("headphone conected")
//            DispatchQueue.main.sync {
//                self.playPauseButton()
//            }
//        }
//        break
//    case .oldDeviceUnavailable:
//
//        if let previusChange = userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
//            for output in previusChange.outputs where output.portType == AVAudioSession.Port.headphones {
//                print("headphones disconected")
//                DispatchQueue.main.sync {
//                    self.pauseSong()
//                }
//            }
//        }
//        break
//    @unknown default: ()
//    }
//}


// configure

//nowPlayingInfo[MPMediaItemPropertyArtist] = nameTrack.text
//nowPlayingInfo[MPMediaItemPropertyTitle] = songs
//nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = audioPlayer.currentTime
//nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = audioPlayer.rate
//nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = audioPlayer.duration
//
//MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo

