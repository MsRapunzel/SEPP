//
//  PortfolioDataService.swift
//  CryptoiOS
//
//  Created by Anastasiia Zolotova on 28.05.2024.
//

import Foundation
import CoreData

/// Handles the core data operations for the portfolio.
class PortfolioDataService {
    
    /// Core Data persistent container.
    private let container: NSPersistentContainer
    /// The name of the Core Data container.
    private let containerName: String = "PortfolioContainer"
    /// The name of the Core Data entity.
    private let entityName: String = "PortfolioEntity"
    
    /// Published array of saved portfolio entities.
    @Published var savedEntities: [PortfolioEntity] = []
    
    /// Initializes a new PortfolioDataService and loads persistent stores.
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: PUBLIC
    
    /// Updates the portfolio with a specified coin and amount.
    /// - Parameters:
    ///   - coin: The coin to update.
    ///   - amount: The amount to update.
    func updatePortfolio(coin: CoinModel, amount: Double) {
        // check if coin is already in portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: PRIVATE
    
    /// Fetches the portfolio from the Core Data container.
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    /// Adds a new coin to the portfolio.
    /// - Parameters:
    ///   - coin: The coin to add.
    ///   - amount: The amount to add.
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    /// Updates an existing portfolio entity with a new amount.
    /// - Parameters:
    ///   - entity: The entity to update.
    ///   - amount: The new amount.
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    /// Deletes an entity from the portfolio.
    /// - Parameter entity: The entity to delete.
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    /// Saves the current context to the Core Data container.
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    /// Applies changes to the Core Data context and fetches the updated portfolio.
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
    
    
}
