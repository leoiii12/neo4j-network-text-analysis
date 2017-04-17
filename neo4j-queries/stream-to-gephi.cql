MATCH path = (:Word)-[:NEXT]->(:Word)
WITH path
WITH collect(path) as paths
call apoc.gephi.add(null, 'workspace1', paths) yield nodes, relationships, time
return nodes, relationships, time