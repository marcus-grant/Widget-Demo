//
//  ViewController.swift
//  Widget-Demo
//
//  Created by Marcus Grant on 10/4/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let redColor = UIColor.hexStringToUIColor(hex: "C0392b")
    let orangeColor = UIColor.hexStringToUIColor(hex: "#E67E22")
    let yellowColor = UIColor.hexStringToUIColor(hex: "F1C40F")
    let greenColor = UIColor.hexStringToUIColor(hex: "2ECC71")
    let blueColor = UIColor.hexStringToUIColor(hex: "3498DB")
    let purpleColor = UIColor.hexStringToUIColor(hex: "9B59B6")
    let clearColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    
    var selectedColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// Extension of UIColor to help define colors based off hex values
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex hexInt: Int) {
        self.init(red:(hexInt >> 16) & 0xff, green:(hexInt >> 8) & 0xff, blue:hexInt & 0xff)
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if (cString.hasPrefix("#")) {
            let index: String.Index = cString.index(cString.startIndex, offsetBy: 1)
            return hexStringToUIColor(hex: cString.substring(from: index))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

