//
//  GetAccountViewController.swift
//  ContactApp
//
//  Created by Léo MARLIERE on 04/04/2022.
//

import Foundation
import UIKit

class GetAccountViewController: UIViewController {
    
    @IBOutlet var valueEOS: UILabel!
    @IBOutlet var valueCPU: UILabel!
    @IBOutlet var valueNET: UILabel!
    @IBOutlet var valueRAM: UILabel!
    @IBOutlet var noValue: UILabel!
    
    @IBOutlet var valueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Get Account Information"
        valueView.isHidden = true
        noValue.isHidden = false
    }
    
}
