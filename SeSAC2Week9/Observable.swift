import Foundation

class Observable<T> { // 양방향 바인딩 - didSet처럼 한쪽에서만 바꿔주는 단방향이 아니라 서로 영향을 줄 수 있도록
    // MVVM을 위함, 확장되면 RxSwift라고 생각하면 됌
    // 여러 곳에서 사용해야 MVVM패턴
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didSet \(value)")
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
        print(#function)
    }
 
}

//class User {
//
//
//
//    private var listener: ((String) -> Void)?
//
//    var value: String {
//        didSet {
//            print("데이터 체인지")
//            listener?(value)
//        }
//    }
//
//    init(value: String) {
//        self.value = value
//    }
//}
