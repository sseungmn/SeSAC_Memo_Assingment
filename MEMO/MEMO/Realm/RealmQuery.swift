//
//  RealmQuery.swift
//  MEMO
//
//  Created by OHSEUNGMIN on 2021/11/11.
//

import Foundation
import RealmSwift
import UIKit

extension UIViewController {
    func add(memo: Memo) {
        let localRealm = try! Realm()
        
        try! localRealm.write {
            localRealm.add(memo)
        }
    }
    
    func delete(memo: Memo) {
        let localRealm = try! Realm()
        
        try! localRealm.write {
            localRealm.delete(memo)
        }
    }
    
    func fix(memo: Memo) {
        let localRealm = try! Realm()
        
        try! localRealm.write {
            memo.fixed = true
        }
    }
    
    func unfix(memo: Memo) {
        let localRealm = try! Realm()
        
        try! localRealm.write {
            memo.fixed = false
        }
    }
}
