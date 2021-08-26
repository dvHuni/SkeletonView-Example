//
//  StoryBoardViewController.swift
//  SkeletonViewExample
//
//  Created by AhnSangHoon on 2021/08/21.
//

import UIKit
import SkeletonView

class StoryBoardViewController: UIViewController {
    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var skeletonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        labelContainer.showSkeleton()
        skeletonCollectionView.showAnimatedGradientSkeleton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view.hideSkeleton()
        }
    }
}

extension StoryBoardViewController: UICollectionViewDelegate { }

extension StoryBoardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "SkeletonCollectionViewCell", for: indexPath)
    }
}

extension StoryBoardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 180)
    }
}

extension StoryBoardViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "SkeletonCollectionViewCell"
    }
}
