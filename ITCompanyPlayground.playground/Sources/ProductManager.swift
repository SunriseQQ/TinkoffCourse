import Foundation

public class ProductManager {
    public var name: String?
    public var developers: [Developer?]?
    public weak var ceo: Ceo?
    public  init() {
        developers = nil
        ceo = nil
    }
    //
    //    public init(name: String, developers: Developer){
    //        self.name = name
    //        self.developers = developers
    //    }
    deinit {
        print("\(name ?? "") product Manager deinit")
    }
    
    public func printDevelopers() {
        guard let  developersGuard = self.developers else {return}
        print("Developers:")
        for i in 0..<developersGuard.count {
            print("Developer \(developersGuard[i]?.name ?? "")")
        }
        print()
    }
    //из-за этого может быть цикл осторожней
    public func printCompany() {
        guard let  developersGuard = self.developers else {return}
        guard let nameGuard = self.name  else {return}
        guard let  ceoGuard = self.ceo else {return}
        print("Состав компании:")
        for i in 0..<developersGuard.count {
            print("Developer \(developersGuard[i]?.name ?? "")")
        }
        print("CEO \(ceoGuard.name ?? "")")
        print("Producr Manager \(nameGuard) \n")
    }
}

