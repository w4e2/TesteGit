//
//  GitWS.swift
//  TesteCedroIOS
//
//  Created by pc on 31/05/18.
//  Copyright © 2018 pc. All rights reserved.
//

import UIKit
import SwiftyJSON
class GitWS: NSObject {
    class func getRepositories(repositoryResult: RepositoriesSearchResult?, responseBlock:@escaping (_ success: Bool?, _ message: String?,_ gameList: RepositoriesSearchResult?) -> Void) {
        let page = repositoryResult == nil ? 1 : (repositoryResult?.page)! + 1
        let url = "\(ApiUrl.gitRootURL)\(ApiUrl.searchRepositories)\(ApiUrl.pagingURL)\(page)"
        BaseRequest.requestWithMethod(method: "GET", url: url, parameters: nil, headers: nil, withErrorDisclaimer: true) { (success, message, result) in
            if success == true {
                guard let dict = result as? [String:Any] else {
                    responseBlock(false,nil,nil)
                    return
                }
                
                let temp = RepositoriesSearchResult(json: JSON(dict))
                responseBlock(true,nil,temp)
            } else {
                responseBlock(false,nil,nil)
                
            }
        }
    }
    class func getPullRequestList(item: Items, responseBlock:@escaping (_ success: Bool?, _ message: String?,_ result: [PullRequest]?) -> Void) {
        let url = "\(ApiUrl.gitRootURL)\(String(format: ApiUrl.searchPullRequestList, item.fullName!))"
        BaseRequest.requestWithMethod(method: "GET", url: url, parameters: nil, headers: nil, withErrorDisclaimer: true) { (success, message, result) in
            if success == true {
                guard let array = result as? [[String:Any]] else {
                    responseBlock(false,nil,nil)
                    return
                }
                var arrayResult:[PullRequest] = []
                for dict in array {
                    arrayResult.append(PullRequest(json: JSON(dict)))
                }
                responseBlock(true,nil,arrayResult)
            } else {
                responseBlock(false,nil,nil)
                
            }
        }
    }
}
