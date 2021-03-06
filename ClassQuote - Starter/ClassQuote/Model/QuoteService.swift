//
//  QuoteService.swift
//  ClassQuote
//
//  Created by Coding Group on 16/12/20.
//  Copyright © 2020 Quote. All rights reserved.
//


import Foundation
class QuoteService
{
    
    //link cita
    private static let quoteUrl = URL(string: "https://api.forismatic.com/api/1.0/")!
    
    //link image
    private static let pictureUrl = URL(string: "https://source.unsplash.com/random/1000x1000")!
    
    //method get quotes
    static func getQuote(callback: @escaping (Bool, Quote?) -> Void)
    {
        //request
        var request = URLRequest(url: quoteUrl)
        request.httpMethod = "POST"
        
        //param for request
        let body = "method=getQuote&lang=en&format=json"
        request.httpBody = body.data(using: .utf8)
        
        //start a task
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){(data, response, error) in DispatchQueue.main.async {
            // threading action (main)
            
            if let data = data, error == nil
        {
            if let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                if let responseJSON = try? JSONDecoder().decode([String: String].self, from: data),
                                       let text = responseJSON["quoteText"],
                                       let author = responseJSON["quoteAuthor"]
                                {
                    getImage { (data) in if let data = data {
                        let quote = Quote(text: text, author: author, imageData: data)
                        callback(true, quote)
                    } else {
                        callback(false, nil)
                    }
                    }
                                          
                } else {
                    callback(false, nil)
                }
                
            } else {
                callback(false, nil)
            }
         } else {
            callback(false, nil)
        }
            
        }
        }
       
        task.resume()
    }
    
    
    //reading json file
    private static func createQuoteRequest() -> URLRequest {
            var request = URLRequest(url: quoteUrl)
            request.httpMethod = "POST"

            let body = "method=getQuote&lang=en&format=json"
            request.httpBody = body.data(using: .utf8)

            return request
        
        }
    /*
    private static func getImage() {
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: pictureUrl) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responseJSON = try? JSONDecoder().decode([String: String].self, from: data),
                        let text = responseJSON["quoteText"],
                        let author = responseJSON["quoteAuthor"] {
                            getImage() // recive image after recive quote
                    }
                }
            }
        }
    }
    */
    
    
    //getting image
    private static func getImage(completionHandler: @escaping ((Data?) -> Void)) {
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: pictureUrl) {
            (data, response, error) in
            DispatchQueue.main.async {
                       // threading
                if data == data, error == nil {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200
                    {
                        completionHandler(data) // getting datas
                    } else {
                        completionHandler(nil)
                    }
                } else {
                    completionHandler(nil)
                }
            }
        }
        task.resume()
    
    }
}
