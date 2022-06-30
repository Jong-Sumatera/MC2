//
//  DashboardViewController.swift
//  MC2
//
//  Created by Clara Evangeline on 29/06/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var result : [File] = []
    var context = PersistenceController.shared.container.viewContext
    func fetchFiles() {
        do {
            result = try context.fetch(File.fetchRequest())
            print("blablabla", result)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFiles()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        var rowContent = cell.defaultContentConfiguration()
//        rowContent.text = result[indexPath.row].fileName
        print("ada apa denganmu",result[indexPath.row].fileName)
        cell.textLabel!.text = result[indexPath.row].fileName
        cell.textLabel?.textColor = UIColor.black
        return cell
    }
}

