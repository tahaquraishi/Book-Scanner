import UIKit

class SearchHistoryViewController: UIViewController {
    @IBOutlet weak var searchHistory: UITextView!
    
    var isbnsHistory = [String]()
    var titlesHistory = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchHistory.text = ""
        for (isbn, title) in zip(isbnsHistory, titlesHistory) {
            searchHistory.text = searchHistory.text + "ISBN: \(isbn)\nTitle: \(title)\n\n"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.isbns = self.isbnsHistory
        vc.titles = self.titlesHistory
    }
    
}
