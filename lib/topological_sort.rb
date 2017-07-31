require_relative 'graph'

def topological_sort(vertices)

  sorted = []
  no_in_edges = []

  #queue up vertices without in_edges
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      no_in_edges.push(vertex)
    end
  end

  #start sorting.
  until no_in_edges.empty? do
    current = no_in_edges.shift

    #destroy the out_edges of each vertex
    current.out_edges.reverse_each do |edge| #do reverse if you're deleting
      edge.destroy!
    end

    sorted.push(current)

    vertices.delete(current)

    #check for vertices without in_edges again
    vertices.each do |vertex|
      if vertex.in_edges.empty?
        if !no_in_edges.include?(vertex)  #you don't want to include vertices twice
          no_in_edges.push(vertex)
        end
      end
    end
  end

  vertices.length != 0 ? [] : sorted   #if cyclic, return []

end
