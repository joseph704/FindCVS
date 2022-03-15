//
//  LocalNetworkStub.swift
//  FindCVSTests
//
//  Created by Joseph Cha on 2022/03/15.
//

import Foundation
import RxSwift
import Stubber

@testable import FindCVS

class LocalNetworkStub: LocalNetwork {
    override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        return Stubber.invoke(getLocation, args: mapPoint)
    }
}
