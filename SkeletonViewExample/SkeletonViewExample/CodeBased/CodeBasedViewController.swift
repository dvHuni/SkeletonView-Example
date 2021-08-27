//
//  CodeBasedViewController.swift
//  SkeletonViewExample
//
//  Created by AhnSangHoon on 2021/08/24.
//

import UIKit
import SkeletonView

class CodeBasedViewController: UIViewController {
    private let bannerImageView = UIImageView()
    private let bannerLabelView = BannerLabelView()
    private let skeletonCollectionViewLayout = UICollectionViewFlowLayout()
    private lazy var skeletonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: skeletonCollectionViewLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if bannerLabelView.isLaidOut {
            view.showSkeleton()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.view.hideSkeleton()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func attribute() {
        view.backgroundColor = .white
        view.isSkeletonable = true
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerLabelView.isSkeletonable = true
        bannerLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        skeletonCollectionView.isSkeletonable = true
        skeletonCollectionView.translatesAutoresizingMaskIntoConstraints = false
        skeletonCollectionView.backgroundColor = .white
        skeletonCollectionView.delegate = self
        skeletonCollectionView.dataSource = self
        skeletonCollectionView.register(SkeletonCollectionViewCell.self, forCellWithReuseIdentifier: SkeletonCollectionViewCell.description())
        
        skeletonCollectionViewLayout.scrollDirection = .horizontal
    }
    
    private func layout() {
        view.addSubview(bannerImageView)
        view.addSubview(bannerLabelView)
        view.addSubview(skeletonCollectionView)
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 300),
            
            bannerLabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            bannerLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            skeletonCollectionView.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor),
            skeletonCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skeletonCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skeletonCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CodeBasedViewController: SkeletonCollectionViewDelegate { }

extension CodeBasedViewController: SkeletonCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: SkeletonCollectionViewCell.description(), for: indexPath)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return SkeletonCollectionViewCell.description()
    }
}

extension CodeBasedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 180)
    }
}

fileprivate class BannerLabelView: UIView {
    private let titleLabel = UILabel()
    private let mainContentLabel = UILabel()
    private let subContentLabel = UILabel()
    
    var isLaidOut: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isLaidOut = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        titleLabel.text = "Title"
        mainContentLabel.text = "Main Content"
        subContentLabel.text = "Sub Content"
        
        commonAttribute(at: self)
        commonAttribute(at: titleLabel)
        commonAttribute(at: mainContentLabel)
        commonAttribute(at: subContentLabel)
    }
    
    private func commonAttribute(at targetView: UIView) {
        targetView.translatesAutoresizingMaskIntoConstraints = false
        targetView.isSkeletonable = true
    }
    
    private func layout() {
        addSubview(titleLabel)
        addSubview(mainContentLabel)
        addSubview(subContentLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            makeLowPrioirtyTralingConstranit(targetView: titleLabel),
            
            mainContentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            mainContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            makeLowPrioirtyTralingConstranit(targetView: mainContentLabel),
            
            subContentLabel.topAnchor.constraint(equalTo: mainContentLabel.bottomAnchor, constant: 8),
            subContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            makeLowPrioirtyTralingConstranit(targetView: subContentLabel),
            subContentLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func makeLowPrioirtyTralingConstranit(targetView: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: targetView,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .trailing,
                                            multiplier: 1.0,
                                            constant: -16)
        constraint.priority = .defaultLow
        return constraint
    }
}

fileprivate class SkeletonCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        commonAttribute(at: self)
        commonAttribute(at: imageView)
        commonAttribute(at: titleLabel)
        commonAttribute(at: subTitleLabel)
        commonAttribute(at: contentLabel)
        
        titleLabel.text = "Title"
        subTitleLabel.text = "SubTitle"
        contentLabel.text = "Content"
    }
    
    private func commonAttribute(at targetView: UIView) {
        targetView.translatesAutoresizingMaskIntoConstraints = false
        targetView.isSkeletonable = true
    }
    
    private func layout() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            
            contentLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 4),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
