import Foundation

public class Developer {
    public var name: String?
    public weak  var productManager: ProductManager?
    public weak var company: Company?
    
    public let nameKeyPath = \Developer.name
    
    public init() {
        name = nil
        productManager = nil
    }
    
    //    public init(name: String){
    //         self.name = name
    //     }
    
    deinit {
        print("\(name ?? "") developer deinit")
    }
    
    //Поиск других разработчиков
    public func findOthers() {
        // let nameKeyPath = \Developer.name
        guard let  productManagerGuard = self.productManager else {return}
        guard let  developersGuard = productManagerGuard.developers else {return}
        for i in 0..<developersGuard.count {
            if developersGuard[i]?[keyPath: nameKeyPath] != self.name?[keyPath: \.self] {
                print("Developer \(developersGuard[i]?[keyPath: nameKeyPath] ?? "") also developer and you can write him")
            }
        }
        print()
    }
    //отправка сообщений разработчику напрямую
    public func sendMessageToDeveloper(developer: Developer?, numberOfMessage: Int){
        if developer?[keyPath: nameKeyPath] == self.name?[keyPath: \.self]{
            return(print("You cant write yourself"))
        }
        //let nameKeyPath = \Developer.name
        switch numberOfMessage {
        case 1:
            print("\(self.name?[keyPath: \.self] ?? ""): \(developer?[keyPath: nameKeyPath] ?? ""), ты говнокодер!")
        case 2:
            print("\(self.name?[keyPath: \.self] ?? ""): Я отправил тебе pull-request,\(developer?[keyPath: nameKeyPath] ?? "")")
        case 3:
            print("\(self.name?[keyPath: \.self] ?? ""): Я так устал от нашего CEO,а ты,\(developer?[keyPath: nameKeyPath] ?? "")?")
        case 4:
            print("\(self.name?[keyPath: \.self] ?? ""): Сам такой \(developer?[keyPath: nameKeyPath] ?? "")")
        default:
            print("\(self.name?[keyPath: \.self] ?? ""): Used unknown numberOfMessage for \(developer?[keyPath: nameKeyPath] ?? "")")
        }
    }
    
    //отправка сообщений разработчикам через PM 8(пункт ТЗ)
    //без указания параметра можно организовать рассылку всем остальным разработчикам
    //Вариант с любым параметром поможет найти нужного нам разработчика через РМ(получить именна разработчиков: func findOthers() )
    public func sendMessageToDevelopersUsePM() {
        guard let  productManagerGuard = self.productManager else {return}
        guard let  developersGuard = productManagerGuard.developers else {return}
        for i in 0..<developersGuard.count {
            if developersGuard[i]?[keyPath: nameKeyPath] != self.name?[keyPath: \.self] {
                print("\(self.name?[keyPath: \.self] ?? ""): Developer \(developersGuard[i]?[keyPath: nameKeyPath] ?? "") check GitHub, I posted a new commit")
            }
        }
    }
    public func sendMessageToDevelopersUsePM(name: String) {
        guard let  productManagerGuard = self.productManager else {return}
        guard let  developersGuard = productManagerGuard.developers else {return}
        for i in 0..<developersGuard.count {
            if developersGuard[i]?[keyPath: nameKeyPath] == name  {
                print("\(self.name?[keyPath: \.self] ?? ""): Developer \(developersGuard[i]?[keyPath: nameKeyPath] ?? "") ты говнокодер!")
            }
        }
        //использовать в случае создания шаблонных фраз
        //        switch numberOfMessage {
        //        case 1:
        //            print("\(developer?[keyPath: nameKeyPath] ?? ""), ты говнокодер!")
        //        case 2:
        //            print("Я отправил тебе pull-request,\(developer?[keyPath: nameKeyPath] ?? "")")
        //        case 3:
        //            print("Я так устал от нашего CEO,а ты,\(developer?[keyPath: nameKeyPath] ?? "")?")
        //        default:
        //            print("Used unknown numberOfMessage for  \(developer?[keyPath: nameKeyPath] ?? "")")
        //        }
    }
    
    //отправка сообщения CEO
    public func sendMessageToCeo(){
        guard let  productManagerGuard = self.productManager else {return}
        guard let  ceoGuard = productManagerGuard.ceo else {return}
        print("\(self.name?[keyPath: \.self] ?? ""): \(ceoGuard.name ?? ""),наш великий CEO,прошу повысить мне зарплату" )
    }
    //отправка сообщения PM
    public func sendMessageToProductManager(){
        guard let  productManagerGuard = self.productManager else {return}
        print("\(self.name?[keyPath: \.self] ?? ""): \(productManagerGuard.name ?? ""), дорогой PM, отправь ТЗ пожалуйста")
    }
}

