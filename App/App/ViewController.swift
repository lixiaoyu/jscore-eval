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

protocol ParamProtocol :JSExport {
  func params() -> String;
}

class JSExportParam: ParamProtocol {
  let param: String
  init(params: String) {
    self.param = params
  }
  func params() -> String {
    return self.param
  }
}
class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
  }

  func fetchJsExpr() {
    let url = URL(string: "http://localhost:3000/eval")
    
    print("URL: \(url!)")
    
    URLSession.shared.dataTask(with: url!){(data,  response, err) in
      
      guard let data = data else {return}
      do{
        print("JSON RESPONSE: \(String(data: data, encoding: .utf8)!)")
        let decoder = JSONDecoder()
    
        let obj = try decoder.decode(Memo.self, from: data)
        print(obj.data)
       _ = self.evaluate(js: obj.data)
      }catch let jsonErr{
        
        print("Failed to decode json:", jsonErr)
      }
    }.resume()
  }

  @IBAction func play(_ sender: Any) {
    fetchJsExpr();
  }
  //  let { foo, bar } = { foo: "aaa", bar: "bbb" };
  
  func evaluate(js: String) -> Bool {
    let paramList : [String:Any] = ["age":19,
                              "level":"3",
                              "interests":["出国游","看电影","逛街"],
                              "interest":"看电影",
                              "profession":"自由职业"]
    let data = try? JSONSerialization.data(withJSONObject: paramList, options: JSONSerialization.WritingOptions.fragmentsAllowed)
    let jsonStr = String(data: data!, encoding: .utf8)
    print(jsonStr)
    
    let jscontext = JSContext()
    //注册一个 js 函数
    jscontext?.evaluateScript(js)
    let jsFunction = jscontext?.objectForKeyedSubscript("foo")
    let result: Bool = jsFunction?.call(withArguments: [paramList]).toBool() ?? false
    if result {
      print("")
    } else {
      print("🍌🍌🍌🍌🍌🍌🍌🍌")
    }
    return result
  }
}

