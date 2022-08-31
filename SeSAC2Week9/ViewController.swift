//
//  ViewController.swift
//  SeSAC2Week9
//
//  Created by J on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lottoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var list: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        LottoAPIManager.requestLotto(drwNo: 1026) { sucess, error in
            guard let sucess = sucess else {
                return
            }
           
            self.lottoLabel.text = sucess.drwNoDate
            
            
            
        }
        
        PersonAPIManager.requestPerson(query: "mac") { person, error in
            guard let person = person else {
                return
            }
            self.list = person
            self.tableView.reloadData()
            dump(person)
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = list?.results[indexPath.row].name
        cell.detailTextLabel?.text = list?.results[indexPath.row].knownForDepartment
        return cell
    }
    
     
}
