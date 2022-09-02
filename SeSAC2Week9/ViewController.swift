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
        
        let example = User("칙촉")
        
        example.bind { name in
            print("이름이 \(name)바뀌었습니다.")
        }
        
        example.value = "고래밥"
        
        let example12 = User([1,2,3])
        
        example12.bind { a in
            print(a)
        }
        
        var number1 = 10
        var number2 = 3
        
        print(number1 - number2)
        
        number1 = 3
        number2 = 1
        
        var number3 = Observable(10)
        var number4 = Observable(3)

        number3.bind { a in
            print("Observable",number3.value - number4.value)
        }
        
        number3.value = 100
        number3.value = 200
        number3.value = 50
        
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
