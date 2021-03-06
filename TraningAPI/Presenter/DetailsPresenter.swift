//
//  DetailsPresenter.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/19.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
protocol  DetailsPresenterInput{
    func getPrefecturesInfo(id: Int)
}
protocol  DetailsPresenterOutput:class {
    func setTitle(name: String, population: String)
    func setContent(details: [[String]])
}

class DetailsPresenter{
    
    private weak var delegate: DetailsPresenterOutput?
    private var model: PrefecturesInput
    init(delegate: DetailsPresenterOutput, model: PrefecturesInput = PrefecturesUseCase()) {
        self.delegate = delegate
        self.model = model
    }
}
//    MARK: - Viewからの依頼
extension DetailsPresenter: DetailsPresenterInput{
    ///感染者数詳細表示
    func getPrefecturesInfo(id: Int){
        guard let delegate = self.delegate else { return }
        model.getDetails(id: id)
        let details = Details.detailsToArray(prefectures: self.model.details)
        delegate.setContent(details: details)
        delegate.setTitle(name: self.model.details.name, population: String(self.model.details.population))
    }
}
