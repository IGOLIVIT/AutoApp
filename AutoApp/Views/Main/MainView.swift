//
//  MainView.swift
//  AutoApp
//
//  Created by IGOR on 23/12/2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {

        ZStack {
            
            Color("\(viewModel.appBg)")
                .ignoresSafeArea()
            
            VStack {
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isGarage = true
                            }
                            
                        }, label: {
                            
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 25, weight: .regular))
                        })
                        .padding(.top)
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        
                        Menu(content: {
                            
                            ForEach(viewModel.cars, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedCar = index
                                    
                                    viewModel.currentCar = String("\(viewModel.selectedCar?.caMake ?? "") \(viewModel.selectedCar?.caModel ?? "")")
                                    
                                }, label: {
                                    
                                    Text("\(index.caMake ?? "") \(index.caModel ?? "")")

                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.currentCar.isEmpty {
                                
                                HStack {
                                    
                                    Text("Add car")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                }
                                
                            } else {
                                
                                HStack {
                                    
                                    Text(viewModel.currentCar)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                }
                            }
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isThemes = true
                                
                            }
                            
                        }, label: {
                            
                            Text("Change theme")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 15, weight: .regular))
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 15, weight: .semibold))
                        })
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 260)
                .background(Image(viewModel.appIm).resizable())
                
                if viewModel.cars.isEmpty {
                    
                    VStack(spacing: 16) {
                        
                        Image("empty")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                        
                        Text("Start by pressing the button +")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))

                        Text("You haven't added any entries about your car yet")
                            .foregroundColor(.gray)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 30).fill(.white))
                    .padding()
                    .padding(.top)
                    
                    Spacer()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.cars, id: \.self) { index in
                            
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
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $viewModel.isThemes, content: {
            
            ThemesView(viewModel: viewModel)
        })
        .onAppear {
            
            viewModel.fetchCars()
        }
        .sheet(isPresented: $viewModel.isGarage, content: {
            
            GarageView(viewModel: viewModel)
        })
    }
}

#Preview {
    MainView()
}
