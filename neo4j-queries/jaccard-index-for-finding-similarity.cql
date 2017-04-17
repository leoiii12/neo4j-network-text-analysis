MATCH (s:Word {name: "god"})

// Get left, right
MATCH (w:Word)-[:NEXT]->(s)
WITH collect(w.name) as left1, s
MATCH (s)-[:NEXT]->(w:Word)
WITH left1, collect(w.name) as right1, s

// Match every other word
MATCH (o:Word) WHERE NOT s = o
WITH left1, right1, s, o

// Get other left
MATCH (w:Word)-[:NEXT]->(o)
WITH collect(w.name) as left1_o, left1, right1, o
// Compute left similarity
WITH  size(apoc.coll.union(left1, left1_o)) AS l1_union_size, size(apoc.coll.intersection(left1, left1_o)) * 1.0 as l1_intersect_size, right1, o
WHERE l1_union_size > 0 AND l1_intersect_size > 0
WITH l1_intersect_size / l1_union_size as left_similarity, right1, o

// Get other right
MATCH (w:Word)<-[:NEXT]-(o)
WITH left_similarity, collect(DISTINCT w.name) as right1_o, right1, o
// Compute right similarity
WITH left_similarity, size(apoc.coll.union(right1, right1_o)) AS r1_union_size, size(apoc.coll.intersection(right1, right1_o)) * 1.0 as r1_intersect_size, right1, o
WHERE r1_union_size > 0 AND r1_intersect_size > 0
WITH left_similarity, r1_intersect_size / r1_union_size as right_similarity, o

// Calculate index
WITH left_similarity + right_similarity AS similarity, o
ORDER BY similarity DESC
WHERE similarity > 0.1
RETURN o.name, similarity LIMIT 100
