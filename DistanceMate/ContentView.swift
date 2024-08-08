//
//  ContentView.swift
//  DistanceMate
//
//  Created by Adam Sayer on 20/7/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var inputDistance = 0.00
    @State private var inputLengthConversion = "Meters"
    @State private var outputLengthConversion = "Feet"
    
    //Convert inout to meters
    var outputDistance: Double {
        let conversionToMeters: [String: Double] = [
            //Meters
            lengthConversions[0]: 1.0,
            //Kilometers
            lengthConversions[1]: 1000.0,
            //Feet
            lengthConversions[2]: 0.3048,
            //Yards
            lengthConversions[3]: 0.9144,
            //Miles
            lengthConversions[4]: 1609.34
        ]
        
        //convert the input in meter form to output
        let conversionFromMeters: [String: Double] = [
            //Meters
            lengthConversions[0]: 1.0,
            //Kilometers
            lengthConversions[1]: 0.001,
            //Feet
            lengthConversions[2]: 3.28084,
            //Yards
            lengthConversions[3]: 1.09361,
            //Miles
            lengthConversions[4]: 0.000621371
        ]
        
        let inputToMeters = inputDistance * (conversionToMeters[inputLengthConversion] ?? 0.0)
        return inputToMeters * (conversionFromMeters[outputLengthConversion] ?? 0.0)
    }

    
    @FocusState private var inputDistanceIsFocussed: Bool
    
    let lengthConversions = ["Meters", "Kilometer", "Feet", "Yards", "Miles"]
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("What would you like to convert") {
                    
                    LabeledContent("Distance Value") {
                        TextField("Distance", value: $inputDistance, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($inputDistanceIsFocussed)
                    }
                    
                    Picker("Input Unit", selection: $inputLengthConversion) {
                        ForEach(lengthConversions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("What are you converting to") {
                    
                    
                    Picker("Input Unit", selection: $outputLengthConversion) {
                        ForEach(lengthConversions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section ("Your conversion") {
                    Text("\(outputDistance, format: .number) \(outputLengthConversion)")
                }
            }
            .navigationTitle("Distance Mate")
            .toolbar {
                if inputDistanceIsFocussed {
                    Button("Done") {
                        inputDistanceIsFocussed = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
