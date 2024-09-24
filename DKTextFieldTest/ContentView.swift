//
//  ContentView.swift
//  DKTextFieldTest
//
//  Created by Jakob Schøler on 24/09/2024.
//

import DesignKit
import SwiftUI

struct StandardWeightsView: View {
    @State private var selectedStandardWeightsUnit: WeightUnit
    @State private var selectedMaleAvgWeight: Double
    @State private var selectedFemaleAvgWeight: Double

    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    enum WeightUnit: String, CustomStringConvertible, CaseIterable {
        case lbs = "lbs"
        case kg = "kg"
        
        var description: String {
            return switch self {
            case .lbs: "lbs"
            case .kg: "kg"
            }
        }
    }

    init() {
        self._selectedStandardWeightsUnit = State(initialValue: .lbs)
        self._selectedMaleAvgWeight = State(initialValue: 205)
        self._selectedFemaleAvgWeight = State(initialValue: 184)
    }

    var body: some View {
        List {
            DKSegmentedControlView(labels: WeightUnit.allCases.map { $0.description }, selectedLabel: selectedStandardWeightsUnit.description) { selected in
                selectedStandardWeightsUnit = WeightUnit(rawValue: selected)!
                updateWeightsForDisplay()
            }
            .padding(.horizontal, 30)
            
            HStack {
                DKCellLabel(label: "TextField")
                TextField("", value: $selectedMaleAvgWeight, formatter: numberFormatter)
                    .foregroundStyle(.ffBlue)
            }
            
            HStack {
                DKCellLabel(label: "DKTextField")
                DKTextField(value: $selectedFemaleAvgWeight, format: .doubleFormat)
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .onAppear {
            updateWeightsForDisplay()
        }
    }
    
    private func convertToSelectedUnit(weightInLbs: Double) -> Double {
        selectedStandardWeightsUnit == .kg ? weightInLbs * 0.453592 : weightInLbs
    }

    private func updateWeightsForDisplay() {
        selectedMaleAvgWeight = convertToSelectedUnit(weightInLbs: 205)
        selectedFemaleAvgWeight = convertToSelectedUnit(weightInLbs: 184)
    }
}
