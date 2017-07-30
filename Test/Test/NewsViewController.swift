//
//  NewsViewController.swift
//  Test
//
//  Created by prafulla on 30/07/17.
//  Copyright © 2017 HelloDoc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsViewController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    var baseModel : BaseModel?
    var lastSearchedText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Question1"
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = []
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableFooterView = UIView()

        
        getNews("")
        
        self.tableView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: "NewsViewCell")
        
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(pulltorefresh), for: .valueChanged)
            tableView.refreshControl = refreshControl
        }
    }

    func pulltorefresh(refreshControl: UIRefreshControl){
        //
        getNews(lastSearchedText, isPulltoRefresh: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = baseModel?.hits?[indexPath.row].url {
            let wv = WebViewController()
            wv.url = url
            self.navigationController?.pushViewController(wv, animated: true)
        }else{
            let alertController = UIAlertController(title: "Error!", message: Constants.errorMessage, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (baseModel?.hits?.count ?? 0)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell") as! NewsViewCell

        // Configure the cell...
        
        let detail = baseModel?.hits?[indexPath.row]
        //
        newCell.newsTitle.text = (detail?.title ?? "")
        
        
        //
        newCell.newsAuther.text = "Written By: " + (detail?.author ?? "Unknown")
        
        //
        newCell.newsTime.text = "Created at: " + (detail?.createdAt ?? "")
        //
        var tags = ""
        for str in (detail?.tags ?? []) {
            tags = tags + "#" + str + " "
        }
        newCell.newsTags.text = tags

        return newCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let detail = baseModel?.hits?[indexPath.row]
        //
        let titleHeight = requiredHeight(labelText: (detail?.title ?? ""), font: UIFont.boldSystemFont(ofSize: 15), additionalOffset: 70)
        //
        let autherHeight = requiredHeight(labelText: "Written By: " + (detail?.author ?? "Unknown"))
        //
        let createdTime = requiredHeight(labelText: "Created at: " + (detail?.createdAt ?? ""))
        //
        var tags = ""
        for str in (detail?.tags ?? []) {
            tags = tags + "#" + str + " "
        }
        
        let tagheight = requiredHeight(labelText: tags, font: UIFont.systemFont(ofSize: 15), additionalOffset: 70)
        return (titleHeight + autherHeight + createdTime + tagheight + 70)
        
    }
    
    // height for text
    func requiredHeight(labelText:String, font : UIFont = .systemFont(ofSize: 15), additionalOffset : CGFloat = 70) -> CGFloat {
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width  - additionalOffset, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = labelText
        label.sizeToFit()
        return label.frame.height
        
    }
    
    

    
   
    
    // network call
    func getNews(_ searchStr : String,isPulltoRefresh : Bool = false){
        
        if !isPulltoRefresh {
            showHood()
        }
        
        var parm : Dictionary<String,String> = [:]
        if searchStr.characters.count != 0 {
            parm["query"] = searchStr
        }
        
        let req = Alamofire.request(Constants.baseUrl, method: .get, parameters: parm, encoding: URLEncoding.default, headers: nil)
        print(req.debugDescription)
        
        req.responseJSON { (response) in
            
            if isPulltoRefresh {
                self.refreshControl?.endRefreshing()
            }else{
                self.hideHood()
            }
            
            if let data = response.data {
                let json:JSON = JSON(data: data)
                self.baseModel = BaseModel.init(json: json)
                self.tableView.reloadData()
            }else{
                // error while fetching data
            }
       }
    }
    
}


extension NewsViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.lastSearchedText = searchBar.text ?? ""
        getNews(lastSearchedText)
    }
}

extension NewsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        //move code from searchBarSearchButtonClicked to here if want to search for every character change
    }
 
    
}


extension UIViewController {
    /// progress hoods
    func showHood(footerMessage : String = "Searching..."){
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            LoadingHood.shared.showInWindow(window: window, withHeader: "Please Wait!", andFooter: footerMessage)
        }
    }
    
    func hideHood(){
        LoadingHood.shared.hide()
    }
}
