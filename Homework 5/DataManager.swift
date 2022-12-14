//
//  DataManager.swift
//  Homework 5
//
//  Created by MacBook Pro on 13.12.2022.
//

import Foundation
import RealmSwift

struct DataManager {
    let realm = try? Realm()
    
    // MARK: - Realm
    
    func addProduct(_ productName: String) {
        let product = Product()
        product.name = productName
        
        try? realm?.write {
            realm?.add(product)
        }
    }
    
    func getProducts() -> [Product] {
        var products = [Product]()
        guard let productsResults = realm?.objects(Product.self) else {
            return [] }
        for product in productsResults {
            products.append(product)
        }
        return products
    }
    
    func deleteProduct(product: Product) {
        try? realm?.write {
            // Delete the Todo.
            realm?.delete(product)
        }
    }
}
