import Pkg; Pkg.add("Images")

img_array = load("coins.ascii.pgm")
using Random
using Statistics


function main()
   
    iterations=1
    g1=[] #group 1
    g2=[] #group 2
    vals = vec(img_array)
    sample = rand(vals, 10)
    T = mean(sample) #this will be updated by the new g1+g2/2
    for num in vec
        if num<T 
         push!(g1, num)
      end
      if num>T 
         push!(g2, num)
      end
            
    end 



    #println(vals)
    # println("Doing work...")
 end

# Call the function at the bottom of the script
main()
