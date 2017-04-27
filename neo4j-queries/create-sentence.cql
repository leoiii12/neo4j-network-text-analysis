WITH "" AS words, "Imagine the casting call for male actors for Hulu’s new TV adaptation of Margaret Atwood’s" AS sentence
MERGE (s: Sentence {name: original_sentence})
WITH words, s

UNWIND range(0, size(words) - 2) AS i
MERGE (w1: Word {name: words[i]}) ON CREATE SET w1.count = 0
MERGE (w1)-[ai1:APPEARS_IN]->(s)
MERGE (w2: Word {name: words[i + 1]}) ON CREATE SET w2.count = 0
MERGE (w2)-[ai2:APPEARS_IN]->(s) 
MERGE (w1)-[r:NEXT]->(w2) ON CREATE SET r.count = 1 ON MATCH SET r.count = r.count + 1

WITH collect(w1) AS w1s, collect(w2) AS w2s
WITH w1s + last(w2s) AS merged_words

UNWIND merged_words AS merged_word
SET merged_word.count = merged_word.count + 1