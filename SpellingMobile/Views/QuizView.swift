//
//  QuizView.swift
//  SpellingMobile
//
//  Created by Russell Gordon on 2025-04-10.
//

import SwiftUI

struct QuizView: View {
    
    // MARK: Stored properties
    
    // Access the view model which runs the mechanics
    // of the game for us
    @State var viewModel = QuizViewModel()
    
    // MARK: Computed properties
    
    // This presents the user interface
    var body: some View {
        
        NavigationStack {
            
            VStack {

                // Top of interface shows food item to guess
                VStack {
                    Image(viewModel.currentItem.imageName)
                        .resizable()
                        .scaledToFit()
                    
                    HStack {
                        TextField("Enter the name of the item", text: $viewModel.userGuess)
                            .textFieldStyle(.roundedBorder)

                        Text(viewModel.currentOutcome.rawValue)
                    }
                        
                    HStack {
                    
                        // Let the user check their guess
                        Button {
                            viewModel.saveResult()
                            viewModel.newWord()
                        } label: {
                            Text("New Word")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)

                        // Let the user check their guess
                        Button {
                            viewModel.checkGuess()
                        } label: {
                            Text("Check")
                        }
                        .buttonStyle(.borderedProminent)
                        
                    }
                    
                }
                .padding()
                
                // Bottom part of interface shows history
                VStack {
                   
                    // Picker to select what outcome to show
                    Picker("Filtering on", selection: $viewModel.selectedOutcomeFilter) {
                        // Options that show up in the picker
                        Text("All results").tag(Outcome.undetermined)
                        Text("Correct").tag(Outcome.correct)
                        Text("Incorrect").tag(Outcome.incorrect)
                    }
                    .pickerStyle(.segmented)
                    
                    // Show previous outcomes
                    List(
                        filtering(
                            originalList: viewModel.history,
                            on: viewModel.selectedOutcomeFilter
                        )
                    ) { currentResult in
                        
                        HStack {

                            Image(currentResult.item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                            
                            Text(currentResult.guessProvided)
                            
                            Spacer()
                            
                            Text(currentResult.outcome.rawValue)
             
                        }
                       
                    }
                    .listStyle(.plain)

                    
                }
                .padding()
                
            }
            .navigationTitle("Spelling Quiz")

        }
        
    }
}

#Preview {
    QuizView()
}
