//
//  CoinDetailViewController.swift
//  CryptoListoSwifto
//
//  Created by Mac on 5/6/18.
//  Copyright © 2018 searoth. All rights reserved.
//

import UIKit

import ReSwift
import RxCocoa
import RxSwift

class CoinDetailViewController: UITableViewController{
  //MARK: IBOUTLET title, subtitle, overview
  
  @IBOutlet weak var coinDetailName: UILabel!
  @IBOutlet weak var coinDetailSymbol: UILabel!
  @IBOutlet weak var coinDetailRank: UILabel!
  
  private let postViewHeight: CGFloat = 300
  private var posterView: UIView!
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPosterView()
    updatePosterView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    mainStore.subscribe(self, transform: {
      mainStore.subscribe(self, transform: {
        $0.select(CoinDetailViewState.init)
      })
    })
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    mainStore.unsubscribe(self)
    
    if case let .show(coin) = mainStore.state.coinDetail{
      mainStore.dispatch(MainStateAction.willHideCoinDetail(coin))
    }
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    mainStore.dispatch(MainStateAction.hideCoinDetail)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    updatePosterView()
  }
  
  
  
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let defaultHeight = super.tableView(tableView, heightForRowAt: indexPath)
    
    if indexPath.section == 1 && indexPath.row == 2 {
      return overviewLabel.sizeThatFits(
        CGSize(
          width: overviewLabel.frame.size.width,
          height: .greatestFiniteMagnitude
        )
        ).height + defaultHeight
    }
    
    return defaultHeight
  }
  
  
  func setupPosterView(){
    posterView = tableView.tableHeaderView
    tableView.tableHeaderView = nil
    tableView.addSubView(posterView)
    tableView.contentInset = UIEdgeInsets(top: posterViewHeight, left: 0, bottom: 0, right: 0)
    tableView.contentOffset = CGPoint(x: 0, y: -posterViewheight)
  }
  
  
  
  func updatePosterView() {
    var posterRect = CGRect(
      x: 0, y: -posterViewHeight,
      width: tableView.bounds.width, height: posterViewHeight
    )
    
    if tableView.contentOffset.y < -posterViewHeight {
      posterRect.origin.y = tableView.contentOffset.y
      posterRect.size.height = -tableView.contentOffset.y
    }
    
    posterView.frame = posterRect
  }
  
}


//MARK: StoreSubscriber

extension CoinDetailViewController: StoreSubscriber{
  typealias StoreSubscriberStateType = CoinDetailViewState
  
  func newState(state: CoinDetailViewState){
    tableView.beginUpdates()
    title = state.name
    titleLabel.text = state.symbol
  }
}
