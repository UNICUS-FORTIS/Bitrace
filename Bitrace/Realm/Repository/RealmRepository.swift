//
//  RealmRepository.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/23/24.
//

import Foundation
import RealmSwift

final class RealmRepository {
    
    static let shared = RealmRepository()
    private init() { }
    
    private let realm = try! Realm()
    
    func fetchBookmarks() -> Results<BookMark> {
        return realm.objects(BookMark.self)
    }
    
    func toggleDatabaseSave(market: CoinMarketModel) {
        
        guard let stored = realm.objects(BookMark.self).first(where: { $0.marketCode == market.market}) else {
        
            self.saveMarket(market: market)
            
            return
        }
        self.removeMarket(market: stored)
    }
    
    private func saveMarket(market: CoinMarketModel) {
        do {
            try realm.write {
                let data = BookMark(code: market.market,
                                    marketName: market.koreanName)
                realm.add(data)
            }
        } catch {
            print("저장 실패")
        }
    }
    
    private func removeMarket(market: BookMark) {
        do {
            try realm.write {
                realm.delete(market)
            }
        } catch {
            print("삭제 실패")
        }
    }
    
    func checkStoredMarket(market: CoinMarketModel) -> Bool {
        guard let _ = realm.objects(BookMark.self).first(where: { $0.marketCode == market.market}) else {
            return false
        }
        return true
    }
    
    func checkRealmDirectory() {
        print(#function)
        print(realm.configuration.fileURL!)
    }
}
