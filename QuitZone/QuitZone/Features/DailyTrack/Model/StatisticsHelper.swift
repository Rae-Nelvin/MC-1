
struct StatisticsHelper {
    var progressData: [ProgressModel] = []

    init(progressData: [ProgressModel]) {
        self.progressData = progressData
    }

    func yAxisCigarettes() -> Int {
        let yAxis = self.progressData.max {x, y in
                return x.totalCigars < y.totalCigars
        }!.totalCigars
        return yAxis
    }

    func yAxisTar() -> Int {
        let yAxis = self.progressData.max {x, y in
            return x.tarConsume < y.tarConsume
        }!.tarConsume
        return Int(yAxis)
    }

    func yAxisNicotine() -> Int {
        let yAxis = self.progressData.max {x, y in
            return Int(x.nicotineConsume) < Int(y.nicotineConsume)
        }!.nicotineConsume
        return Int(yAxis)
    }
}
