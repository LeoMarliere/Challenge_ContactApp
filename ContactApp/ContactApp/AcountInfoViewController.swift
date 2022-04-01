//
//  AcountInfoViewController.swift
//  ContactApp
//
//  Created by Léo MARLIERE on 01/04/2022.
//

import Foundation
import UIKit

class AccountInfoViewController: UIViewController {
    
    @IBOutlet var accountName: UILabel!
    @IBOutlet var accountBalance: UILabel!
    @IBOutlet var stakedCPU: UILabel!
    @IBOutlet var currentCPU: UILabel!
    @IBOutlet var stakedNET: UILabel!
    @IBOutlet var currentNET: UILabel!
    @IBOutlet var ramUsage: UILabel!
    @IBOutlet var ramFreeAmount: UILabel!
    
    public var accountData: AccountData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account Information"
        
        accountName.text = accountData.account_name
        accountBalance.text = accountData.core_liquid_balance
        currentCPU.text = getCPUValue(from: accountData.cpu_weight)
        currentNET.text = getNETValue(from: accountData.net_weight)
        ramUsage.text = getNETValue(from: accountData.ram_usage)
    }
    
    private func getCPUValue(from cpu: String)-> String {
        guard let value = Double(cpu) else { return "Error"}
        
        if value <= 1000 {
            return cpu + "microseconds"
        } else if value <= 1000000 {
            return String(format: "%.2f", value/1000) + " milliseconds"
        } else {
            return String(format: "%.2f", value/1000000) + " seconds"
        }
    }
    
    private func getNETValue(from net: String)-> String {
        guard let value = Double(net) else { return "Error"}
        
        if value <= 1024 {
            return net + "bytes"
        } else if value <= 1048576 {
            return String(format: "%.2f", value/1000) + " kilobytes"
        } else {
            return String(format: "%.2f", value/1000000) + " megabytes"
        }
    }
}

