import Foundation
import HTML

/// Component that generates the JavaScript to initialize a chart
public struct ChartScript: HTML {
    public let chartId: String
    public let configuration: ChartConfiguration
    public let waitForDOM: Bool
    public let storeGlobally: Bool
    
    public init(
        chartId: String,
        configuration: ChartConfiguration,
        waitForDOM: Bool = true,
        storeGlobally: Bool = false
    ) {
        self.chartId = chartId
        self.configuration = configuration
        self.waitForDOM = waitForDOM
        self.storeGlobally = storeGlobally
    }
    
    public var body: some HTML {
        script {
            generateScript()
        }
    }
    
    private func generateScript() -> String {
        let configJS = configuration.toJavaScript()
        let globalVar = storeGlobally ? "window.chart_\(chartId)" : "chart_\(chartId)"
        
        if waitForDOM {
            return """
            (function() {
                function init_\(chartId)() {
                    if (typeof Chart === 'undefined') {
                        setTimeout(init_\(chartId), 100);
                        return;
                    }
                    
                    const ctx = document.getElementById('\(chartId)');
                    if (!ctx) {
                        console.error('Canvas element not found: \(chartId)');
                        return;
                    }
                    
                    // Destroy existing chart if it exists
                    if (\(globalVar)) {
                        \(globalVar).destroy();
                    }
                    
                    // Create new chart
                    \(globalVar) = new Chart(ctx.getContext('2d'), \(configJS));
                }
                
                // Initialize on DOM ready
                if (document.readyState === 'loading') {
                    document.addEventListener('DOMContentLoaded', init_\(chartId));
                } else {
                    init_\(chartId)();
                }
            })();
            """
        } else {
            return """
            const ctx_\(chartId) = document.getElementById('\(chartId)');
            if (ctx_\(chartId)) {
                \(globalVar) = new Chart(ctx_\(chartId).getContext('2d'), \(configJS));
            }
            """
        }
    }
}