//
//  ServiceViewModel.swift
//  AutoApp
//
//  Created by IGOR on 24/12/2024.
//

import SwiftUI
import CoreData

final class ServiceViewModel: ObservableObject {
    
    @Published var cars: [CarsModel] = []
    @Published var selectedCar: CarsModel?
    
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
    
    @AppStorage("carsCount") var carsCount: Int = 0
    @AppStorage("products") var products: Int = 0
    @AppStorage("person") var person: Int = 0
    
    @Published var types: [String] = ["headlights", "engine", "rubber", "brakes", "car paint", "car interrior"]
    @Published var currentType = ""

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

    @Published var seMil: String = ""
    @Published var seDate: String = ""
    @Published var seCar: String = ""
    @Published var seType: String = ""

    @Published var services: [ServModel] = []
    @Published var selectedServ: ServModel?

    func addServ() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "ServModel", into: context) as! ServModel

        loan.seMil = seMil
        loan.seDate = seDate
        loan.seCar = seCar
        loan.seType = seType

        CoreDataStack.shared.saveContext()
    }

    func fetchServs() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ServModel>(entityName: "ServModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.services = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.services = []
        }
    }
}
