import Pkg; Pkg.add("FileIO")
using Images, Random, Statistics
using FileIO


img_array = Float64.(load("coins.ascii.pgm"))

function main()
    vals = vec(img_array)

    # Initial threshold
    sample = rand(vals, 10)
    T = mean(sample)

    iterations = 0

    while true
        iterations += 1

        # Reset groups every iteration
        g1 = Float64[]
        g2 = Float64[]

        # Partition
        for num in vals
            if num < T
                push!(g1, num)
            else
                push!(g2, num)
            end
        end

        # Means
        g1_mean = mean(g1)
        g2_mean = mean(g2)

        # New threshold
        T2 = (g1_mean + g2_mean) / 2

        # Stop condition
        if abs(T2 - T) < 0.001 || iterations >= 100
            println("Final threshold: ", T2)
            println("Iterations: ", iterations)
            break
        end

        T = T2
        
    end
    segmented = img_array .>= T


    save("segmented.png", segmented)
end



main()
