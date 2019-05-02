class SecondViewController: UIViewController {
    var text:String = ""
    
    @IBOutlet weak var textLabel:UILabel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        textLabel?.text = text
    }
}
