# Utility to fetch all titles used for Legislators

titles = {}
UsState.names.each do | state, name |
  LeaderFinder.by_state(state).each do |x|
    titl = x['title'].downcase
    # remove state name from title, is present
    state_name = name.downcase
    i = titl.downcase.index(state_name.downcase)
    if i
      titl[i,state_name.length] = ''
      titl.strip!
    end
    titles[titl] ? titles[titl]+=1 : titles[titl]=1
  end
end
puts 'Legislators titles = ' + titles.inspect

