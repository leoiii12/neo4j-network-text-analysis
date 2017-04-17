MATCH (w:Word)
RETURN w.name AS word, w.count AS word_cout
ORDER BY word_cout DESC LIMIT 100