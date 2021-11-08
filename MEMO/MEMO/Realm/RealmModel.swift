//
//  RealmModel.swift
//  MEMO
//
//  Created by OHSEUNGMIN on 2021/11/08.
//

import Foundation
import RealmSwift

class Memo: Object {
    @Persisted (primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var writeDate: Date
    @Persisted var fixed: Bool
    
    convenience init(title: String, content: String?, writeDate: Date) {
        self.init()
        
        self.title = title
        self.content = content
        self.writeDate = writeDate
        self.fixed = false
    }
}
