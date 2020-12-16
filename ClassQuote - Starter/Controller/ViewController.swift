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

    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToQuoteLabel()
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
    private func error()
    {
        let errorVC = UIAlertController(title: "Error", message: "The quote download failed.", preferredStyle: .alert)
        errorVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(errorVC, animated: true, completion: nil)
    }
}
