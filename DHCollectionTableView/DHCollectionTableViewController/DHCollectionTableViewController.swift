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

    var sourceArray: NSArray!
    var contentOffsetDictionary: NSMutableDictionary!
    
    convenience init(source: NSMutableArray) {
        self.init()
        self.tableView.registerClass(DHCollectionTableViewCell.self, forCellReuseIdentifier: reuseTableViewCellIdentifier)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.sourceArray = NSArray(array: source)
        self.contentOffsetDictionary = NSMutableDictionary()
    }
}
// MARK: - Table view data source
extension DHCollectionTableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseTableViewCellIdentifier, forIndexPath: indexPath) as! DHCollectionTableViewCell
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let collectionCell: DHCollectionTableViewCell = cell as! DHCollectionTableViewCell
        collectionCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, index: indexPath.row)
        let index: NSInteger = collectionCell.collectionView.tag
        let value: AnyObject? = self.contentOffsetDictionary.valueForKey(index.description)
        let horizontalOffset: CGFloat = CGFloat(value != nil ? value!.floatValue : 0)
        collectionCell.collectionView.setContentOffset(CGPointMake(horizontalOffset, 0), animated: false)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}
// MARK: - Collection View Data source and Delegate
extension DHCollectionTableViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionViewArray: NSArray = self.sourceArray[collectionView.tag] as! NSArray
        return collectionViewArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseCollectionViewCellIdentifier, forIndexPath: indexPath) 
        
        let collectionViewArray = self.sourceArray[collectionView.tag] as! NSArray
        cell.backgroundColor = collectionViewArray[indexPath.item] as? UIColor
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let itemColor: UIColor = self.sourceArray[collectionView.tag][indexPath.item] as! UIColor
//        let vc = UIViewController()
//        vc.view.backgroundColor = itemColor
//        vc.title = "Line-->\(collectionView.tag)"
//        vc.navigationItem.prompt = "Item-->\(indexPath.item)"
//        self.navigationController?.pushViewController(vc, animated: true)
        if UIDevice.currentDevice().systemVersion >= "8.0" {
            let alert = UIAlertController(title: "第\(collectionView.tag)行", message: "第\(indexPath.item)个元素", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            let v: UIView = UIView(frame: CGRectMake(10, 20, 50, 50))
            v.backgroundColor = itemColor
            alert.view.addSubview(v)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if !scrollView.isKindOfClass(UICollectionView) {
            return
        }
        let horizontalOffset: CGFloat = scrollView.contentOffset.x
        let collectionView: UICollectionView = scrollView as! UICollectionView
        self.contentOffsetDictionary.setValue(horizontalOffset, forKey: collectionView.tag.description)
    }
}
