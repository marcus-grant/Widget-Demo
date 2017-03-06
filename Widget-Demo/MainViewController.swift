//
//  MainViewController.swift
//  Widget-Demo
//
//  Created by Marcus Grant on 12/14/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

// TODO: Make an alert dialog with default values instead of fatalErrors()

import UIKit

class MainViewController: UIViewController {

    //@IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var mockImage: UIImageView!
    @IBOutlet weak var mockButton: UIButton!


    var defaults: UserDefaults
    var currentContext: String

    required init?(coder aDecoder: NSCoder) {
        guard let defaults = UserDefaults(suiteName: "group.method.WidgetDemo")
            else {
                print("No defaults found using suiteName: \"group.method.WidgetDemo\"")
                fatalError("Couldn't load defaults")
        }; //return defaults
        self.defaults = defaults
        self.currentContext = MockContext.Order.rawValue
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        updateContext()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeContext(segue: UIStoryboardSegue) {
        updateContext()
        print("Changed Context to \(currentContext) at end of unwind")
    }

    func updateContext() {
        currentContext = getContextString(fromDefaults: defaults)
        //contextLabel.text = getContextString(fromDefaults: defaults)
        var newMockImage: UIImage
        print ("Updating context to \(currentContext)")
        switch currentContext {
        case MockContext.Order.rawValue:
            print("order case")
            newMockImage = #imageLiteral(resourceName: "OrderScreen")
            mockButton.isHidden = false
            break
        case MockContext.CheckIn.rawValue:
            print ("checkin case")
            newMockImage = #imageLiteral(resourceName: "CheckinScreen")
            mockButton.isHidden = true
            break
        case MockContext.Map.rawValue:
            print("map case")
            newMockImage = #imageLiteral(resourceName: "MapScreen")
            mockButton.isHidden = true
            break
        case MockContext.Compass.rawValue:
            print("compass case")
            newMockImage = #imageLiteral(resourceName: "MapScreen")
            mockButton.isHidden = true
            break
        default:
            fatalError("An incorrect context was requested of the MockObject instance, using context of raw value, \(currentContext)") //TODO: change default and add dialog

        }
        mockImage.image = newMockImage

    }

    func getContextString(fromDefaults defaults: UserDefaults) -> String {
        let contextKey = "context"
        guard let contextObject = defaults.object(forKey: contextKey)
            else {
                var readContextErrorMSG = "Couln't get stored context for MockContext"
                readContextErrorMSG += " instance with key \(contextKey)"
                print(readContextErrorMSG)
                return MockContext.Order.rawValue
        }; guard let contextString = contextObject as? String
            else {
                let readContextNotString = "Stored context value not a string"
                fatalError(readContextNotString)
        }; guard let validatedContext = MockContext(rawValue: contextString)
            else {
                //TODO: Dialog here to point out the false enum match
                return MockContext.Order.rawValue
        }; return validatedContext.rawValue
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
