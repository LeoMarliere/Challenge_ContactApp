//
//  AcountInfoViewController.swift
//  ContactApp
//
//  Created by Léo MARLIERE on 01/04/2022.
//

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
    public var formatter = Formatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account Information"
        
        accountName.text = accountData.account_name
        accountBalance.text = accountData.core_liquid_balance
        currentCPU.text = formatter.getCPUValue(from: accountData.cpu_weight)
        currentNET.text = formatter.getNETValue(from: accountData.net_weight)
        ramUsage.text = formatter.getNETValue(from: accountData.ram_usage)
    }
}

