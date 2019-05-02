import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var isbnField: UITextField!
    @IBOutlet weak var searchResults: UITextView!
    
    var isbns = [String]()
    var titles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 9781594631931 (Kite Runner)
    @IBAction func enterISBN(_ sender: Any) {
        Alamofire.request("https://www.googleapis.com/books/v1/volumes?q=isbn:" + isbnField.text!).responseJSON { response in
            debugPrint(response)
            
            if let value = response.result.value {
                let json = JSON(value)
                if (json["totalItems"].stringValue != "0" && self.isbnField.text! != "") {
                    let title = json["items"][0]["volumeInfo"]["title"].stringValue
                    let author = json["items"][0]["volumeInfo"]["authors"].arrayValue
                    let genre = json["items"][0]["volumeInfo"]["categories"][0].stringValue
                    let rating = json["items"][0]["volumeInfo"]["averageRating"].stringValue
                    let description = json["items"][0]["volumeInfo"]["description"].stringValue
                    if (rating != "") {
                        self.searchResults.text = "Title: \(title)\n\nAuthor: \(author)\n\nGenre: \(genre)\n\nRating: \(rating)/5\n\nSummary: \(description)"
                    } else {
                        self.searchResults.text = "Title: \(title)\n\nAuthor: \(author)\n\nGenre: \(genre)\n\nSummary: \(description)"
                    }
                
                    self.isbns.append(self.isbnField.text!)
                    self.titles.append(title)
                    
                } else {
                    self.searchResults.text = "No books found."
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SearchHistoryViewController
        vc.isbnsHistory = self.isbns
        vc.titlesHistory = self.titles
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isbnField.resignFirstResponder();
    }
    
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}

