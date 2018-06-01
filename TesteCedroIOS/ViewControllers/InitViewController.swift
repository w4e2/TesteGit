//
//  InitViewController.swift
//  TesteIOSWilliam
//
//  Created by pc on 13/05/18.
//  Copyright © 2018 pc. All rights reserved.
//

import UIKit
import Lottie
class InitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let animationView = LOTAnimationView(name: "animation-w248-h187")
        animationView.loopAnimation = true
        animationView.center = self.view.center
        animationView.frame.size.height = 187
        animationView.frame.size.width = 248
        self.view.addSubview(animationView)
        animationView.play()
        self.getRepositoryList()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getRepositoryList() {
        GitWS.getRepositories(repositoryResult: nil) { (success, message, result) in
            if success == true {
                
                self.performSegue(withIdentifier: "ShowGitList", sender: result)
                
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowGitList" {
            let dest = segue.destination as! UINavigationController
            let list = dest.viewControllers[0] as! RepositoryListViewController
            list.repositoryResult = sender as! RepositoriesSearchResult
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
