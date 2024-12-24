//
//  Start1.swift
//  AutoApp
//
//  Created by IGOR on 23/12/2024.
//

import SwiftUI

struct Start1: View {
    
    @StateObject var viewModel = StartViewModel()
    
    var body: some View {

        ZStack {
            
            Image("b1")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                VStack(spacing: 14) {
                    
                    Text("Welcome!")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .bold))
                    
                    Text("Enter your name and email address.")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .regular))
                        .padding(.bottom)
                    
                    ZStack(content: {
                        
                        Text("Name")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.addName.isEmpty ? 1 : 0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("", text: $viewModel.addName)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .medium))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 7).fill(.white))
                    
                    ZStack(content: {
                        
                        Text("e-mail")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.addMail.isEmpty ? 1 : 0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("", text: $viewModel.addMail)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .medium))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 7).fill(.white))
                    
                    NavigationLink(destination: {
                        
                        Start2()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        Text("Continue")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color("prim")))
                        
                    })
                    .padding(.vertical)
                    
                    Button(action: {
                        
                        viewModel.status = true
                        
                    }, label: {
                        
                        Text("Сontinue without registration")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .regular))
                    })
                    .padding(.top)
                }
                .padding()
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 30).fill(Color("fbg").opacity(0.5)))
                .padding()
            }
        }
    }
}

#Preview {
    Start1()
}
