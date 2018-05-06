//
//  CoinListViewController.swift
//  CryptoListoSwifto
//
//  Created by Mac on 5/6/18.
//  Copyright © 2018 searoth. All rights reserved.
//

import ReSwift

import RxCocoa
import RxSwift

import RxKeyboard

class CoinListViewController: UIViewController {
  var coins: [Coin] = []
  
  let disposeBag = DisposeBag()
  //MARK: TableView goes here
  
  @IBOutlet weak var coinsTableView: UITableView!
  {
    didSet{
      
      coinsTableView.backgroundView = UIView()
      coinsTableView.backgroundView?.backgroundColor = coinsTableView.backgroundColor
      
      coinsTableView.rx.itemSelected
        .map{self.coins[$0.row] }
        .map(MainStateAction.showCoinDetai)
        .bind(onNext: mainStore.dispatch)
        .disposed(by: disposeBag)
      
      coinsTableView.rx.willDisplayCell
        .filter{ $1.row == mainstore.state.coins.coun - 1}
        .map{ _ in fetchCoinsPage }
        .bind(onNext: mainStore.dispatch)
        .disposed(by: disposeBag)
    }
  }
  //MARK: searchBar goes here
  @IBOutlet weak var searchBar: UISearchBar!{
    didSet{
      searchbar.rx.textDidBeginEditing
        .filter{ self.searchBar.text?.isEmpty ?? false }
        .bind(onNext: {
          mainStore.dispatch(MainStateAction.readySearch)
          mainStore.dispatch(fetchCoinsPage)
        })
        .disposed(by: disposeBag)
      
      searchBar.rx.text.orEmpty
        .filter{ !$0.isEmpty }
          .bind(onNext: {
            mainStore.dispatch(MainStateAction.search($0))
            mainStore.dispatch(fetchCoinsPage)
          })
          .disposed(by: disposeBag)
      
      searchBar.rx.text.orEmpty
        .filter{ $0.isEmpty }
        .bind(onNext: { _ in
          mainStore.dispatch(MainStateAction.readySearch)
          mainStore.dispatch(fetchCoinsPage)
        })
        .disposed(by: disposeBag)
      
      searchBar.rx.cancelButtonClicked
        .bind(onNext: {
          mainStore.dispatch(MainStateAction.cancelSearch)
          mainStore.dispatch(fetchCoinsPage)
        })
        .disposed(by: disposeBag)
    }
  }
  
  //MARK: VIEW DID
  override func viewDidload(){
    super.viewDidLoad()
    
    RxKeyboard.instance.visibleHeight.drive(onNext: {height in self.additionalSafeAreaInsets.bottom = height}).disposed(by:disposeBag)
  }
  
  override func viewWillAppear(_ animated: Bool){
    super.viewWillAppear(animated)
    mainStore.subscribe(self, transform: {
      $0.select(CoinListViewState.init)
    })
  }
 
  override func viewWillDisappear(_ animated: Bool){
    super.viewWillDisappear(animated)
    mainStore.unsubscribe(self)
  }
  
  
}

//MARK List Store Subscriber
extension CoinListViewController: StoreSubscriber{
  typealias StoreSubscriberStateType = CoinListViewState
  
  func newState(state: CoinListViewState){
    coins = state.coins
    coinsTableView.reloadData()
    
    searchBar.text = state.searchBarText
    searchBar.showCancelButton = state.searchBarShowsCancel
    
    switch(searchBar.isFirstReponder, state.searchBarFirstResponder){
    case (true, false): searchBar.resignFirstResponder()
    case(false, true): searchBar.becomeFirstResponder()
    default: break
    }
  }
}

class CoinListTableViewCell: UITableViewCell{
  //MARK: need icon, title, subtitle IBOUTLETS
  
  @IBOutlet weak var coinName: UILabel!
  
  @IBOutlet weak var coinSymbol: UILabel!
  
  
  
  
  
  override func setSelected(_ selected: Bool, animated: Bool){
    super.setSelected(selected, animated: animated)
    accessoryType = selected ? .none : .disclosureIndicator
  }
  
  var coin: Coin? {
    didSet{
      guard let coin = coin else { return }
      
      icon.setPosterForCoin(coin)
      title.text = coin.name
      subtitle.text = coin.symbol ?? ""
    }
  }
}

extension CoinListViewController: UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int{
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return coins.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoinListTableViewCell") as? CoinListTableViewCell else {
      return UITableViewCell()
    }
    
    cell.coin = coins[indexPath.row]
    cell.accessoryType = .disclosureIndicator
    cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    cell.selectionStyle = .none
    
    return cell
  }
}

extension CoinListViewController: UISearchBarDelegate{
  
}
