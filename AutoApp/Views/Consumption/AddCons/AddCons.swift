//
//  AddCons.swift
//  AutoApp
//
//  Created by IGOR on 24/12/2024.
//

import SwiftUI

struct AddCons: View {
    
    @StateObject var viewModel: ConsumptionViewModel
    
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
                            
                            viewModel.conDate = ""
                            viewModel.conSpent = ""
                            
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
                            
                            viewModel.products += 1
                            viewModel.carsCount += Int(viewModel.conSpent) ?? 0
                            
                            viewModel.currentCarAdd = String("\(viewModel.selectedCar?.caMake ?? "") \(viewModel.selectedCar?.caModel ?? "")")
                            
                            viewModel.conCar = viewModel.currentCarAdd
                            viewModel.conCat = viewModel.currentTypeAdd
                            
                            viewModel.addCon()
                            
                            viewModel.conDate = ""
                            viewModel.conSpent = ""
                            
                            viewModel.fetchCons()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 25, weight: .regular))
                        })
                        .opacity((viewModel.selectedCar?.caModel ?? "").isEmpty || viewModel.conSpent.isEmpty || viewModel.currentTypeAdd.isEmpty ? 0.5 : 1)
                        .disabled((viewModel.selectedCar?.caModel ?? "").isEmpty || viewModel.conSpent.isEmpty || viewModel.currentTypeAdd.isEmpty ? true : false)
                    }
                }
                .padding(.bottom, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 14) {
                        
                        Text("Amount spent")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        ZStack(content: {
                            
                            Text("0")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.conSpent.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.conSpent)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.2)))
                        
                        Text("Category")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        Menu(content: {
                            
                            ForEach(viewModel.types, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.currentTypeAdd = index
                                    
                                }, label: {
                                    
                                    Text(index)
                                })
                            }
                            
                        }, label: {
                            
                            HStack {
                                
                                HStack {
                                    
                                    Text(viewModel.currentTypeAdd)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 17, weight: .semibold))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.2)))
                                
                                Image(viewModel.currentTypeAdd)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                            }
                            
                        })
                        
                        Text("Date")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        ZStack(content: {
                            
                            Text("12/12/2024")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.conDate.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.conDate)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(0.2)))
                        
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
    AddCons(viewModel: ConsumptionViewModel())
}
