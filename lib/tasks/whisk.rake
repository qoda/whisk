desc "Sync the dictionary to the database"
namespace :dictionary do
    task :sync => :environment do
        puts
        puts "Syncing to database..."
        contents = File.open('db/seeds/dictionary.txt', 'rb') { |f| f.readlines }

        redis = Redis.new
        for line in contents
            word = line.strip
            if !$redis.exists(word)
                $redis.set(word, 1)
                puts "Added: " + word
            end
        end
    end
end
