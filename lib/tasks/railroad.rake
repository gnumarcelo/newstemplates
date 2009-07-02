namespace :graph do
  desc "create a PDF showing all models"
  task :models do
    `railroad -M > doc/graphs/models.dot`
    `dot -Tpdf -o doc/graphs/models.pdf doc/graphs/models.dot`
    `open doc/graphs/models.pdf`
  end
end

task :proto => ["db:migrate:sort", "db:migrate:reset", "metrics:all", "graph:models"]
