#=
  Name: Eva Lesko, Joure Fadhil 
  Course: CS 372
  Instructor: McCann
  Due Date: April 20th,2026

  Description: 
  This program performs iterative thresholding on a grayscale image to 
  achieve binary segmentation. It begins with a random mean threshold 
  and refines it by partitioning pixels into two groups (background 
  and foreground), calculating their means, and updating the threshold 
  to the midpoint of those means until convergence or an iteration 
  limit is reached.

  Operational Requirements:
  - Language: Julia (v1.x)
  - Packages: FileIO, Images, Random, Statistics
  - Input: Expects "coins.ascii.pgm" in the local directory.
  - Output: Saves "segmented.png" to the local directory.

  Bugs/Missing Features:
  - None known.
  Written Reponses:
  https://docs.google.com/document/d/16SR9MQHIWa0MDm3Ju7u3ESsXJJCECWJo0Ll0J1GzDmE/edit?usp=sharing
=#

import Pkg; Pkg.add("FileIO")
using Images, Random, Statistics
using FileIO

# Global scope image loading
img_array = Float64.(load("coins.ascii.pgm")) # The source image converted to float matrix

#=
  main
  Purpose: Executes the iterative thresholding algorithm and saves the result.
  Pre-conditions: img_array is loaded with valid image data.
  Post-conditions: "segmented.png" is saved to disk based on the final threshold.
  Parameters: None
  Returns: Nothing
=#
function main()
    vals = vec(img_array) # Flattened vector of pixel intensities

    # Initial threshold selection
    sample = rand(vals, 10) # Random sample of 10 pixels
    T = mean(sample)        # Initial threshold value

    iterations = 0          # Counter for convergence limit

    # Primary refinement loop
    while true
        iterations += 1

        # Reset groups every iteration to re-partition pixels
        g1 = Float64[] # Group for pixels below the current threshold
        g2 = Float64[] # Group for pixels at or above the current threshold

        # Partition: Assign each pixel to a group based on T
        for num in vals
            if num < T
                push!(g1, num)
            else
                push!(g2, num)
            end
        end

        # Means: Calculate average intensity of both groups
        g1_mean = mean(g1)
        g2_mean = mean(g2)

        # New threshold: The midpoint between the two group means
        T2 = (g1_mean + g2_mean) / 2

        # Stop condition: Terminate if change is minimal or limit reached
        if abs(T2 - T) < 0.001 || iterations >= 100
            println("Final threshold: ", T2)
            println("Iterations: ", iterations)
            break
        end

        T = T2
        
    end
    
    # Create the binary image using the final threshold
    segmented = img_array .>= T

    # Save output to file
    save("segmented.png", segmented)
end

main()
