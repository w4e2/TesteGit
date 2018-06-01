//
//  ColorManager.swift
//  TesteCedroIOS
//
//  Created by pc on 31/05/18.
//  Copyright © 2018 pc. All rights reserved.
//

import UIKit

class ColorManager: NSObject {
    class func getAuthorNameColor() -> UIColor {
        return UIColor(red: 70.0/255, green: 176.0/255, blue: 249.0/255, alpha: 1)
    }
    class func getRepositoryNameColor() -> UIColor {
        return UIColor(red: 172.0/255, green: 62.0/255, blue: 136.0/255, alpha: 1)
    }
    class func getRepositoryDescritionColor() -> UIColor {
        return UIColor.white

    }
}
