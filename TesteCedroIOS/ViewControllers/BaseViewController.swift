//
//  BaseViewController.swift
//  TesteCedroIOS
//
//  Created by pc on 31/05/18.
//  Copyright © 2018 pc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var refreshControl: UIRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
        self.navigationItem.titleView = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func refreshPulledReloadData () {
        
    }
    func addRefreshControlTo(scrollView: UIScrollView) {
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(BaseViewController.refreshPulledReloadData), for: UIControlEvents.valueChanged)

        scrollView.addSubview(refreshControl)
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
