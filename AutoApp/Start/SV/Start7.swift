//
//  Start7.swift
//  AutoApp
//
//  Created by IGOR on 23/12/2024.
//

import SwiftUI

struct Start7: View {

    @StateObject var viewModel = StartViewModel()
    
    var body: some View {

        ZStack {
            
            Image("b7")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                VStack(spacing: 14) {
                    
                    Text("What is your preferred method of receiving vehicle status notifications?")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    ForEach(viewModel.notifications, id: \.self) { index in
                        
                            Button(action: {
                                
                                viewModel.currNot = index
                                
                            }, label: {
                                
                                Text(index)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 16, weight: .regular))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 7).fill(viewModel.currNot == index ? Color("cbg") : .white))
                            })
                    }
                    
                    Button(action: {
                        
                        viewModel.status = true
                        
                    }, label: {
                        
                        Text("Continue")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color("prim")))
                        
                    })
                    .padding(.vertical)

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
    Start7()
}
