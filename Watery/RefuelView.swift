//
//  DrinksView.swift
//  Watery
//
//  Created by Daniel Dähling on 14.11.20.
//

import SwiftUI
import ComposableArchitecture

struct DrinksState: Equatable {
    var barChartState: BarChartState = BarChartState()
    var drinks: IdentifiedArrayOf<Drink> = []
    var dailyConsumption: Double = 0
    var selectedDrinkSize: DrinkSize = .small
    var sizeArray: [DrinkSize] = [.small, .medium, .large, .custom(1.5)]
    var selectedDrinkType : DrinkType = .water
    var selectedDrinkID : Int {
        DrinkType.allCases.firstIndex { $0 == selectedDrinkType }!
    }
    
    let drinkIdAndType: [Int: DrinkType] = [
        0 : .tea,
        1 : .spritzer,
        2 : .lemonade,
        3 : .coffee,
        4 : .juice,
        5 : .lightdrinks
    ]
    
    static var exampleDrinksState : DrinksState = .init(drinks: .init(Drink.exampleDrinks))
}

enum DrinksAction: Equatable {
    case barChartAction(BarChartAction)
    case drinkAdded(Drink)
    case drinksOverViewAction(DrinksOverViewAction)
    case cupSelectionAction(id: Int, action: SelectedDrinkSizeAction)
    case drinkSelected(DrinkType)
    case generatorNotificationSent(UINotificationFeedbackGenerator.FeedbackType)
}

struct DrinksEnvironment {
    let uuid: () -> UUID
    let generator: UINotificationFeedbackGenerator
}

let drinksReducer = Reducer<
    DrinksState, DrinksAction, DrinksEnvironment
>.combine(
    drinksOverViewReducer.pullback(state: \.self, action: /DrinksAction.drinksOverViewAction, environment: { $0 }),
    Reducer { drinksState, drinksAction, drinksEnvironment in
        switch drinksAction {
        case let .drinkAdded(drink):
            drinksState.drinks.append(drink)
            //TODO: Include stable sort
            drinksState.dailyConsumption += drink.netWorth
            return .none
        case .drinksOverViewAction(_):
            return .none
        case let .cupSelectionAction(_, action):
            switch action {
            case let .selectedDrinkChanged(drinkSize):
                drinksState.selectedDrinkSize = drinkSize
                return .none
            }
        case let .drinkSelected(drinkType):
            drinksState.selectedDrinkType = drinkType
            return .none
        case let .generatorNotificationSent(notification):
            drinksEnvironment.generator.notificationOccurred(notification)
            return .none
        case .barChartAction(_):
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
                    
                    
                    Text("\(viewStore.selectedDrinkType.rawValue)".capitalized)
                        .font(.largeTitle)
                        .foregroundColor(ColorManager.wateryBlue)
                        .bold()

                    
                    HStack {
                        CupSizeGroupView(store: self.store.scope(state: { $0.sizeArray }, action: { $0 }))
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
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollViewReader { scrollView in
                HStack{
                    // Left Chevron
                    Button(action: viewStore.state.selectedDrinkID > 0 ? {
                        let id = viewStore.selectedDrinkID - 1
                        scrollView.scrollTo(id, anchor: .center)
                        viewStore.send(.drinkSelected(DrinkType.allCases[id]))
                        viewStore.send(.generatorNotificationSent(.warning))
                    } : {
                        
                        viewStore.send(.generatorNotificationSent(.error))
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(Font.title.weight(.regular))
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    //Image ScrollView
                    ScrollView(.horizontal) {
                        HStack() {
                            ForEach(0..<DrinkType.allCases.count) { i in
                                Image(DrinkImage.allCases[i].rawValue)
                                    .id(i)
                                    // Why not use a Z-Stack?
                                    .overlay(
                                        Button(action: {
                                            viewStore.send(.generatorNotificationSent(.success))
                                            let id = viewStore.selectedDrinkID
                                            scrollView.scrollTo(id, anchor: .center)
                                            
                                            let drink = Drink(date: Date(), id: UUID(), size: viewStore.selectedDrinkSize, type: viewStore.selectedDrinkType)
                                            
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
                        scrollView.scrollTo(viewStore.selectedDrinkID, anchor: .center)
                    }
                    
                    // Right Chevron
                    Button(action: viewStore.selectedDrinkID + 1 < DrinkType.allCases.count ? {
                        let id = viewStore.selectedDrinkID + 1
                        scrollView.scrollTo(id, anchor: .center)
                        viewStore.send(.drinkSelected(DrinkType.allCases[id]))
                        viewStore.send(.generatorNotificationSent(.warning))
                    } :
                    {
                        viewStore.send(.generatorNotificationSent(.error))
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
                initialState: DrinksState(drinks: .init(Drink.exampleDrinks)),
                reducer: drinksReducer,
                environment: DrinksEnvironment(
                    uuid: UUID.init,
                    generator: UINotificationFeedbackGenerator()
                )))
    }
}
