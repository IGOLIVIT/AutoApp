//
//  ConsumptionView.swift
//  AutoApp
//
//  Created by IGOR on 23/12/2024.
//

import SwiftUI

struct ConsumptionView: View {
    
    @StateObject var viewModel = ConsumptionViewModel()
    
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
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 25, weight: .regular))
                        })
                    }
                }
                .padding(.bottom, 30)
                
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("$\(viewModel.carsCount)")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .bold))
                    
                    HStack {
                        
                        Text("Number of products")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .medium))
                        
                        Spacer()
                        
                        Text("\(viewModel.products)")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .medium))
                    }
                    
                    HStack {
                        
                        Text("Person")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .medium))
                        
                        Spacer()
                        
                        Text("\(viewModel.person)")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .medium))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 30).fill(Color("prim")))
                
                if viewModel.consumptions.isEmpty {
                    
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
                    .padding(.top)
                    
                    Spacer()
                    
                } else {
                    
                    if viewModel.consumptions.filter({($0.conCat ?? "") == viewModel.currentTypeFilter}).isEmpty {
                        
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
                        .padding(.top)
                        
                        Spacer()
                        
                    } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.consumptions.filter({($0.conCat ?? "") == viewModel.currentTypeFilter}).filter{($0.conCar ?? "") == viewModel.currentCar}, id: \.self) { index in
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    
                                    Text(index.conCat ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .medium))
                                    
                                    HStack {
                                        
                                        Text("Date")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Text(index.conDate ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                    
                                    HStack {
                                        
                                        Text("Total price")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Text(index.conSpent ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                    
                                    HStack {
                                        
                                        Text("Car")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Text(index.conCar ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                    
                                    Button(action: {
                                        
                                        viewModel.selectedCons = index
                                        
                                        withAnimation(.spring()) {
                                            
                                            viewModel.isDelete = true
                                        }
                                        
                                    }, label: {
                                        
                                        Text("Delete")
                                            .foregroundColor(.white)
                                            .font(.system(size: 17, weight: .semibold))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 50)
                                            .background(RoundedRectangle(cornerRadius: 30).fill(Color("gray")))
                                    })
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                            }
                        }
                    }
                }
                }
            }
            .padding()
            
            VStack {
                
                Spacer()
                
                HStack {
                    
                    ForEach(viewModel.types, id: \.self) { index in
                    
                        Button(action: {
                            
                            viewModel.currentTypeFilter = index
                            
                        }, label: {
                            
                            VStack {
                                
                                Image(index)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 26)
                                
                                Text(index)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                                    .fixedSize()
                                    .rotationEffect(.degrees(90))
                                    .frame(height: 90)
                                
                                Spacer()
                            }
                            .padding(7)
                            .frame(width: 33, height: 200)
                            .background(RoundedRectangle(cornerRadius: 10).fill(viewModel.currentTypeFilter == index ? Color("prim2") : .white))
                        })
                    }
                }
            }
            .padding(.horizontal)
            .ignoresSafeArea()
        }
        .onAppear {
            
            viewModel.fetchCons()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddCons(viewModel: viewModel)
        })
        .onAppear {
            
            viewModel.fetchCars()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack(spacing: 19) {

                    Text("Do you want to delete?")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        
                        Button(action: {
                            
                            CoreDataStack.shared.deleteCons(withConSpent: viewModel.selectedCons?.conSpent ?? "", completion: {
                                
                                viewModel.fetchCons()
                            })
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Text("Delete")
                                .foregroundColor(.red)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Text("Cancel")
                                .foregroundColor(.black)
                                .font(.system(size: 17, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })
                    }
                    .padding(.top, 25)

                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    ConsumptionView()
}
