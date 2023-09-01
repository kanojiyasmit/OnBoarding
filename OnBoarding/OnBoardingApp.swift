//
//  OnBoardingApp.swift
//  OnBoarding
//
//  Created by Smit Kanojiya on 31/08/23.
//

import SwiftUI

@main
struct OnBoardingApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView(viewModel: OnboardingViewModel())
        }
    }
}
