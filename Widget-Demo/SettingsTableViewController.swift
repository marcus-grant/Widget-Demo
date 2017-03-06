//
//  SettingsTableViewController.swift
//  Widget-Demo
//
//  Created by Marcus Grant on 12/14/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    enum SettingSections {
        case context
    }

    let sections = ["Contexts"]
    let contexts = MockContext.allValues
    var defaults: UserDefaults
    var currentContext: String //TODO: modify

    required init?(coder aDecoder: NSCoder) {
        guard let defaults = UserDefaults(suiteName: "group.method.WidgetDemo")
            else {
                print("No defaults found using suiteName: \"group.method.WidgetDemo\"")
                fatalError("Couldn't load defaults")
        }; //return defaults
        self.currentContext = MockContext.Order.rawValue
        self.defaults = defaults
        super.init(coder: aDecoder)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        currentContext = getContextString(fromDefaults: defaults)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contexts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = contexts[indexPath.row]        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "settingsCell")
        header!.textLabel!.text = sections[section]
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let context = contexts[indexPath.row]
        print("SettingsVC has selected \(context) as context")
        defaults.set(context, forKey: "context")
        defaults.synchronize()
        //self.navigationController!.popViewController(animated: true)
        //self.performSegue(withIdentifier: "contextSelectionSegue", sender: tableView)
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
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    
//    @IBAction func changeContext(segue: UIStoryboardSegue) {
//        // Write changes to defaults so parent mockup controller knows which scene to display
//    }
//    
//    @IBAction func unwindWithSettings(segue: UIStoryboardSegue) {
//        
//    }

}
