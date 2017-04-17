MATCH (node:Word)
WITH collect(node) AS nodes
CALL apoc.algo.pageRankWithConfig(nodes, {iterations: 100, types: 'NEXT'}) YIELD node, score
RETURN node, score
ORDER BY score DESC LIMIT 1000