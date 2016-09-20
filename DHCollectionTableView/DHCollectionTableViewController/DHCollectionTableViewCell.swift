//
//  DHCollectionTableViewCell.swift
//  DHCollectionTableView
//
//  Created by 胡大函 on 14/11/3.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

import UIKit

class DHIndexedCollectionView: UICollectionView {
  
  var indexPath: IndexPath!
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

let collectionViewCellIdentifier: NSString = "CollectionViewCell"

class DHCollectionTableViewCell: UITableViewCell {
  
  var collectionView: DHIndexedCollectionView!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5)
    layout.minimumLineSpacing = 5
    layout.itemSize = CGSize(width: 91, height: 91)
    layout.scrollDirection = .horizontal

    collectionView = DHIndexedCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellIdentifier as String)
    collectionView.backgroundColor = .lightGray
    collectionView.showsHorizontalScrollIndicator = false
    
    contentView.addSubview(self.collectionView)
    layoutMargins = UIEdgeInsetsMake(10, 0, 10, 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let frame = self.contentView.bounds
    collectionView.frame = CGRect(x: 0, y: 0.5, width: frame.size.width, height: frame.size.height - 1)
  }
  
  func setCollectionViewDataSourceDelegate(dataSourceDelegate delegate: UICollectionViewDelegate & UICollectionViewDataSource, index: NSInteger) {
    collectionView.dataSource = delegate
    collectionView.delegate = delegate
    collectionView.tag = index
    collectionView.reloadData()
  }
  
  func setCollectionViewDataSourceDelegate(dataSourceDelegate delegate: UICollectionViewDelegate & UICollectionViewDataSource, indexPath: IndexPath) {
    collectionView.dataSource = delegate
    collectionView.delegate = delegate
    collectionView.indexPath = indexPath
    collectionView.tag = indexPath.section
    collectionView.reloadData()
  }
}
