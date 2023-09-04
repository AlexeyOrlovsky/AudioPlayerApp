//
//  SectionHeader.swift
//  Music-App
//
//  Created by Алексей Орловский on 09.05.2023.
//

//import UIKit
//
//class SectionHeader: UICollectionReusableView {
//
//    static let reuserId = "SectionHeader"
//
//    let title = UILabel()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        //
//
//        costomizeElements()
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func costomizeElements() {
//        title.textColor = .white
//        title.font = UIFont(name: "avenir", size: 20)
//        title.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    func setupConstraints() {
//        addSubview(title)
//        NSLayoutConstraint.activate([
//            title.topAnchor.constraint(equalTo: topAnchor),
//            title.leadingAnchor.constraint(equalTo: leadingAnchor),
//            title.trailingAnchor.constraint(equalTo: trailingAnchor),
//            title.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//}

