//
//  OnboardingPage.swift
//  OnboardingApp
//
//  Created by Smit Kanojiya on 31/08/23.
//

import Foundation
import SwiftUI

// MARK: - OnboardingPage
struct OnboardingPage: Identifiable {
    let id = UUID()
    let imageName: String // Image name for the onboarding page
    let title: String // Title of the onboarding page
    let description: String // Description of the onboarding page
    let backgroundColor: Color // Background color of the onboarding page
}
