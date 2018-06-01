//
//  RepositoryListViewController.swift
//  TesteCedroIOS
//
//  Created by pc on 31/05/18.
//  Copyright © 2018 pc. All rights reserved.
//

import UIKit

class RepositoryListViewController: BaseViewController {
    @IBOutlet weak var repositoryTableView: UITableView!
    var repositoryResult: RepositoriesSearchResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        repositoryTableView.rowHeight = UITableViewAutomaticDimension
        repositoryTableView.estimatedRowHeight = 150
        self.addRefreshControlTo(scrollView: repositoryTableView)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Swift"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func refreshPulledReloadData() {
        self.getRepositoryList()
    }
    func getRepositoryList() {
        GitWS.getRepositories(repositoryResult: nil) { (success, message, result) in
            if success == true {
                self.repositoryResult = result
                self.repositoryTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    func nextPage() {
        GitWS.getRepositories(repositoryResult: self.repositoryResult) { (success, message, result) in
            if success == true {
                self.repositoryResult?.merge(result: result!)
                self.repositoryTableView.reloadData()
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension RepositoryListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = repositoryResult?.items?.count else {
            return 0
        }
        return  count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "RepositoriesTableViewCell") as! RepositoriesTableViewCell
        let item = repositoryResult!.items![indexPath.row]
        cel.customizeForItem(item)
        return cel
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = repositoryResult!.items![indexPath.row]
        
        self.performSegue(withIdentifier: "ShowPullRequestList", sender: item)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let item = repositoryResult?.items else {
            return
        }
        if indexPath.row == (item.count - 1) {
            self.nextPage()
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPullRequestList" {
            let pull = segue.destination as! PullRequestListViewController
            pull.selectedItem = sender as! Items
        }
    }
    
}
