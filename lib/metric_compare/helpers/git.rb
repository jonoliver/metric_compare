module MetricCompare
  module Git
    def self.head
      commit_hash_for_step
    end
    
    def self.last_commit
      commit_hash_for_step 1
    end
    
    def self.commit?(name)
      `git cat-file -t #{name}`.strip == 'commit'
    end
    
    def self.full_commit_hash(name)
      `git rev-parse #{name}`.strip
    end
    
    def self.checkout(name)
      puts "Checking out #{name}" 
      `git checkout #{name} -q`
    end
    
    def self.clean?
      `git status -s`.empty?
    end
    
    def self.head_short_name
      `git rev-parse --abbrev-ref HEAD`.strip
    end
    
    # give me the hash for this step(0=current HEAD)
    def self.commit_hash_for_step(step=0)
      `git rev-parse HEAD~#{step}`.strip    
    end
  end
end