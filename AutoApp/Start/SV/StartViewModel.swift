//
//  StartViewModel.swift
//  AutoApp
//
//  Created by IGOR on 24/12/2024.
//

import SwiftUI
import CoreData

final class StartViewModel: ObservableObject {
    
    @AppStorage("status") var status: Bool = false
    
    @AppStorage("name") var name: String = ""
    @Published var addName: String = ""
    
    @AppStorage("email") var email: String = ""
    @Published var addMail: String = ""

    @Published var carMake: String = ""
    @Published var carModel: String = ""
    @Published var year: String = ""
    @Published var fuelType: String = ""

    @Published var experiences: [String] = ["I'm new", "I have basic knowledge", "I'm an experienced user"]
    @Published var currExperience = ""

    @Published var services: [String] = ["Regular maintenance", "Engine repair", "Checking the brakes"]
    @Published var currServ = ""
    
    @Published var intervals: [String] = ["Every 5,000 km", "Every 10,000 km", "Once a year", "As needed"]
    @Published var currInterval = ""
    
    @Published var methods: [String] = ["Via the app", "By phone", "In person at the service"]
    @Published var currMethod = ""
    
    @Published var notifications: [String] = ["SMS", "Email", "In-app notifications"]
    @Published var currNot = ""

}
