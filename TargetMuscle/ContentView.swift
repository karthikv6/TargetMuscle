//
//  ContentView.swift
//  TargetMuscle
//
//  Created by Karthik Vetrivelan on 1/25/23.
//

import SwiftUI
import UIKit
//import ExerciseData

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
            VStack {
                HStack {
                    Text("Muscle Groups")
                        .font(.title)
                    Spacer()
                    NavigationLink(destination: PersonalRoutinesView()) {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                    }


                }
                List(muscleGroups, id: \.self) { muscleGroup in
                    NavigationLink(destination: ExerciseView(exercises: self.exercises[muscleGroup] ?? [])) {
                        Text(muscleGroup)
                    }
                }
                .navigationBarTitle("Target Work")
            }
            .padding()
        }
    }
}

struct PersonalRoutinesView: View {
    @State private var showForm = false
    @State private var name = ""
    @State private var selectedExercises: Set<String> = []
    let exercises = [
            "Chest": ["Barbell Bench Press", "Dumbbell Fly", "Push-ups"],
            "Back": ["Deadlift", "Bent-over Row", "Pull-ups"],
            "Shoulders": ["Barbell Shoulder Press", "Dumbbell Lateral Raise", "Dumbbell Front Raise"],
            "Arms": ["Barbell Curl", "Tricep Dips", "Hammer Curl"],
            "Legs": ["Squat", "Deadlift", "Lunges"]
        ]
    var routines: [String: Routine] = [:]
    var body: some View {
        VStack {
            // code to display existing routines here
            Spacer()
            Button(action: {
                self.showForm.toggle()
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showForm) {
            Form {
                TextField("Routine Name", text: $name)
                ForEach(exercises.keys.sorted(), id: \.self) { muscleGroup in
                    Section(header: Text(muscleGroup)) {
                        ForEach(self.exercises[muscleGroup]!, id: \.self) { exercise in
                            Checkbox(isOn: self.$selectedExercises.contains(exercise)) {
                                Text(exercise)
                            }
                        }
                    }
                }
                Button(action: {
                    self.addRoutine()
                }) {
                    Text("Add Routine")
                }
            }
        }
    }
    func addRoutine() {
        let newRoutine = Routine(name: name, exercises: Array(selectedExercises))
        routines[name] = newRoutine
        self.showForm = false
    }
}

struct Routine {
    var name: String
    var exercises: Set<String>
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

var exerciseDescriptions = [
    "Barbell Bench Press": "Lie down on a flat bench with a barbell. Grab the barbell with a medium-width grip. Plant your feet firmly on the ground. Unrack the barbell by straightening your arms. Lower the barbell to your chest. Push the barbell back to the starting position.",
    "Dumbbell Fly": "Lie down on a flat bench with a dumbbell in each hand. Hold the dumbbells above your chest with your palms facing each other. Lower the dumbbells to the sides of your chest. Raise the dumbbells back to the starting position.",
    "Push-ups": "Place your hands on the ground, slightly wider than shoulder-width apart. Extend your legs behind you and balance on your toes. Lower your body by bending your arms until your chest nearly touches the ground. Push your body back up to the starting position.",
    "Deadlift": "Stand in front of a loaded barbell with your feet hip-width apart. Bend your knees and grab the barbell with an overhand grip. Keep your back straight and lift the barbell off the ground. Lower the barbell back to the ground.",
    "Bent-over Row": "Stand in front of a loaded barbell with your feet hip-width apart. Bend your knees and grab the barbell with an overhand grip. Keep your back straight and lift the barbell off the ground. Lower the barbell back to the ground.",
    "Pull-ups": "Grab a pull-up bar with an overhand grip. Hang from the bar with your arms fully extended. Pull your body up towards the bar. Lower your body back to the starting position.",
    "Barbell Shoulder Press":"Stand with your feet hip-width apart and hold a barbell at shoulder level with an overhand grip. Push the barbell above your head until your arms are fully extended. Lower the barbell back to the starting position.",
    "Dumbbell Lateral Raise": "Stand with your feet hip-width apart and hold a dumbbell in each hand at your sides. Raise the dumbbells out to the sides until they are at shoulder level. Lower the dumbbells back to the starting position.",
    "Dumbbell Front Raise": "Stand with your feet hip-width apart and hold a dumbbell in each hand at your sides. Raise one dumbbell in front of you until it is at shoulder level. Lower the dumbbell back to the starting position and repeat with the other arm.",
    "Barbell Curl": "Stand with your feet hip-width apart and hold a barbell with an underhand grip. Curl the barbell up towards your chest. Lower the barbell back to the starting position.",
    "Tricep Dips": "Place your hands on the edge of a bench or chair. Extend your legs out in front of you. Lower your body by bending your arms until your arms are at a 90-degree angle. Push your body back up to the starting position.",
    "Hammer Curl": "Stand with your feet hip-width apart and hold a dumbbell in each hand at your sides. Curl one dumbbell up towards your shoulder. Lower the dumbbell back to the starting position and repeat with the other arm.",
    "Squat": "Stand with your feet hip-width apart and hold a barbell on your shoulders. Lower your body by bending your knees. Push your body back up to the starting position.",
    "Lunges": "Stand with your feet hip-width apart and hold a dumbbell in each hand. Step forward with one foot and lower your body by bending your knees. Push your body back up to the starting position and repeat with the other leg."
    ]


struct Exercise:Hashable {
    let name: String
    let description: [String : String]
    let reps: String
    let sets: String
    let image: String
    

    
    init(name: String, reps: String, sets: String, image: String) {
        self.name = name
        self.description = exerciseDescriptions
        self.reps = reps
        self.sets = sets
        self.image = image
    }
}

struct ExerciseView: View {
    let exercises: [String]

    var body: some View {
        List(exercises, id: \.self) { exercise in
            NavigationLink(destination: ExerciseDescriptionView(exercise: exercise)) {
                Text(exercise)
            }
        }
        .navigationBarTitle("Exercises")
    }
}

struct ExerciseDescriptionView: View {
    let exercise: String
    var exerciseDescription : String
    init(exercise: String) {
        self.exercise = exercise
        self.exerciseDescription = exerciseDescriptions[exercise] ?? ""
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(exercise)
                .font(.largeTitle)
                .padding()
            Text(exerciseDescription)
                .font(.title)
                .foregroundColor(.gray)
                .padding()
        }
    }
}


//struct ExerciseView: View {
//    let exercises: [Exercise]
//
//    var body: some View {
//        List(exercises, id: \.self) { exercise in
//            VStack(alignment: .leading) {
//                Text(exercise.name)
//                    .font(.headline)
//                Text(exercise.description)
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                HStack {
//                    Text("Reps: \(exercise.reps)")
//                    Spacer()
//                    Text("Sets: \(exercise.sets)")
//                }
//                .font(.footnote)
//                .foregroundColor(.gray)
//            }
//        }
//        .navigationBarTitle("Exercises")
//    }
//}

