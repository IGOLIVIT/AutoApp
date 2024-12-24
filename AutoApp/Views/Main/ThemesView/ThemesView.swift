//
//  ThemesView.swift
//  AutoApp
//
//  Created by IGOR on 23/12/2024.
//

import SwiftUI

struct ThemesView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("\(viewModel.appBg)")
                .ignoresSafeArea()
            
            VStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
           
                    ForEach(viewModel.themes, id: \.self) { index in
                    
                        Button(action: {
                            
                            viewModel.curBg = index.background
                            viewModel.appBg = index.background
                            viewModel.appIm = index.image
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(index.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("\(index.background)"))
                                    
                                    Image("checkmark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40)
                                        .shadow(color: .black, radius: 10)
                                        .opacity(viewModel.curBg == index.background ? 1 : 0)
                                }
                            }
                        })
                    }
                }
                
                HStack {
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isThemes = false
                            
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
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isThemes = false
                            
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
            .padding()
        }
    }
}

#Preview {
    ThemesView(viewModel: MainViewModel())
}
