"""
returns, for every cluster, the n (default 10) words indexes with higher fapwm value for the cluster
if the cluster contains less than n non zero fapwm values, excess indexes will be 0
takes in words x clusters fapwm values matrix and (optional) number of topwords, returns topwords x clusters Int matrix of word indexes
"""
function topmost_words(fapwm, num=10)
    res = Int.(zeros(num, fapwm.n))
    for cluster in 1:fapwm.n
        clus = fapwm[:,cluster]
        srp = sortperm(clus, rev=true)
        if length(clus.nzval)<num # if there are less than num nonzero fapwm values in the cluster column
            res[1:length(clus.nzval),cluster] = srp[1:length(clus.nzval)]
        else
            res[:,cluster] = srp[1:num]
        end
    end
    res
end
