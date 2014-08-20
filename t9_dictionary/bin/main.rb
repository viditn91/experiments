require_relative '../lib/trie'
t = Trie.new
t.insert('vidit')
t.insert('viditjain')
p t.find(84348) # 'vidit'
p t.find(843485246) # 'viditjain'