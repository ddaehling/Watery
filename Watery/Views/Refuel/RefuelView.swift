////
////  RefuelView.swift
////  Watery
////
////  Created by Tom Stich on 25.11.20.
////
//
//import SwiftUI
//import ComposableArchitecture
//
//
//struct RefuelView: View {
//    let store : Store<DrinksState, DrinksAction>
////
////    var selectedDrinkType = Water()
////    @State var selectedDrinkSize: Size = .small
//    
//    var body: some View {
////        WithViewStore(self.store) { viewStore in
////            HStack {
////                VStack(alignment: .leading) {
////                    Text("Refuel yourself")
////                        .font(.title2).padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
////
////                    Text(selectedDrinkType.name)
////                        .font(.largeTitle)
////                        .foregroundColor(ColorManager.wateryBlue)
////                        .bold()
////
////                    HStack {
////                        CupSizeGroupView(store: self.store)
////                    }
////
////                }
////
////                DrinksView(
////                    store: Store(
////                        initialState: DrinksState(drinks: Drink.exampleDrinks),
////                        reducer: drinksReducer,
////                        environment: DrinksEnvironment(uuid: { UUID() } )))
////            }
//        }
//    }
//}
//
//struct RefuelView_Previews: PreviewProvider {
//    static var previews: some View {
//        RefuelView(store: Store(
//                    initialState: DrinksState(drinks: Drink.exampleDrinks),
//                    reducer: drinksReducer,
//                    environment: DrinksEnvironment(uuid: { UUID() } )))
//    }
//}
