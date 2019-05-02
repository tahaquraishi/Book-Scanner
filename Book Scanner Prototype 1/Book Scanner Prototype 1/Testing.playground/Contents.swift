import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class enterISBN {
    
    var ISBN:String
    
    // Data from ISBN
    var title:String = ""
    var author:String = ""
    var description:String = ""
    
    init(ISBN:String) {
        self.ISBN = ISBN
    }
    
    func search() {
        Alamofire.request("https://www.googleapis.com/books/v1/volumes?q=isbn:" + ISBN).responseJSON { response in
            debugPrint(response)
            
            if let value = response.result.value {
                let json = JSON(value)
                if (json["totalItems"].stringValue != "0") {
                    self.title = json["items"][0]["volumeInfo"]["title"].stringValue
                    self.author = json["items"][0]["volumeInfo"]["authors"][0].stringValue
                    self.description = json["items"][0]["volumeInfo"]["description"].stringValue
                    print("Title: \(self.title)\n\nAuthor: \(self.author)\n\nSummary: \(self.description)")
                } else {
                    print("No books found.")
                }
            }
        }
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getAuthor() -> String {
        return author
    }
    
    func getDescription() -> String {
        return description
    }
    
}
