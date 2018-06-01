//
//  PullRequestListViewController.swift
//  TesteCedroIOS
//
//  Created by pc on 31/05/18.
//  Copyright © 2018 pc. All rights reserved.
//

import UIKit
import SkeletonView

class PullRequestListViewController: BaseViewController {
    var selectedItem: Items?
    var arrayPullRequest: [PullRequest] = []
    @IBOutlet weak var pullRequestTableView: UITableView!
    @IBOutlet weak var placeHolderTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = selectedItem?.name
        self.addRefreshControlTo(scrollView: pullRequestTableView)


    }
    override func refreshPulledReloadData() {
        self.getPullRequests()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pullRequestTableView.rowHeight = UITableViewAutomaticDimension
        pullRequestTableView.estimatedRowHeight = 150
        placeHolderTableView.rowHeight = UITableViewAutomaticDimension
        placeHolderTableView.estimatedRowHeight = 150
        
        self.showSkeleton()
        self.getPullRequests()
        // Do any additional setup after loading the view.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getPullRequests() {
        guard selectedItem != nil else {
            return
        }
        GitWS.getPullRequestList(item: selectedItem!) { (success, message, result) in

            if success == true {
                self.arrayPullRequest = result!
                self.pullRequestTableView.reloadData()
            }
            self.hidSkeletonView()
            self.refreshControl.endRefreshing()

        }
    }
    func hidSkeletonView() {
        self.placeHolderTableView.isHidden = true

        self.placeHolderTableView.hideSkeleton()
    }
    func showSkeleton() {
        self.placeHolderTableView.isHidden = false

        let gradient = SkeletonGradient(baseColor: UIColor(white: 0.2, alpha: 1))
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        self.placeHolderTableView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
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
extension PullRequestListViewController: UITableViewDelegate,UITableViewDataSource,SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPullRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "PullRequestTableViewCell") as! PullRequestTableViewCell
        let request = arrayPullRequest[indexPath.row]
        cel.customizeForItem(request)
        return cel
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let request = arrayPullRequest[indexPath.row]

        guard let urlString = request.htmlUrl else {
            return
        }
        guard let url = URL(string : urlString) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: { (status) in
            
        })
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdenfierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "PullRequestTableViewCell"
    }

}
