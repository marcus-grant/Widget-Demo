//
//  ViewController.swift
//  Widget-Demo
//
//  Created by Marcus Grant on 10/4/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import UIKit
import NotificationCenter


class ViewController: UIViewController {

    let redColor = UIColor(red: 192, green: 57, blue: 43)
    let orangeColor = UIColor.hexStringToUIColor("#E67E22")
    let yellowColor = UIColor.hexStringToUIColor("F1C40F")
    let greenColor = UIColor.hexStringToUIColor("2ECC71")
    let blueColor = UIColor.hexStringToUIColor("3498DB")
    let purpleColor = UIColor.hexStringToUIColor("9B59B6")
    let clearColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    
    var selectedColor: UIColor? /*{
        get {
            if self.selectedColor == nil { return clearColor }
            else { return self.selectedColor }
        } set {
            self.selectedColor = newValue
        }
    }*/
    
    var defaults: UserDefaults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set either default background color or the previously selected one
        if let selectedColor = selectedColor {} else {
            selectedColor = clearColor
        }
        
        // get user defaults
        defaults = UserDefaults(suiteName: "group.method.WidgetDemo")
        
        // make sure defaults were retrieved properly
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped(_ sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        
        var printString = "Pressed "
        switch button.tag {
        case 1:
            selectedColor = redColor
            printString += "red "
            break
        case 2:
            selectedColor = orangeColor
            printString += "orange "
            break
        case 3:
            selectedColor = yellowColor
            printString += "yellow "
            break
        case 4:
            selectedColor = greenColor
            printString += "green "
            break
        case 5:
            selectedColor = blueColor
            printString += "blue "
            break
        case 6:
            selectedColor = purpleColor
            printString += "purple "
            break
        default:
            print("Unknown Button Pushed!")
            return
        }
        printString += "button pushed!"
        print(printString)
        writeToDefaults(selectedColor!)
    }

    func writeToDefaults(_ color: UIColor) {
        let backgroundColorValues = selectedColor!.components
        defaults?.set(backgroundColorValues.red, forKey: "SelectedRedValue")
        defaults?.set(backgroundColorValues.green, forKey: "SelectedGreenValue")
        defaults?.set(backgroundColorValues.blue, forKey: "SelectedBlueValue")
        defaults?.set(backgroundColorValues.alpha, forKey: "SelectedAlphaValue")
        defaults?.synchronize()
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
    
    static func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (cString.hasPrefix("#")) {
            let index: String.Index = cString.index(cString.startIndex, offsetBy: 1)
            return hexStringToUIColor(cString.substring(from: index))
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
    
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    
    var components: (red: Float, green: Float, blue: Float, alpha: Float) {
        let color = coreImageColor
        return (Float(color.red), Float(color.green), Float(color.blue), Float(color.alpha))
    }
}

