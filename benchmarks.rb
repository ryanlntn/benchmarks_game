require 'json'

benchmarks = JSON.parse(IO.read("./benchmarks.json"))
languages = {}

benchmarks.each do |benchmark|
  language = benchmark["lang"]
  if languages.has_key?(language)
    languages[language][:size] += benchmark["size(B)"]
    languages[language][:elapsed] += benchmark["elapsed(s)"]
    languages[language][:total] += 1
  else
    languages[language] = {}
    languages[language][:size] = benchmark["size(B)"]
    languages[language][:elapsed] = benchmark["elapsed(s)"]
    languages[language][:total] = 1
  end
end

languages.each do |language, stats|
  stats[:size] = stats[:size] / stats[:total]
  stats[:elapsed] = stats[:elapsed] / stats[:total]
  stats[:score] = (stats[:size] ** 2 + stats[:elapsed] ** 2) ** 0.5 # Low score wins
end

puts "Language".ljust(30) + "Size".ljust(10) + "Elapsed".ljust(20) + "Score".ljust(20)
languages.sort_by{ |k,v| v[:score] }.each do |language, stats|
  puts "#{language.ljust(30)}#{stats[:size].to_s.ljust(10)}#{stats[:elapsed].round.to_s.ljust(20)}#{stats[:score].round.to_s.ljust(20)}"
end
