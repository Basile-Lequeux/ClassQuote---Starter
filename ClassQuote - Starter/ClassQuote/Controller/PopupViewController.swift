//
//  PopupViewController.swift
//  ClassQuote
//
//  Created by admin on 17/12/2020.
//  Copyright © 2020 OpenClassrooms. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var PopupBouton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func dismissPopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
