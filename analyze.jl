## Setup ##
using flights, DataFrames, Chain
const inputp = "../flightdata"
readdir(inputp)[occursin.(r"\.csv$", readdir(inputp))]
const aaarrivals = "american_arrivals.csv"
const aadepartures = "american_departures.csv"
const deltaarrivals = "delta_arrivals.csv"
const deltadepartures = "delta_departures.csv"
const jbarrivals = "jetblue_arrivals.csv"
const jbdepartures = "jetblue_departures.csv"
const unarrivals = "united_arrivals.csv"
const undepartures = "united_departures.csv"

## Look at files ##
peekfile(inputp, aaarrivals, n = 12)
peekfile(inputp, aaarrivals, n = 12, rev = true)

readflights(inputp, aaarrivals, version = 2) |> describe

show(readflights(inputp, aaarrivals)[19200:19300, [11]], allrows = true)

@chain readflights(inputp, aaarrivals) begin
    subset([7, 11] => ByRow((x, y) -> x == "24:00" || y == "24:00"))
end
