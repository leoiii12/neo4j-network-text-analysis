MATCH path = (:Word)-[:NEXT]->(:Word)
RETURN path;