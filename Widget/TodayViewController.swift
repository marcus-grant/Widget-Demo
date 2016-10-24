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
import CoreLocation

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // MARK: - Display Parameters
    enum defaultParameters {
        static let qrSideLength: CGFloat = 95.0
        static let buttonBarHeight: CGFloat = 32.0
        static let qrErrorCorrection = QRCode.ErrorCorrection.High
        static let whiteColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        static let primaryColor = UIColor.darkGray
    }
    
    
    
    
    let defaults = UserDefaults(suiteName: "group.method.WidgetDemo")
    
    
    @IBOutlet var widgetSuperView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var upperContentView: UIView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var qr: QRCode?
    
    var currentDistance: Double = 0.0
    var timer: Timer!
    var movingTowardsTarget = true
    var arrived = false
    
    var selectedColor = defaultParameters.primaryColor
    var selectedCIColor: CIColor { get { return selectedColor.coreImageColor } }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        qr = defaultQRCode()
        currentDistance = 14.3
        timer = Timer()
        movingTowardsTarget = true
        arrived = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //  VERY IMPORTANT IN iOS 10 to expand widget height
        //self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        imageViewWidthConstraint.constant = 0

        selectedColor = getColorFromDefaults()

        currentDistance = 14.3
        updateQR()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                updateSubViewsColor()
        //updateQR()
        guard qr != nil else {
            fatalError("Could not generate QR Code")
        }
        let qrHeight = qr!.size.height
        imageViewHeightConstraint.constant = qrHeight
        let totalHeight = qrHeight
        imageViewHeightConstraint.constant = qrHeight
        self.preferredContentSize.height = totalHeight
        view.layoutSubviews()
        
        timer = Timer.scheduledTimer(timeInterval: 0.3,
                                     target: self,
                                     selector: #selector(timedUpdate),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func resetWalkingTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(timedUpdate), userInfo: nil, repeats: true)
    }
    
    func timedUpdate() {
        if movingTowardsTarget {
            if currentDistance > 5 {
                currentDistance -= 0.28427
                updateLabel()
            } else {
                arrived = true
                updateLabel()
                showImageView()
                movingTowardsTarget = false
                timer.invalidate()
                timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(resetWalkingTimer), userInfo: nil, repeats: false)
            }
        } else {
            if currentDistance < 42 {
                if arrived {
                    hideImageView()
                    arrived = false
                }
                currentDistance += 0.4893
                updateLabel()
            } else {
                movingTowardsTarget = true
                timer.invalidate()
                timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(resetWalkingTimer), userInfo: nil, repeats: false)
            }
        }
    }
    
    func updateLabel() {
        if currentDistance > 5 {
            labelView.text = String(format: "Distance to: %.1f", currentDistance)
        } else {
            labelView.text = "Use the QR Code!"
        }
    }
    func updateWidgetHeight() {
        
        if qr == nil {
            
        }
    }
    
    func updateQR() {
        if let qrString = defaults?.string(forKey: "qrString") {
            if let url = URL(string: qrString) {
                if let qr = QRCode(url) {
                    self.qr = qr
                }
            }
        } else { // No user defaults detected, so generate a default QR
            print("Warning: No UserDefault for \"qrString\" found, loading default QR-Code")
            self.qr = defaultQRCode()
        }
        qr!.size.width = defaultParameters.qrSideLength
        qr!.size.height = defaultParameters.qrSideLength
        imageView.image = qr!.image
        imageViewHeightConstraint.constant = qr!.size.height
    }
    
    func defaultQRCode() -> QRCode {
        guard let url      = URL(string: "www.method.com") else { fatalError("Couldn't format string") }
        guard var qr       = QRCode(url) else { fatalError("Error: Could not generate default QR!") }
        qr.errorCorrection = defaultParameters.qrErrorCorrection
        qr.size = CGSize(width: defaultParameters.qrSideLength, height: defaultParameters.qrSideLength)
        qr.color = selectedCIColor
        return qr
        
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
    
    
//    @IBAction func qrButtonTapped(_ sender: AnyObject) {
//        if imageViewWidthConstraint.constant > 0 { hideImageView() }
//        else { showImageView() }
//    }
    
    @IBAction func openAppTapped(_ sender: AnyObject) {
        let hostURL = URL(string: "WidgetDemo:") //
        if let appurl = hostURL {
            self.extensionContext!.open(appurl, completionHandler: nil)
        }
    }
    
    func updateSubViewsColor() {
        self.view.backgroundColor = selectedColor
        upperContentView.backgroundColor = selectedColor
    }
    
    func hideImageView() {
        imageViewWidthConstraint.constant = 0
    }
    
    func showImageView() {
        guard let qr = qr else {
            fatalError("Error: No QR Generated!")
        }
        guard let image = qr.image else {
            fatalError("ERROR: Tried to display widget imageView with no image!")
        }
        imageView.image = image
        imageViewWidthConstraint.constant = image.size.width
        imageViewHeightConstraint.constant = image.size.height

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

