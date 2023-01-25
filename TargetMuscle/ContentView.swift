//
//  ContentView.swift
//  TargetMuscle
//
//  Created by Karthik Vetrivelan on 1/25/23.
//

import SwiftUI

struct ContentView: View {
    let muscleGroups = ["Chest", "Back", "Shoulders", "Arms", "Legs"]
    let exercises = [
            "Chest": ["Barbell Bench Press", "Dumbbell Fly", "Push-ups"],
            "Back": ["Deadlift", "Bent-over Row", "Pull-ups"],
            "Shoulders": ["Barbell Shoulder Press", "Dumbbell Lateral Raise", "Dumbbell Front Raise"],
            "Arms": ["Barbell Curl", "Tricep Dips", "Hammer Curl"],
            "Legs": ["Squat", "Deadlift", "Lunges"]
        ]

    var body: some View {
        NavigationView {
                    List(muscleGroups, id: \.self) { muscleGroup in
                        NavigationLink(destination: ExerciseView(exercises: self.exercises[muscleGroup] ?? [])) {
                            Text(muscleGroup)
                        }
                    }
                    .navigationBarTitle("Muscle Groups")
                }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Exercise {
    let name: String
    let description: String
    let reps: String
    let sets: String
}

struct ExerciseView: View {
    let exercises: [Exercise]

    var body: some View {
        List(exercises, id: \.self) { exercise in
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .font(.headline)
                Text(exercise.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    Text("Reps: \(exercise.reps)")
                    Spacer()
                    Text("Sets: \(exercise.sets)")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
        }
        .navigationBarTitle("Exercises")
    }
}

