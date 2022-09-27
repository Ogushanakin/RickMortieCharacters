//
//  RickMortyViewModel.swift
//  RickMortyChars
//
//  Created by AKIN on 26.09.2022.
//

import Foundation

protocol IRickMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var rickMortiesCharacters: [Result] { get set }
    var rickMortyService: IRickMortyService { get }
    
    var rickMortyOutPut: RickMortyOutPut? { get }
    
    func setDelegate(output: RickMortyOutPut)
}

final class RickMortyViewModel: IRickMortyViewModel {
    var rickMortyOutPut: RickMortyOutPut?
    
    func setDelegate(output: RickMortyOutPut) {
        rickMortyOutPut = output
    }
    
    
    var rickMortiesCharacters: [Result] = []
    private var isLoading = false
    let rickMortyService: IRickMortyService 
    
    init() {
        rickMortyService = RickMortyService()
    }
    
    func fetchItems() {
        changeLoading()
        rickMortyService.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.rickMortiesCharacters = response ?? []
            self?.rickMortyOutPut?.saveDatas(values: self?.rickMortiesCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickMortyOutPut?.changeLoading(isLoad: isLoading)
    }
    
    
    
    
}
