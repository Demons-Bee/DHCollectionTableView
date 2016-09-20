//
//  AppDelegate.swift
//  DHCollectionTableView
//
//  Created by 胡大函 on 14/11/3.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    
    let numberOfTableViewRows: NSInteger = 20
    let numberOfCollectionViewCells: NSInteger = 30
    
    var source = Array<AnyObject>()
    for _ in 0..<numberOfTableViewRows {
      var colorArray = Array<UIColor>()
      for _ in 0..<numberOfCollectionViewCells {
        let color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
        colorArray.append(color)
      }
      source.append(colorArray as AnyObject)
    }

    // the source format is Array<Array<AnyObject>>
    let viewController = DHCollectionTableViewController(source: source)
    viewController.title = "TableView嵌套CollectionView"
    window?.rootViewController = UINavigationController(rootViewController: viewController)
    window?.makeKeyAndVisible()
    return true
  }
  
}

