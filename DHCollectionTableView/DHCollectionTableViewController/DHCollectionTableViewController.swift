//
//  DHCollectionTableViewController.swift
//  DHCollectionTableView
//
//  Created by 胡大函 on 14/11/3.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

import UIKit

let reuseTableViewCellIdentifier = "TableViewCell"
let reuseCollectionViewCellIdentifier = "CollectionViewCell"

class DHCollectionTableViewController: UITableViewController {
  
  var sourceArray: Array<AnyObject>!
  var contentOffsetDictionary: Dictionary<AnyHashable,AnyObject>!
  
  convenience init(source: Array<AnyObject>) {
    self.init()
    tableView.register(DHCollectionTableViewCell.self, forCellReuseIdentifier: reuseTableViewCellIdentifier)
		tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    sourceArray = source
    contentOffsetDictionary = Dictionary<NSObject,AnyObject>()
  }
  
}
// MARK: - Table view data source
extension DHCollectionTableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sourceArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseTableViewCellIdentifier, for: indexPath) as! DHCollectionTableViewCell
    return cell
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let collectionCell = cell as! DHCollectionTableViewCell
    collectionCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, index: (indexPath as NSIndexPath).row)
    
    let index = collectionCell.collectionView.tag
    let value = contentOffsetDictionary[index]
    let horizontalOffset = CGFloat(value != nil ? value!.floatValue : 0)
    collectionCell.collectionView.setContentOffset(CGPoint(x: horizontalOffset, y: 0), animated: false)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
// MARK: - Collection View Data source and Delegate
extension DHCollectionTableViewController:UICollectionViewDataSource,UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let collectionViewArray = sourceArray[collectionView.tag] as! Array<AnyObject>
    return collectionViewArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCollectionViewCellIdentifier, for: indexPath)
    
    let collectionViewArray = sourceArray[collectionView.tag] as! Array<AnyObject>
    cell.backgroundColor = collectionViewArray[(indexPath as NSIndexPath).item] as? UIColor
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let itemColor: UIColor = (sourceArray[collectionView.tag] as! Array<AnyObject>)[(indexPath as NSIndexPath).item] as! UIColor

		let alert = UIAlertController(title: "第\(collectionView.tag)行", message: "第\((indexPath as NSIndexPath).item)个元素", preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
    let v: UIView = UIView(frame: CGRect(x: 10, y: 20, width: 50, height: 50))
    v.backgroundColor = itemColor
    alert.view.addSubview(v)
    present(alert, animated: true, completion: nil)
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if !(scrollView is UICollectionView) {
      return
    }
    let horizontalOffset = scrollView.contentOffset.x
    let collectionView = scrollView as! UICollectionView
    contentOffsetDictionary[collectionView.tag] = horizontalOffset as AnyObject
  }
}
