//
//  AddCar.swift
//  AutoApp
//
//  Created by IGOR on 24/12/2024.
//

import SwiftUI

struct AddCar: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Text("Add a car")
                    .foregroundColor(.black)
                    .font(.system(size: 26, weight: .semibold))
                    .padding(.bottom)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        ZStack(content: {
                            
                            Text("Car make")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.caMake.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.caMake)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.2)))
                        
                        ZStack(content: {
                            
                            Text("Car model")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.caModel.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.caModel)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.2)))
                        
                        ZStack(content: {
                            
                            Text("Year")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.caYear.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.caYear)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.2)))
                        
                        ZStack(content: {
                            
                            Text("Fuel type")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.caFuel.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.caFuel)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.2)))
                        .padding(.bottom)
                        
                        HStack {
                            
                            Button(action: {
                                
                                viewModel.caMake = ""
                                viewModel.caModel = ""
                                viewModel.caYear = ""
                                viewModel.caFuel = ""
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAddCar = false
                                    
                                }
                                
                            }, label: {
                                
                                Text("Close")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 30).fill(Color("gray")))
                            })
                            
                            Button(action: {
                                
                                viewModel.person += 1
                                
                                viewModel.addCar()
                                
                                viewModel.caMake = ""
                                viewModel.caModel = ""
                                viewModel.caYear = ""
                                viewModel.caFuel = ""
                                
                                viewModel.fetchCars()
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAddCar = false
                                    
                                }
                                
                            }, label: {
                                
                                Text("Save")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 30).fill(Color("prim")))
                            })
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddCar(viewModel: MainViewModel())
}
