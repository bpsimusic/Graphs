# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

#The dependency tuple[1] is what needs to be done first before
#tuple[0] can execute.

require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
  answer = []
  vertices = []
  sorted = []
  max = 1;
  arr.each do |tuple|
    max = [max, tuple.max].max
  end

  (1..max).each do |num|
    vertices << Vertex.new(num)
  end

  arr.each do |tuple|
    vertex1 = find_vertex(tuple[1], vertices) #Dependency
    vertex2 = find_vertex(tuple[0], vertices) #Task after dependency is done
    Edge.new(vertex1, vertex2)
  end

  # take out the vertices without edges.
  vertices.reverse_each do |vertex|
    if vertex.in_edges.empty? && vertex.out_edges.empty?
      sorted << vertex
      vertices.delete(vertex)
    end
  end

  #combine the sorted list with the vertices without edges.
  sorted = sorted.concat(topological_sort(vertices))
  sorted.each do |vertex|
    answer << vertex.value
  end

  answer
end

#helper method to locate vertex in an array
def find_vertex(num, vertices)
  vertices.each do |vertex|
    return vertex if vertex.value == num
  end
end
