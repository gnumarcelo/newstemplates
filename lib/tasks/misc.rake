desc "sort migration files into alphabetical order"
namespace :db do
  namespace :migrate do
    task :sort do
      migrations = `ls db/migrate`.chomp.split("\n")

      model_names = []
      migrations.each do |m|
        raise "invalid format" unless m =~ /^[0-9]+_create_([a-z_]+)\.rb$/
        model_names << $1
      end
      model_names.sort!

      model_names.each_with_index do |n, i|
        original = migrations.select {|m| m =~ /#{n}/}
        replacement = sprintf("%03d", i+1) + "_create_" + n + ".rb"
        `mv db/migrate/#{original} db/migrate/#{replacement}`
      end
    end
  end
end
