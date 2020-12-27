//
//  ViewController.swift
//  Tranxit Task
//
//  Created by Shyam Kumar on 10/9/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
class ViewController: UIViewController, UIViewControllerTransitioningDelegate  {

    
    @IBOutlet weak var mobileNoTxtF: UITextField!
    
    let dB = DatabaseHelper()
    
    var storedNo = [MobileNo]()
    
    var isValidated = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.isNavigationBarHidden = true
    
    }

    
    @IBAction func BtnAct(_ sender: TKTransitionSubmitButton) {
   

        if sender.title(for: .normal) == "Register" {
            
            if validateMobileNo(mobNo: mobileNoTxtF.text ?? "") {
                
                guard let mobile = dB.add(MobileNo.self) else {return}
                
                if let mobileNo = mobileNoTxtF.text {
                      mobile.mobileNo = mobileNo
               }
                
                dB.save()
                showToast(message: "Mobile Registed Now Login", font: .systemFont(ofSize: 12.0))
          }} else {
            
             if validateMobileNo(mobNo: mobileNoTxtF.text ?? "") {
            
            storedNo = dB.fetch(MobileNo.self)
            
            storedNo.forEach { (i) in
              if i.mobileNo == mobileNoTxtF.text {

                  isValidated = true
           }
                
              
        }
                
                  
          let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
                                                        
                   if !isLogin && isValidated  {
                            apiCall{ res in
                                
                            if let wallet_balance = res["wallet_balance"] {
                            UserDefaults.standard.set("\(wallet_balance)", forKey: "wallet_balance")
                            UserDefaults.standard.set(true, forKey: "isLogin")
                        self.navToMain(Btn: sender)
                                
                        }
                  }
                   } else {
                    showToast(message: "Mobile number not registered", font: .systemFont(ofSize: 12.0))
                    UserDefaults.standard.set(false, forKey: "isLogin")
                }
                                                        
                                                            
                  if let _ = UserDefaults.standard.value(forKey: "wallet_balance") as? String {
                    self.navToMain(Btn: sender)
                    UserDefaults.standard.set(true, forKey: "isLogin")
            }
                              
      }
   }
}
    

    func validateMobileNo(mobNo: String) -> Bool {
        
        guard !mobNo.isEmpty else {
               showToast(message: "Mobile Number must not be empty", font: .systemFont(ofSize: 12.0))
                   return false
               }
        
        let number  = ".*[0-9]+.*"
               let numberTxt = NSPredicate(format:"SELF MATCHES %@", number)
               guard numberTxt.evaluate(with: mobNo) else {
                   showToast(message: "Please enter atleast one number", font: .systemFont(ofSize: 12.0))
                   return false
               }
    
        guard mobNo.count == 10 else {
            showToast(message: "Mobile Number must contain 10 numbers", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        
            return true
    
    }

    func navToMain(Btn : TKTransitionSubmitButton) {
        Btn.animate(1, completion: { () -> () in
                              
                             let sb = UIStoryboard.init(name: "Main", bundle: nil)
                             
                             
                                    let secondVc = sb.instantiateViewController(identifier: "MainViewController") as! MainViewController
                             
                                    secondVc.transitioningDelegate = self
                                    secondVc.modalPresentationStyle = .fullScreen
                                    
                                  let nav = UINavigationController(rootViewController: secondVc)
            nav.modalPresentationStyle = .fullScreen
                               // self.window?.rootViewController = nav
            self.navigationController?.present(nav, animated: true, completion: nil)
                                  
        })
    }
    
    
      func apiCall(_ completion: @escaping (_ dic : NSDictionary) -> Void) {
          
         
        let _ = AF.request("https://foodie.deliveryventure.com/api/user/profile", parameters: ["Node":"wallet_balance"], headers: ["X-Requested-With" : "XMLHttpRequest", "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImJmZTdmNmQ4NDExZjA2NGIyZTlhYzlmMWRlNWUyY2Q0YWY2ZDU2ODhkMjhlMTBkZDViZWM5ZDc4MTFkNTU5MmNmYjMzN2I5ZjczZTkxZDViIn0.eyJhdWQiOiIyIiwianRpIjoiYmZlN2Y2ZDg0MTFmMDY0YjJlOWFjOWYxZGU1ZTJjZDRhZjZkNTY4OGQyOGUxMGRkNWJlYzlkNzgxMWQ1NTkyY2ZiMzM3YjlmNzNlOTFkNWIiLCJpYXQiOjE2MDIyNDg1MTQsIm5iZiI6MTYwMjI0ODUxNCwiZXhwIjoxNjMzNzg0NTE0LCJzdWIiOiIyMyIsInNjb3BlcyI6W119.owalOLzTfO1bUxrKE20XNK4GzaMlPssyHYEoOingdkstk1HmLz45yEB1HP1IZdX9CWc9-6-6cXXR_Um6Misa7_Hk95S7oKVYqTJR8zFAcShv3inkc2tsDhCe6ih_ei9flikWrh8NociR3JCr9_bPZVFOZYd5cPyPCRtH04FcqC_9Sv_PHBNs6jdSHYklS8LDGinNHIv3hyKl0EBYO7vui52-qfFcTmP5SfSANA-S_Y2YznTYi0tMk2qHJjCbT-MH-8J08pyXony8FCOQkbqigF9u8g_SijBdtPhjZwKAz-eBRl8SUz4XrewiKcna0Bk_OC0LJGhalIGFc40S0skfjY8FxvyoiiCYGHKMbgY-YCNQSp7_SHxP0-ZGCZLuGLbTjcuKxuyDc_whXQgQsEDQLiWJoCuYi8lR9TUJVlS9pbAsMJxpxuQEQ6OGDpclp1g2xW-5KAxjns0_7eWkWGwGddaAorGVIAnx4G1znuLcEjSfVgXY8M04EvDvGGB2FOf04NB31GSxsS5239xjGDahTb_V6ws8uZnGkFs-HEU_BD1WoGwcEw22fafDeAC782gLFXIA6URcWhvkbGusoEI13A7CkY1Z48n0rWtEqwJHkWxOLuuKgL4xwXGcqpbVikgA1EdRRW47jRAXKuOjYYYU-mQTZXTnMVNxwHZnEQDw_C4","Content-Type" : "application/json"]).responseJSON { (res) in
              
          switch res.result {
          case .success(let value):
          
          completion(value as! NSDictionary)
          
          case .failure(let err):
          print("err", err)
          }
       }
    }

}

