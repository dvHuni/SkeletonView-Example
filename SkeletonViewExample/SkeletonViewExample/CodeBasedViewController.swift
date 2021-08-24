//
//  CodeBasedViewController.swift
//  SkeletonViewExample
//
//  Created by AhnSangHoon on 2021/08/24.
//

import UIKit

class CodeBasedViewController: UIViewController {
    private let bannerImageView = UIImageView()
    private let bannerLabelView = BannerLabelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
        
    private func attribute() {
        view.backgroundColor = .white
    }
    
    private func layout() {
        view.addSubview(bannerImageView)
        view.addSubview(bannerLabelView)
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 300),
            
            bannerLabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            bannerLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


fileprivate class BannerLabelView: UIView {
    private let titleLabel = UILabel()
    private let mainContentLabel = UILabel()
    private let subContentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Title"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContentLabel.text = "Main Content"
        mainContentLabel.translatesAutoresizingMaskIntoConstraints = false
        subContentLabel.text = "Sub Content"
        subContentLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        addSubview(titleLabel)
        addSubview(mainContentLabel)
        addSubview(subContentLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 16),
            
            mainContentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            mainContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainContentLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 16),
            
            subContentLabel.topAnchor.constraint(equalTo: mainContentLabel.bottomAnchor, constant: 8),
            subContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            subContentLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 16),
            subContentLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
