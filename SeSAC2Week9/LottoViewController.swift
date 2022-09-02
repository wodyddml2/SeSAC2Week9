//
//  LottoViewController.swift
//  SeSAC2Week9
//
//  Created by J on 2022/09/01.
//

import UIKit

class LottoViewController: UIViewController {
    @IBOutlet weak var lotto1: UILabel!
    @IBOutlet weak var lotto2: UILabel!
    @IBOutlet weak var lotto3: UILabel!
    @IBOutlet weak var lotto4: UILabel!
    @IBOutlet weak var lotto5: UILabel!
    @IBOutlet weak var lotto6: UILabel!
    @IBOutlet weak var lotto7: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewModel = LottoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.fetchLottoAPI(drwNo: 1000)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.viewModel.fetchLottoAPI(drwNo: 1023)
        }
        bindData()
    }
    
    func bindData() {
        viewModel.number1.bind { value in
            self.lotto1.text = "\(value)"
        }
        viewModel.number2.bind { value in
            self.lotto2.text = "\(value)"
        }
        viewModel.number3.bind { value in
            self.lotto3.text = "\(value)"
        }
        viewModel.number4.bind { value in
            self.lotto4.text = "\(value)"
        }
        viewModel.number5.bind { value in
            self.lotto5.text = "\(value)"
        }
        viewModel.number6.bind { value in
            self.lotto6.text = "\(value)"
        }
        viewModel.number7.bind { value in
            self.lotto7.text = "\(value)"
        }
        viewModel.lottoMoney.bind { value in
            self.dateLabel.text = "\(value)"
        }
        
    }
    

}
