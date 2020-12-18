//
//  FavorisViewController.swift
//  ClassQuote
//
//  Created by Basile on 18/12/2020.
//  Copyright © 2020 OpenClassrooms. All rights reserved.
//

import UIKit


class FavorisViewController: UIViewController {

    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var textlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadfavoris()
        
     
      
        // Do any additional setup after loading the view.
    }
    
    
    public func loadfavoris(){
        
        
        
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent("Favoris.json")

        // Read data from .json file and transform data into an array
        do {
         let data = try Data(contentsOf: fileUrl, options: [])
            guard let QuoteArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else { return }
            /*
            print("recu,\(QuoteArray)")
            print("texte,\(QuoteArray["text"]!)")
            favorislabel.text = QuoteArray["text"]!
            */
            
            authorlabel.text = QuoteArray["author"]
            textlabel.text = QuoteArray["text"]
                
                
            } catch {
             print(error)
            }
            
            
            //return QuoteArray["text"]!
            
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
