//
//  GetAccountViewController.swift
//  ContactApp
//
//  Created by Léo MARLIERE on 04/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class GetAccountViewController: UIViewController {
    
    struct Constant {
        static let apiURL = "https://eos.greymass.com/v1/chain/get_account"
    }
    
    @IBOutlet var accountNameEntry: UITextField!
    @IBOutlet var valueEOS: UILabel!
    @IBOutlet var valueCPU: UILabel!
    @IBOutlet var valueNET: UILabel!
    @IBOutlet var valueRAM: UILabel!
    @IBOutlet var noValue: UILabel!
    @IBOutlet var valueView: UIView!
    
    public var formatter = Formatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Get Account Information"
        valueView.isHidden = true
        noValue.isHidden = false
        setUpTextFieldObserver()
    }
    
    private func setUpTextFieldObserver() {
        
        accountNameEntry.rx
            .controlEvent([.editingChanged])
            .asObservable()
            .subscribe({ [unowned self] _ in
                
                print("My text : \(self.accountNameEntry.text ?? "")")
                //getAPIData(with: self.accountNameEntry.text)
                
            }).dispose()
    }
    
    private func displayDataFounded(with data: AccountData) {
        valueView.isHidden = false
        noValue.isHidden = true
        
        valueEOS.text = data.core_liquid_balance
        valueCPU.text = formatter.getCPUValue(from: data.cpu_weight)
        valueNET.text = formatter.getNETValue(from: data.net_weight)
        valueRAM.text = formatter.getNETValue(from: data.ram_usage)
    }
    
    private func setUpForNoDataFounded() {
        valueView.isHidden = true
        noValue.isHidden = false
    }
}

extension GetAccountViewController {
    
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
                    DispatchQueue.main.async { self.setUpForNoDataFounded() }
                    return
                }
                
                let accountData = AccountData(account_name: accountName,
                                          core_liquid_balance: core_liquid_balance,
                                          net_weight: String(net_weight),
                                          cpu_weight: cpu_weight,
                                          ram_usage: String(ram_usage))
                
                DispatchQueue.main.async {
                    self.displayDataFounded(with: accountData)
                }
                
            } catch {
                print("Failed to convert data")
            }
        }.resume()
    }
}
