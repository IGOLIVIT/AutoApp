//
//  ServiceView.swift
//  AutoApp
//
//  Created by IGOR on 23/12/2024.
//

import SwiftUI

struct ServiceView: View {

    @StateObject var viewModel = ServiceViewModel()
    
    var body: some View {

        ZStack {
            
            Color("\(viewModel.appBg)")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Car service")
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
                
                if viewModel.services.isEmpty {
                    
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
                            
                            ForEach(viewModel.services, id: \.self) { index in
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    
                                    Text(index.seType ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .medium))
                                    
                                    HStack {
                                        
                                        Text("Date")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Text(index.seDate ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                    
                                    HStack {
                                        
                                        Text("Car mileage")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Text(index.seMil ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                    
                                    HStack {
                                        
                                        Text("Car")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Text(index.seCar ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                    
                                    Button(action: {
                                        
                                        viewModel.selectedServ = index
                                        
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
            .padding()
        }
        .onAppear {
            
            viewModel.fetchServs()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddService(viewModel: viewModel)
        })
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
                            
                            CoreDataStack.shared.deleteServ(withSeMil: viewModel.selectedServ?.seMil ?? "", completion: {
                                
                                viewModel.fetchServs()
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
    ServiceView()
}
