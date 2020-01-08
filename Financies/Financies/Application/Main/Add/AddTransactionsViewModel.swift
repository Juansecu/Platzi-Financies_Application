//
//  AddTransactions.swift
//  PlatziFinanzas
//
//  Created by Andres Silva on 12/5/18.
//  Copyright © 2018 Platzi. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FinanciesCore

class AddTransactionsViewModel {
    private var db: Firestore {
        return Firestore.firestore()
    }
    
    func add(name: String, description: String, value: String) {
        guard let value = Float(value) else {
            return
        }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let transaction = FinanciesCore.Transaction(
            value: value,
            category: .expend,
            name: name,
            date: Date()
        )
        
        guard var data = transaction.data() else {
            return
        }
        
        data["ownerID"] = uid
        
        db.collection("transactions").addDocument(data: data) { (error) in
            print(error?.localizedDescription ?? "Object added.")
            NotificationCenter.default.post(name: Notification.Name("AddedNewData"), object: nil)
        }
    }
}
