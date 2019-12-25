//
//  ViewController.swift
//  JSCoreEval
//
//  Created by walterlee on 2019/12/24.
//  Copyright © 2019 walterlee. All rights reserved.
//

import UIKit
import JavaScriptCore
struct Memo: Codable {
  var data: String
}

class ViewController: UIViewController {
  var jsFuncStr: String?
  
  
  @IBOutlet weak var ageTextField: UITextField!
  @IBOutlet weak var levelTextField: UITextField!
  @IBOutlet weak var interestsTextField: UITextField!
  @IBOutlet weak var interestTextField: UITextField!
  @IBOutlet weak var professionTextField: UITextField!
  
  @IBOutlet weak var lblCalculateResult: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    fetchJsExpr()
  }

  func fetchJsExpr() {
    let url = URL(string: "http://localhost:3000/eval")
    
    print("URL: \(url!)")
    
    URLSession.shared.dataTask(with: url!){[unowned self] (data,  response, err)  in
      
      guard let data = data else {return}
      do{
//        print("JSON RESPONSE: \(String(data: data, encoding: .utf8)!)")
        let decoder = JSONDecoder()
    
        let obj = try decoder.decode(Memo.self, from: data)
        print(obj.data)
        self.jsFuncStr = obj.data
      }catch let jsonErr{
        
        print("Failed to decode json:", jsonErr)
      }
    }.resume()
  }

  @IBAction func preset(_ sender: Any) {
    ageTextField.text = "19"
    levelTextField.text = "3"
    interestsTextField.text = "出国游,看电影,逛街"
    interestTextField.text = "出国游"
    professionTextField.text = "上班族"
  }
  /*
     let paramList : [String:Any] = ["age":19,
                               "level":"3",
                               "interests":["出国游","看电影","逛街"],
                               "interest":"看电影",
                               "profession":"自由职业"]
  */
  @IBAction func evalate(_ sender: Any) {
    let age = Int(self.ageTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "0")
    let level = self.levelTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let interestsString = self.interestsTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let interests = interestsString?.components(separatedBy: ",")
    let interest = self.interestTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let profession = self.professionTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    
    let paramList : [String:Any] = ["age": age ?? 0,
                              "level": level ?? "",
                              "interests": interests ?? [],
                              "interest": interest ?? "",
                              "profession": profession ?? ""]
    let data = try? JSONSerialization.data(withJSONObject: paramList, options: JSONSerialization.WritingOptions.fragmentsAllowed)
    let jsonStr = String(data: data!, encoding: .utf8)
    print("\(String(describing: jsonStr))")
    
    let jscontext = JSContext()
    //注册一个 js 函数
    jscontext?.evaluateScript(self.jsFuncStr)
    let jsFunction = jscontext?.objectForKeyedSubscript("foo")
    let result: Bool = jsFunction?.call(withArguments: [paramList]).toBool() ?? false
    if result {
      lblCalculateResult.textColor = .red
      lblCalculateResult.text = "运算结果: " + ""
    } else {
      lblCalculateResult.textColor = .blue
      lblCalculateResult.text = "运算结果: " + "🍌🍌🍌🍌🍌🍌🍌🍌"
    }
  }
  //  let { foo, bar } = { foo: "aaa", bar: "bbb" };

}

