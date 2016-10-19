//
//  TodayViewController.swift
//  Widget
//
//  Created by Marcus Grant on 10/4/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import UIKit
import NotificationCenter
import QRCode

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // Color Definitions
    // Red c0392b
    // Orange e67e22
    //
    
    let defaults = UserDefaults(suiteName: "group.method.WidgetDemo")
    
    
    @IBOutlet var widgetSuperView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var upperContentView: UIView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var qr: QRCode?
    
    var selectedColor: UIColor?
    var selectedCIColor: CIColor? {
        get {
            if let selectedColor = selectedColor {
                return selectedColor.ciColor
            } else {
                return nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  VERY IMPORTANT IN iOS 10 to expand widget height
        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        if let image = imageView.image {
            print("Dimensions of image view's image (w x h): \(image.size.width) x \(image.size.height)")
        } else {
            print("Image view has no image!")
        }
        
        guard let validatedQR = QRCode(URL(string: "www.method.com")!) else {
            fatalError("Could not generate QR Code!")
        }
        qr = validatedQR
        imageViewWidthConstraint.constant = 0
        imageViewHeightConstraint.constant = validatedQR.size.height
        
        selectedColor = getColorFromDefaults()
        
        //updateSubViewColor()
        
        
        
    }
    
    func updateQR() {
        if let qrString = defaults?.string(forKey: "qrString") {
            if let url = URL(string: qrString) {
                if var qr = QRCode(url) {
                    //Error Correction Level
                    //Size
                    //Color
                    self.qr = qr
                }
            }
        }
        print("Warning: No UserDefault for \"qrString\" found, loading default QR-Code")
        qr = defaultQRCode()
    }
    
    func defaultQRCode() -> QRCode {
        let url = URL(string: "www.method.com")
        var qr = QRCode(url!)
        qr!.errorCorrection = QRCode.ErrorCorrection.High
        //size?
        //color?
        return qr!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(_ completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
    
    @IBAction func qrButtonTapped(_ sender: AnyObject) {
        if imageViewWidthConstraint.constant > 0 {
            hideImageView()
        } else {
            updateQR()
            guard let qrImage = qr?.image else {
                print("Warning: Couldn't load QR Image, using default")
                qr = defaultQRCode()
                imageView.image = qr!.image
                return
            }
            imageView.image = qrImage
            showImageView()
        }
    }
    
    func updateSubViewsColor() {
        self.view.backgroundColor = selectedColor
        upperContentView.backgroundColor = selectedColor
        buttonContainerView.backgroundColor = selectedColor
    }
    
    func hideImageView() {
        imageViewWidthConstraint.constant = 0
    }
    
    func showImageView() {
        guard let image = imageView.image else {
            fatalError("ERROR: Tried to display widget imageView with no image!")
        }
        let width   = image.size.width
        let height  = image.size.height
        imageViewWidthConstraint.constant   = width
        imageViewHeightConstraint.constant  = height
    }
    
    // Helper method to return the UIColor recorded into the UserDefaults, if error occurs, return clear color
    func getColorFromDefaults() -> UIColor {
        guard let defaults = defaults
            else {
                print("Couldn't Get App Group Defaults")
                return UIColor.clear
        }
        guard let red = defaults.object(forKey: "SelectedRedValue") as? Float
            else {
                print("Couldn't fetch from NSUserDefaults with given key")
                return UIColor.clear
        }
        guard let green = defaults.object(forKey: "SelectedGreenValue") as? Float
            else {
                print("Couldn't fetch from NSUserDefaults with given key")
                return UIColor.clear
        }
        guard let blue = defaults.object(forKey: "SelectedBlueValue") as? Float
            else {
                print("Couldn't fetch from NSUserDefaults with given key")
                return UIColor.clear
        }
        guard let alpha = defaults.object(forKey: "SelectedAlphaValue") as? Float
            else {
                print("Couldn't fetch from NSUserDefaults with given key")
                return UIColor.clear
        }
        return UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
    }
    
    

    

    
}

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: Float, green: Float, blue: Float, alpha: Float) {
        let color = coreImageColor
        return (Float(color.red), Float(color.green), Float(color.blue), Float(color.alpha))
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
}

extension CIColor {
    var uiColor: UIColor {
        return UIColor(ciColor: self)
    }
}

