import UIKit
import Kanna


class ViewController: UIViewController {

    @IBOutlet var textView : UITextView!
    @IBOutlet var textView2 : UITextView!
    @IBOutlet var textField : UITextField!
    @IBOutlet var htmltextField : UITextField!
    
    var list = Array<XMLElement>()
    var list_data = Array<String>()
    var xpathlo = ""
    var htmllocation = ""
    let xpathlocation = "//div[3]//dl/dd"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func parsingHTML(){
        htmllocation = String(htmltextField.text!)
        let apiURI = NSURL(string: "http://www.giheung.hs.kr/l_foodment/?&yy=2016&mm=05&_action=view&_view=view")
        let apidata : NSData = NSData(contentsOfURL: apiURI!)!
        
        if let doc = Kanna.HTML(html: apidata, encoding: NSUTF8StringEncoding){
            for data in doc.xpath(xpathlocation){
                list.append(data)
            }
            for data1 in list{
                if let a = data1.text{
                    let link3 = String(a)
                    let trimmedString = link3.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                    list_data.append(trimmedString)
                    print(trimmedString)
                }
            }
        }
        
    }
    
    @IBAction func testbutton(sender: AnyObject){
        xpathlo = String(textField.text!)
        parsingHTML()
        var strtemp = ""
        for i in 0..<list_data.count{
            strtemp += list_data[i]
        }
        textView.text = strtemp
        strtemp = ""
        list = Array<XMLElement>()
        list_data = Array<String>()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

