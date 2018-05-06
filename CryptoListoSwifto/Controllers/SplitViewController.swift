//
//  SplitViewController.swift
//  CryptoListoSwifto
//
//  Created by Mac on 5/6/18.
//  Copyright © 2018 searoth. All rights reserved.
//

import UIKit

import ReSwift

class SplitViewController: UISplitViewController{
  var coinListViewController: CoinListViewController? {
    let navigationController = viewControllers.first as? UINavigationController
    return navigationController?.topViewController as? CoinListViewController
  }
  
  var coinDetailViewController: CoinDetailViewController? {
    let nagivationController = viewControllers.last as? UINavigationController
    return nagivationController?.topViewController as? CoinDetailViewController
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle{
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    preferredDisplayMode = .allVisible
    delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    mainStore.subscribe(self)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    mainStore.unsubscribe(self)
  }
  
}

// MARK: Store Subs
extension SplitViewController: StoreSubscriber{
  typealias StoreSubscriberStateType = MainState
  
  func newState(state: MainState){
    if case .show = state.coinDetail, coinDetailViewController == nil {
      coinListViewController?.performSegue(withIdentifier: "showDetail", sender: self)
    }
  }
}

//MARK: UISplitViewControllerDelegate
extension SplitViewController: UISplitViewControllerDelegate{
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary
    secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    return true
  }
}






