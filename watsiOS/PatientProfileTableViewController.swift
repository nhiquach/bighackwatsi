//
//  PatientProfileTableViewController.swift
//  watsiOS
//
//  Created by Nhi Quach on 4/8/16.
//  Copyright © 2016 bighack. All rights reserved.
//

import UIKit

class PatientProfileTableViewController: UITableViewController {

    var patients = [Patient]()
    var images = [String: UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let api = WatsiAPI()
        api.loadPatients(initializePatients)
        self.tableView.backgroundColor = UIColor.whiteColor()
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("goToPatientDetail", sender: indexPath)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToPatientDetail" {
            let destVC = segue.destinationViewController as! PatientDetailViewController
            let indexPath = sender as! NSIndexPath
            let selectedCell = tableView!.cellForRowAtIndexPath(indexPath) as! PatientProfileTableViewCell
            destVC.image = selectedCell.profilePictureImageView!.image
            destVC.token = patients[indexPath.row].token
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "PatientCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PatientProfileTableViewCell
        let patient = patients[indexPath.row]
        loadImageForCell(patient, imageView: cell.profilePictureImageView)
        cell.profilePictureImageView.layer.cornerRadius = 65
        cell.profilePictureImageView.clipsToBounds = true
        cell.profilePictureImageView.layer.borderWidth = 3.0
        cell.profilePictureImageView.layer.borderColor = UIColor.grayColor().CGColor
        cell.backgroundColor = UIColor(red: 177/256, green: 206/256, blue: 214/256, alpha: 1.0)
        cell.nameAgeLabel.text = patient.name + ", " + String(patient.age) + " " + patient.ageTag
        cell.countryLabel.text = patient.country
        let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, 190))
        
        whiteRoundedView.layer.backgroundColor = UIColor.whiteColor().CGColor
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)
        cell.donationProgressView.progress = Float(patient.donated)/Float(patient.target)
        cell.donationProgressView.progressTintColor = UIColor(red: 222/256, green: 128/256, blue: 135/256, alpha: 1.0) 
        cell.goalLabel.text = "Goal: $" + String(patient.target/100)
        cell.headerTextView.text = patient.header
        cell.headerTextView.font = UIFont(name: "Helvetica", size: 14.0)
        return cell
    }
    func loadImageForCell(patient: Patient, imageView: UIImageView) {
        let url = NSURL(string: patient.profileUrl)
        if ((images[patient.profileUrl]) != nil) {
            let img = images[patient.profileUrl]
            imageView.image = img
        } else {
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: {
                (data, response, error) -> Void in
                if error == nil {
                    let img = UIImage(data: data!)
                    imageView.image = img
                    self.images[patient.profileUrl] = img
                }
            })
            task.resume()
        }
    }
    
    func initializePatients(patients: [Patient]) {
        self.patients = patients
        self.tableView.reloadData()
    }
    
}
