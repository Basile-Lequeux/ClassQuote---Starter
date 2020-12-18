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
    @IBOutlet weak var popUpBouton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLayer()
    }
    
    @IBAction func dismissPopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func changeLayer() {
        popUpView.layer.cornerRadius = 10
        popUpView.clipsToBounds = true
        popUpBouton.layer.cornerRadius = 20
    }
}
