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
    
    let defaults = UserDefaults(suiteName: "group.method.WidgetDemo")
    
    
    @IBOutlet var widgetSuperView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = getColorFromDefaults()
        
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


