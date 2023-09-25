//
//  PortfolioDataService.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 25/09/23.
//

import Foundation
import CoreData

// Other Services are going to the API. This is going to the Core Data
class PortfolioDataService {
    
    // Setting up Core Data
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error Loading Core Data \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: - Public
    
    func updatePortfolio(coin: Coin, amount: Double){
//        if let entity = savedEntities.first(where: { savedEntity in
//            return savedEntity.coinID == coin.id
//        }) {
//            
//        }
        // The Above can be rewritten as
        
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: - Private
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching Portfolio Entities \(error.localizedDescription)")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
    }
    
    private func update(entity: PortfolioEntity, amount: Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data \(error.localizedDescription)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
}
