//
//  SplashScreenView.swift
//  MC2
//
//  Created by Dewi Nurul Hamidah on 04/07/22.
//

import SwiftUI

struct SplashScreenView: View {
    @AppStorage("onboarding") private var isOnboarding = true
    @State private var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            if isOnboarding {
                OnboardingScreen()
            } else {
                ContentView()
            }
            
        } else {
            VStack {
                VStack {
                    Image("logolaunchscreen")
                        .resizable()
                        .frame(width: 400, height: 400, alignment: .center)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

