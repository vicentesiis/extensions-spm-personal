//
//  PaywayServicesTestHelper.swift
//  ClaroVideoServicesTests
//
//  Created by Juan Carlos  Carrera on 12/07/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

/// This containts static functions just for Tests purpose that are commun to Payway service.
struct PaywayServicesTestHelper {
  static func getMultiPurchaseButtonInfoJSONObject() -> [String:Any] {
    let json: [String:Any] = [
      "data": [
        "listButtons": [
          "540761": [
            "buttons": [
              [
                "waspurchased": "0",
                "purchasechecked": "0",
                "price": "46",
                "offerid": "14326744",
                "currency": "$",
                "paymentmethod": nil,
                "purchaseid": nil,
                "oneoffertype": "download_buy",
                "linkworkflowstart": "/services/payway/workflowstart?object_type=G&offer_id=14326744&device_category=web&device_manufacturer=generic&device_model=web&device_type=generic®ion=mexico",
                "gateway": "default",
                "oneofferdesc": "Compra",
                "producttype": "CV_EPISODEBUY",
                "key": "Telmexmexico_CAPITULOS_EST_COMPRA",
                "bannerpromo": "cv_episodebuy_download_buy_mexico_wp0_amcogate"
              ]
            ],
            "playButton": [
              "visible": "0"
            ]
          ],
          "540762": [
            "buttons": [
              [
                "waspurchased": "1",
                "purchasechecked": "1",
                "price": "46",
                "offerid": "14326744",
                "currency": "$",
                "paymentmethod": [
                  "gateway": "amcogate",
                  "gateway_text": "TEXT_PGS_PAYMENT_MEXICO_GATEWAY_AMCOGATE"
                ],
                "purchaseid": "674872886",
                "oneoffertype": "download_buy",
                "linkworkflowstart": "/services/payway/workflowstart?object_type=G&offer_id=14326744&device_category=web&device_manufacturer=generic&device_model=web&device_type=generic®ion=mexico",
                "gateway": "default",
                "oneofferdesc": "Compra",
                "producttype": "CV_EPISODEBUY",
                "key": "Telmexmexico_CAPITULOS_EST_COMPRA",
                "bannerpromo": "cv_episodebuy_download_buy_mexico_wp1_amcogate"
              ]
            ],
            "playButton": [
              [
                "waspurchased": "1",
                "purchasechecked": "1",
                "price": "46",
                "offerid": "14326744",
                "currency": "$",
                "paymentmethod": [
                  "gateway": "amcogate",
                  "gateway_text": "TEXT_PGS_PAYMENT_MEXICO_GATEWAY_AMCOGATE"
                ],
                "purchaseid": "674872886",
                "oneoffertype": "download_buy",
                "gateway": "default",
                "oneofferdesc": "Compra",
                "producttype": "CV_EPISODEBUY",
                "key": "Telmexmexico_CAPITULOS_EST_COMPRA",
                "bannerpromo": "cv_episodebuy_download_buy_mexico_wp1_amcogate",
                "visible": "1",
                "payway_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MTg5MzI2MzksImV4cCI6MTYxOTAxOTAzOSwicGdzIjp7InVzZXJfaWQiOiI1MzY1NzczNiIsInBfdXNlcl9pZCI6IjUzNjU3NzM2Iiwib2ZmZXJpZCI6IjE0MzI2NzQ0IiwicHVyY2hhc2VpZCI6IjY3NDg3Mjg4NiIsImdyb3VwIjpudWxsLCJwbGF5IjoxLCJjX2Rpc3BfcCI6IjIifX0.yfAj-VRxUQj3MAQ0926stbtLoWOx25WTrMlKny9-CpA",
                "advertisement": [
                  "adstierenabled": "0"
                ]
              ]
            ]
          ],
          "542342": [
            "buttons": [
              [
                "waspurchased": "0",
                "purchasechecked": "0",
                "price": "46",
                "offerid": "14326744",
                "currency": "$",
                "paymentmethod": nil,
                "purchaseid": nil,
                "oneoffertype": "download_buy",
                "linkworkflowstart": "/services/payway/workflowstart?object_type=G&offer_id=14326744&device_category=web&device_manufacturer=generic&device_model=web&device_type=generic®ion=mexico",
                "gateway": "default",
                "oneofferdesc": "Compra",
                "producttype": "CV_EPISODEBUY",
                "key": "Telmexmexico_CAPITULOS_EST_COMPRA",
                "bannerpromo": "cv_episodebuy_download_buy_mexico_wp0_amcogate"
              ]
            ],
            "playButton": [
              "visible": "0"
            ]
          ]
        ]
      ]
    ]
    return json
  }
}
