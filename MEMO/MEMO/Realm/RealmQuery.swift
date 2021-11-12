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
    
    func edit(memo: Memo, title: String?, content: String?) {
        let localRealm = try! Realm()
        let task = localRealm.objects(Memo.self).where {
            $0._id == memo._id
        }.first!
        
        try! localRealm.write {
            if title != nil || content != nil { task.modifiedDate = Date() }
            if title != nil { task.title = title! }
            if content != nil { task.content = content! }
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
