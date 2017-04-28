MATCH (node:Word)
WITH collect(node) AS nodes
CALL apoc.algo.pageRankWithConfig(nodes, {iterations: 100, types: 'NEXT|APPEARS_IN'}) YIELD node, score
RETURN node, score
ORDER BY score DESC LIMIT 1000

MATCH (node:Sentence)
WITH collect(node) AS nodes
CALL apoc.algo.pageRankWithConfig(nodes, {iterations: 100, types: 'APPEARS_IN|NEXT'}) YIELD node, score
RETURN node, score
ORDER BY score DESC LIMIT 1000