# Get Arvix papers

# https://arxiv.org/help/api/user-manual
# ti  Title
# au  Author
# abs Abstract
# co  Comment
# jr  Journal Reference
# cat Subject Category
# rn  Report Number
# id  Id (use id_list instead)
# all All of the above

class ArvixGetter
  include HTTParty
  base_uri 'http://export.arxiv.org/api/query'

  def initialize(cat: 'cs.AI', max_results: '10')
    @options = { query: { search_query: cat, max_results: max_results } }
  end

  def papers
    self.class.get("", @options)
  end
end
