//
//  PopupViewController.swift
//  ClassQuote
//
//  Created by admin on 17/12/2020.
//  Copyright © 2020 OpenClassrooms. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.layer.cornerRadius = 10
        popUpView.clipsToBounds = true
    }
    
    @IBAction func dismissPopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
