module FAPWM
    using SparseArrays
    include("get_fapwm.jl")
    include("topmost_words.jl")
    include("print_fapwm.jl") 
    export get_fapwm, print_fapwm, topmost_words

end