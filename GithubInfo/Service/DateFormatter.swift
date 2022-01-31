//
//  DateFormatter.swift
//  GithubInfo
//
//  Created by Thomas Noble on 31/01/2022.
//

import Foundation


let date = Date()
let formate = date.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss") // Set output formate

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

func dateFromyyyyMMddTHHmmssZToddMMAAAA(with datestr: String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd/MM/yyyy"
    
    

    if let date = dateFormatter.date(from: datestr) {
        return dateFormatterPrint.string(from: date)
    } else {
        return ""
    }
}
