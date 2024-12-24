//
//  Start6.swift
//  AutoApp
//
//  Created by IGOR on 23/12/2024.
//

import SwiftUI

struct Start6: View {

    @StateObject var viewModel = StartViewModel()
    
    var body: some View {

        ZStack {
            
            Image("b6")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                VStack(spacing: 14) {
                    
                    Text("Which method of signing up for service is most convenient for you?")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    ForEach(viewModel.methods, id: \.self) { index in
                        
                            Button(action: {
                                
                                viewModel.currMethod = index
                                
                            }, label: {
                                
                                Text(index)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 16, weight: .regular))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 7).fill(viewModel.currMethod == index ? Color("cbg") : .white))
                            })
                    }
                    
                    NavigationLink(destination: {
                        
                        Start7()
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
    Start6()
}
