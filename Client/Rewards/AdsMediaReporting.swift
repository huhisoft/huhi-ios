// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation
import WebKit
import HuhiRewards

class AdsMediaReporting: TabContentScript {
    let rewards: HuhiRewards
    weak var tab: Tab?
    
    init(rewards: HuhiRewards, tab: Tab) {
        self.rewards = rewards
        self.tab = tab
    }
    
    class func name() -> String {
        return "AdsMediaReporting"
    }
    
    func scriptMessageHandlerName() -> String? {
        return "adsMediaReporting"
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if let isPlaying = message.body as? Bool, rewards.ledger.isEnabled && rewards.ads.isEnabled {
            guard let tab = tab else { return }
            if isPlaying {
                rewards.reportMediaStarted(tabId: tab.rewardsId)
            } else {
                rewards.reportMediaStopped(tabId: tab.rewardsId)
            }
        }
    }
}