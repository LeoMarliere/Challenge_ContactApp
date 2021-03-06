//
//  ViewController.swift
//  ContactApp
//
//  Created by Léo MARLIERE on 31/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    struct Constant {
        static let accountNameTest1 = "wombatresmgr"
        static let accountNameTest2 = "womplayitems"
        static let apiURL = "https://eos.greymass.com/v1/chain/get_account"
        static let mockAccount = AccountData(account_name: "wombatresmgr",
                                             core_liquid_balance: "12045",
                                             net_weight: "1234732",
                                             cpu_weight: "23862",
                                             ram_usage: "4362722")
    }
    
    @IBOutlet var accountNameEntry: UITextField!
    @IBOutlet var entryButton: UIButton!
    @IBOutlet var errorMessage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account Name"
    }
    
    private func getAPIData(with accountName: String) {

        // Create Request
        guard let formattedURL = URL(string: Constant.apiURL) else {
            print("Error While creating URL")
            return
        }
        
        var request = URLRequest(url: formattedURL,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10)

        let jsonBody = ["account_name":accountName] as [String:Any]

        do {
            let requestBody = try JSONSerialization.data(withJSONObject: jsonBody, options: .fragmentsAllowed)
            request.httpBody = requestBody
            request.httpMethod = "POST"
        }
        catch {
            print("Failed to create Request body")
        }
        
        // Execute Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil, data == data else {
                print ("Error")
                return
            }
            
            do {
                let dictionnary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                
                guard dictionnary != nil,
                      let core_liquid_balance = dictionnary!["core_liquid_balance"] as? String,
                      let net_weight = dictionnary!["net_weight"] as? Int,
                      let cpu_weight = dictionnary!["cpu_weight"] as? String,
                      let ram_usage = dictionnary!["ram_usage"] as? Int else {
                    print("Error with the Mapping of the Data")
                    DispatchQueue.main.async { self.errorMessage.isHidden = false }
                    return
                }
                
                let accountData = AccountData(account_name: accountName,
                                          core_liquid_balance: core_liquid_balance,
                                          net_weight: String(net_weight),
                                          cpu_weight: cpu_weight,
                                          ram_usage: String(ram_usage))
                
                DispatchQueue.main.async {
                    self.displayAccountData(with: accountData)
                }
                
            } catch {
                print("Failed to convert data")
            }
        }.resume()
    }
    
    private func displayAccountData(with data: AccountData) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountInfoViewController") as? AccountInfoViewController else {
            return
        }

        vc.accountData = data
        vc.title = "Account Information"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapValidation() {
        
        errorMessage.isHidden = true
        
        guard let accountName = accountNameEntry.text, !accountName.isEmpty else {
            return
        }
        
        self.getAPIData(with: accountName)
    }
    
    @IBAction func didTapV2() {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "GetAccountViewController") as? GetAccountViewController else {
            return
        }
        
        vc.title = "Get Account Information"
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
