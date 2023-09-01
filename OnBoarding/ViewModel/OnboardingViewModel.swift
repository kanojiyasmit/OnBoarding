//
//  OnboardingViewModel.swift
//  OnboardingApp
//
//  Created by Smit Kanojiya on 31/08/23.
//

import Foundation
import SwiftUI

// MARK: - OnboardingViewModel
class OnboardingViewModel: ObservableObject {
    // Published properties to hold onboarding data
    @Published var onboardingPages: [OnboardingPage] = [
        OnboardingPage(imageName: "onboarding1",
                       title: "Your First Car Without a Driver's License",
                       description: "Meets people who have just obtained their license",
                       backgroundColor: .yellowLight), // First onboarding page data
        OnboardingPage(imageName: "onboarding2",
                       title: "Always There: Over 1000 Cars in Tbilisi",
                       description: "We lead with the largest fleet of cars",
                       backgroundColor: .purpleLight), // Second onboarding page data
        OnboardingPage(imageName: "onboarding3",
                       title: "No Payments for Parking, Maintenance, and Gasoline",
                       description: "We cover all car-related expenses for you",
                       backgroundColor: .orangeLight), // Third onboarding page data
        OnboardingPage(imageName: "onboarding4",
                       title: "29 Car Models: From Skoda Octavia to Porsche 911",
                       description: "Choose between regular or exclusive car models",
                       backgroundColor: .blueLight) // Fourth onboarding page data
    ]
    
    // Published properties to manage onboarding state
    @Published var currentPageIndex: Int = 0 // Currently selected onboarding page
    @Published var onboardingProgress: CGFloat = 0 // Progress indicator for onboarding
    
    // Function to update the progress indicator
    func updateOnboardingProgress() {
        withAnimation {
            onboardingProgress = CGFloat(currentPageIndex + 1) / CGFloat(onboardingPages.count)
        }
    }
    
    // Function to navigate to the next onboarding page
    func goToNextPage() {
        if currentPageIndex < onboardingPages.count - 1 {
            withAnimation {
                currentPageIndex += 1
            }
        }
    }
    
    // Function to skip the onboarding and proceed to the last page
    func skipOnboarding() {
        currentPageIndex = onboardingPages.count - 1
    }
}
