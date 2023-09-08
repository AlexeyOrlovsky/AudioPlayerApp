//
//  ViewController.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

import SnapKit
import SwiftUI
import UIKit

class HomeViewController: UIViewController {
    
    /// Array Song Model
    let content = ContentCell.content
    
    /// collectionView add section in collection
    fileprivate let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return HomeViewController.createSectionLayout(section: sectionIndex)
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewDidLoad()
        setupCollectionView()
    }
    
    func setupViewDidLoad() {
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "door.left.hand.open"), style: .done, target: self, action: #selector(leaveButton))
        navigationItem.leftBarButtonItem?.tintColor = .tertiaryLabel
        let titleNavigationBar = UILabel()
        titleNavigationBar.text = "Home"
        titleNavigationBar.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        navigationItem.titleView = titleNavigationBar
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(CustomSongCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.frame = view.bounds
    }
}

/// @objc funcs
extension HomeViewController {
    @objc func leaveButton() {
            let alert = UIAlertController(title: "Are you sure you want to log out of your account?", message: "If yes click the button below", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel",
                                          style: .destructive,
                                          handler: {_ in
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:
                                            {_ in
                UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
                NavigationManager.shared.showNotAuthorizedUserStage()
            }))
            present(alert, animated: true)
    }
}

/// UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomSongCell
        cell.backgroundColor = .quaternarySystemFill
        cell.layer.cornerRadius = 10
        if indexPath.section == 0 {
            cell.content = self.content[indexPath.row]
        }
        else if indexPath.section == 1 {
            cell.content = self.content[indexPath.row]
        }
        return cell
    }
    
    /// present SongController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let position = indexPath.row
        
        let vc = SongViewController()
        
        vc.songs = content
        vc.position = position
        
        present(vc, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    /// Create form section
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            
            /// Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize (widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            
            /// Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(360)), subitem: item, count: 4)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(390)), subitem: verticalGroup, count: 1)
            
            /// Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
            
        case 1:
            /// Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize (widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
            
            /// Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(640)), subitem: item, count: 8)
            
            /// Section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
            
        default:
            
            /// Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize (widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            /// Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)), subitem: item, count: 3)
            
            /// Section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            /// Позволяет скролить в сторону
            section.orthogonalScrollingBehavior = .groupPaging // .groupPaging подтягивает скрол туда, где перепадает больший процент, .continuous - делает скрол без анимации
            return section
        }
    }
}


