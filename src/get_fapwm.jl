
"""
calculated frequent and predictive words method (fapwm) values for the clustering of a dataset
takes assignment array (such as .assignment of k means result) and column-document data matrix
returns fapwm values as a number of words x number of clusters matrix m where m_ij = fapwm value for word i in cluster j

fapwm value is defined as = p(word | cluster)*p(word | cluster)/p(word)
where word is the "word appears at least once in the document" event and cluster is the "document is in the specific cluster" event.
"""
function get_fapwm(assignments::Array{Int, 1}, data)
    cols = size(data, 2)# number of documents
    rows = size(data, 1)# number of words
    wsums = [count((x)->(x>0),data[i,:]) for i in 1:rows]
    # calculate word frequency p(word) as occurrences/documents
    # occurrences arent the sums of times a word appears in each documents but the amount of documents a word appears in, regardless of how many times it appears in that document
    pword = [(wsums[i] == 0 ? 0 : wsums[i]/cols) for i in 1:rows]

    res = spzeros(rows ,maximum(assignments))
    for cluster in 1:maximum(assignments)# for each cluster        
        ids = findall((x)->(x==cluster),assignments)
        # calculate sum of word occurrences among all documents of cluster
        sums = [count((x)->(x>0),data[i,ids]) for i in 1:rows]
        # calculate cluster local frequency p(word | cluster) of word in cluster as occurrences(in the cluster)/documents(in the cluster)
        frqs = [(sums[i]==0 ? 0 : sums[i]/length(ids)) for i in 1:rows]
        # pushes array containing fapwm values for each word in res array
        for word in 1:rows
            if frqs[word] != 0
                # set fapwm value
                res[word, cluster] = frqs[word]*(frqs[word]/pword[word])
            end
            # if local frequency is 0, fapwm value is also 0
            # return matrix is initialized as 0 so we dont need to do anything in this case
        end
    end

    res
end