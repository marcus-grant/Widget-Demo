//
//  TodayViewController.swift
//  Widget
//
//  Created by Marcus Grant on 10/4/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // Color Definitions
    // Red c0392b
    // Orange e67e22
    //
    let backgroundRed = UIColor.hexStringToUIColor(hex: "C0392b")
    let backgroundOrange = UIColor.hexStringToUIColor(hex: "#E67E22")
    let backgroundYellow = UIColor.hexStringToUIColor(hex: "F1C40F")
    let backgroundGreen = UIColor.hexStringToUIColor(hex: "2ECC71")
    let backgroundBlue = UIColor.hexStringToUIColor(hex: "3498DB")
    let backgroundPurple = UIColor.hexStringToUIColor(hex: "9B59B6")
    let backgroundClear = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    
//    var selectedColor
    
    
    @IBOutlet var widgetSuperView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        widgetSuperView.backgroundColor = backgroundRed
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
    

    
}


