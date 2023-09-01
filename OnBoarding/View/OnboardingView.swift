//
//  OnboardingView.swift
//  OnboardingApp
//
//  Created by Smit Kanojiya on 31/08/23.
//

import SwiftUI

// MARK: - OnboardingView
struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel // ViewModel to manage onboarding data
    
    var body: some View {
        ZStack {
            // TabView for displaying onboarding pages
            TabView(selection: $viewModel.currentPageIndex) {
                ForEach(viewModel.onboardingPages.indices, id: \.self) { index in
                    OnboardingPageView(page: viewModel.onboardingPages[index]) // Individual onboarding page
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // TabView style
            .ignoresSafeArea()
            
            // Horizontal stack for skip button and circular progress indicator
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    // Page indicator
                    CustomTabIndicator(pageCount: viewModel.onboardingPages.count, currentIndex: viewModel.currentPageIndex)
                    
                    Text("Skip")
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.white.opacity(0.7))
                        .onTapGesture {
                            viewModel.skipOnboarding() // Action to skip onboarding
                        }
                }
                
                Spacer()
                
                // Circular progress indicator
                CircularProgress(progress: $viewModel.onboardingProgress, viewModel: viewModel)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.horizontal, 25)
            .onChange(of: viewModel.currentPageIndex) { _ in
                viewModel.updateOnboardingProgress() // Update progress when the user changes the page
            }
            .onAppear {
                viewModel.updateOnboardingProgress() // Initialize progress when the view appears
            }
        }
    }
}

// MARK: - OnboardingPageView
struct OnboardingPageView: View {
    let page: OnboardingPage // Represents an individual onboarding page
    
    var body: some View {
        ZStack {
            page.backgroundColor.ignoresSafeArea() // Background color of the page
            
            VStack(alignment: .leading, spacing: 12) {
                Group {
                    Text(page.title)
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    Text(page.description)
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.horizontal, 25) // Styling for page title and description
                
                Image(page.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 25) // Image associated with the page
            }
        }
    }
}

// MARK: - CustomTabIndicator
struct CustomTabIndicator: View {
    let pageCount: Int // Total number of onboarding pages
    let currentIndex: Int // Current selected page

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<pageCount) { index in
                if index == currentIndex {
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 24, height: 8) // Highlight the current page
                } else {
                    Circle()
                        .fill(Color.white.opacity(0.4))
                        .frame(width: 8, height: 8) // Display dots for other pages
                }
            }
        }
    }
}

// MARK: - CircularProgress
struct CircularProgress: View {
    @Binding var progress: CGFloat // Binding to represent progress
    @ObservedObject var viewModel: OnboardingViewModel // ViewModel for managing onboarding
    
    var body: some View {
        Image(systemName: "chevron.right.circle.fill")
            .resizable()
            .foregroundColor(.white)
            .frame(width: 42, height: 42)
            .padding(6)
            .background(Circle().stroke(Color.white.opacity(0.1), lineWidth: 3))
            .background(Circle().trim(from: 0, to: self.progress)
                .stroke(.white, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .rotationEffect(.degrees(-90))) // Circular progress indicator
            .onTapGesture {
                viewModel.goToNextPage() // Action to proceed to the next page
            }
    }
}

// MARK: - OnboardingView_Previews
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: OnboardingViewModel()) // Preview for the onboarding view
    }
}
