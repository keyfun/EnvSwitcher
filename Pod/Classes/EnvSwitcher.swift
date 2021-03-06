//
//  EnvSwitcher.swift
//  EnvSwitcher
//
//  Created by Hui Key on 3/2/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public class EnvSwitcher:NSObject {
    static let SAVE_KEY:String = "Keyfun_EnvSwitcher_Key"
    private static var window:UIWindow?
    private static var completion:((option:String) -> Void)?
    private static var options:[String] = []
    private static var isShowed:Bool = false
    private static var isSave:Bool = false
    private static var title:String = ""
    private static var message:String = ""
    
    static public func initSwitcher(window:UIWindow?, duration:Double, options:[String], isSave:Bool, completion: ((option:String) -> Void)?) {
        self.window = window
        self.completion = completion
        self.options = options
        self.isSave = isSave
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        longPressRecognizer.minimumPressDuration = duration
        longPressRecognizer.numberOfTouchesRequired = 2
        window?.addGestureRecognizer(longPressRecognizer)
        isShowed = false
    }
    
    static func longPressed(sender: UILongPressGestureRecognizer) {
//        print("longpressed")
        showAlertButtonTapped()
    }
    
    static func showAlertButtonTapped() {
        if(isShowed) {
            return
        }
        isShowed = true
        
        var tmpTitle:String = ""
        
        if(self.title.isEmpty) {
            let version = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
            let build = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
            //print("version = \(version), build = \(build)")
            tmpTitle = "EnvSwitcher \n Version = (\(version)) \n Build = \(build)"
        } else {
            tmpTitle = self.title
        }
    
        var tmpMessage = ""
        if(self.message.isEmpty) {
            if(getUserPreferences() != nil) {
                tmpMessage = "Selected [\(getUserPreferences()!)]\nPlease Select Environment Options"
            } else {
                tmpMessage = "Please Select Environment Options"
            }
        } else {
            tmpMessage = self.message
        }
        
        let alert = UIAlertController(title: tmpTitle, message: tmpMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        // create options from the array
        for option in options {
            alert.addAction(UIAlertAction(title: option, style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
                saveToUserPreferences(option)
                completion?(option: option)
                isShowed = false
            }))
        }
        
        // add the last cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive, handler: { (action:UIAlertAction) -> Void in
            completion?(option: "")
            isShowed = false
        }))
        
        // show the alert
        self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func saveToUserPreferences(value:String) {
        if(isSave) {
            NSUserDefaults.standardUserDefaults().setObject(value, forKey: SAVE_KEY)
        }
    }
    
    static public func getUserPreferences() -> String? {
        return NSUserDefaults.standardUserDefaults().stringForKey(SAVE_KEY)
    }
    
    static public func setTitle(str:String) {
        self.title = str
    }
    
    static public func setMessage(str:String) {
        self.message = str
    }
}
