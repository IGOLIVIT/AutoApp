//
//  SettingsView.swift
//  AutoApp
//
//  Created by IGOR on 23/12/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {

    @StateObject var viewModel = MainViewModel()
    
    var body: some View {

        ZStack {
            
            Color("\(viewModel.appBg)")
                .ignoresSafeArea()
            
            VStack {
                
                VStack {
                    
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
                .padding(.bottom)

                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 15) {
                            
                            Button(action: {
                                
                                SKStoreReviewController.requestReview()
                                
                            }, label: {
                                
                                Text("Rate App")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 30).fill(Color("prim")))
                            })
                            
                            Button(action: {
                                
                                guard let url = URL(string: "https://www.termsfeed.com/live/96472a23-009f-4da2-b970-8f4b2d4b9810") else { return }
                                
                                UIApplication.shared.open(url)
                                
                            }, label: {
                                
                                Text("Usage Policy")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 30).fill(Color("prim")))
                            })
                        }
                        .padding()
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
    SettingsView()
}
