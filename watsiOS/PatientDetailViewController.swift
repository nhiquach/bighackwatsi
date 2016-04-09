//
//  PatientDetailViewController.swift
//  watsiOS
//
//  Created by Nhi Quach on 4/9/16.
//  Copyright © 2016 bighack. All rights reserved.
//

import UIKit

class PatientDetailViewController: UIViewController {

    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var patientImageView: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        patientImageView.image = image
    }
}
