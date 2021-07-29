function print_fapwm(fapwm, lexi::Array{String,1}, num=10, name::String="frequent and predictive words.md")
    topm = topmost_words(fapwm, num)
    words = []
    for cluster in 1:fapwm.n
        idx = filter(!iszero, topm[:,cluster])
        push!(words, lexi[idx])
    end
    print_words(words, name)
end

function print_words(arr, name="frequent and predictive words.md")
    open(name, "w") do io
        write(io, "This file contains every word present in each cluster, ordered by the score given by the Frequent and Predictive words Method,\n which scores words based on the product of local frequency and predictiveness.\n For more informations, see https://iarjset.com/upload/2017/july-17/IARJSET%203.pdf\n")
        for i in 1:length(arr)
            write(io, "[Cluster $i](#cluster$i)\n")
        end

        for i in 1:length(arr)
            write(io, "# Cluster$i\n\n")
            ln = length(arr[i])#>50 ? 50 : length(arr[i])
            for j in 1:ln
                write(io, arr[i][j])
                if round(j/10) == j/10
                    write(io, "\n")
                else
                    write(io, ", ")
                end
            end
            write(io, "\n\n")
        end

    end
end