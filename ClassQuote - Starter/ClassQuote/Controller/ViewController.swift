//
//  ViewController.swift
//  ClassQuote
//
//  Created by Ambroise COLLON on 08/03/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
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
    private func addToFavoris() {
        print("Ajouter au favoris")
    }
    
    //Gesture swipe
    @objc func didSwipe(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            print("Swipe left")
            self.tappedNewQuoteButton()
        } else if (sender.direction == .right) {
            print("Swipe right")
            self.addToFavoris()
        }
    }
}
