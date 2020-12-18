//
//  ViewController.swift
//  ClassQuote
//
//  Created by Coding Group on 16/12/20.
//  Copyright © 2020 Quote. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newQuoteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var menuIsHidden = true
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    
    var favoris = "init"
    let defaults = UserDefaults.standard
    var count = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraintToMenu()
        addShadowToQuoteLabel()
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
                
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        self.view.isUserInteractionEnabled = true

        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        
        if defaults.value(forKey: "fav") != nil {
            favoris = defaults.string(forKey: "fav")!
        }
        print("load")
        print(favoris)
        
        
        
    }

    @IBAction func toggleMenu(_ sender: UIBarButtonItem) {
        if menuIsHidden {
            leadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            leadingConstraint.constant = -190
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        menuIsHidden = !menuIsHidden
    }
    
    private func addConstraintToMenu() {
        leadingConstraint.constant = -190
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 6
    }
    
    private func addShadowToQuoteLabel() {
        quoteLabel.layer.shadowColor = UIColor.black.cgColor
        quoteLabel.layer.shadowOpacity = 0.9
        quoteLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
    }

    @IBAction func tappedNewQuoteButton() {
        QuoteService.getQuote {(success, quote) in if success, let quote = quote {
            //affich image
            self.update(quote: quote)
        } else {
            //error
            self.error()
        }
        }
    }
    
    //func to affich quote, author
    private func update(quote: Quote){
        quoteLabel.text = quote.text
        imageView.image = UIImage(data: quote.imageData)
        authorLabel.text = quote.author
    }
    
    //error
    private func error() {
        let errorVC = UIAlertController(title: "Error", message: "The quote download failed.", preferredStyle: .alert)
        errorVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(errorVC, animated: true, completion: nil)
    }
    
    //Ajout au favoris
    
    public func addToFavoris() {
        
        
        //récuperation des données de la quote
        let author = authorLabel.text!
        let text = quoteLabel.text!
        let favoris = "favoris"
        
        let stringcount = String(count)
        
        
        
        
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let fileUrl = documentDirectoryUrl.appendingPathComponent("Favoris.json")
        
            
        let QuoteArray = ["ID": stringcount, "text": text, "author": author, "favoris":favoris]
        

        do {
            let data = try JSONSerialization.data(withJSONObject: QuoteArray, options: [])
            try data.write(to: fileUrl, options: [])
            count = count + 1
            print("envoie... ,\(QuoteArray)")
            } catch {
             print(error)
            }

    
        
        
        
        /*
        print(favoris)
        defaults.set(quoteLabel.text, forKey: "fav")
 */
        
    }
    
    

    
    //Gesture swipe
    @objc func didSwipe(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            self.tappedNewQuoteButton()
        } else if (sender.direction == .right) {
            self.addToFavoris()
        
        }
    }
}
