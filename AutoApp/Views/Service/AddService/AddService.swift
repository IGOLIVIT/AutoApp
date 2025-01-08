//
//  AddService.swift
//  AutoApp
//
//  Created by IGOR on 24/12/2024.
//

import SwiftUI

struct AddService: View {

    @StateObject var viewModel: ServiceViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("\(viewModel.appBg)")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Consumption")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                    
                    HStack {
                        
                        Button(action: {
                            
                       
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Text("Cancel")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                            viewModel.currentCarAdd = String("\(viewModel.selectedCar?.caMake ?? "") \(viewModel.selectedCar?.caModel ?? "")")
                            
                            viewModel.seCar = viewModel.currentCarAdd
                            
                            viewModel.seType = viewModel.currentType
                            
                            viewModel.addServ()
                            
                            viewModel.seMil = ""
                            viewModel.seDate = ""
                            viewModel.currentType = ""
                            
                            viewModel.fetchServs()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 25, weight: .regular))
                        })
                        .opacity(viewModel.seMil.isEmpty || viewModel.seDate.isEmpty || viewModel.currentType.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.seMil.isEmpty || viewModel.seDate.isEmpty || viewModel.currentType.isEmpty ? true : false)
                    }
                }
                .padding(.bottom, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 14) {
                        
                        Text("Car mileage")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        ZStack(content: {
                            
                            Text("0")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.seMil.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.seMil)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.2)))
                        
                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                Text("Date")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .medium))
                                
                                ZStack(content: {
                                    
                                    Text("12/12/2024")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.seDate.isEmpty ? 1 : 0)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    TextField("", text: $viewModel.seDate)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.2)))
                                
                            }
                            
                            VStack(alignment: .leading) {

                                Text("Number of owners")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .medium))
                                
                                ZStack(content: {
                                    
                                    Text("0")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.seOwn.isEmpty ? 1 : 0)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    TextField("", text: $viewModel.seOwn)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.2)))
                                
                            }
                        }

                        Text("Car")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        Menu(content: {
                            
                            ForEach(viewModel.cars, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selectedCar = index
                                    
                                }, label: {
                                    
                                    Text(index.caModel ?? "")
                                })
                            }
                            
                        }, label: {
                            
                            HStack {
                                
                                HStack {
                                    
                                    Text(viewModel.selectedCar?.caModel ?? "")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                    Spacer()
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.2)))
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 17, weight: .semibold))
                            }
                            
                        })
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.types, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.currentType = index
                                    
                                }, label: {
                                    
                                    Text(index)
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .semibold))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(RoundedRectangle(cornerRadius: 30).fill(viewModel.currentType == index ? Color("11") : Color("prim")))
                                })
                            }
                        })
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 30).fill(.white))
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchCars()
        }
    }
}

#Preview {
    AddService(viewModel: ServiceViewModel())
}
