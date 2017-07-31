# Graphs/Topological Sort

## Vertex and Edge

I implemented my own graph in Ruby by creating Vertex and Edge classes. Each Vertex holds a value and an array of
in_edges and out_edges. Each Edge holds a to_vertex, from_vertex, and cost.

```ruby
class Vertex
  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end
end

class Edge
  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    @cost = cost
    from_vertex.out_edges.push(self)
    to_vertex.in_edges.push(self)
  end
end
```

Every time you create an edge, you must add itself to
the vertex's in_edges array or out_edges array.

## Kahn's Algorithm

Kahn's Algorithm is most widely used to implement Topological Sort for a dependency set. It uses BFS to sort the vertices.

We add vertices without any in_edges to a queue. For each vertex in the queue, we delete the out_edge.

```Ruby
def destroy!
  from_vertex.out_edges.delete(self)
  to_vertex.in_edges.delete(self)
  self.from_vertex = nil
  self.to_vertex = nil
end
```

After the out_edge is deleted, we move the vertex from the queue to the sorted list, and remove the vertex from the graph.

Next, we examine the graph for any more vertices without in_edges. We put them onto the queue. We repeat this step iteratively until there are no more vertices in the queue.

```Ruby
vertices.each do |vertex|
  if vertex.in_edges.empty?
    if !no_in_edges.include?(vertex)  #you don't want to include vertices twice
      no_in_edges.push(vertex)
    end
  end
end
```

If a graph is cyclic, the graph is not a dependency list, and the topological sort will return an empty array.

## Time Complexity

The time complexity of this will be O(|V| + |E|). The |V| is the number of vertices, while |E| is the number of edges.

|V| comes from iterating each vertex and seeing whether the vertex has any in_edges. |E| comes from deleting each edge.

If it's a dense graph, |E| will become close to |V^2| and time complexity will be quadratic. If it's a sparse graph, |E| will become close to |V| and time complexity will be linear. 

## NPM install

I implemented a topological sort on a NPM problem. The way NPM installs dependencies is with a dependency list.

In the problem, tuple[0] represents the package id, while tuple[1] represents tuple[0]'s dependency. Tuple[1] must be installed before tuple[0].
