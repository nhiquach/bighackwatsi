//
//  WatsiAPI.swift
//  watsiOS
//
//  Created by Nhi Quach on 4/8/16.
//  Copyright © 2016 bighack. All rights reserved.
//

import Foundation


class WatsiAPI {
    

    func loadPatients(completion: (([Patient]) -> Void)!) {
        var url: NSURL
        url = NSURL(string: "https://watsi.org/fund-treatments.json")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                var patients = [Patient]()
                do {
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
                    let patientDictionary = jsonDictionary["profiles"] as! [NSDictionary]
                    for patient in patientDictionary {
                        patients.append(Patient(data: patient))
                    }
                    
                    
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(patients)
                        }
                    }
                } catch let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    func getPatientUrl(token: String) -> String {
        return "https://watsi.org/profile/\(token).json"
    }
}