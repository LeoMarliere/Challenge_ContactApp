//
//  Formatter.swift
//  ContactApp
//
//  Created by Léo MARLIERE on 04/04/2022.
//

import Foundation
import UIKit

class Formatter {
    
    public func getCPUValue(from cpu: String)-> String {
        guard let value = Double(cpu) else { return "Error"}
        
        if value <= 1000 {
            return cpu + "microseconds"
        } else if value <= 1000000 {
            return String(format: "%.2f", value/1000) + " milliseconds"
        } else {
            return String(format: "%.2f", value/1000000) + " seconds"
        }
    }
    
    public func getNETValue(from net: String)-> String {
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
