//
//  ViewController.swift
//  ContactApp
//
//  Created by Léo MARLIERE on 31/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var accountNameEntry: UITextField!
    @IBOutlet var entryButton: UIButton!
    @IBOutlet var errorMessage: UILabel!
    
    private let apiURL = "http://localhost:8080/v1/chain/get_account/"
    private let accountNameTest = "wombatresmgr"
    // /paths/~1get_abi/post/requestBody/content/application~1json/schema/properties/account_name
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account Name"
    }
    
    
    private func getAPIData(from url: String) -> AccountData? {
        
        /*
        var accountData: AccountData?
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else { return }
            
            var result: Response?
            do { result = try JSONDecoder().decode(Response.self, from: data) }
            catch { print("Failed to convert data")}
            
            guard let response = result else { return }
            accountData = response.result
        }).resume()
         
         return accountData
         */
        
        
        //TEST VALUE
        return AccountData(account_name: "wombatresmgr",
                           core_liquid_balance: "12045",
                           net_weight: "1234732",
                           cpu_weight: "23862",
                           ram_usage: "4362722")
        
    }
    
    @IBAction func didTapValidation() {
        
        errorMessage.isHidden = true
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AccountInfoViewController") as? AccountInfoViewController else {
            return
        }
        
        guard let accountName = accountNameEntry.text, !accountName.isEmpty,
              let accountData = getAPIData(from: apiURL + accountName) else {
                  errorMessage.isHidden = false
                  return
        }
        
        vc.accountData = accountData
        vc.title = "Account Information"
        navigationController?.pushViewController(vc, animated: true)
    }


}


struct Response: Codable {
    let status: String
    let result: AccountData
}

public struct AccountData: Codable {
    let account_name: String
    let core_liquid_balance: String
    let net_weight: String
    let cpu_weight: String
    let ram_usage: String
}


/*
 
 {
   "account_name": "string",
   "head_block_num": 0,
   "head_block_time": "string",
   "last_code_update": "string",
   "created": "string",
   "refund_request": {
     "owner": "string",
     "request_time": "string",
     "net_amount": "string",
     "cpu_amount": "string"
   },
   "ram_quota": "string",
   "net_limit": {
     "max": "string",
     "available": "string",
     "used": "string"
   },
   "cpu_limit": {
     "max": "string",
     "available": "string",
     "used": "string"
   },
   "total_resources": {
     "owner": "string",
     "ram_bytes": "string",
     "net_weight": "string",
     "cpu_weight": "string"
   },
   "core_liquid_balance": "string",
   "self_delegated_bandwidth": {
     "from": "string",
     "to": "string",
     "net_weight": "string",
     "cpu_weight": "string"
   },
   "net_weight": "string",
   "cpu_weight": "string",
   "ram_usage": "string",
   "privileged": true,
   "permissions": [
     {
       "parent": "string",
       "perm_name": "string",
       "required_auth": {
         "waits": [
           {
             "wait_sec": 0,
             "weight": 0
           }
         ],
         "keys": [
           {
             "key": "string",
             "weight": 0
           }
         ],
         "threshold": 0,
         "accounts": [
           {
             "weight": 0,
             "permission": {
               "actor": "string",
               "permission": "string"
             }
           }
         ]
       }
     }
   ],
   "voter_info": {
     "owner": "string",
     "proxy": "string",
     "producers": [
       "string"
     ],
     "staked": "string",
     "last_vote_weight": "string",
     "proxied_vote_weight": "string",
     "is_proxy": 0,
     "flags1": 0,
     "reserved2": 0,
     "reserved3": "string"
   }
 }
 
 */


