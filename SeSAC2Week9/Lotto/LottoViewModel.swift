import Foundation

class LottoViewModel {
    var number1 = Observable(1)
    var number2 = Observable(2)
    var number3 = Observable(3)
    var number4 = Observable(4)
    var number5 = Observable(5)
    var number6 = Observable(6)
    var number7 = Observable(7)
    var lottoMoney = Observable("당첨금")
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    func fetchLottoAPI(drwNo: Int) {
        LottoAPIManager.requestLotto(drwNo: drwNo) { sucess, error in
            guard let sucess = sucess else {
                return
            }
           
            self.number1.value = sucess.drwtNo1
            self.number2.value = sucess.drwtNo2
            self.number3.value = sucess.drwtNo3
            self.number4.value = sucess.drwtNo4
            self.number5.value = sucess.drwtNo5
            self.number6.value = sucess.drwtNo6
            self.number7.value = sucess.bnusNo
            self.lottoMoney.value = self.format(for: sucess.totSellamnt)
        }
    }
}
