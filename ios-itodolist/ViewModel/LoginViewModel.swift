//
//  LoginViewModel.swift
//  ios-itodolist
//
//  Created by Admin on 07.02.2019.
//  Copyright © 2019 Vladlin Moiseenko. All rights reserved.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    
    let apiController: ApiController
    
    //let status = Variable<Int>(0)
    
    private var modelAuthorize: Authorize {
        willSet {
            //print("ns:", newValue.status)
        }
    }

    init(apiController: ApiController) {
        self.apiController = apiController
        self.modelAuthorize = Authorize()
    }

    //func apiAuthorize(_ username:String, _ password:String) -> Bool {
     func apiAuthorize(_ username:String, _ password:String) {
        
        let jsonParam = try? JSONEncoder().encode(Credentials(username: username, password: password))
        let param = try? JSONSerialization.jsonObject(with: jsonParam!, options: []) as? [String : Any]

        apiController.authorize(param: param as! [String : Any], success: {modelAuthorize in
            //self.modelAuthorize = modelAuthorize
            
            if (modelAuthorize.status == 1) {
                
                UserDefaults.standard.set(modelAuthorize.authorizationCode, forKey: "authorizationCode")
                
//                apiController.accesstoken(param: param as! [String : Any], success: {model in
//
//                }, failure: { errorMsg in
//                    print(errorMsg)
//                })
                
                
            } else {
                UserDefaults.standard.set("empty", forKey: "authorizationCode")
            }
            
        }, failure: { errorMsg in
            print(errorMsg)
        })
        
    }

}
