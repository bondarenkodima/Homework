//
//  ViewController.swift
//  Homework 5
//
//  Created by MacBook Pro on 13.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // задаем название контроллера
        self.title = "Список покупок:"
        
        // регистрация ячейки
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // вытягивание данных при загрузке экрана
        self.products = DataManager().getProducts()
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        // создание алерт контроллер
        let alert = UIAlertController(title: "Продукты", message: "Добавьте продукты в список", preferredStyle: .alert)
        
        // создание кнопки save с замыканием - выполнится по нажатию кнопки
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            action in
            // проверка есть ли в алерт контроллере текстфилд и есть в нем текст
            guard let textField = alert.textFields?.first,
                  let productToSave = textField.text, !productToSave.isEmpty else {
                return
            }
            
            // вызываем функцию сохранения
            DataManager().addProduct(productToSave)
            
            //обновляем данные в проперти products и перезагружаем данные в таблице
            self.products = DataManager().getProducts()
            self.tableView.reloadData()
            
            // таблица по умолчанию подтягивает данные из проперти products
            // обновить состояние и подтянет свежие данные
        }
        
        // создаем кнопку cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // добавляем текстфилд
        alert.addTextField()
        
        // добавляем кнопки в алерт контроллер
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        // показать алерт контроллер
        present(alert, animated: true)
    }
}


extension ViewController: UITableViewDataSource {
    // метод  в котором указываем кол-во ячеек (rows) в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    // метод в котором создаем каждую ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = self.products[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = product.name
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit cell: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if cell == UITableViewCell.EditingStyle.delete{
            let product = self.products[indexPath.row]
            DataManager().deleteProduct(product: product)
            self.products = DataManager().getProducts()
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

