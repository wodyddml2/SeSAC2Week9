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
    
    private var viewModel = PersonViewModel()
    

    
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
        
        viewModel.fetchPerson(query: "mac")
        viewModel.list.bind { person in
            print("viewcontroller bind")
            self.tableView.reloadData()
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = viewModel.cellForRowAt(at: indexPath).name
        cell.detailTextLabel?.text = viewModel.cellForRowAt(at: indexPath).knownForDepartment
        return cell
    }
    
     
}
