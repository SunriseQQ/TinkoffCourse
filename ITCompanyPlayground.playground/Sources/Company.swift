import Foundation

public class Company {
    
    public weak var ceo: Ceo?
    public weak var productManager: ProductManager?
    public  var developers: [Developer?]?
    
    public init(){
        ceo = nil
        productManager = nil
        developers = nil
    }
    
    public init(ceo: Ceo, productManager: ProductManager,developers: [Developer?]?){
        self.ceo = ceo
        self.productManager = productManager
        self.developers = developers
    }
    
    public func returnCompany() -> Company{
        guard let developersGuard = self.developers else {return(Company())}
        guard let productManagerGuard = self.productManager else {return(Company())}
        guard let ceoGuard = self.ceo else {return(Company())}
        
        return(Company(ceo:ceoGuard, productManager: productManagerGuard, developers: developersGuard))
    }
    
    //   public func copy(with zone: NSZone? = nil) -> Company {
    //        guard let developersGuard = self.developers else {return(Company())}
    //        guard let productManagerGuard = self.productManager else {return(Company())}
    //        guard let ceoGuard = self.ceo else {return(Company())}
    //           let copy = Company(ceo:ceoGuard, productManager: productManagerGuard, developers: developersGuard)
    //           return copy
    //       }
    
    public func simulationChat() {
        print("Симуляция чата")
        guard let developersGuard = self.developers else {return}
        guard let productManagerGuard = self.productManager else {return}
        guard let ceoGuard = self.ceo else {return}
        switch developersGuard.count {
        case 1:
            developersGuard[0]?.sendMessageToCeo()
            print("\(ceoGuard.name ?? ""): \(developersGuard[0]?.name ?? "") нет, не повышу")
            developersGuard[0]?.sendMessageToProductManager()
            print("\(productManagerGuard.name ?? ""):\(developersGuard[0]?.name ?? ""), пожалуйтса, ожидайте")
        case 2...:
            developersGuard[0]?.sendMessageToCeo()
            print("\(ceoGuard.name ?? ""): \(developersGuard[0]?.name ?? "") нет, не повышу")
            developersGuard[0]?.sendMessageToProductManager()
            print("\(productManagerGuard.name ?? ""): \(developersGuard[0]?.name ?? ""), пожалуйтса, ожидайте")
            developersGuard[0]?.sendMessageToDevelopersUsePM(name: developersGuard[1]?.name ?? "")
            developersGuard[1]?.sendMessageToDeveloper(developer: developersGuard[0], numberOfMessage: 4)
            
        default:
            print("No developers in this company")
        }
        print("Симуляция чата окончена \n")
    }
}
