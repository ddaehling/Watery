//
//  DrinksView.swift
//  Watery
//
//  Created by Daniel Dähling on 14.11.20.
//

import SwiftUI
import ComposableArchitecture

struct DrinksState: Equatable {
    var drinks: [Drink]
    var dailyConsumption: Double
    var selectedDrinkId: Int
    var selectedDrinkSize: DrinkSizes
    
    
    init(drinks : [Drink] = []) {
        self.dailyConsumption = 0.0
        self.drinks = drinks
        self.selectedDrinkId = 0
        self.selectedDrinkSize = DrinkSizes.small
    }
    
    static var exampleDrinksState : DrinksState = .init(drinks: .init(Drink.exampleDrinks))
}

let DrinkIdAndType: [Int: DrinkTypes] = [
    0 : DrinkTypes.tea,
    1 : DrinkTypes.spritzer,
    2 : DrinkTypes.lemonade,
    3 : DrinkTypes.coffee,
    4 : DrinkTypes.juice,
    5 : DrinkTypes.lightdrinks
]

enum DrinksAction: Equatable {
    case selectedDrinkChanged(Int, DrinkSizes)
    case drinkAdded(Drink)
    case drinksOverViewAction(DrinksOverViewAction)
}

struct DrinksEnvironment {
    let uuid: () -> UUID
}

let drinksReducer = Reducer<
    DrinksState, DrinksAction, DrinksEnvironment
>.combine(
    drinksOverViewReducer.pullback(state: \.self, action: /DrinksAction.drinksOverViewAction, environment: { $0 }),
    Reducer { drinksState, drinksAction, drinksEnvironment in
        switch drinksAction {
        case let .drinkAdded(drink):
            var dailyConsumtion = drinksState.dailyConsumption
            drinksState.drinks.append(drink)
            
            switch drink.size {
            case DrinkSizes.small:
                drinksState.dailyConsumption = dailyConsumtion + 0.3
            case DrinkSizes.medium:
                drinksState.dailyConsumption = dailyConsumtion + 0.5
            case DrinkSizes.large:
                drinksState.dailyConsumption = dailyConsumtion + 0.7
            case DrinkSizes.custom:
                drinksState.dailyConsumption = dailyConsumtion + 1.0
            }
            
            //TODO: Include stable sort
            return .none
        case .drinksOverViewAction(_):
            return .none
            
        case let .selectedDrinkChanged(id, size):
            drinksState.selectedDrinkId =  id
            drinksState.selectedDrinkSize =  size
            return .none
        }
    }
).debug()

struct RefuelView: View {
    let store : Store<DrinksState, DrinksAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            
            HStack {
                VStack(alignment: .leading) {
                    
                    Text("Refuel yourself")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                        .foregroundColor(ColorManager.wateryBlue)
                    
                    
                    Text(DrinkTypes.allCases[viewStore.selectedDrinkId].rawValue)
                        .font(.largeTitle)
                        .foregroundColor(ColorManager.wateryBlue)
                        .bold()

                    
                    HStack {
                        CupSizeGroupView(store: self.store)
                    }
                    
                     
                }.padding(.leading, 5)
                
                DrinksScrollView(store: self.store)
            }
            .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 8) , height: 170)
        }
    }
    
}

struct DrinksScrollView: View {
    let store : Store<DrinksState, DrinksAction>
    
    let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollViewReader { scrollView in
                HStack{
                    // Left Chevron
                    Button(action: viewStore.selectedDrinkId > 0 ? {
                        let id = viewStore.selectedDrinkId - 1
                        scrollView.scrollTo(id, anchor: .center)
                        viewStore.send(.selectedDrinkChanged(id, viewStore.selectedDrinkSize))
                        self.generator.notificationOccurred(.warning)
                    } : {
                        self.generator.notificationOccurred(.error)
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(Font.title.weight(.regular))
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    //Image ScrollView
                    ScrollView(.horizontal) {
                        HStack() {
                            ForEach(0..<DrinkTypes.allCases.count) { i in
                                Image(DrinkImages.allCases[i].rawValue)
                                    .id(i)
                                    .overlay(
                                        Button(action: {
                                            self.generator.notificationOccurred(.success)
                                            let id = viewStore.selectedDrinkId
                                            scrollView.scrollTo(id, anchor: .center)
                                            
                                            let drink = Drink(date: Date(), id: UUID(), size: viewStore.selectedDrinkSize, type: DrinkTypes.allCases[id])
                                            
                                            viewStore.send(.drinkAdded(drink))
                                        }, label: {
                                            Image(systemName: "plus.circle")
                                                .font(Font.title.weight(.semibold))
                                                .foregroundColor(ColorManager.wateryBlue)
                                        })
                                    )
                            }
                        }
                    }
                    .onAppear {
                        scrollView.scrollTo(viewStore.selectedDrinkId, anchor: .center)
                    }
                    
                    // Right Chevron
                    Button(action: viewStore.selectedDrinkId + 1 < DrinkTypes.allCases.count ? {
                        let id = viewStore.selectedDrinkId + 1
                        
                        scrollView.scrollTo(id, anchor: .center)
                        viewStore.send(.selectedDrinkChanged(id, viewStore.selectedDrinkSize))
                        
                        self.generator.notificationOccurred(.warning)
                    } :
                    {
                        self.generator.notificationOccurred(.error)
                    }
                    , label: {
                        Image(systemName: "chevron.right")
                            .font(Font.title.weight(.regular))
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}



struct DrinksView_Previews: PreviewProvider {
    static var previews: some View {
        RefuelView(
            store: Store(
                initialState: DrinksState(drinks: Drink.exampleDrinks),
                reducer: drinksReducer,
                environment: DrinksEnvironment(uuid: { UUID() } )))
    }
}
