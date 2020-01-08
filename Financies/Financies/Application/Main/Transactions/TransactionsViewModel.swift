//
//  TransactionsViewModel.swift
//  Financies
//
//  Created by Juan on 1/8/20.
//  Copyright © 2020 Juan. All rights reserved.
//

import Foundation
import FinanciesCore
import FirebaseAuth
import FirebaseFirestore

protocol TransactionsViewModelDelegate {
    func reloadData()
}

class TransactionsViewModel {
    private var items: [FinanciesCore.Transaction] = []
    
    private var db: Firestore {
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        settings.isPersistenceEnabled = true
        db.settings = settings
        return db
    }
    
    var numberOfItems: Int {
        return items.count
    }
    
    var delegate: TransactionsViewModelDelegate?
    
    init() {
        getData()
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: Notification.Name("AddedNewData"), object: nil)
    }
    
    @objc private func getData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("transactions").whereField("ownerID", isEqualTo: uid).order(by: "date", descending: true).addSnapshotListener { [weak self] (snapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.items.removeAll()
            
            try? snapshot?.documents.forEach({ (snapshot) in
                let json = snapshot.data()
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                
                guard let transaction = try? JSONDecoder().decode(Transaction.self, from: jsonData) else {
                    return
                }
                
                transaction.firebaseID = snapshot.documentID
                
                self.items.append(transaction)
            })
            
            self.delegate?.reloadData()
        }
    }
    
    func item(at indexPath: IndexPath) -> TransactionViewModel {
        return TransactionViewModel(transaction: items[indexPath.row])
    }
    
    func remove(at indexPath: IndexPath) {
        let item = items.remove(at: indexPath.row)
        guard let firebaseID = item.firebaseID else { return }
        db.collection("transactions").document(firebaseID).delete()
    }
}

class TransactionViewModel {
    private var transaction: FinanciesCore.Transaction
    
    var name: String {
        return transaction.name
    }
    
    var value: String {
        return transaction.value.currency()
    }
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: transaction.date)
    }
    
    var time: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: transaction.date)
    }
    
    init(transaction: FinanciesCore.Transaction) {
        self.transaction = transaction
    }
}
