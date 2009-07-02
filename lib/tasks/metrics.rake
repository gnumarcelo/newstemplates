task :metrics => "metrics:all"

namespace :metrics do
  desc "Run all custom stats"
  task :all => ["metrics:cloc", "metrics:rcov"]

  desc "Run CLOC metrics and store in stats/cloc.txt"
  task :cloc do
    puts `cloc --no3 --read-lang-def=/Users/ana/ana/cloc_definitions.txt --report-file=stats/cloc.txt app/ lib/ spec/ stories/`
    puts `cat stats/cloc.txt`
  end

  desc "Run RCOV metrics and store in stats/rcov.txt"
  task :rcov do
    # Specify a SPEC_OPTS format and output file so it doesn't end up in STDOUT.
    `rake spec:rcov SPEC_OPTS="--format specdoc:stats/specdoc.txt" RCOV_OPTS="--text-report --exclude spec,config" > stats/rcov.txt`
    puts `cat stats/rcov.txt`
  end
end
