MATCH (w1:Word)-[r:NEXT]->(w2:Word)
RETURN [w1.name, w2.name] AS word_pair, r.count AS count ORDER BY count DESC LIMIT 100

MATCH path = (w1:Word)-[r:NEXT*..2]->(w2:Word)
RETURN  [w1.name, w2.name] AS word_pair, 
        reduce(totalCount = 0, n IN relationships(path) | totalCount + n.count) AS totalCount
        ORDER BY totalCount DESC LIMIT 100