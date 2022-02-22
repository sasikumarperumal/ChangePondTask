//
//  HomeViewController.swift
//  ChangePondTask
//
//  Created by Sasikumar Perumal on 20/02/22.
//

import UIKit

class HomeViewController: UIViewController, UISearchControllerDelegate {
    
    let viewModel = HomeViewModel()
    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var commonFeeds = [Hits]()
    
    var loadingData = false
    
    var nextPageKey = 1
    
    var searchText = ""
    
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        homeTableView.tableFooterView = footerView
        
        // Reachability Check
        if !ConnectionCheck.isConnectedToNetwork(){
            
            activityIndicator.stopAnimating()
            
            // Fetch details for offline showing
            commonFeeds = CoreDataManagement.shared.fetchDataDetails() ?? [Hits]()
            
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
            debugPrint("Internet Down!")
        }
        
        // Search Bar setup
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        searchController.searchBar.placeholder = "Search artists"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        
        // api call
        apiCall(nextPage: nextPageKey)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Tableview Setup
        tableSetup()
    }
    
    func apiCall(nextPage:Int) {
        viewModel.getListApiCall(param: ["query":"technology","page":"\(nextPageKey)"])
    }
    
    func tableSetup() {
        viewModel.delegate = self
        homeTableView.estimatedRowHeight = 50
        homeTableView.rowHeight = UITableView.automaticDimension
        homeTableView?.register(UINib(nibName: "HomeListTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeListTableViewCellID")
        
    }
    
}

// MARK:- UITableViewDelegate, UITableViewDataSource

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return commonFeeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListTableViewCellID", for: indexPath) as? HomeListTableViewCell
        else { preconditionFailure("Failed to load collection view cell") }
        
        cell.viewModelCell = viewModel.homenData(indexpath: indexPath, DataValue: commonFeeds)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !((commonFeeds[indexPath.row].url ?? "").isEmpty) {
            let webVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController
            webVC?.url = commonFeeds[indexPath.row].url ?? ""
            self.navigationController?.pushViewController(webVC ?? UIViewController(), animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

// MARK:- Delegate For Updating the Views
extension HomeViewController : refreshViewsDelegate {
    
    func refreshViews(hitDetailsData: [Hits]) {
        
        activityIndicator.stopAnimating()
        
        commonFeeds = hitDetailsData
        
        DispatchQueue.main.async {
            self.homeTableView.reloadData()
        }
    }
}

// MARK:- UIScrollViewDelegate and load more function
extension HomeViewController {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == homeTableView {
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height - 1)
            {
                if ConnectionCheck.isConnectedToNetwork(){
                    activityIndicator.startAnimating()
                    loadMoreData()
                }
            }
        }
    }
    
    func loadMoreData() {
        if !self.loadingData  {
            
            if !viewModel.isDataAvailable {
                self.loadingData = true
            }
            self.nextPageKey = self.nextPageKey + 1
            
            viewModel.getListApiCall(param: ["query":searchText,"page":self.nextPageKey])
            
        }
    }
    
    
}

// MARK:- UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("Searching with: " + (searchController.searchBar.text ?? ""))
        searchText = (searchController.searchBar.text ?? "")
        
        if searchText.count > 5 {
            CoreDataManagement.shared.delete()
            viewModel.getListApiCall(param: ["query":searchText,"page":self.nextPageKey])
        }
    }
}
