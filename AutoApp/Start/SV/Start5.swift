//
//  Start5.swift
//  AutoApp
//
//  Created by IGOR on 23/12/2024.
//

import SwiftUI

struct Start5: View {

    @StateObject var viewModel = StartViewModel()
    
    var body: some View {

        ZStack {
            
            Image("b5")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                VStack(spacing: 14) {
                    
                    Text("How often do you service your car?")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    ForEach(viewModel.intervals, id: \.self) { index in
                        
                            Button(action: {
                                
                                viewModel.currInterval = index
                                
                            }, label: {
                                
                                Text(index)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 16, weight: .regular))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 7).fill(viewModel.currInterval == index ? Color("cbg") : .white))
                            })
                    }
                    
                    NavigationLink(destination: {
                        
                        Start6()
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
    Start5()
}
