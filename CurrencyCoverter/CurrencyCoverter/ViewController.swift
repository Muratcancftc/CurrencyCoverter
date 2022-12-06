//
//  ViewController.swift
//  CurrencyCoverter
//
//  Created by Muratcan Çiftçi on 26.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        // 1- request veya session
        // 2- response veya datayı almak
        // 3- parsing = pars etmek= aldığın veriyi işlemek(parsing veya JSON Serialization)
        
        
        
        //1
        let url = URL(string:   "http://data.fixer.io/api/latest?access_key=4a990ae1cc0ef5a920e4c7e9eeb1123c")
        
        let session = URLSession.shared
        
        //Closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error == nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }else{
                
                //2
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYCN
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rate"] as? [String : Any]{
                                //print(rates)
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let turkish = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY: \(turkish)"
                                }
                            }
                            
                        }
                        
                    }catch {
                        print("Error")
                    }
                }
                
            }
        }
        task.resume()
        
    }
    
}

