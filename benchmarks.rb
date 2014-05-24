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

p languages
