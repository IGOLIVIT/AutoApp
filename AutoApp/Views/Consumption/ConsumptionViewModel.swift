//
//  ConsumptionViewModel.swift
//  AutoApp
//
//  Created by IGOR on 24/12/2024.
//

import SwiftUI
import CoreData

final class ConsumptionViewModel: ObservableObject {
    
    @AppStorage("carsCount") var carsCount: Int = 0
    @AppStorage("products") var products: Int = 0
    @AppStorage("person") var person: Int = 0
    
    @Published var types: [String] = ["Toll road", "Repair", "Car wash", "Insurance", "Parking", "Taxes and fees", "Tire service", "Car spare parts", "Accessories"]
    @Published var currentType = ""
    @Published var currentTypeFilter = "Parking"
    @Published var currentTypeAdd = "Parking"

    @AppStorage("appIm") var appIm: String = "im1"
    @AppStorage("appBg") var appBg: String = "11"

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isThemes: Bool = false

    @Published var themes: [MainModel] = [
        
        MainModel(id: 1, image: "im1", background: "11"),
        MainModel(id: 2, image: "im2", background: "22"),
        MainModel(id: 3, image: "im3", background: "33"),
        MainModel(id: 4, image: "im4", background: "44"),
        MainModel(id: 5, image: "im5", background: "55"),

    ]
    
    @AppStorage("currentCar") var currentCar: String = ""
    @Published var currentCarAdd: String = ""
    
    @Published var cars: [CarsModel] = []
    @Published var selectedCar: CarsModel?

    @Published var conCar: String = ""
    @Published var conSpent: String = ""
    @Published var conDate: String = ""
    @Published var conCat: String = ""

    @Published var consumptions: [ConsModel] = []
    @Published var selectedCons: ConsModel?

    func addCon() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "ConsModel", into: context) as! ConsModel

        loan.conCar = conCar
        loan.conSpent = conSpent
        loan.conDate = conDate
        loan.conCat = conCat

        CoreDataStack.shared.saveContext()
    }

    func fetchCons() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ConsModel>(entityName: "ConsModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.consumptions = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.consumptions = []
        }
    }
    
    func fetchCars() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CarsModel>(entityName: "CarsModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.cars = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.cars = []
        }
    }
}
