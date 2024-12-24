//
//  GarageView.swift
//  AutoApp
//
//  Created by IGOR on 24/12/2024.
//

import SwiftUI

struct GarageView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {

        ZStack {
            
            Color("bg2")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Garage")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .regular))
                    
                    HStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCar = true
                            }
                            
                        }, label: {
                            
                            Text("Add +")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .regular))
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isGarage = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 24, weight: .regular))
                                .rotationEffect(.degrees(45))
                        })
                    }
                }
                .padding(.bottom, 30)
                
                HStack {
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Search")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .regular))
                            .opacity(viewModel.search.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.search)
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .regular))
                    })
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .regular))
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .padding(.bottom)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        ForEach(viewModel.fetchCarsBySearch(), id: \.self) { index in
                        
                            Button(action: {
                                
                                viewModel.selectedCar = index
                                
                                viewModel.currentCar = String("\(viewModel.selectedCar?.caMake ?? "") \(viewModel.selectedCar?.caModel ?? "")")
                                
                            }, label: {
                                
                                VStack(alignment: .leading, spacing: 14) {
                                    
                                    HStack {
                                        
                                        Text(index.caMake ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .regular))
                                        
                                        Text(index.caModel ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Image("checkmark")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 22)
                                            .opacity(viewModel.selectedCar == index ? 1 : 0)
                                    }
                                    
                                    HStack {
                                        
                                        Text("Year")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Text(index.caYear ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .regular))
                                    }
                                    
                                    HStack {
                                        
                                        Text("Fuel type")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Text(index.caFuel ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .regular))
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                            })
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchCars()
        }
        .sheet(isPresented: $viewModel.isAddCar, content: {
            
            AddCar(viewModel: viewModel)
        })
    }
}

#Preview {
    GarageView(viewModel: MainViewModel())
}
