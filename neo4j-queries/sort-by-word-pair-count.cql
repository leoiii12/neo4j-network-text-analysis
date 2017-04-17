MATCH (w1:Word)-[r:NEXT]->(w2:Word)
RETURN [w1.name, w2.name] AS word_pair, r.count AS count ORDER BY count DESC LIMIT 100