//
//  UILabel+Extension.swift
//  MEMO
//
//  Created by OHSEUNGMIN on 2021/11/12.
//

import UIKit

extension UILabel {
    func highlight(searchText: String, color: UIColor = .orange) {
       guard let labelText = self.text else { return }
       do {
           let mutableString = NSMutableAttributedString(string: labelText)
           let regex = try NSRegularExpression(pattern: searchText, options: .caseInsensitive)
           
           for match in regex.matches(in: labelText, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: labelText.utf16.count)) as [NSTextCheckingResult] {
               mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: match.range)
           }
           self.attributedText = mutableString
       } catch {
           print(error)
       }
        
    }
    
    func nohighlight() {
       guard let labelText = self.text else { return }
       let mutableString = NSMutableAttributedString(string: labelText)
       mutableString.addAttribute(NSAttributedString.Key.foregroundColor,
                                  value: UIColor.black,
                                  range: NSRange(location: 0, length: labelText.count))
       self.attributedText = mutableString
    }
}
