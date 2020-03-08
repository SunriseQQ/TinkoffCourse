import UIKit
import Foundation

var developer1: Developer? = Developer()
var developer2: Developer? = Developer()
var productManager: ProductManager? = ProductManager()
var ceo: Ceo? = Ceo()
var company: Company? = Company()
var newCompany: Company? = Company()
//developer1 nameKeyPath = \Developer.name

company?.ceo = ceo
company?.productManager = productManager
company?.developers = [developer1,developer2]

ceo?.name = "Jonathan"
ceo?.productManager = company?.productManager

productManager?.name = "Josuke"
productManager?.ceo = company?.ceo
productManager?.developers = company?.developers

developer1?.productManager = company?.productManager
developer1?.name = "Joseph "
developer2?.name = "Jotaro"
developer2?.productManager = company?.productManager

ceo?.printProductManager()
ceo?.printCompany()
ceo?.printDevelopers()

developer2?.findOthers()
developer1?.sendMessageToDeveloper(developer: developer2, numberOfMessage: 1)
developer1?.sendMessageToCeo()
developer1?.sendMessageToProductManager()
developer1?.sendMessageToDevelopersUsePM()
developer1?.sendMessageToDevelopersUsePM(name: "Jotaro")

newCompany = company?.returnCompany()
newCompany?.simulationChat()

newCompany = nil
company = nil
ceo = nil
developer2 = nil
developer1 = nil
productManager = nil

