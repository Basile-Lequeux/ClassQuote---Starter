//
//  ViewController.swift
//  ClassQuote
//
//  Created by Coding Group on 16/12/20.
//  Copyright © 2020 Quote. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newQuoteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var menuIsHidden = true
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet var CountQuote: UILabel!
    var countCitation = 0
    var count = 0
    
    
    let userDefaults = UserDefaults.standard
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraintToMenu()
        addShadowToQuoteLabel()
        //startPopup()
    
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
                
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        self.view.isUserInteractionEnabled = true

        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        
        CountQuote.text = "\(countCitation)"
    
    }
    
    /*private func startPopup() {
        let vc = PopupViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async(execute: {
            self.parent?.present(vc, animated: true)
        })
    }*/

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
  
    //Share Button
    @IBAction func shareButtonV(_ sender: UIBarButtonItem) {
        let vc = UIActivityViewController(activityItems: [shareQuote()], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
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

//    @IBAction func tappedNewQuoteButton() {
//        QuoteService.getQuote {(success, quote) in if success, let quote = quote {
//            //affich image
//            self.update(quote: quote)
//            self.CitationCount()
//            
//            } else {
//            //error
//            self.error()
//            }
//        }
//    }
    
    @IBAction func CourtQuote() {
        Essaie2()
    }
    
    @IBAction func longQuoteButton() {
        Essaie1()
    }
    
    func Essaie1()  {
        QuoteService.getQuote {(success, quote) in if success, let quote = quote {
            //affich image
            if quote.text.count > 100{
                self.update(quote: quote)
                self.CitationCount()
            }
            else {
                print("appel récursif + quote = \(quote.text.count)")
                self.Essaie1()
                
            }
            
            } else {
            //error
            self.error()
            }
        }
       
    }
    
    func Essaie2()  {
        QuoteService.getQuote {(success, quote) in if success, let quote = quote {
            //affich image
            if quote.text.count < 100{
                self.update(quote: quote)
                self.CitationCount()
            }
            else {
                print("appel récursif + quote = \(quote.text.count)")
                self.Essaie2()
                
            }
            
            } else {
            //error
            self.error()
            }
        }
       
    }
    
    func Essaie3() {
        QuoteService.getQuote {(success, quote) in if success, let quote = quote {
            //affich image
            self.update(quote: quote)
            self.CitationCount()
            
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
        var authors = String("authors,\(stringcount)")
            
        let QuoteDictionary = [
            "author" : author,
            "text": text
        ]
        
        
        userDefaults.set(QuoteDictionary, forKey: "myKey")
        
        var strings: [String:String] = userDefaults.object(forKey: "myKey") as? [String:String] ?? [:]
        
        

        //strings["id"] = stringcount
        //strings[authors] = author
        //strings["text"] = text
        //strings["tata"] = "yo"
        
        
        userDefaults.set(strings, forKey: "myKey")
        
        print(userDefaults.object(forKey: "myKey")!)
        
        
        

        
        
        
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let fileUrl = documentDirectoryUrl.appendingPathComponent("Favoris.json")
        
            
        let QuoteArray = ["ID": stringcount, "text": text, "author": author, "favoris":favoris]
        

        do {
            let data = try JSONSerialization.data(withJSONObject: QuoteArray, options: [])
            try data.write(to: fileUrl, options: [])
            count = count + 1
            
            } catch {
             print(error)
            }

    
        
        
    }
    
    

    
    //Gesture swipe
    @objc func didSwipe(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            self.Essaie3()
        } else if (sender.direction == .right) {
            self.addToFavoris()
        
        }
    }
    

    //fonc share
    func shareQuote() ->String{
        let textequote = quoteLabel.text!
        let texteauthor = authorLabel.text!
        return "\(textequote) \n  \(texteauthor)"
        
    }
    
    func CitationCount(){
        countCitation = countCitation + 1
        CountQuote.text = "\(countCitation)"
        
    }
    
  
    
    
}
