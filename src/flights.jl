module flights
using CSV, DataFrames, CategoricalArrays, Dates, Missings, Serialization, UnicodePlots, Statistics, StatsBase, FreqTables, Chain
export readflights, peekfile

"""
    readflights(inputpath, filename)

Read in a flight arrivals or departure file and process it to a DataFrame.
"""
function readflights(inputpath, filename; version=1)
    input = joinpath(inputpath, filename)
    if version == 1
        CSV.read(input, DataFrame; header = 8, footerskip = 2)
    elseif version == 2
        CSV.read(input, DataFrame; header = 8, footerskip = 2, dateformat = Dict(2 => dateformat"m/d/y", 6 => dateformat"H:M", 7 => dateformat"H:M", 11 => dateformat"H:M"))
    else
        CSV.read(input, DataFrame; header = 8, footerskip = 2,
            types = Dict(2 => Date, 6 => Time, 7 => Time, 11 => Time),
            dateformat = Dict(2 => dateformat"m/d/y", 6 => dateformat"H:M", 7 => dateformat"H:M", 11 => dateformat"H:M"))
    end
end

"""
    peekfile(inputpath, filename; n = 10)

Look at the first few lines, n, in a text file.
"""
function peekfile(inputpath, filename; n = 10, rev = false)
    if rev == true
        for (i, line) in enumerate(Iterators.reverse(eachline(joinpath(inputpath, filename))))
            if i > n
                break
            end
            println(i, "  ", line)
        end
    else
        for (i, line) in enumerate(eachline(joinpath(inputpath, filename)))
            if i > n
                break
            end
            println(i, "  ", line)
        end
    end
end

end # module flights
