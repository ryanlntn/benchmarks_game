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

puts "Language\t\tScore"
languages.each do |language, stats|
  puts "#{language}\t\t#{stats[:score]}"
end
