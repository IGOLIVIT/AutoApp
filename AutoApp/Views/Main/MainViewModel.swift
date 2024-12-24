//
//  MainViewModel.swift
//  AutoApp
//
//  Created by IGOR on 23/12/2024.
//

import SwiftUI
import CoreData

final class MainViewModel: ObservableObject {
    
    @AppStorage("carsCount") var carsCount: Int = 0
    @AppStorage("products") var products: Int = 0
    @AppStorage("person") var person: Int = 0

    @Published var search: String = ""
    
    func fetchCarsBySearch() -> [CarsModel] {
        
        return cars.isEmpty ? cars : search.isEmpty ? cars : cars.filter{($0.caMake ?? "").lowercased().contains(search.lowercased())}
    }
    
    @Published var images: [String] = ["im1", "im2", "im3", "im4", "im5"]
    @Published var bgs: [String] = ["im11", "im22", "im33", "im44", "im55"]
    @Published var currentImage = ""
    @Published var curBg = "im11"
    
    @AppStorage("currentCar") var currentCar: String = ""

    @AppStorage("appIm") var appIm: String = "im1"
    @AppStorage("appBg") var appBg: String = "11"

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isThemes: Bool = false
    @Published var isGarage: Bool = false
    @Published var isAddCar: Bool = false

    @Published var themes: [MainModel] = [
        
        MainModel(id: 1, image: "im1", background: "11"),
        MainModel(id: 2, image: "im2", background: "22"),
        MainModel(id: 3, image: "im3", background: "33"),
        MainModel(id: 4, image: "im4", background: "44"),
        MainModel(id: 5, image: "im5", background: "55"),

    ]

    @Published var caMake: String = ""
    @Published var caModel: String = ""
    @Published var caYear: String = ""
    @Published var caFuel: String = ""

    @Published var cars: [CarsModel] = []
    @Published var selectedCar: CarsModel?

    func addCar() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "CarsModel", into: context) as! CarsModel

        loan.caMake = caMake
        loan.caModel = caModel
        loan.caYear = caYear
        loan.caFuel = caFuel

        CoreDataStack.shared.saveContext()
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
